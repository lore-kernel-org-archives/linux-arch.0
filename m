From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 37/37] unaligned-access: use get/put_endian helpers
Date: Thu, 29 May 2008 13:19:17 -0700
Message-ID: <1212092357.28403.139.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:41560 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbYE2UTR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:19:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083442wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:19:17 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Arches that have no unaligned access restictions can call the
aligned versions.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/linux/unaligned/access_ok.h |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/unaligned/access_ok.h b/include/linux/unaligned/access_ok.h
index 99c1b4d..341074d 100644
--- a/include/linux/unaligned/access_ok.h
+++ b/include/linux/unaligned/access_ok.h
@@ -6,62 +6,62 @@
 
 static inline u16 get_unaligned_le16(const void *p)
 {
-	return le16_to_cpup((__le16 *)p);
+	return get_le16((__le16 *)p);
 }
 
 static inline u32 get_unaligned_le32(const void *p)
 {
-	return le32_to_cpup((__le32 *)p);
+	return get_le32((__le32 *)p);
 }
 
 static inline u64 get_unaligned_le64(const void *p)
 {
-	return le64_to_cpup((__le64 *)p);
+	return get_le64((__le64 *)p);
 }
 
 static inline u16 get_unaligned_be16(const void *p)
 {
-	return be16_to_cpup((__be16 *)p);
+	return get_be16((__be16 *)p);
 }
 
 static inline u32 get_unaligned_be32(const void *p)
 {
-	return be32_to_cpup((__be32 *)p);
+	return get_be32((__be32 *)p);
 }
 
 static inline u64 get_unaligned_be64(const void *p)
 {
-	return be64_to_cpup((__be64 *)p);
+	return get_be64((__be64 *)p);
 }
 
 static inline void put_unaligned_le16(u16 val, void *p)
 {
-	*((__le16 *)p) = cpu_to_le16(val);
+	put_le16(val, (__le16 *)p);
 }
 
 static inline void put_unaligned_le32(u32 val, void *p)
 {
-	*((__le32 *)p) = cpu_to_le32(val);
+	put_le32(val, (__le32 *)p);
 }
 
 static inline void put_unaligned_le64(u64 val, void *p)
 {
-	*((__le64 *)p) = cpu_to_le64(val);
+	put_le64(val, (__le64 *)p);
 }
 
 static inline void put_unaligned_be16(u16 val, void *p)
 {
-	*((__be16 *)p) = cpu_to_be16(val);
+	put_be16(val, (__be16 *)p);
 }
 
 static inline void put_unaligned_be32(u32 val, void *p)
 {
-	*((__be32 *)p) = cpu_to_be32(val);
+	put_be32(val, (__be32 *)p);
 }
 
 static inline void put_unaligned_be64(u64 val, void *p)
 {
-	*((__be64 *)p) = cpu_to_be64(val);
+	put_be64(val, (__be64 *)p);
 }
 
 #endif /* _LINUX_UNALIGNED_ACCESS_OK_H */
-- 
1.5.6.rc0.277.g804cf
