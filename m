From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/15] io_uring: add submission polling
Date: Wed,  9 Jan 2019 19:44:03 -0700
Message-ID: <20190110024404.25372-15-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

This enables an application to do IO, without ever entering the kernel.
By using the SQ ring to fill in new events and watching for completions
on the CQ ring, we can submit and reap IOs without doing a single system
call. The kernel side thread will poll for new submissions, and in case
of HIPRI/polled IO, it'll also poll for completions.

For O_DIRECT, we can do this with just SQTHREAD being enabled. For
buffered aio, we need the workqueue as well. If we can satisfy the
buffered inline from the SQTHREAD, we do that. If not, we punt to the
workqueue. This is just like buffered aio off the io_uring_enter(2)
system call.

Proof of concept. If the thread has been idle for 1 second, it will set
sq_ring->flags |= IORING_SQ_NEED_WAKEUP. The application will have to
call io_uring_enter() to start things back up again. If IO is kept busy,
that will never be needed. Basically an application that has this
feature enabled will guard it's io_uring_enter(2) call with:

barrier();
if (*sq_ring->flags & IORING_SQ_NEED_WAKEUP)
	io_uring_enter(fd, to_submit, 0, 0);

instead of calling it unconditionally.

Improvements:

1) Maybe have smarter backoff. Busy loop for X time, then go to
   monitor/mwait, finally the schedule we have now after an idle
   second. Might not be worth the complexity.

2) Probably want the application to pass in the appropriate grace
   period, not hard code it at 1 second.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 102 +++++++++++++++++++++++++++++++---
 include/uapi/linux/io_uring.h |   3 +
 2 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index da46872ecd67..6c62329b00ec 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -67,6 +67,7 @@ struct io_mapped_ubuf {
 
 struct io_sq_offload {
 	struct task_struct	*thread;	/* if using a thread */
+	bool			thread_poll;
 	struct workqueue_struct	*wq;		/* wq offload */
 	struct mm_struct	*mm;
 	struct files_struct	*files;
@@ -1145,17 +1146,35 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 {
 	struct io_submit_state state, *statep = NULL;
 	int ret, i, submitted = 0;
+	bool nonblock;
 
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 
+	/*
+	 * Having both a thread and a workqueue only makes sense for buffered
+	 * IO, where we can't submit in an async fashion. Use the NOWAIT
+	 * trick from the SQ thread, and punt to the workqueue if we can't
+	 * satisfy this iocb without blocking. This is only necessary
+	 * for buffered IO with sqthread polled submission.
+	 */
+	nonblock = (ctx->flags & IORING_SETUP_SQWQ) != 0;
+
 	for (i = 0; i < nr; i++) {
-		if (unlikely(mm_fault))
+		if (unlikely(mm_fault)) {
 			ret = -EFAULT;
-		else
-			ret = io_submit_sqe(ctx, &sqes[i], statep, false);
+		} else {
+			ret = io_submit_sqe(ctx, &sqes[i], statep, nonblock);
+			/* nogo, submit to workqueue */
+			if (nonblock && ret == -EAGAIN)
+				ret = io_queue_async_work(ctx, &sqes[i]);
+			if (!ret) {
+				submitted++;
+				continue;
+			}
+		}
 		if (!ret) {
 			submitted++;
 			continue;
@@ -1171,7 +1190,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 }
 
 /*
- * sq thread only supports O_DIRECT or FIXEDBUFS IO
+ * SQ thread is woken if the app asked for offloaded submission. This can
+ * be either O_DIRECT, in which case we do submissions directly, or it can
+ * be buffered IO, in which case we do them inline if we can do so without
+ * blocking. If we can't, then we punt to a workqueue.
  */
 static int io_sq_thread(void *data)
 {
@@ -1182,6 +1204,8 @@ static int io_sq_thread(void *data)
 	struct files_struct *old_files;
 	mm_segment_t old_fs;
 	DEFINE_WAIT(wait);
+	unsigned inflight;
+	unsigned long timeout;
 
 	old_files = current->files;
 	current->files = sqo->files;
@@ -1189,11 +1213,49 @@ static int io_sq_thread(void *data)
 	old_fs = get_fs();
 	set_fs(USER_DS);
 
+	timeout = inflight = 0;
 	while (!kthread_should_stop()) {
 		bool mm_fault = false;
 		int i;
 
+		if (sqo->thread_poll && inflight) {
+			unsigned int nr_events = 0;
+
+			/*
+			 * Normal IO, just pretend everything completed.
+			 * We don't have to poll completions for that.
+			 */
+			if (ctx->flags & IORING_SETUP_IOPOLL) {
+				/*
+				 * App should not use IORING_ENTER_GETEVENTS
+				 * with thread polling, but if it does, then
+				 * ensure we are mutually exclusive.
+				 */
+				if (mutex_trylock(&ctx->uring_lock)) {
+					io_iopoll_check(ctx, &nr_events, 0);
+					mutex_unlock(&ctx->uring_lock);
+				}
+			} else {
+				nr_events = inflight;
+			}
+
+			inflight -= nr_events;
+			if (!inflight)
+				timeout = jiffies + HZ;
+		}
+
 		if (!io_peek_sqring(ctx, &sqes[0])) {
+			/*
+			 * If we're polling, let us spin for a second without
+			 * work before going to sleep.
+			 */
+			if (sqo->thread_poll) {
+				if (inflight || !time_after(jiffies, timeout)) {
+					cpu_relax();
+					continue;
+				}
+			}
+
 			/*
 			 * Drop cur_mm before scheduling, we can't hold it for
 			 * long periods (or over schedule()). Do this before
@@ -1207,6 +1269,13 @@ static int io_sq_thread(void *data)
 			}
 
 			prepare_to_wait(&sqo->wait, &wait, TASK_INTERRUPTIBLE);
+
+			/* Tell userspace we may need a wakeup call */
+			if (sqo->thread_poll) {
+				ctx->sq_ring->flags |= IORING_SQ_NEED_WAKEUP;
+				smp_wmb();
+			}
+
 			if (!io_peek_sqring(ctx, &sqes[0])) {
 				if (kthread_should_park())
 					kthread_parkme();
@@ -1218,6 +1287,13 @@ static int io_sq_thread(void *data)
 					flush_signals(current);
 				schedule();
 				finish_wait(&sqo->wait, &wait);
+
+				if (sqo->thread_poll) {
+					struct io_sq_ring *ring;
+
+					ring = ctx->sq_ring;
+					ring->flags &= ~IORING_SQ_NEED_WAKEUP;
+				}
 				continue;
 			}
 			finish_wait(&sqo->wait, &wait);
@@ -1240,7 +1316,7 @@ static int io_sq_thread(void *data)
 			io_inc_sqring(ctx);
 		} while (io_peek_sqring(ctx, &sqes[i]));
 
-		io_submit_sqes(ctx, sqes, i, cur_mm, mm_fault);
+		inflight += io_submit_sqes(ctx, sqes, i, cur_mm, mm_fault);
 	}
 	current->files = old_files;
 	set_fs(old_fs);
@@ -1483,6 +1559,9 @@ static int io_sq_thread_start(struct io_ring_ctx *ctx)
 	if (!sqo->files)
 		goto err;
 
+	if (ctx->flags & IORING_SETUP_SQPOLL)
+		sqo->thread_poll = true;
+
 	if (ctx->flags & IORING_SETUP_SQTHREAD) {
 		sqo->thread = kthread_create_on_cpu(io_sq_thread, ctx,
 							ctx->sq_thread_cpu,
@@ -1493,7 +1572,8 @@ static int io_sq_thread_start(struct io_ring_ctx *ctx)
 			goto err;
 		}
 		wake_up_process(sqo->thread);
-	} else if (ctx->flags & IORING_SETUP_SQWQ) {
+	}
+	if (ctx->flags & IORING_SETUP_SQWQ) {
 		int concurrency;
 
 		/* Do QD, or 2 * CPUS, whatever is smallest */
@@ -1524,7 +1604,8 @@ static void io_sq_thread_stop(struct io_ring_ctx *ctx)
 		kthread_park(sqo->thread);
 		kthread_stop(sqo->thread);
 		sqo->thread = NULL;
-	} else if (sqo->wq) {
+	}
+	if (sqo->wq) {
 		destroy_workqueue(sqo->wq);
 		sqo->wq = NULL;
 	}
@@ -1738,6 +1819,11 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p,
 		if (ret)
 			goto err;
 	}
+	if ((p->flags & IORING_SETUP_SQPOLL) &&
+	   !(p->flags & IORING_SETUP_SQTHREAD)) {
+		ret = -EINVAL;
+		goto err;
+	}
 	if (p->flags & (IORING_SETUP_SQTHREAD | IORING_SETUP_SQWQ)) {
 		ctx->sq_thread_cpu = p->sq_thread_cpu;
 
@@ -1778,7 +1864,7 @@ SYSCALL_DEFINE3(io_uring_setup, u32, entries, struct iovec __user *, iovecs,
 	}
 
 	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQTHREAD |
-			IORING_SETUP_SQWQ))
+			IORING_SETUP_SQWQ | IORING_SETUP_SQPOLL))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p, iovecs);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 79004940f7da..9321eb97479d 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -37,6 +37,7 @@ struct io_uring_sqe {
 #define IORING_SETUP_IOPOLL	(1 << 0)	/* io_context is polled */
 #define	IORING_SETUP_SQTHREAD	(1 << 1)	/* Use SQ thread */
 #define IORING_SETUP_SQWQ	(1 << 2)	/* Use SQ workqueue */
+#define IORING_SETUP_SQPOLL	(1 << 3)	/* SQ thread polls */
 
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
@@ -75,6 +76,8 @@ struct io_sqring_offsets {
 	__u32 resv[3];
 };
 
+#define IORING_SQ_NEED_WAKEUP	(1 << 0) /* needs io_uring_enter wakeup */
+
 struct io_cqring_offsets {
 	__u32 head;
 	__u32 tail;
-- 
2.17.1

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
