From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/16] io_uring: add io_uring_event cache hit information
Date: Tue,  8 Jan 2019 09:56:45 -0700
Message-ID: <20190108165645.19311-17-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

Add hint on whether a read was served out of the page cache, or if it
hit media. This is useful for buffered async IO, O_DIRECT reads would
never have this set (for obvious reasons).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 6 +++++-
 include/uapi/linux/io_uring.h | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6c10841e4342..50b9cfa8c861 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -524,12 +524,16 @@ static void io_fill_cq_error(struct io_ring_ctx *ctx, unsigned ki_index,
 static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *iocb = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
 	fput(kiocb->ki_filp);
 
-	io_complete_scqring(iocb, res, 0);
+	if (res > 0 && test_bit(KIOCB_F_FORCE_NONBLOCK, &iocb->ki_flags))
+		ev_flags = IOEV_FLAG_CACHEHIT;
+
+	io_complete_scqring(iocb, res, ev_flags);
 }
 
 static void io_complete_scqring_iopoll(struct kiocb *kiocb, long res, long res2)
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index bd665d38dd97..7dd21126f142 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -56,6 +56,11 @@ struct io_uring_event {
 	__u32	flags;
 };
 
+/*
+ * io_uring_event->flags
+ */
+#define IOEV_FLAG_CACHEHIT	(1 << 0)	/* IO did not hit media */
+
 /*
  * Magic offsets for the application to mmap the data it needs
  */
-- 
2.17.1

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
