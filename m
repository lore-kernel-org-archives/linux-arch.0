Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42848 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfAJCos (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 21:44:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so4167907pga.9
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 18:44:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/15] io_uring: add io_uring_event cache hit information
Date: Wed,  9 Jan 2019 19:44:04 -0700
Message-ID: <20190110024404.25372-16-axboe@kernel.dk>
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
Message-ID: <20190110024404.Qq2nOpn8TfLH3jZa_JnjcyCCJsWQ9oDofZdcE--WIQE@z>

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
index 6c62329b00ec..f2a603c447ba 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -511,11 +511,16 @@ static void io_fill_cq_error(struct io_ring_ctx *ctx, struct sqe_submit *s,
 static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *iocb = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
 	fput(kiocb->ki_filp);
-	io_cqring_fill_event(iocb->ki_ctx, iocb->ki_index, res, 0);
+
+	if (res > 0 && test_bit(KIOCB_F_FORCE_NONBLOCK, &iocb->ki_flags))
+		ev_flags = IOCQE_FLAG_CACHEHIT;
+
+	io_cqring_fill_event(iocb->ki_ctx, iocb->ki_index, res, ev_flags);
 	io_free_kiocb(iocb);
 }
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 9321eb97479d..20e4c22e040d 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -55,6 +55,11 @@ struct io_uring_cqe {
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
