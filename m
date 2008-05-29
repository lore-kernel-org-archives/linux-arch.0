From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 04/37] crypto: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:00 -0700
Message-ID: <1212092280.28403.106.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:41560 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbYE2USE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:04 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083442wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:01 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 crypto/ccm.c         |    6 +++---
 crypto/crc32c.c      |    6 +++---
 crypto/ctr.c         |    3 +--
 crypto/lrw.c         |    2 +-
 crypto/michael_mic.c |    4 ++--
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/crypto/ccm.c b/crypto/ccm.c
index 7cf7e5a..54638a7 100644
--- a/crypto/ccm.c
+++ b/crypto/ccm.c
@@ -150,11 +150,11 @@ static int format_adata(u8 *adata, unsigned int a)
 	 * RFC 3610 and NIST Special Publication 800-38C
 	 */
 	if (a < 65280) {
-		*(__be16 *)adata = cpu_to_be16(a);
+		put_be16(a, (__be16 *)adata);
 		len = 2;
 	} else  {
-		*(__be16 *)adata = cpu_to_be16(0xfffe);
-		*(__be32 *)&adata[2] = cpu_to_be32(a);
+		put_be16(0xfffe, (__be16 *)adata);
+		put_be32(a, (__be32 *)&adata[2]);
 		len = 6;
 	}
 
diff --git a/crypto/crc32c.c b/crypto/crc32c.c
index 0dcf64a..a1c3f8a 100644
--- a/crypto/crc32c.c
+++ b/crypto/crc32c.c
@@ -52,7 +52,7 @@ static int chksum_setkey(struct crypto_tfm *tfm, const u8 *key,
 		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
 		return -EINVAL;
 	}
-	mctx->key = le32_to_cpu(*(__le32 *)key);
+	mctx->key = get_le32((__le32 *)key);
 	return 0;
 }
 
@@ -67,8 +67,8 @@ static void chksum_update(struct crypto_tfm *tfm, const u8 *data,
 static void chksum_final(struct crypto_tfm *tfm, u8 *out)
 {
 	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
-	
-	*(__le32 *)out = ~cpu_to_le32(mctx->crc);
+
+	put_le32(~mctx->crc, (__le32 *)out);
 }
 
 static int crc32c_cra_init(struct crypto_tfm *tfm)
diff --git a/crypto/ctr.c b/crypto/ctr.c
index 2d7425f..5105d07 100644
--- a/crypto/ctr.c
+++ b/crypto/ctr.c
@@ -285,8 +285,7 @@ static int crypto_rfc3686_crypt(struct blkcipher_desc *desc,
 	memcpy(iv + CTR_RFC3686_NONCE_SIZE, info, CTR_RFC3686_IV_SIZE);
 
 	/* initialize counter portion of counter block */
-	*(__be32 *)(iv + CTR_RFC3686_NONCE_SIZE + CTR_RFC3686_IV_SIZE) =
-		cpu_to_be32(1);
+	put_be32(1, (__be32 *)(iv + CTR_RFC3686_NONCE_SIZE + CTR_RFC3686_IV_SIZE));
 
 	desc->tfm = child;
 	desc->info = iv;
diff --git a/crypto/lrw.c b/crypto/lrw.c
index 8ef664e..42a4533 100644
--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -111,7 +111,7 @@ static inline int get_index128(be128 *block)
 	__be32 *p = (__be32 *) block;
 
 	for (p += 3, x = 0; x < 128; p--, x += 32) {
-		u32 val = be32_to_cpup(p);
+		u32 val = get_be32(p);
 
 		if (!~val)
 			continue;
diff --git a/crypto/michael_mic.c b/crypto/michael_mic.c
index 9e917b8..8aab62f 100644
--- a/crypto/michael_mic.c
+++ b/crypto/michael_mic.c
@@ -71,7 +71,7 @@ static void michael_update(struct crypto_tfm *tfm, const u8 *data,
 			return;
 
 		src = (const __le32 *)mctx->pending;
-		mctx->l ^= le32_to_cpup(src);
+		mctx->l ^= get_le32(src);
 		michael_block(mctx->l, mctx->r);
 		mctx->pending_len = 0;
 	}
@@ -79,7 +79,7 @@ static void michael_update(struct crypto_tfm *tfm, const u8 *data,
 	src = (const __le32 *)data;
 
 	while (len >= 4) {
-		mctx->l ^= le32_to_cpup(src++);
+		mctx->l ^= get_le32(src++);
 		michael_block(mctx->l, mctx->r);
 		len -= 4;
 	}
-- 
1.5.6.rc0.277.g804cf
