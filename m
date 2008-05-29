From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 21/37] adfs: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:42 -0700
Message-ID: <1212092322.28403.123.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43327 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbYE2USn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:43 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392252yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:43 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Also move the macro to a static function.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/adfs/dir_f.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index ea7df21..c8f2736 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -73,11 +73,13 @@ static inline int adfs_readname(char *buf, char *ptr, int maxlen)
 	  *(u8 *)(bh[_buf]->b_data + _off);	\
 	})
 
-#define dir_u32(idx)				\
-	({ int _buf = idx >> blocksize_bits;	\
-	   int _off = idx - (_buf << blocksize_bits);\
-	  *(__le32 *)(bh[_buf]->b_data + _off);	\
-	})
+static u32 get_dir_u32(int idx, const struct adfs_dir *dir)
+{
+	int buf = (idx >> dir->sb->s_blocksize_bits);
+	int off = idx - (buf << dir->sb->s_blocksize_bits);
+
+	return get_le32((__le32 *)(dir->bh[buf]->b_data + off));
+}
 
 #define bufoff(_bh,_idx)			\
 	({ int _buf = _idx >> blocksize_bits;	\
@@ -108,7 +110,7 @@ adfs_dir_checkbyte(const struct adfs_dir *dir)
 	do {
 		last += 26;
 		do {
-			dircheck = le32_to_cpu(dir_u32(i)) ^ ror13(dircheck);
+			dircheck = get_dir_u32(i, dir) ^ ror13(dircheck);
 
 			i += sizeof(u32);
 		} while (i < (last & ~3));
-- 
1.5.6.rc0.277.g804cf
