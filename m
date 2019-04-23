Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfDWQin (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 12:38:43 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] asm-generic: provide entirely generic nommu uaccess
Date: Tue, 23 Apr 2019 18:38:08 +0200
Message-Id: <20190423163809.9962-4-hch@lst.de>
In-Reply-To: <20190423163809.9962-1-hch@lst.de>
References: <20190423163809.9962-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

Move the code to implement uaccess using memcpy or direct loads and
stores to asm-generic/uaccess.h and make it selectable kconfig option.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/h8300/Kconfig               |  1 +
 arch/h8300/include/asm/Kbuild    |  1 +
 arch/h8300/include/asm/uaccess.h | 55 --------------------------------
 include/asm-generic/uaccess.h    | 48 ++++++++++++++++++++++++++++
 lib/Kconfig                      |  4 +++
 5 files changed, 54 insertions(+), 55 deletions(-)
 delete mode 100644 arch/h8300/include/asm/uaccess.h

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index c071da34e081..c24d36241503 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -23,6 +23,7 @@ config H8300
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_HASH
 	select CPU_NO_EFFICIENT_FFS
+	select UACCESS_MEMCPY
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index e3dead402e5f..91533fc44b69 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -47,6 +47,7 @@ generic-y += timex.h
 generic-y += tlbflush.h
 generic-y += topology.h
 generic-y += trace_clock.h
+generic-y += uaccess.h
 generic-y += unaligned.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
diff --git a/arch/h8300/include/asm/uaccess.h b/arch/h8300/include/asm/uaccess.h
deleted file mode 100644
index bc8031949d07..000000000000
--- a/arch/h8300/include/asm/uaccess.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_UACCESS_H
-#define _ASM_UACCESS_H
-
-#include <linux/string.h>
-
-static inline __must_check unsigned long
-raw_copy_from_user(void *to, const void __user * from, unsigned long n)
-{
-	if (__builtin_constant_p(n)) {
-		switch(n) {
-		case 1:
-			*(u8 *)to = *(u8 __force *)from;
-			return 0;
-		case 2:
-			*(u16 *)to = *(u16 __force *)from;
-			return 0;
-		case 4:
-			*(u32 *)to = *(u32 __force *)from;
-			return 0;
-		}
-	}
-
-	memcpy(to, (const void __force *)from, n);
-	return 0;
-}
-
-static inline __must_check unsigned long
-raw_copy_to_user(void __user *to, const void *from, unsigned long n)
-{
-	if (__builtin_constant_p(n)) {
-		switch(n) {
-		case 1:
-			*(u8 __force *)to = *(u8 *)from;
-			return 0;
-		case 2:
-			*(u16 __force *)to = *(u16 *)from;
-			return 0;
-		case 4:
-			*(u32 __force *)to = *(u32 *)from;
-			return 0;
-		default:
-			break;
-		}
-	}
-
-	memcpy((void __force *)to, from, n);
-	return 0;
-}
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
-
-#include <asm-generic/uaccess.h>
-
-#endif
diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index aac336831204..3dcabfceb21e 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -9,6 +9,54 @@
  */
 #include <linux/string.h>
 
+#ifdef CONFIG_UACCESS_MEMCPY
+static inline __must_check unsigned long
+raw_copy_from_user(void *to, const void __user * from, unsigned long n)
+{
+	if (__builtin_constant_p(n)) {
+		switch(n) {
+		case 1:
+			*(u8 *)to = *(u8 __force *)from;
+			return 0;
+		case 2:
+			*(u16 *)to = *(u16 __force *)from;
+			return 0;
+		case 4:
+			*(u32 *)to = *(u32 __force *)from;
+			return 0;
+		}
+	}
+
+	memcpy(to, (const void __force *)from, n);
+	return 0;
+}
+
+static inline __must_check unsigned long
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	if (__builtin_constant_p(n)) {
+		switch(n) {
+		case 1:
+			*(u8 __force *)to = *(u8 *)from;
+			return 0;
+		case 2:
+			*(u16 __force *)to = *(u16 *)from;
+			return 0;
+		case 4:
+			*(u32 __force *)to = *(u32 *)from;
+			return 0;
+		default:
+			break;
+		}
+	}
+
+	memcpy((void __force *)to, from, n);
+	return 0;
+}
+#define INLINE_COPY_FROM_USER
+#define INLINE_COPY_TO_USER
+#endif /* CONFIG_UACCESS_MEMCPY */
+
 #define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
 
 #ifndef KERNEL_DS
diff --git a/lib/Kconfig b/lib/Kconfig
index a9e56539bd11..7a3f01ac45e8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -591,6 +591,10 @@ config ARCH_NO_SG_CHAIN
 config ARCH_HAS_PMEM_API
 	bool
 
+# use memcpy to implement user copies for nommu architectures
+config UACCESS_MEMCPY
+	bool
+
 config ARCH_HAS_UACCESS_FLUSHCACHE
 	bool
 
-- 
2.20.1
