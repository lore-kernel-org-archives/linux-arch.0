From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH resend] asm/types.h: All architectures use int-ll64.h in
 kernelspace
Date: Sat, 13 Aug 2011 21:53:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1108132152050.18053@ayla.of.borg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from jacques.telenet-ops.be ([195.130.132.50]:49329 "EHLO
	jacques.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab1HMTxq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Aug 2011 15:53:46 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>

Now all 64-bit architectures have been converted to int-ll64.h, we can
deprecate int-l64.h in kernelspace:
  - Add a check to prevent new architectures from using int-l64.h in
    kernelspace,
  - Update documentation, as the casts to (unsigned) long long are no longer
    needed.

For backwards compatibility, alpha, ia64, mips, and powerpc still use
int-l64.h in userspace.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
For the documentation parts:
Acked-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/printk-formats.txt |    4 ++--
 include/asm-generic/int-l64.h    |   38 +-------------------------------------
 include/asm-generic/types.h      |    3 +--
 3 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/Documentation/printk-formats.txt b/Documentation/printk-formats.txt
index 5df176e..dd8c3d6 100644
--- a/Documentation/printk-formats.txt
+++ b/Documentation/printk-formats.txt
@@ -127,11 +127,11 @@ struct va_format:
 
 u64 SHOULD be printed with %llu/%llx, (unsigned long long):
 
-	printk("%llu", (unsigned long long)u64_var);
+	printk("%llu", u64_var);
 
 s64 SHOULD be printed with %lld/%llx, (long long):
 
-	printk("%lld", (long long)s64_var);
+	printk("%lld", s64_var);
 
 If <type> is dependent on a config option for its size (e.g., sector_t,
 blkcnt_t, phys_addr_t, resource_size_t) or is architecture-dependent
diff --git a/include/asm-generic/int-l64.h b/include/asm-generic/int-l64.h
index 1ca3efc..f07a500 100644
--- a/include/asm-generic/int-l64.h
+++ b/include/asm-generic/int-l64.h
@@ -31,43 +31,7 @@ typedef unsigned long __u64;
 #endif /* __ASSEMBLY__ */
 
 #ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long s64;
-typedef unsigned long u64;
-
-#define S8_C(x)  x
-#define U8_C(x)  x ## U
-#define S16_C(x) x
-#define U16_C(x) x ## U
-#define S32_C(x) x
-#define U32_C(x) x ## U
-#define S64_C(x) x ## L
-#define U64_C(x) x ## UL
-
-#else /* __ASSEMBLY__ */
-
-#define S8_C(x)  x
-#define U8_C(x)  x
-#define S16_C(x) x
-#define U16_C(x) x
-#define S32_C(x) x
-#define U32_C(x) x
-#define S64_C(x) x
-#define U64_C(x) x
-
-#endif /* __ASSEMBLY__ */
-
+#error Please use <asm-generic/int-ll64.h> in kernelspace
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_GENERIC_INT_L64_H */
diff --git a/include/asm-generic/types.h b/include/asm-generic/types.h
index 7a0f69e..a9672ef 100644
--- a/include/asm-generic/types.h
+++ b/include/asm-generic/types.h
@@ -1,8 +1,7 @@
 #ifndef _ASM_GENERIC_TYPES_H
 #define _ASM_GENERIC_TYPES_H
 /*
- * int-ll64 is used practically everywhere now,
- * so use it as a reasonable default.
+ * int-ll64 is used everywhere now.
  */
 #include <asm-generic/int-ll64.h>
 
-- 
1.7.0.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
