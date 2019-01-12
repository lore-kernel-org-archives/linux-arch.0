From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/16] io_uring: add io_uring_event cache hit information
Date: Sat, 12 Jan 2019 14:30:11 -0700
Message-ID: <20190112213011.1439-17-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

Add hint on whether a read was served out of the page cache, or if it
hit media. This is useful for buffered async IO, O_DIRECT reads would
never have this set (for obvious reasons).

If the read hit page cache, cqe->flags will have IOCQE_FLAG_CACHEHIT
set.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 7 ++++++-
 include/uapi/linux/io_uring.h | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 66a76f9fa7af..5074cdd85f43 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -573,11 +573,16 @@ static void io_fput(struct io_kiocb *req)
 static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
 	io_fput(req);
-	io_cqring_fill_event(req->ki_ctx, req->ki_user_data, res, 0);
+
+	if (res > 0 && (req->ki_flags & REQ_F_FORCE_NONBLOCK))
+		ev_flags = IOCQE_FLAG_CACHEHIT;
+
+	io_cqring_fill_event(req->ki_ctx, req->ki_user_data, res, ev_flags);
 	io_free_req(req);
 }
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index ffdaf46f19dd..74370aed5f71 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -67,6 +67,11 @@ struct io_uring_cqe {
 	__u32	flags;
 };
 
+/*
+ * io_uring_event->flags
+ */
+#define IOCQE_FLAG_CACHEHIT	(1 << 0)	/* IO did not hit media */
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
