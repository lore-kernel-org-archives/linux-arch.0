From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/15] io_uring: add file registration
Date: Wed, 16 Jan 2019 10:50:02 -0700
Message-ID: <20190116175003.17880-15-axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190116175003.17880-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

We normally have to fget/fput for each IO we do on a file. Even with
the batching we do, this atomic inc/dec cost adds up.

This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
for the io_uring_register(2) system call. The arguments passed in must
be an array of __s32 holding file descriptors, and nr_args should hold
the number of file descriptors the application wishes to pin for the
duration of the io_uring context (or until IORING_UNREGISTER_FILES is
called).

When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
to the index in the array passed in to IORING_REGISTER_FILES.

Files are automatically unregistered when the io_uring context is
torn down. An application need only unregister if it wishes to
register a few set of fds.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 130 ++++++++++++++++++++++++++++------
 include/uapi/linux/io_uring.h |   9 ++-
 2 files changed, 118 insertions(+), 21 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e64f491b861c..f73ee269f51b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -94,6 +94,10 @@ struct io_ring_ctx {
 	struct files_struct	*sqo_files;
 	wait_queue_head_t	sqo_wait;
 
+	/* if used, fixed file set */
+	struct file		**user_files;
+	unsigned		nr_user_files;
+
 	/* if used, fixed mapped user buffers */
 	unsigned		nr_user_bufs;
 	struct io_mapped_ubuf	*user_bufs;
@@ -135,6 +139,7 @@ struct io_kiocb {
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
+#define REQ_F_FIXED_FILE	8	/* ctx owns file */
 	u64			user_data;
 	u64			res;
 };
@@ -355,15 +360,17 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		 * Batched puts of the same file, to avoid dirtying the
 		 * file usage count multiple times, if avoidable.
 		 */
-		if (!file) {
-			file = req->rw.ki_filp;
-			file_count = 1;
-		} else if (file == req->rw.ki_filp) {
-			file_count++;
-		} else {
-			fput_many(file, file_count);
-			file = req->rw.ki_filp;
-			file_count = 1;
+		if (!(req->flags & REQ_F_FIXED_FILE)) {
+			if (!file) {
+				file = req->rw.ki_filp;
+				file_count = 1;
+			} else if (file == req->rw.ki_filp) {
+				file_count++;
+			} else {
+				fput_many(file, file_count);
+				file = req->rw.ki_filp;
+				file_count = 1;
+			}
 		}
 
 		if (to_free == ARRAY_SIZE(reqs))
@@ -500,13 +507,19 @@ static void kiocb_end_write(struct kiocb *kiocb)
 	}
 }
 
+static void io_fput(struct io_kiocb *req)
+{
+	if (!(req->flags & REQ_F_FIXED_FILE))
+		fput(req->rw.ki_filp);
+}
+
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 
 	kiocb_end_write(kiocb);
 
-	fput(kiocb->ki_filp);
+	io_fput(req);
 	io_cqring_fill_event(req->ctx, req->user_data, res, 0);
 	io_free_req(req);
 }
@@ -610,7 +623,17 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct kiocb *kiocb = &req->rw;
 	int ret;
 
-	kiocb->ki_filp = io_file_get(state, sqe->fd);
+	if (unlikely(sqe->flags & ~IOSQE_FIXED_FILE))
+		return -EINVAL;
+
+	if (sqe->flags & IOSQE_FIXED_FILE) {
+		if (unlikely(!ctx->user_files || sqe->fd >= ctx->nr_user_files))
+			return -EBADF;
+		kiocb->ki_filp = ctx->user_files[sqe->fd];
+		req->flags |= REQ_F_FIXED_FILE;
+	} else {
+		kiocb->ki_filp = io_file_get(state, sqe->fd);
+	}
 	if (unlikely(!kiocb->ki_filp))
 		return -EBADF;
 	kiocb->ki_pos = sqe->off;
@@ -649,7 +672,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	return 0;
 out_fput:
-	io_file_put(state, kiocb->ki_filp);
+	if (!(sqe->flags & IOSQE_FIXED_FILE))
+		io_file_put(state, kiocb->ki_filp);
 	return ret;
 }
 
@@ -766,7 +790,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	kfree(iovec);
 out_fput:
 	if (unlikely(ret))
-		fput(file);
+		io_fput(req);
 	return ret;
 }
 
@@ -820,7 +844,7 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 out_fput:
 	if (unlikely(ret))
-		fput(file);
+		io_fput(req);
 	return ret;
 }
 
@@ -853,19 +877,30 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
+	if (unlikely(sqe->flags & ~IOSQE_FIXED_FILE))
+		return -EINVAL;
 	if (unlikely(sqe->addr))
 		return -EINVAL;
 	if (unlikely(sqe->fsync_flags & ~IORING_FSYNC_DATASYNC))
 		return -EINVAL;
 
-	file = fget(sqe->fd);
+	if (sqe->flags & IOSQE_FIXED_FILE) {
+		if (unlikely(!ctx->user_files || sqe->fd >= ctx->nr_user_files))
+			return -EBADF;
+		file = ctx->user_files[sqe->fd];
+	} else {
+		file = fget(sqe->fd);
+	}
+
 	if (unlikely(!file))
 		return -EBADF;
 
 	ret = vfs_fsync_range(file, sqe->off, end > 0 ? end : LLONG_MAX,
 			sqe->fsync_flags & IORING_FSYNC_DATASYNC);
 
-	fput(file);
+	if (!(sqe->flags & IOSQE_FIXED_FILE))
+		fput(file);
+
 	io_cqring_fill_event(ctx, sqe->user_data, ret, 0);
 	io_free_req(req);
 	return 0;
@@ -878,10 +913,6 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	const struct io_uring_sqe *sqe = s->sqe;
 	ssize_t ret;
 
-	/* enforce forwards compatibility on users */
-	if (unlikely(sqe->flags))
-		return -EINVAL;
-
 	if (unlikely(s->index >= ctx->sq_entries))
 		return -EINVAL;
 	req->user_data = sqe->user_data;
@@ -1332,6 +1363,55 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 	return ret;
 }
 
+static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
+{
+	int i;
+
+	if (!ctx->user_files)
+		return -EINVAL;
+
+	for (i = 0; i < ctx->nr_user_files; i++)
+		fput(ctx->user_files[i]);
+
+	kfree(ctx->user_files);
+	ctx->user_files = NULL;
+	ctx->nr_user_files = 0;
+	return 0;
+}
+
+static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
+				 unsigned nr_args)
+{
+	__s32 __user *fds = (__s32 __user *) arg;
+	int fd, i, ret = 0;
+
+	if (!nr_args)
+		return -EINVAL;
+
+	ctx->user_files = kcalloc(nr_args, sizeof(struct file *), GFP_KERNEL);
+	if (!ctx->user_files)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_args; i++) {
+		ret = -EFAULT;
+		if (copy_from_user(&fd, &fds[i], sizeof(fd)))
+			break;
+
+		ctx->user_files[i] = fget(fd);
+
+		ret = -EBADF;
+		if (!ctx->user_files[i])
+			break;
+		ctx->nr_user_files++;
+		ret = 0;
+	}
+
+	if (ret)
+		io_sqe_files_unregister(ctx);
+
+	return ret;
+}
+
 static int io_sq_offload_start(struct io_ring_ctx *ctx,
 			       struct io_uring_params *p)
 {
@@ -1603,6 +1683,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_sq_offload_stop(ctx);
 	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
+	io_sqe_files_unregister(ctx);
 	io_sqe_buffer_unregister(ctx);
 	percpu_ref_exit(&ctx->refs);
 	kfree(ctx);
@@ -1872,6 +1953,15 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 			break;
 		ret = io_sqe_buffer_unregister(ctx);
 		break;
+	case IORING_REGISTER_FILES:
+		ret = io_sqe_files_register(ctx, arg, nr_args);
+		break;
+	case IORING_UNREGISTER_FILES:
+		ret = -EINVAL;
+		if (arg || nr_args)
+			break;
+		ret = io_sqe_files_unregister(ctx);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index c9eb6f4c6de0..88ec687231be 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -16,7 +16,7 @@
  */
 struct io_uring_sqe {
 	__u8	opcode;		/* type of operation for this sqe */
-	__u8	flags;		/* as of now unused */
+	__u8	flags;		/* IOSQE_ flags */
 	__u16	ioprio;		/* ioprio for the request */
 	__s32	fd;		/* file descriptor to do IO on */
 	__u64	off;		/* offset into file */
@@ -33,6 +33,11 @@ struct io_uring_sqe {
 	};
 };
 
+/*
+ * sqe->flags
+ */
+#define IOSQE_FIXED_FILE	(1 << 0)	/* use fixed fileset */
+
 /*
  * io_uring_setup() flags
  */
@@ -120,5 +125,7 @@ struct io_uring_params {
  */
 #define IORING_REGISTER_BUFFERS		0
 #define IORING_UNREGISTER_BUFFERS	1
+#define IORING_REGISTER_FILES		2
+#define IORING_UNREGISTER_FILES		3
 
 #endif
-- 
2.17.1

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
