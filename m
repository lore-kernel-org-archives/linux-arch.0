From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/15] io_uring: support for IO polling
Date: Wed,  9 Jan 2019 19:43:55 -0700
Message-ID: <20190110024404.25372-7-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

Add support for polled read and write commands. These act like their
non-polled counterparts, except we expect to poll for completion of
them.

To use polling, io_uring_setup() must be used with the
IORING_SETUP_IOPOLL flag being set. It is illegal to mix and match
polled and non-polled IO on an io_uring.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 247 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |   5 +
 2 files changed, 239 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0bad563f3486..c872bfb32a03 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -71,13 +71,17 @@ struct io_ring_ctx {
 
 	struct completion	ctx_done;
 
+	/* iopoll submission state */
 	struct {
-		struct mutex		uring_lock;
-		wait_queue_head_t	wait;
+		spinlock_t		poll_lock;
+		struct list_head	poll_submitted;
 	} ____cacheline_aligned_in_smp;
 
 	struct {
+		struct list_head	poll_completing;
 		spinlock_t		completion_lock;
+		struct mutex		uring_lock;
+		wait_queue_head_t	wait;
 	} ____cacheline_aligned_in_smp;
 };
 
@@ -97,9 +101,12 @@ struct io_kiocb {
 	unsigned long		ki_index;
 	struct list_head	ki_list;
 	unsigned long		ki_flags;
+#define KIOCB_F_IOPOLL_COMPLETED	0	/* polled IO has completed */
+#define KIOCB_F_IOPOLL_EAGAIN		1	/* submission got EAGAIN */
 };
 
 #define IO_PLUG_THRESHOLD		2
+#define IO_IOPOLL_BATCH			8
 
 struct sqe_submit {
 	const struct io_uring_sqe *sqe;
@@ -136,6 +143,9 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 
 	spin_lock_init(&ctx->completion_lock);
 	init_waitqueue_head(&ctx->wait);
+	spin_lock_init(&ctx->poll_lock);
+	INIT_LIST_HEAD(&ctx->poll_submitted);
+	INIT_LIST_HEAD(&ctx->poll_completing);
 	mutex_init(&ctx->uring_lock);
 
 	return ctx;
@@ -187,12 +197,151 @@ static void io_ring_drop_ctx_ref(struct io_ring_ctx *ctx, unsigned refs)
 		wake_up(&ctx->wait);
 }
 
+static void io_free_kiocb_many(struct io_ring_ctx *ctx, void **iocbs, int *nr)
+{
+	if (*nr) {
+		kmem_cache_free_bulk(kiocb_cachep, *nr, iocbs);
+		io_ring_drop_ctx_ref(ctx, *nr);
+		*nr = 0;
+	}
+}
+
 static void io_free_kiocb(struct io_kiocb *iocb)
 {
 	kmem_cache_free(kiocb_cachep, iocb);
 	io_ring_drop_ctx_ref(iocb->ki_ctx, 1);
 }
 
+/*
+ * Find and free completed poll iocbs
+ */
+static void io_iopoll_reap(struct io_ring_ctx *ctx, unsigned int *nr_events)
+{
+	void *iocbs[IO_IOPOLL_BATCH];
+	struct io_kiocb *iocb, *n;
+	int to_free = 0;
+
+	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_list) {
+		if (!test_bit(KIOCB_F_IOPOLL_COMPLETED, &iocb->ki_flags))
+			continue;
+		if (to_free == ARRAY_SIZE(iocbs))
+			io_free_kiocb_many(ctx, iocbs, &to_free);
+
+		list_del(&iocb->ki_list);
+		iocbs[to_free++] = iocb;
+
+		fput(iocb->rw.ki_filp);
+		(*nr_events)++;
+	}
+
+	if (to_free)
+		io_free_kiocb_many(ctx, iocbs, &to_free);
+}
+
+/*
+ * Poll for a mininum of 'min' events, and a maximum of 'max'. Note that if
+ * min == 0 we consider that a non-spinning poll check - we'll still enter
+ * the driver poll loop, but only as a non-spinning completion check.
+ */
+static int io_iopoll_getevents(struct io_ring_ctx *ctx, unsigned int *nr_events,
+				long min)
+{
+	struct io_kiocb *iocb;
+	int found, polled, ret;
+
+	/*
+	 * Check if we already have done events that satisfy what we need
+	 */
+	if (!list_empty(&ctx->poll_completing)) {
+		io_iopoll_reap(ctx, nr_events);
+		if (min && *nr_events >= min)
+			return 0;
+	}
+
+	/*
+	 * Take in a new working set from the submitted list, if possible.
+	 */
+	if (!list_empty_careful(&ctx->poll_submitted)) {
+		spin_lock(&ctx->poll_lock);
+		list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
+		spin_unlock(&ctx->poll_lock);
+	}
+
+	if (list_empty(&ctx->poll_completing))
+		return 0;
+
+	/*
+	 * Check again now that we have a new batch.
+	 */
+	io_iopoll_reap(ctx, nr_events);
+	if (min && *nr_events >= min)
+		return 0;
+
+	polled = found = 0;
+	list_for_each_entry(iocb, &ctx->poll_completing, ki_list) {
+		/*
+		 * Poll for needed events with spin == true, anything after
+		 * that we just check if we have more, up to max.
+		 */
+		bool spin = !polled || *nr_events < min;
+		struct kiocb *kiocb = &iocb->rw;
+
+		if (test_bit(KIOCB_F_IOPOLL_COMPLETED, &iocb->ki_flags))
+			break;
+
+		found++;
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, spin);
+		if (ret < 0)
+			return ret;
+
+		polled += ret;
+	}
+
+	io_iopoll_reap(ctx, nr_events);
+	if (*nr_events >= min)
+		return 0;
+	return found;
+}
+
+/*
+ * We can't just wait for polled events to come to us, we have to actively
+ * find and complete them.
+ */
+static void io_iopoll_reap_events(struct io_ring_ctx *ctx)
+{
+	if (!(ctx->flags & IORING_SETUP_IOPOLL))
+		return;
+
+	mutex_lock(&ctx->uring_lock);
+	while (!list_empty_careful(&ctx->poll_submitted) ||
+	       !list_empty(&ctx->poll_completing)) {
+		unsigned int nr_events = 0;
+
+		io_iopoll_getevents(ctx, &nr_events, 1);
+	}
+	mutex_unlock(&ctx->uring_lock);
+}
+
+static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
+			   long min)
+{
+	int ret = 0;
+
+	while (!*nr_events || !need_resched()) {
+		int tmin = 0;
+
+		if (*nr_events < min)
+			tmin = min - *nr_events;
+
+		ret = io_iopoll_getevents(ctx, nr_events, tmin);
+		if (ret <= 0)
+			break;
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static void kiocb_end_write(struct kiocb *kiocb)
 {
 	if (kiocb->ki_flags & IOCB_WRITE) {
@@ -208,18 +357,16 @@ static void kiocb_end_write(struct kiocb *kiocb)
 	}
 }
 
-static void io_cqring_fill_event(struct io_ring_ctx *ctx, unsigned ki_index,
-				 long res, unsigned ev_flags)
+static void __io_cqring_fill_event(struct io_ring_ctx *ctx, unsigned ki_index,
+				   long res, unsigned ev_flags)
 {
 	struct io_uring_cqe *cqe;
-	unsigned long flags;
 
 	/*
 	 * If we can't get a cq entry, userspace overflowed the
 	 * submission (by quite a lot). Increment the overflow count in
 	 * the ring.
 	 */
-	spin_lock_irqsave(&ctx->completion_lock, flags);
 	cqe = io_peek_cqring(ctx);
 	if (cqe) {
 		cqe->index = ki_index;
@@ -229,6 +376,15 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, unsigned ki_index,
 		io_inc_cqring(ctx);
 	} else
 		ctx->cq_ring->overflow++;
+}
+
+static void io_cqring_fill_event(struct io_ring_ctx *ctx, unsigned ki_index,
+				 long res, unsigned ev_flags)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+	__io_cqring_fill_event(ctx, ki_index, res, ev_flags);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 }
 
@@ -243,8 +399,23 @@ static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 	io_free_kiocb(iocb);
 }
 
+static void io_complete_scqring_iopoll(struct kiocb *kiocb, long res, long res2)
+{
+	struct io_kiocb *iocb = container_of(kiocb, struct io_kiocb, rw);
+
+	kiocb_end_write(kiocb);
+
+	if (unlikely(res == -EAGAIN)) {
+		set_bit(KIOCB_F_IOPOLL_EAGAIN, &iocb->ki_flags);
+	} else {
+		__io_cqring_fill_event(iocb->ki_ctx, iocb->ki_index, res, 0);
+		set_bit(KIOCB_F_IOPOLL_COMPLETED, &iocb->ki_flags);
+	}
+}
+
 static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
 {
+	struct io_ring_ctx *ctx = kiocb->ki_ctx;
 	struct kiocb *req = &kiocb->rw;
 	int ret;
 
@@ -266,12 +437,22 @@ static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
 	ret = kiocb_set_rw_flags(req, sqe->rw_flags);
 	if (unlikely(ret))
 		goto out_fput;
-	if (req->ki_flags & IOCB_HIPRI) {
-		ret = -EINVAL;
-		goto out_fput;
-	}
 
-	req->ki_complete = io_complete_scqring_rw;
+	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		ret = -EOPNOTSUPP;
+		if (!(req->ki_flags & IOCB_DIRECT) ||
+		    !req->ki_filp->f_op->iopoll)
+			goto out_fput;
+
+		req->ki_flags |= IOCB_HIPRI;
+		req->ki_complete = io_complete_scqring_iopoll;
+	} else {
+		if (req->ki_flags & IOCB_HIPRI) {
+			ret = -EINVAL;
+			goto out_fput;
+		}
+		req->ki_complete = io_complete_scqring_rw;
+	}
 	return 0;
 out_fput:
 	fput(req->ki_filp);
@@ -298,6 +479,30 @@ static inline void io_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
+/*
+ * After the iocb has been issued, it's safe to be found on the poll list.
+ * Adding the kiocb to the list AFTER submission ensures that we don't
+ * find it from a io_getevents() thread before the issuer is done accessing
+ * the kiocb cookie.
+ */
+static void io_iopoll_kiocb_issued(struct io_kiocb *kiocb)
+{
+	/*
+	 * For fast devices, IO may have already completed. If it has, add
+	 * it to the front so we find it first. We can't add to the poll_done
+	 * list as that's unlocked from the completion side.
+	 */
+	const int front = test_bit(KIOCB_F_IOPOLL_COMPLETED, &kiocb->ki_flags);
+	struct io_ring_ctx *ctx = kiocb->ki_ctx;
+
+	spin_lock(&ctx->poll_lock);
+	if (front)
+		list_add(&kiocb->ki_list, &ctx->poll_submitted);
+	else
+		list_add_tail(&kiocb->ki_list, &ctx->poll_submitted);
+	spin_unlock(&ctx->poll_lock);
+}
+
 static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
@@ -400,6 +605,8 @@ static int io_fsync(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
 {
 	struct fsync_iocb *req = &kiocb->fsync;
 
+	if (kiocb->ki_ctx->flags & IORING_SETUP_IOPOLL)
+		return -EINVAL;
 	if (unlikely(sqe->addr || sqe->off || sqe->len || sqe->__resv))
 		return -EINVAL;
 
@@ -461,6 +668,13 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	 */
 	if (ret)
 		goto out_put_req;
+	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		if (test_bit(KIOCB_F_IOPOLL_EAGAIN, &req->ki_flags)) {
+			ret = -EAGAIN;
+			goto out_put_req;
+		}
+		io_iopoll_kiocb_issued(req);
+	}
 	return 0;
 out_put_req:
 	io_free_kiocb(req);
@@ -573,12 +787,17 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 			return ret;
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
+		unsigned nr_events = 0;
 		int get_ret;
 
 		if (!ret && to_submit)
 			min_complete = 0;
 
-		get_ret = io_cqring_wait(ctx, min_complete);
+		if (ctx->flags & IORING_SETUP_IOPOLL)
+			get_ret = io_iopoll_check(ctx, &nr_events,
+							min_complete);
+		else
+			get_ret = io_cqring_wait(ctx, min_complete);
 		if (get_ret < 0 && !ret)
 			ret = get_ret;
 	}
@@ -604,6 +823,7 @@ static void io_free_scq_urings(struct io_ring_ctx *ctx)
 
 static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
+	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
 	percpu_ref_exit(&ctx->refs);
 	kfree(ctx);
@@ -612,6 +832,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 {
 	percpu_ref_kill(&ctx->refs);
+	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
 	io_ring_ctx_free(ctx);
 }
@@ -815,7 +1036,7 @@ SYSCALL_DEFINE3(io_uring_setup, u32, entries, struct iovec __user *, iovecs,
 			return -EINVAL;
 	}
 
-	if (p.flags)
+	if (p.flags & ~IORING_SETUP_IOPOLL)
 		return -EINVAL;
 	if (iovecs)
 		return -EINVAL;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index ae30ed41965f..ba9e5b851f73 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -31,6 +31,11 @@ struct io_uring_sqe {
 	};
 };
 
+/*
+ * io_uring_setup() flags
+ */
+#define IORING_SETUP_IOPOLL	(1 << 0)	/* io_context is polled */
+
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
 #define IORING_OP_FSYNC		3
-- 
2.17.1

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
