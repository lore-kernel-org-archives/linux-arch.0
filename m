From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 3/6v3] byteorder: add get/put endian helpers for the
	aligned case
Date: Wed, 28 May 2008 12:33:01 -0700
Message-ID: <1212003181.5964.28.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:55926 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbYE1TdO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 May 2008 15:33:14 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2048371ywe.1
        for <linux-arch@vger.kernel.org>; Wed, 28 May 2008 12:33:05 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

Create helpers when working with aligned loads/stores, same
functionality as get_unaligned_* and put_unaligned_*

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/linux/byteorder.h |   84 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/include/linux/byteorder.h b/include/linux/byteorder.h
index b4713ce..ad47244 100644
--- a/include/linux/byteorder.h
+++ b/include/linux/byteorder.h
@@ -278,6 +278,90 @@ static inline __be64 __cpu_to_be64p(const __u64 *p)
 # define htons(x) ___htons(x)
 # define ntohs(x) ___ntohs(x)
 
+static inline u16 get_le16(const __le16 *p)
+{
+#ifdef __LITTLE_ENDIAN
+	return (__force u16)*p;
+#else
+	return swab16p((__force u16 *)p);
+#endif
+}
+
+static inline u32 get_le32(const __le32 *p)
+{
+#ifdef __LITTLE_ENDIAN
+	return (__force u32)*p;
+#else
+	return swab32p((__force u32 *)p);
+#endif
+}
+
+static inline u64 get_le64(const __le64 *p)
+{
+#ifdef __LITTLE_ENDIAN
+	return (__force u64)*p;
+#else
+	return __swab64p((__force u64 *)p);
+#endif
+}
+
+static inline u16 get_be16(const __be16 *p)
+{
+#ifdef __BIG_ENDIAN
+	return (__force u16)*p;
+#else
+	return swab16p((__force u16 *)p);
+#endif
+}
+
+static inline u32 get_be32(const __be32 *p)
+{
+#ifdef __BIG_ENDIAN
+	return (__force u32)*p;
+#else
+	return swab32p((__force u32 *)p);
+#endif
+}
+
+static inline u64 get_be64(const __be64 *p)
+{
+#ifdef __BIG_ENDIAN
+	return (__force u64)*p;
+#else
+	return __swab64p((__force u64 *)p);
+#endif
+}
+
+static inline void put_le16(u16 val, __le16 *p)
+{
+	*p = cpu_to_le16(val);
+}
+
+static inline void put_le32(u32 val, __le32 *p)
+{
+	*p = cpu_to_le32(val);
+}
+
+static inline void put_le64(u64 val, __le64 *p)
+{
+	*p = cpu_to_le64(val);
+}
+
+static inline void put_be16(u16 val, __be16 *p)
+{
+	*p = cpu_to_be16(val);
+}
+
+static inline void put_be32(u32 val, __be32 *p)
+{
+	*p = cpu_to_be32(val);
+}
+
+static inline void put_be64(u64 val, __be64 *p)
+{
+	*p = cpu_to_be64(val);
+}
+
 static inline void le16_add_cpu(__le16 *var, u16 val)
 {
 	*var = cpu_to_le16(le16_to_cpup(var) + val);
-- 
1.5.5.1.579.g4e43
