From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 05/12] m68k: move exports to definitions
Date: Fri, 29 Jan 2016 19:18:27 +0000
Message-ID: <1454095114-4128-5-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160129191744.GB17997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

the rest of architectures should just use generic-y += export.h in
asm/Kbuild

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/include/asm/export.h |  3 +++
 arch/m68k/kernel/Makefile      |  2 +-
 arch/m68k/kernel/m68k_ksyms.c  | 32 --------------------------------
 arch/m68k/lib/ashldi3.c        |  4 ++++
 arch/m68k/lib/ashrdi3.c        |  4 ++++
 arch/m68k/lib/divsi3.S         |  3 +++
 arch/m68k/lib/lshrdi3.c        |  4 ++++
 arch/m68k/lib/modsi3.S         |  3 +++
 arch/m68k/lib/muldi3.c         |  4 ++++
 arch/m68k/lib/mulsi3.S         |  4 ++--
 arch/m68k/lib/udivsi3.S        |  4 ++--
 arch/m68k/lib/umodsi3.S        |  4 ++--
 12 files changed, 32 insertions(+), 39 deletions(-)
 create mode 100644 arch/m68k/include/asm/export.h
 delete mode 100644 arch/m68k/kernel/m68k_ksyms.c

diff --git a/arch/m68k/include/asm/export.h b/arch/m68k/include/asm/export.h
new file mode 100644
index 0000000..0af20f4
--- /dev/null
+++ b/arch/m68k/include/asm/export.h
@@ -0,0 +1,3 @@
+#define KSYM_ALIGN 2
+#define KCRC_ALIGN 2
+#include <asm-generic/export.h>
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index e47778f..3600500 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -13,7 +13,7 @@ extra-$(CONFIG_SUN3X)	:= head.o
 extra-$(CONFIG_SUN3)	:= sun3-head.o
 extra-y			+= vmlinux.lds
 
-obj-y	:= entry.o irq.o m68k_ksyms.o module.o process.o ptrace.o
+obj-y	:= entry.o irq.o module.o process.o ptrace.o
 obj-y	+= setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
 
 obj-$(CONFIG_MMU_MOTOROLA) += ints.o vectors.o
diff --git a/arch/m68k/kernel/m68k_ksyms.c b/arch/m68k/kernel/m68k_ksyms.c
deleted file mode 100644
index 774c1bd..0000000
--- a/arch/m68k/kernel/m68k_ksyms.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include <linux/module.h>
-
-asmlinkage long long __ashldi3 (long long, int);
-asmlinkage long long __ashrdi3 (long long, int);
-asmlinkage long long __lshrdi3 (long long, int);
-asmlinkage long long __muldi3 (long long, long long);
-
-/* The following are special because they're not called
-   explicitly (the C compiler generates them).  Fortunately,
-   their interface isn't gonna change any time soon now, so
-   it's OK to leave it out of version control.  */
-EXPORT_SYMBOL(__ashldi3);
-EXPORT_SYMBOL(__ashrdi3);
-EXPORT_SYMBOL(__lshrdi3);
-EXPORT_SYMBOL(__muldi3);
-
-#if defined(CONFIG_CPU_HAS_NO_MULDIV64)
-/*
- * Simpler 68k and ColdFire parts also need a few other gcc functions.
- */
-extern long long __divsi3(long long, long long);
-extern long long __modsi3(long long, long long);
-extern long long __mulsi3(long long, long long);
-extern long long __udivsi3(long long, long long);
-extern long long __umodsi3(long long, long long);
-
-EXPORT_SYMBOL(__divsi3);
-EXPORT_SYMBOL(__modsi3);
-EXPORT_SYMBOL(__mulsi3);
-EXPORT_SYMBOL(__udivsi3);
-EXPORT_SYMBOL(__umodsi3);
-#endif
diff --git a/arch/m68k/lib/ashldi3.c b/arch/m68k/lib/ashldi3.c
index 37234c2..8dffd36 100644
--- a/arch/m68k/lib/ashldi3.c
+++ b/arch/m68k/lib/ashldi3.c
@@ -13,6 +13,9 @@ but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details. */
 
+#include <linux/compiler.h>
+#include <linux/export.h>
+
 #define BITS_PER_UNIT 8
 
 typedef		 int SItype	__attribute__ ((mode (SI)));
@@ -55,3 +58,4 @@ __ashldi3 (DItype u, word_type b)
 
   return w.ll;
 }
+EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/m68k/lib/ashrdi3.c b/arch/m68k/lib/ashrdi3.c
index 1d59345..e6565a3 100644
--- a/arch/m68k/lib/ashrdi3.c
+++ b/arch/m68k/lib/ashrdi3.c
@@ -13,6 +13,9 @@ but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details. */
 
+#include <linux/compiler.h>
+#include <linux/export.h>
+
 #define BITS_PER_UNIT 8
 
 typedef		 int SItype	__attribute__ ((mode (SI)));
@@ -56,3 +59,4 @@ __ashrdi3 (DItype u, word_type b)
 
   return w.ll;
 }
+EXPORT_SYMBOL(__ashrdi3);
diff --git a/arch/m68k/lib/divsi3.S b/arch/m68k/lib/divsi3.S
index 2c0ec85..3a2143f 100644
--- a/arch/m68k/lib/divsi3.S
+++ b/arch/m68k/lib/divsi3.S
@@ -33,6 +33,8 @@ General Public License for more details. */
    D. V. Henkel-Wallace (gumby@cygnus.com) Fete Bastille, 1992
 */
 
+#include <asm/export.h>
+
 /* These are predefined by new versions of GNU cpp.  */
 
 #ifndef __USER_LABEL_PREFIX__
@@ -118,3 +120,4 @@ L2:	movel	d1, sp@-
 L3:	movel	sp@+, d2
 	rts
 
+	EXPORT_SYMBOL(__divsi3)
diff --git a/arch/m68k/lib/lshrdi3.c b/arch/m68k/lib/lshrdi3.c
index 49e1ec8..0397797 100644
--- a/arch/m68k/lib/lshrdi3.c
+++ b/arch/m68k/lib/lshrdi3.c
@@ -13,6 +13,9 @@ but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details. */
 
+#include <linux/compiler.h>
+#include <linux/export.h>
+
 #define BITS_PER_UNIT 8
 
 typedef		 int SItype	__attribute__ ((mode (SI)));
@@ -55,3 +58,4 @@ __lshrdi3 (DItype u, word_type b)
 
   return w.ll;
 }
+EXPORT_SYMBOL(__lshrdi3);
diff --git a/arch/m68k/lib/modsi3.S b/arch/m68k/lib/modsi3.S
index 1d9e0ef..1c96764 100644
--- a/arch/m68k/lib/modsi3.S
+++ b/arch/m68k/lib/modsi3.S
@@ -33,6 +33,8 @@ General Public License for more details. */
    D. V. Henkel-Wallace (gumby@cygnus.com) Fete Bastille, 1992
 */
 
+#include <asm/export.h>
+
 /* These are predefined by new versions of GNU cpp.  */
 
 #ifndef __USER_LABEL_PREFIX__
@@ -106,3 +108,4 @@ SYM (__modsi3):
 	movel	d1, d0
 	rts
 
+	EXPORT_SYMBOL(__modsi3)
diff --git a/arch/m68k/lib/muldi3.c b/arch/m68k/lib/muldi3.c
index 9006d15..6459af5 100644
--- a/arch/m68k/lib/muldi3.c
+++ b/arch/m68k/lib/muldi3.c
@@ -14,6 +14,9 @@ but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details. */
 
+#include <linux/compiler.h>
+#include <linux/export.h>
+
 #ifdef CONFIG_CPU_HAS_NO_MULDIV64
 
 #define SI_TYPE_SIZE 32
@@ -90,3 +93,4 @@ __muldi3 (DItype u, DItype v)
 
   return w.ll;
 }
+EXPORT_SYMBOL(__muldi3);
diff --git a/arch/m68k/lib/mulsi3.S b/arch/m68k/lib/mulsi3.S
index c39ad4e..855675e 100644
--- a/arch/m68k/lib/mulsi3.S
+++ b/arch/m68k/lib/mulsi3.S
@@ -32,7 +32,7 @@ General Public License for more details. */
    Some of this code comes from MINIX, via the folks at ericsson.
    D. V. Henkel-Wallace (gumby@cygnus.com) Fete Bastille, 1992
 */
-
+#include <asm/export.h>
 /* These are predefined by new versions of GNU cpp.  */
 
 #ifndef __USER_LABEL_PREFIX__
@@ -102,4 +102,4 @@ SYM (__mulsi3):
 	addl	d1, d0
 
 	rts
-
+	EXPORT_SYMBOL(__mulsi3)
diff --git a/arch/m68k/lib/udivsi3.S b/arch/m68k/lib/udivsi3.S
index 35a5446..78440ae 100644
--- a/arch/m68k/lib/udivsi3.S
+++ b/arch/m68k/lib/udivsi3.S
@@ -32,7 +32,7 @@ General Public License for more details. */
    Some of this code comes from MINIX, via the folks at ericsson.
    D. V. Henkel-Wallace (gumby@cygnus.com) Fete Bastille, 1992
 */
-
+#include <asm/export.h>
 /* These are predefined by new versions of GNU cpp.  */
 
 #ifndef __USER_LABEL_PREFIX__
@@ -154,4 +154,4 @@ L2:	subql	IMM (1),d4
 	unlk	a6		| and return
 	rts
 #endif /* __mcf5200__ || __mcoldfire__ */
-
+	EXPORT_SYMBOL(__udivsi3)
diff --git a/arch/m68k/lib/umodsi3.S b/arch/m68k/lib/umodsi3.S
index 099da51..b6fd11f 100644
--- a/arch/m68k/lib/umodsi3.S
+++ b/arch/m68k/lib/umodsi3.S
@@ -32,7 +32,7 @@ General Public License for more details. */
    Some of this code comes from MINIX, via the folks at ericsson.
    D. V. Henkel-Wallace (gumby@cygnus.com) Fete Bastille, 1992
 */
-
+#include <asm/export.h>
 /* These are predefined by new versions of GNU cpp.  */
 
 #ifndef __USER_LABEL_PREFIX__
@@ -105,4 +105,4 @@ SYM (__umodsi3):
 	subl	d0, d1		/* d1 = a - (a/b)*b */
 	movel	d1, d0
 	rts
-
+	EXPORT_SYMBOL(__umodsi3)
-- 
2.1.4
