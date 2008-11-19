From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] unaligned: write in increasing memory order
Date: Wed, 19 Nov 2008 11:20:05 -0800
Message-ID: <1227122405.13182.21.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.251]:59989 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbYKSTUK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Nov 2008 14:20:10 -0500
Received: by hs-out-0708.google.com with SMTP id 4so66501hsl.5
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2008 11:20:09 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, "ralf@linux-mips.org" <ralf@linux-mips.org>, Geert Uytterhoeven <geert@linux-m68k.org>

This ordering seems more logical.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
gcc 4.2 seems to be smart enough to figure it out in either order.

 include/asm-generic/unaligned.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 3bef59f..55d1126 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -164,14 +164,14 @@ static inline void __put_le16_noalign(u8 *p, u16 val)
 
 static inline void __put_le32_noalign(u8 *p, u32 val)
 {
-	__put_le16_noalign(p + 2, val >> 16);
 	__put_le16_noalign(p, val);
+	__put_le16_noalign(p + 2, val >> 16);
 }
 
 static inline void __put_le64_noalign(u8 *p, u64 val)
 {
-	__put_le32_noalign(p + 4, val >> 32);
 	__put_le32_noalign(p, val);
+	__put_le32_noalign(p + 4, val >> 32);
 }
 
 static inline void __put_be16_noalign(u8 *p, u16 val)
-- 
1.6.0.4.1013.gc6a01
