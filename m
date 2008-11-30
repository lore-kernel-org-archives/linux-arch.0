From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH-mm 5/7] unaligned: wire up h8300 and m32r arches
Date: Sat, 29 Nov 2008 18:40:31 -0800
Message-ID: <1228012831.26141.1030.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:29749 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848AbYK3Ckr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Nov 2008 21:40:47 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2058677wfd.4
        for <linux-arch@vger.kernel.org>; Sat, 29 Nov 2008 18:40:47 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Hirokazu Takata <takata@linux-m32r.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

Provide arch overrides using memmove to avoid any functional
changes.  At a later time these arches should be able to just
use the common header directly, but this is not certain currently.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 arch/h8300/include/asm/unaligned.h |   51 +++++++++++++++++++++++++++---
 include/asm-m32r/unaligned.h       |   60 ++++++++++++++++++++++++++++--------
 2 files changed, 93 insertions(+), 18 deletions(-)

diff --git a/arch/h8300/include/asm/unaligned.h b/arch/h8300/include/asm/unaligned.h
index b8d06c7..a184b55 100644
--- a/arch/h8300/include/asm/unaligned.h
+++ b/arch/h8300/include/asm/unaligned.h
@@ -1,11 +1,52 @@
 #ifndef _ASM_H8300_UNALIGNED_H
 #define _ASM_H8300_UNALIGNED_H
 
-#include <linux/unaligned/be_memmove.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
 
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
 
+static inline u16 __arch_load_cpu16_noalign(const void *p)
+{
+	u16 tmp;
+	memmove(&tmp, p, 2);
+	return tmp;
+}
+#define __arch_load_cpu16_noalign __arch_load_cpu16_noalign
+
+static inline u32 __arch_load_cpu32_noalign(const void *p)
+{
+	u32 tmp;
+	memmove(&tmp, p, 4);
+	return tmp;
+}
+#define __arch_load_cpu32_noalign __arch_load_cpu32_noalign
+
+static inline u64 __arch_load_cpu16_noalign(const void *p)
+{
+	u64 tmp;
+	memmove(&tmp, p, 8);
+	return tmp;
+}
+#define __arch_load_cpu64_noalign __arch_load_cpu64_noalign
+
+static inline void __arch_store_cpu16_noalign(void *p, u16 val)
+{
+	memmove(p, &val, 2);
+}
+#define __arch_store_cpu16_noalign __arch_store_cpu16_noalign
+
+static inline void __arch_store_cpu32_noalign(void *p, u32 val)
+{
+	memmove(p, &val, 4);
+}
+#define __arch_store_cpu32_noalign __arch_store_cpu32_noalign
+
+static inline void __arch_store_cpu64_noalign(void *p, u64 val)
+{
+	memmove(p, &val, 8);
+}
+#define __arch_store_cpu64_noalign __arch_store_cpu64_noalign
+
+#include <linux/unaligned.h>
 #endif /* _ASM_H8300_UNALIGNED_H */
diff --git a/include/asm-m32r/unaligned.h b/include/asm-m32r/unaligned.h
index 377eb20..a676014 100644
--- a/include/asm-m32r/unaligned.h
+++ b/include/asm-m32r/unaligned.h
@@ -1,18 +1,52 @@
 #ifndef _ASM_M32R_UNALIGNED_H
 #define _ASM_M32R_UNALIGNED_H
 
-#if defined(__LITTLE_ENDIAN__)
-# include <linux/unaligned/le_memmove.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_le
-# define put_unaligned	__put_unaligned_le
-#else
-# include <linux/unaligned/be_memmove.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_be
-# define put_unaligned	__put_unaligned_be
-#endif
+#include <linux/kernel.h>
+#include <linux/string.h>
 
+/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
+
+static inline u16 __arch_load_cpu16_noalign(const void *p)
+{
+	u16 tmp;
+	memmove(&tmp, p, 2);
+	return tmp;
+}
+#define __arch_load_cpu16_noalign __arch_load_cpu16_noalign
+
+static inline u32 __arch_load_cpu32_noalign(const void *p)
+{
+	u32 tmp;
+	memmove(&tmp, p, 4);
+	return tmp;
+}
+#define __arch_load_cpu32_noalign __arch_load_cpu32_noalign
+
+static inline u64 __arch_load_cpu16_noalign(const void *p)
+{
+	u64 tmp;
+	memmove(&tmp, p, 8);
+	return tmp;
+}
+#define __arch_load_cpu64_noalign __arch_load_cpu64_noalign
+
+static inline void __arch_store_cpu16_noalign(void *p, u16 val)
+{
+	memmove(p, &val, 2);
+}
+#define __arch_store_cpu16_noalign __arch_store_cpu16_noalign
+
+static inline void __arch_store_cpu32_noalign(void *p, u32 val)
+{
+	memmove(p, &val, 4);
+}
+#define __arch_store_cpu32_noalign __arch_store_cpu32_noalign
+
+static inline void __arch_store_cpu64_noalign(void *p, u64 val)
+{
+	memmove(p, &val, 8);
+}
+#define __arch_store_cpu64_noalign __arch_store_cpu64_noalign
+
+#include <linux/unaligned.h>
 #endif /* _ASM_M32R_UNALIGNED_H */
-- 
1.6.0.4.1044.g77718
