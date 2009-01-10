Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37745 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753033AbZAJAf6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jan 2009 19:35:58 -0500
Message-Id: <200901100033.n0A0X22c007031@imap1.linux-foundation.org>
Subject: - unaligned-wire-up-trivial-arches-for-new-common-unaligned-header.patch removed from -mm tree
From: akpm@linux-foundation.org
Date: Fri, 09 Jan 2009 16:16:37 -0800
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: harvey.harrison@gmail.com, benh@kernel.crashing.org, bryan.wu@analog.com, davem@davemloft.net, dhowells@redhat.com, geert@linux-m68k.org, gerg@snapgear.com, grundler@parisc-linux.org, hpa@zytor.com, hskinnemoen@atmel.com, ink@jurassic.park.msu.ru, kyle@mcmartin.ca, linux-arch@vger.kernel.org, mingo@elte.hu, paulus@samba.org, ralf@linux-mips.org, rth@twiddle.net, schwidefsky@de.ibm.com, starvik@axis.com, tglx@linutronix.de, tony.luck@intel.com, mm-commits@vger.kernel.org


The patch titled
     unaligned: wire up trivial arches for new common unaligned header
has been removed from the -mm tree.  Its filename was
     unaligned-wire-up-trivial-arches-for-new-common-unaligned-header.patch

This patch was dropped because an updated version will be merged

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
Subject: unaligned: wire up trivial arches for new common unaligned header
From: Harvey Harrison <harvey.harrison@gmail.com>

Arches where unaligned access is OK, or arches the use packed-struct for
the native endianness and byteshifting for the opposite endianness.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Cc: <linux-arch@vger.kernel.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Bryan Wu <bryan.wu@analog.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: Greg Ungerer <gerg@snapgear.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: Grant Grundler <grundler@parisc-linux.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/alpha/include/asm/unaligned.h     |    7 +------
 arch/avr32/include/asm/unaligned.h     |    8 +-------
 arch/blackfin/include/asm/unaligned.h  |    7 +------
 arch/cris/include/asm/unaligned.h      |    7 ++-----
 arch/ia64/include/asm/unaligned.h      |    7 +------
 arch/m68knommu/include/asm/unaligned.h |   22 +++++-----------------
 arch/mips/include/asm/unaligned.h      |   17 +----------------
 arch/parisc/include/asm/unaligned.h    |    6 +-----
 arch/powerpc/include/asm/unaligned.h   |    7 ++-----
 arch/s390/include/asm/unaligned.h      |    7 ++-----
 arch/sparc/include/asm/unaligned.h     |    6 +-----
 arch/x86/include/asm/unaligned.h       |    8 ++------
 arch/xtensa/include/asm/unaligned.h    |   16 +---------------
 include/asm-frv/unaligned.h            |    7 +------
 include/asm-m68k/unaligned.h           |    7 ++-----
 include/asm-mn10300/unaligned.h        |    7 ++-----
 16 files changed, 26 insertions(+), 120 deletions(-)

diff -puN arch/alpha/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/alpha/include/asm/unaligned.h
--- a/arch/alpha/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/alpha/include/asm/unaligned.h
@@ -1,11 +1,6 @@
 #ifndef _ASM_ALPHA_UNALIGNED_H
 #define _ASM_ALPHA_UNALIGNED_H
 
-#include <linux/unaligned/le_struct.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned __get_unaligned_le
-#define put_unaligned __put_unaligned_le
+#include <linux/unaligned.h>
 
 #endif /* _ASM_ALPHA_UNALIGNED_H */
diff -puN arch/avr32/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/avr32/include/asm/unaligned.h
--- a/arch/avr32/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/avr32/include/asm/unaligned.h
@@ -10,12 +10,6 @@
  * However, swapped word loads must be word-aligned so we can't
  * optimize word loads in general.
  */
-
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#include <linux/unaligned.h>
 
 #endif /* _ASM_AVR32_UNALIGNED_H */
diff -puN arch/blackfin/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/blackfin/include/asm/unaligned.h
--- a/arch/blackfin/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/blackfin/include/asm/unaligned.h
@@ -1,11 +1,6 @@
 #ifndef _ASM_BLACKFIN_UNALIGNED_H
 #define _ASM_BLACKFIN_UNALIGNED_H
 
-#include <linux/unaligned/le_struct.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
+#include <linux/unaligned.h>
 
 #endif /* _ASM_BLACKFIN_UNALIGNED_H */
diff -puN arch/cris/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/cris/include/asm/unaligned.h
--- a/arch/cris/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/cris/include/asm/unaligned.h
@@ -4,10 +4,7 @@
 /*
  * CRIS can do unaligned accesses itself. 
  */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
+#define _UNALIGNED_ACCESS_OK
+#include <linux/unaligned.h>
 
 #endif /* _ASM_CRIS_UNALIGNED_H */
diff -puN arch/ia64/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/ia64/include/asm/unaligned.h
--- a/arch/ia64/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/ia64/include/asm/unaligned.h
@@ -1,11 +1,6 @@
 #ifndef _ASM_IA64_UNALIGNED_H
 #define _ASM_IA64_UNALIGNED_H
 
-#include <linux/unaligned/le_struct.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
+#include <linux/unaligned.h>
 
 #endif /* _ASM_IA64_UNALIGNED_H */
diff -puN arch/m68knommu/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/m68knommu/include/asm/unaligned.h
--- a/arch/m68knommu/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/m68knommu/include/asm/unaligned.h
@@ -1,25 +1,13 @@
 #ifndef _ASM_M68KNOMMU_UNALIGNED_H
 #define _ASM_M68KNOMMU_UNALIGNED_H
 
-
-#ifdef CONFIG_COLDFIRE
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
-#else
 /*
- * The m68k can do unaligned accesses itself. 
+ * The m68k can do unaligned accesses itself.  COLDFIRE can not.
  */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
+#ifndef CONFIG_COLDFIRE
+# define _UNALIGNED_ACCESS_OK
 #endif
 
+#include <linux/unaligned.h>
+
 #endif /* _ASM_M68KNOMMU_UNALIGNED_H */
diff -puN arch/mips/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/mips/include/asm/unaligned.h
--- a/arch/mips/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/mips/include/asm/unaligned.h
@@ -8,21 +8,6 @@
 #ifndef _ASM_MIPS_UNALIGNED_H
 #define _ASM_MIPS_UNALIGNED_H
 
-#include <linux/compiler.h>
-#if defined(__MIPSEB__)
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_be
-# define put_unaligned	__put_unaligned_be
-#elif defined(__MIPSEL__)
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_le
-# define put_unaligned	__put_unaligned_le
-#else
-#  error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
-#endif
+#include <linux/unaligned.h>
 
 #endif /* _ASM_MIPS_UNALIGNED_H */
diff -puN arch/parisc/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/parisc/include/asm/unaligned.h
--- a/arch/parisc/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/parisc/include/asm/unaligned.h
@@ -1,11 +1,7 @@
 #ifndef _ASM_PARISC_UNALIGNED_H
 #define _ASM_PARISC_UNALIGNED_H
 
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#include <linux/unaligned.h>
 
 #ifdef __KERNEL__
 struct pt_regs;
diff -puN arch/powerpc/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/powerpc/include/asm/unaligned.h
--- a/arch/powerpc/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/powerpc/include/asm/unaligned.h
@@ -6,11 +6,8 @@
 /*
  * The PowerPC can do unaligned accesses itself in big endian mode.
  */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#define _UNALIGNED_ACCESS_OK
+#include <linux/unaligned.h>
 
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_UNALIGNED_H */
diff -puN arch/s390/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/s390/include/asm/unaligned.h
--- a/arch/s390/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/s390/include/asm/unaligned.h
@@ -4,10 +4,7 @@
 /*
  * The S390 can do unaligned accesses itself. 
  */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#define _UNALIGNED_ACCESS_OK
+#include <linux/unaligned.h>
 
 #endif /* _ASM_S390_UNALIGNED_H */
diff -puN arch/sparc/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/sparc/include/asm/unaligned.h
--- a/arch/sparc/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/sparc/include/asm/unaligned.h
@@ -1,10 +1,6 @@
 #ifndef _ASM_SPARC_UNALIGNED_H
 #define _ASM_SPARC_UNALIGNED_H
 
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#include <linux/unaligned.h>
 
 #endif /* _ASM_SPARC_UNALIGNED_H */
diff -puN arch/x86/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/x86/include/asm/unaligned.h
--- a/arch/x86/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/x86/include/asm/unaligned.h
@@ -4,11 +4,7 @@
 /*
  * The x86 can do unaligned accesses itself.
  */
-
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned __get_unaligned_le
-#define put_unaligned __put_unaligned_le
+#define _UNALIGNED_ACCESS_OK
+#include <linux/unaligned.h>
 
 #endif /* _ASM_X86_UNALIGNED_H */
diff -puN arch/xtensa/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header arch/xtensa/include/asm/unaligned.h
--- a/arch/xtensa/include/asm/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/arch/xtensa/include/asm/unaligned.h
@@ -10,20 +10,6 @@
 #ifndef _ASM_XTENSA_UNALIGNED_H
 #define _ASM_XTENSA_UNALIGNED_H
 
-#include <asm/byteorder.h>
-
-#ifdef __LITTLE_ENDIAN
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_le
-# define put_unaligned	__put_unaligned_le
-#else
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_be
-# define put_unaligned	__put_unaligned_be
-#endif
+#include <linux/unaligned.h>
 
 #endif	/* _ASM_XTENSA_UNALIGNED_H */
diff -puN include/asm-frv/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header include/asm-frv/unaligned.h
--- a/include/asm-frv/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/include/asm-frv/unaligned.h
@@ -12,11 +12,6 @@
 #ifndef _ASM_UNALIGNED_H
 #define _ASM_UNALIGNED_H
 
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#include <linux/unaligned.h>
 
 #endif /* _ASM_UNALIGNED_H */
diff -puN include/asm-m68k/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header include/asm-m68k/unaligned.h
--- a/include/asm-m68k/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/include/asm-m68k/unaligned.h
@@ -4,10 +4,7 @@
 /*
  * The m68k can do unaligned accesses itself.
  */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#define _UNALIGNED_ACCESS_OK
+#include <linux/unaligned.h>
 
 #endif /* _ASM_M68K_UNALIGNED_H */
diff -puN include/asm-mn10300/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header include/asm-mn10300/unaligned.h
--- a/include/asm-mn10300/unaligned.h~unaligned-wire-up-trivial-arches-for-new-common-unaligned-header
+++ a/include/asm-mn10300/unaligned.h
@@ -11,10 +11,7 @@
 #ifndef _ASM_MN10300_UNALIGNED_H
 #define _ASM_MN10300_UNALIGNED_H
 
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
+#define _UNALIGNED_ACCESS_OK
+#include <linux/unaligned.h>
 
 #endif /* _ASM_MN10300_UNALIGNED_H */
_

Patches currently in -mm which might be from harvey.harrison@gmail.com are

origin.patch
memstick-annotate-endianness-of-attribute-structs.patch

