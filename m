From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 35/37] 9p: use get/put_endian helpers
Date: Thu, 29 May 2008 13:19:13 -0700
Message-ID: <1212092353.28403.137.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:43046 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152AbYE2UTO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:19:14 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083458wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:19:13 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 net/9p/conv.c         |   14 +++++++-------
 net/9p/trans_fd.c     |    2 +-
 net/9p/trans_virtio.c |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/9p/conv.c b/net/9p/conv.c
index 4454720..e9a21ce 100644
--- a/net/9p/conv.c
+++ b/net/9p/conv.c
@@ -92,7 +92,7 @@ static void buf_put_int8(struct cbuf *buf, u8 val)
 static void buf_put_int16(struct cbuf *buf, u16 val)
 {
 	if (buf_check_size(buf, 2)) {
-		*(__le16 *) buf->p = cpu_to_le16(val);
+		put_le16(val, (__le16 *)buf->p);
 		buf->p += 2;
 	}
 }
@@ -100,7 +100,7 @@ static void buf_put_int16(struct cbuf *buf, u16 val)
 static void buf_put_int32(struct cbuf *buf, u32 val)
 {
 	if (buf_check_size(buf, 4)) {
-		*(__le32 *)buf->p = cpu_to_le32(val);
+		put_le32(val, (__le32 *)buf->p);
 		buf->p += 4;
 	}
 }
@@ -108,7 +108,7 @@ static void buf_put_int32(struct cbuf *buf, u32 val)
 static void buf_put_int64(struct cbuf *buf, u64 val)
 {
 	if (buf_check_size(buf, 8)) {
-		*(__le64 *)buf->p = cpu_to_le64(val);
+		put_le64(val, (__le64 *)buf->p);
 		buf->p += 8;
 	}
 }
@@ -145,7 +145,7 @@ static u16 buf_get_int16(struct cbuf *buf)
 	u16 ret = 0;
 
 	if (buf_check_size(buf, 2)) {
-		ret = le16_to_cpu(*(__le16 *)buf->p);
+		ret = get_le16((__le16 *)buf->p);
 		buf->p += 2;
 	}
 
@@ -157,7 +157,7 @@ static u32 buf_get_int32(struct cbuf *buf)
 	u32 ret = 0;
 
 	if (buf_check_size(buf, 4)) {
-		ret = le32_to_cpu(*(__le32 *)buf->p);
+		ret = get_le32((__le32 *)buf->p);
 		buf->p += 4;
 	}
 
@@ -169,7 +169,7 @@ static u64 buf_get_int64(struct cbuf *buf)
 	u64 ret = 0;
 
 	if (buf_check_size(buf, 8)) {
-		ret = le64_to_cpu(*(__le64 *)buf->p);
+		ret = get_le64((__le64 *)buf->p);
 		buf->p += 8;
 	}
 
@@ -520,7 +520,7 @@ p9_create_common(struct cbuf *bufp, u32 size, u8 id)
 void p9_set_tag(struct p9_fcall *fc, u16 tag)
 {
 	fc->tag = tag;
-	*(__le16 *) (fc->sdata + 5) = cpu_to_le16(tag);
+	put_le16(tag, (__le16 *)(fc->sdata + 5));
 }
 EXPORT_SYMBOL(p9_set_tag);
 
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 4507f74..df2ba92 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -771,7 +771,7 @@ static void p9_read_work(struct work_struct *work)
 
 	m->rpos += err;
 	while (m->rpos > 4) {
-		n = le32_to_cpu(*(__le32 *) m->rbuf);
+		n = get_le32((__le32 *)m->rbuf);
 		if (n >= m->msize) {
 			P9_DPRINTK(P9_DEBUG_ERROR,
 				"requested packet size too big: %d\n", n);
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 42adc05..240603d 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -339,7 +339,7 @@ p9_virtio_rpc(struct p9_trans *t, struct p9_fcall *tc, struct p9_fcall **rc)
 
 	wait_event(*req->wq, req->status == REQ_STATUS_RCVD);
 
-	size = le32_to_cpu(*(__le32 *) rdata);
+	size = get_le32((__le32 *)rdata);
 
 	err = p9_deserialize_fcall(rdata, size, *rc, t->extended);
 	if (err < 0) {
-- 
1.5.6.rc0.277.g804cf
