Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:54702 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbfAHQ5M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2019 11:57:12 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so7231498ita.4
        for <linux-arch@vger.kernel.org>; Tue, 08 Jan 2019 08:57:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/16] io_uring: split kiocb init from allocation
Date: Tue,  8 Jan 2019 09:56:39 -0700
Message-ID: <20190108165645.19311-11-axboe@kernel.dk>
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
Message-ID: <20190108165639.PJs7HVTXaILCuO1c7SE1SZ5SFnNUBOca3LR_eqJEkwo@z>

In preparation from having pre-allocated requests, that we then just
need to initialize before use.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index afbaebb63012..11d045f0f799 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -202,6 +202,14 @@ static struct io_uring_event *io_peek_cqring(struct io_ring_ctx *ctx)
 	return &ring->events[tail & ctx->cq_ring.ring_mask];
 }
 
+static void io_req_init(struct io_ring_ctx *ctx, struct io_kiocb *req)
+{
+	percpu_ref_get(&ctx->refs);
+	req->ki_ctx = ctx;
+	INIT_LIST_HEAD(&req->ki_list);
+	req->ki_flags = 0;
+}
+
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
 {
 	struct io_kiocb *req;
@@ -210,10 +218,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
 	if (!req)
 		return NULL;
 
-	percpu_ref_get(&ctx->refs);
-	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
-	req->ki_flags = 0;
+	io_req_init(ctx, req);
 	return req;
 }
 
-- 
2.17.1
