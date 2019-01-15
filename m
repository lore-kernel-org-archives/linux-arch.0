From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/16] io_uring: add support for pre-mapped user IO buffers
Date: Mon, 14 Jan 2019 19:55:28 -0700
Message-ID: <20190115025531.13985-14-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

If we have fixed user buffers, we can map them into the kernel when we
setup the io_context. That avoids the need to do get_user_pages() for
each and every IO.

To utilize this feature, the application must call io_uring_register()
after having setup an io_uring context, passing in
IORING_REGISTER_BUFFERS as the opcode, and the following struct as the
argument:

struct io_uring_register_buffers {
	struct iovec *iovecs;
	__u32 nr_iovecs;
};

If successful, these buffers are now mapped into the kernel, eligible
for IO. To use these fixed buffers, the application must use the
IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
must point to somewhere inside the indexed buffer.

The application may register buffers throughout the lifetime of the
io_uring context. It can call io_uring_register() with
IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
buffers, and then register a new set. The application need not
unregister buffers explicitly before shutting down the io_uring context.

It's perfectly valid to setup a larger buffer, and then sometimes only
use parts of it for an IO. As long as the range is within the originally
mapped region, it will work just fine.

RLIMIT_MEMLOCK is used to check how much memory we can pin. A somewhat
arbitrary 1G per buffer size is also imposed.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/io_uring.c                          | 345 ++++++++++++++++++++++++-
 include/linux/sched/user.h             |   2 +-
 include/linux/syscalls.h               |   2 +
 include/uapi/linux/io_uring.h          |  21 +-
 kernel/sys_ni.c                        |   1 +
 7 files changed, 361 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 194e79c0032e..7e89016f8118 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -400,3 +400,4 @@
 386	i386	rseq			sys_rseq			__ia32_sys_rseq
 387	i386	io_uring_setup		sys_io_uring_setup		__ia32_compat_sys_io_uring_setup
 388	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
+389	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 453ff7a79002..8e05d4f05d88 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -345,6 +345,7 @@
 334	common	rseq			__x64_sys_rseq
 335	common	io_uring_setup		__x64_sys_io_uring_setup
 336	common	io_uring_enter		__x64_sys_io_uring_enter
+337	common	io_uring_register	__x64_sys_io_uring_register
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/io_uring.c b/fs/io_uring.c
index d0e4e37592fe..00743a5a6fac 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -24,8 +24,11 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/blkdev.h>
+#include <linux/bvec.h>
 #include <linux/anon_inodes.h>
 #include <linux/sched/mm.h>
+#include <linux/sizes.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
@@ -61,6 +64,13 @@ struct list_multi {
 	unsigned multi;
 };
 
+struct io_mapped_ubuf {
+	u64		ubuf;
+	size_t		len;
+	struct		bio_vec *bvec;
+	unsigned int	nr_bvecs;
+};
+
 struct io_ring_ctx {
 	struct percpu_ref	refs;
 
@@ -84,6 +94,11 @@ struct io_ring_ctx {
 	struct mm_struct	*sqo_mm;
 	struct files_struct	*sqo_files;
 
+	/* if used, fixed mapped user buffers */
+	unsigned		nr_user_bufs;
+	struct io_mapped_ubuf	*user_bufs;
+	struct user_struct	*user;
+
 	struct completion	ctx_done;
 
 	struct {
@@ -691,12 +706,51 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
 	}
 }
 
+static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
+			   const struct io_uring_sqe *sqe,
+			   struct iov_iter *iter)
+{
+	struct io_mapped_ubuf *imu;
+	size_t len = sqe->len;
+	size_t offset;
+	int index;
+
+	/* attempt to use fixed buffers without having provided iovecs */
+	if (unlikely(!ctx->user_bufs))
+		return -EFAULT;
+	if (unlikely(sqe->buf_index >= ctx->nr_user_bufs))
+		return -EFAULT;
+
+	index = array_index_nospec(sqe->buf_index, ctx->sq_entries);
+	imu = &ctx->user_bufs[index];
+	if ((unsigned long) sqe->addr < imu->ubuf ||
+	    (unsigned long) sqe->addr + len > imu->ubuf + imu->len)
+		return -EFAULT;
+
+	/*
+	 * May not be a start of buffer, set size appropriately
+	 * and advance us to the beginning.
+	 */
+	offset = (unsigned long) sqe->addr - imu->ubuf;
+	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
+	if (offset)
+		iov_iter_advance(iter, offset);
+	return 0;
+}
+
 static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 			   const struct io_uring_sqe *sqe,
 			   struct iovec **iovec, struct iov_iter *iter)
 {
 	void __user *buf = (void __user *) (uintptr_t) sqe->addr;
 
+	if (sqe->opcode == IORING_OP_READ_FIXED ||
+	    sqe->opcode == IORING_OP_WRITE_FIXED) {
+		ssize_t ret = io_import_fixed(ctx, rw, sqe, iter);
+		*iovec = NULL;
+		return ret;
+	}
+
 #ifdef CONFIG_COMPAT
 	if (ctx->compat)
 		return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
@@ -870,9 +924,19 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		ret = io_nop(req, sqe);
 		break;
 	case IORING_OP_READV:
+		if (unlikely(sqe->buf_index))
+			return -EINVAL;
 		ret = io_read(req, sqe, force_nonblock, state);
 		break;
 	case IORING_OP_WRITEV:
+		if (unlikely(sqe->buf_index))
+			return -EINVAL;
+		ret = io_write(req, sqe, force_nonblock, state);
+		break;
+	case IORING_OP_READ_FIXED:
+		ret = io_read(req, sqe, force_nonblock, state);
+		break;
+	case IORING_OP_WRITE_FIXED:
 		ret = io_write(req, sqe, force_nonblock, state);
 		break;
 	case IORING_OP_FSYNC:
@@ -898,9 +962,11 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 static void io_sq_wq_submit_work(struct work_struct *work)
 {
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work.work);
+	struct sqe_submit *s = &req->work.submit;
 	struct io_ring_ctx *ctx = req->ctx;
-	mm_segment_t old_fs = get_fs();
 	struct files_struct *old_files;
+	mm_segment_t old_fs;
+	bool needs_user;
 	int ret;
 
 	/*
@@ -913,19 +979,32 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	old_files = current->files;
 	current->files = ctx->sqo_files;
 
-	if (!mmget_not_zero(ctx->sqo_mm)) {
-		ret = -EFAULT;
-		goto err;
+	/*
+	 * If we're doing IO to fixed buffers, we don't need to get/set
+	 * user context
+	 */
+	needs_user = true;
+	if (s->sqe->opcode == IORING_OP_READ_FIXED ||
+	    s->sqe->opcode == IORING_OP_WRITE_FIXED)
+		needs_user = false;
+
+	if (needs_user) {
+		if (!mmget_not_zero(ctx->sqo_mm)) {
+			ret = -EFAULT;
+			goto err;
+		}
+		use_mm(ctx->sqo_mm);
+		old_fs = get_fs();
+		set_fs(USER_DS);
 	}
 
-	use_mm(ctx->sqo_mm);
-	set_fs(USER_DS);
-
 	ret = __io_submit_sqe(ctx, req, &req->work.submit, false, NULL);
 
-	set_fs(old_fs);
-	unuse_mm(ctx->sqo_mm);
-	mmput(ctx->sqo_mm);
+	if (needs_user) {
+		set_fs(old_fs);
+		unuse_mm(ctx->sqo_mm);
+		mmput(ctx->sqo_mm);
+	}
 err:
 	if (ret) {
 		io_fill_cq_error(ctx, &req->work.submit, ret);
@@ -1168,6 +1247,183 @@ static void io_sq_offload_stop(struct io_ring_ctx *ctx)
 	}
 }
 
+static int io_sqe_user_account_mem(struct io_ring_ctx *ctx,
+				   unsigned long nr_pages)
+{
+	unsigned long page_limit, cur_pages, new_pages;
+
+	if (!ctx->user)
+		return 0;
+
+	/* Don't allow more pages than we can safely lock */
+	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+	do {
+		cur_pages = atomic_long_read(&ctx->user->locked_vm);
+		new_pages = cur_pages + nr_pages;
+		if (new_pages > page_limit)
+			return -ENOMEM;
+	} while (atomic_long_cmpxchg(&ctx->user->locked_vm, cur_pages,
+					new_pages) != cur_pages);
+
+	return 0;
+}
+
+static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
+{
+	int i, j;
+
+	if (!ctx->user_bufs)
+		return -EINVAL;
+
+	for (i = 0; i < ctx->sq_entries; i++) {
+		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
+
+		for (j = 0; j < imu->nr_bvecs; j++) {
+			set_page_dirty_lock(imu->bvec[j].bv_page);
+			put_page(imu->bvec[j].bv_page);
+		}
+
+		if (ctx->user)
+			atomic_long_sub(imu->nr_bvecs, &ctx->user->locked_vm);
+		kfree(imu->bvec);
+		imu->nr_bvecs = 0;
+	}
+
+	kfree(ctx->user_bufs);
+	ctx->user_bufs = NULL;
+	free_uid(ctx->user);
+	ctx->user = NULL;
+	return 0;
+}
+
+static int io_copy_iov(struct io_ring_ctx *ctx, struct iovec *dst,
+		       struct io_uring_register_buffers *reg, unsigned index)
+{
+	struct iovec __user *src;
+
+#ifdef CONFIG_COMPAT
+	if (ctx->compat) {
+		struct compat_iovec __user *ciovs;
+		struct compat_iovec ciov;
+
+		ciovs = (struct compat_iovec __user *) reg->iovecs;
+		if (copy_from_user(&ciov, &ciovs[index], sizeof(ciov)))
+			return -EFAULT;
+
+		dst->iov_base = (void __user *) (unsigned long) ciov.iov_base;
+		dst->iov_len = ciov.iov_len;
+		return 0;
+	}
+#endif
+	src = (struct iovec __user *) &reg->iovecs[index];
+	if (copy_from_user(dst, src, sizeof(*dst)))
+		return -EFAULT;
+	return 0;
+}
+
+static int io_sqe_buffer_register(struct io_ring_ctx *ctx,
+				  struct io_uring_register_buffers *reg)
+{
+	struct page **pages = NULL;
+	int i, j, got_pages = 0;
+	int ret = -EINVAL;
+
+	if (reg->nr_iovecs > USHRT_MAX)
+		return -EINVAL;
+
+	ctx->user_bufs = kcalloc(reg->nr_iovecs, sizeof(struct io_mapped_ubuf),
+					GFP_KERNEL);
+	if (!ctx->user_bufs)
+		return -ENOMEM;
+
+	if (!capable(CAP_IPC_LOCK))
+		ctx->user = get_uid(current_user());
+
+	for (i = 0; i < reg->nr_iovecs; i++) {
+		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
+		unsigned long off, start, end, ubuf;
+		int pret, nr_pages;
+		struct iovec iov;
+		size_t size;
+
+		ret = io_copy_iov(ctx, &iov, reg, i);
+		if (ret)
+			break;
+
+		/*
+		 * Don't impose further limits on the size and buffer
+		 * constraints here, we'll -EINVAL later when IO is
+		 * submitted if they are wrong.
+		 */
+		ret = -EFAULT;
+		if (!iov.iov_base)
+			goto err;
+
+		/* arbitrary limit, but we need something */
+		if (iov.iov_len > SZ_1G)
+			goto err;
+
+		ubuf = (unsigned long) iov.iov_base;
+		end = (ubuf + iov.iov_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		start = ubuf >> PAGE_SHIFT;
+		nr_pages = end - start;
+
+		ret = io_sqe_user_account_mem(ctx, nr_pages);
+		if (ret)
+			goto err;
+
+		if (!pages || nr_pages > got_pages) {
+			kfree(pages);
+			pages = kmalloc_array(nr_pages, sizeof(struct page *),
+						GFP_KERNEL);
+			if (!pages)
+				goto err;
+			got_pages = nr_pages;
+		}
+
+		imu->bvec = kmalloc_array(nr_pages, sizeof(struct bio_vec),
+						GFP_KERNEL);
+		if (!imu->bvec)
+			goto err;
+
+		down_write(&current->mm->mmap_sem);
+		pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
+						pages, NULL);
+		up_write(&current->mm->mmap_sem);
+
+		if (pret < nr_pages) {
+			if (pret < 0)
+				ret = pret;
+			goto err;
+		}
+
+		off = ubuf & ~PAGE_MASK;
+		size = iov.iov_len;
+		for (j = 0; j < nr_pages; j++) {
+			size_t vec_len;
+
+			vec_len = min_t(size_t, size, PAGE_SIZE - off);
+			imu->bvec[j].bv_page = pages[j];
+			imu->bvec[j].bv_len = vec_len;
+			imu->bvec[j].bv_offset = off;
+			off = 0;
+			size -= vec_len;
+		}
+		/* store original address for later verification */
+		imu->ubuf = ubuf;
+		imu->len = iov.iov_len;
+		imu->nr_bvecs = nr_pages;
+	}
+	kfree(pages);
+	ctx->nr_user_bufs = reg->nr_iovecs;
+	return 0;
+err:
+	kfree(pages);
+	io_sqe_buffer_unregister(ctx);
+	return ret;
+}
+
 static void io_free_scq_urings(struct io_ring_ctx *ctx)
 {
 	if (ctx->sq_ring) {
@@ -1189,6 +1445,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_sq_offload_stop(ctx);
 	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
+	io_sqe_buffer_unregister(ctx);
 	percpu_ref_exit(&ctx->refs);
 	kfree(ctx);
 }
@@ -1436,6 +1693,74 @@ COMPAT_SYSCALL_DEFINE2(io_uring_setup, u32, entries,
 }
 #endif
 
+static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
+			       void __user *arg)
+{
+	int ret;
+
+	/* Drop our initial ref and wait for the ctx to be fully idle */
+	percpu_ref_put(&ctx->refs);
+	percpu_ref_kill(&ctx->refs);
+	wait_for_completion(&ctx->ctx_done);
+
+	switch (opcode) {
+	case IORING_REGISTER_BUFFERS: {
+		struct io_uring_register_buffers reg;
+
+		ret = -EFAULT;
+		if (copy_from_user(&reg, arg, sizeof(reg)))
+			break;
+		ret = io_sqe_buffer_register(ctx, &reg);
+		break;
+		}
+	case IORING_UNREGISTER_BUFFERS:
+		ret = -EINVAL;
+		if (arg)
+			break;
+		ret = io_sqe_buffer_unregister(ctx);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	/* bring the ctx back to life */
+	percpu_ref_resurrect(&ctx->refs);
+	percpu_ref_get(&ctx->refs);
+	return ret;
+}
+
+SYSCALL_DEFINE3(io_uring_register, unsigned int, fd, unsigned int, opcode,
+		void __user *, arg)
+{
+	struct io_ring_ctx *ctx;
+	long ret = -EBADF;
+	struct fd f;
+
+	f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+
+	ret = -EOPNOTSUPP;
+	if (f.file->f_op != &io_uring_fops)
+		goto out_fput;
+
+	ret = -EINVAL;
+	ctx = f.file->private_data;
+	if (!percpu_ref_tryget(&ctx->refs))
+		goto out_fput;
+
+	ret = -EBUSY;
+	if (mutex_trylock(&ctx->uring_lock)) {
+		ret = __io_uring_register(ctx, opcode, arg);
+		mutex_unlock(&ctx->uring_lock);
+	}
+	io_ring_drop_ctx_refs(ctx, 1);
+out_fput:
+	fdput(f);
+	return ret;
+}
+
 static int __init io_uring_init(void)
 {
 	req_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 39ad98c09c58..c7b5f86b91a1 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -40,7 +40,7 @@ struct user_struct {
 	kuid_t uid;
 
 #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
-    defined(CONFIG_NET)
+    defined(CONFIG_NET) || defined(CONFIG_IO_URING)
 	atomic_long_t locked_vm;
 #endif
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 542757a4c898..e36c264d74e8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
 				struct io_uring_params __user *p);
 asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
 				u32 min_complete, u32 flags);
+asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
+				void __user *arg);
 
 /* fs/xattr.c */
 asmlinkage long sys_setxattr(const char __user *path, const char __user *name,
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index d31ae2f767d1..fda25d09c8a1 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -30,7 +30,10 @@ struct io_uring_sqe {
 		__u32		fsync_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
-	__u64	__pad2[3];
+	union {
+		__u16	buf_index;	/* index into fixed buffers, if used */
+		__u64	__pad2[3];
+	};
 };
 
 /*
@@ -42,6 +45,8 @@ struct io_uring_sqe {
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
 #define IORING_OP_FSYNC		3
+#define IORING_OP_READ_FIXED	4
+#define IORING_OP_WRITE_FIXED	5
 
 /*
  * sqe->fsync_flags
@@ -105,4 +110,18 @@ struct io_uring_params {
 	struct io_cqring_offsets cq_off;
 };
 
+/*
+ * io_uring_register(2) opcodes and arguments
+ */
+#define IORING_REGISTER_BUFFERS		0
+#define IORING_UNREGISTER_BUFFERS	1
+
+struct io_uring_register_buffers {
+	union {
+		struct iovec *iovecs;
+		__u64 pad;
+	};
+	__u32 nr_iovecs;
+};
+
 #endif
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index ee5e523564bb..1bb6604dc19f 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -48,6 +48,7 @@ COND_SYSCALL_COMPAT(io_getevents);
 COND_SYSCALL_COMPAT(io_pgetevents);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
+COND_SYSCALL(io_uring_register);
 
 /* fs/xattr.c */
 
-- 
2.17.1

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
