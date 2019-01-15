Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42581 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfAOCzu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jan 2019 21:55:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so550345pga.9
        for <linux-arch@vger.kernel.org>; Mon, 14 Jan 2019 18:55:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/16] io_uring: add fsync support
Date: Mon, 14 Jan 2019 19:55:21 -0700
Message-ID: <20190115025531.13985-7-axboe@kernel.dk>
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
Message-ID: <20190115025521.YZXlf1-VADfZSDfYdTzq69gTIPEaub0smGAVo0fTYVs@z>

From: Christoph Hellwig <hch@lst.de>

Add a new fsync opcode, which either syncs a range if one is passed,
or the whole file if the offset and length fields are both cleared
to zero.  A flag is provided to use fdatasync semantics, that is only
force out metadata which is required to retrieve the file data, but
not others like metadata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  8 +++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 148eb3af7dc4..7d74463217a6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -449,6 +449,36 @@ static int io_nop(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return 0;
 }
 
+static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		    bool force_nonblock)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	loff_t end = sqe->off + sqe->len;
+	struct file *file;
+	int ret;
+
+	/* fsync always requires a blocking context */
+	if (force_nonblock)
+		return -EAGAIN;
+
+	if (unlikely(sqe->addr))
+		return -EINVAL;
+	if (unlikely(sqe->fsync_flags & ~IORING_FSYNC_DATASYNC))
+		return -EINVAL;
+
+	file = fget(sqe->fd);
+	if (unlikely(!file))
+		return -EBADF;
+
+	ret = vfs_fsync_range(file, sqe->off, end > 0 ? end : LLONG_MAX,
+			sqe->fsync_flags & IORING_FSYNC_DATASYNC);
+
+	fput(file);
+	io_cqring_fill_event(ctx, sqe->user_data, ret, 0);
+	io_free_req(req);
+	return 0;
+}
+
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			   struct sqe_submit *s, bool force_nonblock)
 {
@@ -474,6 +504,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_WRITEV:
 		ret = io_write(req, sqe, force_nonblock);
 		break;
+	case IORING_OP_FSYNC:
+		ret = io_fsync(req, sqe, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index a1ebaa09e1b8..ac49bd179ed9 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -27,7 +27,7 @@ struct io_uring_sqe {
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
 		__kernel_rwf_t	rw_flags;
-		__u32		__resv;
+		__u32		fsync_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	__u64	__pad2[3];
@@ -36,6 +36,12 @@ struct io_uring_sqe {
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
+#define IORING_OP_FSYNC		3
+
+/*
+ * sqe->fsync_flags
+ */
+#define IORING_FSYNC_DATASYNC	(1 << 0)
 
 /*
  * IO completion data structure (Completion Queue Entry)
-- 
2.17.1
