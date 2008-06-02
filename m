From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCHv4 6/6] byteorder: add copy_{endian} helpers
Date: Mon, 02 Jun 2008 10:37:24 -0700
Message-ID: <1212428244.11008.40.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:37656 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481AbYFBRhi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jun 2008 13:37:38 -0400
Received: by yw-out-2324.google.com with SMTP id 9so562126ywe.1
        for <linux-arch@vger.kernel.org>; Mon, 02 Jun 2008 10:37:32 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, "tony.luck" <tony.luck@intel.com>

Add helpers for the idiom:
*(__le16 *)ptr = cpu_to_le16(val);

Can now be written as:
copy_le16(ptr, val);

Implemented as macros to allow val to be byteswapped at compile-time
when it is a constant.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/linux/byteorder.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/linux/byteorder.h b/include/linux/byteorder.h
index b4713ce..8d3c847 100644
--- a/include/linux/byteorder.h
+++ b/include/linux/byteorder.h
@@ -278,6 +278,17 @@ static inline __be64 __cpu_to_be64p(const __u64 *p)
 # define htons(x) ___htons(x)
 # define ntohs(x) ___ntohs(x)
 
+/*
+ * Defined as macros to allow constant folding of the cpu_to_XXXX when
+ * possible.
+ */
+#define copy_le16(ptr, val)	(*(__le16 *)(ptr) = cpu_to_le16((u16)(val));)
+#define copy_le32(ptr, val)	(*(__le32 *)(ptr) = cpu_to_le32((u32)(val));)
+#define copy_le64(ptr, val)	(*(__le64 *)(ptr) = cpu_to_le64((u64)(val));)
+#define copy_be16(ptr, val)	(*(__be16 *)(ptr) = cpu_to_be16((u16)(val));)
+#define copy_be32(ptr, val)	(*(__be32 *)(ptr) = cpu_to_be32((u32)(val));)
+#define copy_be64(ptr, val)	(*(__be64 *)(ptr) = cpu_to_be64((u64)(val));)
+
 static inline void le16_add_cpu(__le16 *var, u16 val)
 {
 	*var = cpu_to_le16(le16_to_cpup(var) + val);
-- 
1.5.6.rc0.277.g804cf
