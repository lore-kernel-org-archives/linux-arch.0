Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33726 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeIJJoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2018 05:44:38 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 6/8] untangle asm/termios.h mess
Date: Mon, 10 Sep 2018 05:52:25 +0100
Message-ID: <20180910045227.9895-6-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk>
 <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Message-ID: <20180910045225.992PhQGsfPwXCGX5eO2kifhvwlLcy1SeCKf6raG0WLw@z>

From: Al Viro <viro@zeniv.linux.org.uk>

Currently, asm/termios.h resolves either to uapi/asm/termios.h
(on architectures that don't have it) or to the same plus the
definitions that are only used by those who pull linux/termios_internal.h

That causes tons of inconveniences - e.g. we can't have generic
asm/termios.h with non-generic uapi/asm/termios.h.

Let's do the following:
	* rename asm/termios.h to asm/termios_internal.h and make
linux/termios_internal.h pull that; that way all includes of
<asm/termios.h> will go directly to uapi/asm/termios.h
	* all but 3 architectures actually have asm/termios.h completely
generic.  Make those 3 select a new config symbol (HAVE_TERMIOS_INTERNAL)
and make the include of asm/termios_internal.h conditional upon that.
Remove all generic instances of asm/termios.h (including include/asm-generic
one).
	* get rid of one pointless include of <asm/termios.h> in
drivers/tty.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/Kconfig                                              |  3 +++
 arch/alpha/Kconfig                                        |  1 +
 arch/alpha/include/asm/{termios.h => termios_internal.h}  |  3 ---
 arch/ia64/include/asm/termios.h                           | 13 -------------
 arch/mips/include/asm/termios.h                           | 15 ---------------
 arch/parisc/include/asm/termios.h                         |  7 -------
 arch/powerpc/Kconfig                                      |  1 +
 .../powerpc/include/asm/{termios.h => termios_internal.h} |  2 --
 arch/riscv/include/asm/Kbuild                             |  1 -
 arch/s390/include/asm/termios.h                           | 12 ------------
 arch/sparc/Kconfig                                        |  1 +
 arch/sparc/include/asm/{termios.h => termios_internal.h}  |  4 ----
 drivers/tty/n_hdlc.c                                      |  1 -
 include/asm-generic/termios.h                             |  9 ---------
 include/linux/termios_internal.h                          |  3 +++
 15 files changed, 9 insertions(+), 67 deletions(-)
 rename arch/alpha/include/asm/{termios.h => termios_internal.h} (97%)
 delete mode 100644 arch/ia64/include/asm/termios.h
 delete mode 100644 arch/mips/include/asm/termios.h
 delete mode 100644 arch/parisc/include/asm/termios.h
 rename arch/powerpc/include/asm/{termios.h => termios_internal.h} (96%)
 delete mode 100644 arch/s390/include/asm/termios.h
 rename arch/sparc/include/asm/{termios.h => termios_internal.h} (98%)
 delete mode 100644 include/asm-generic/termios.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 6801123932a5..a36cce432768 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -727,6 +727,9 @@ config OLD_SIGACTION
 config COMPAT_OLD_SIGACTION
 	bool
 
+config HAS_TERMIOS_INTERNAL
+	bool
+
 config 64BIT_TIME
 	def_bool ARCH_HAS_64BIT_TIME
 	help
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 5b4f88363453..85120bbda191 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -30,6 +30,7 @@ config ALPHA
 	select MODULES_USE_ELF_RELA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
+	select HAS_TERMIOS_INTERNAL
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios_internal.h
similarity index 97%
rename from arch/alpha/include/asm/termios.h
rename to arch/alpha/include/asm/termios_internal.h
index 63e1ffc8f719..6c2a67e65992 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios_internal.h
@@ -2,9 +2,6 @@
 #ifndef _ALPHA_TERMIOS_H
 #define _ALPHA_TERMIOS_H
 
-#include <linux/uaccess.h>
-#include <uapi/asm/termios.h>
-
 /*	eof=^D		eol=\0		eol2=\0		erase=del
 	werase=^W	kill=^U		reprint=^R	sxtc=\0
 	intr=^C		quit=^\		susp=^Z		<OSF/1 VDSUSP>
diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
deleted file mode 100644
index 1cef02701401..000000000000
--- a/arch/ia64/include/asm/termios.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Modified 1999
- *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
- *
- * 99/01/28	Added N_IRDA and N_SMSBLOCK
- */
-#ifndef _ASM_IA64_TERMIOS_H
-#define _ASM_IA64_TERMIOS_H
-
-#include <uapi/asm/termios.h>
-
-#endif /* _ASM_IA64_TERMIOS_H */
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
deleted file mode 100644
index 12bc56857bf1..000000000000
--- a/arch/mips/include/asm/termios.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1995, 1996, 2000, 2001 by Ralf Baechle
- * Copyright (C) 2000, 2001 Silicon Graphics, Inc.
- */
-#ifndef _ASM_TERMIOS_H
-#define _ASM_TERMIOS_H
-
-#include <linux/uaccess.h>
-#include <uapi/asm/termios.h>
-
-#endif /* _ASM_TERMIOS_H */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
deleted file mode 100644
index 1850a90befb3..000000000000
--- a/arch/parisc/include/asm/termios.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _PARISC_TERMIOS_H
-#define _PARISC_TERMIOS_H
-
-#include <uapi/asm/termios.h>
-
-#endif	/* _PARISC_TERMIOS_H */
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db0b6eebbfa5..b1402b1f1685 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -223,6 +223,7 @@ config PPC
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_RSEQ
+	select HAS_TERMIOS_INTERNAL
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/powerpc/include/asm/termios.h b/arch/powerpc/include/asm/termios_internal.h
similarity index 96%
rename from arch/powerpc/include/asm/termios.h
rename to arch/powerpc/include/asm/termios_internal.h
index cb1e593e95bf..b93e889342cf 100644
--- a/arch/powerpc/include/asm/termios.h
+++ b/arch/powerpc/include/asm/termios_internal.h
@@ -12,8 +12,6 @@
 #ifndef _ASM_POWERPC_TERMIOS_H
 #define _ASM_POWERPC_TERMIOS_H
 
-#include <uapi/asm/termios.h>
-
 /*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  */
 #define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025" 
 
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index efdbe311e936..f74ea476a932 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -52,7 +52,6 @@ generic-y += stat.h
 generic-y += statfs.h
 generic-y += swab.h
 generic-y += termbits.h
-generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += types.h
diff --git a/arch/s390/include/asm/termios.h b/arch/s390/include/asm/termios.h
deleted file mode 100644
index 0e26fe97b0d4..000000000000
--- a/arch/s390/include/asm/termios.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  S390 version
- *
- *  Derived from "include/asm-i386/termios.h"
- */
-#ifndef _S390_TERMIOS_H
-#define _S390_TERMIOS_H
-
-#include <uapi/asm/termios.h>
-
-#endif	/* _S390_TERMIOS_H */
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e6f2a38d2e61..ef9fba4a2d0f 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -33,6 +33,7 @@ config SPARC
 	select HAVE_CBPF_JIT if SPARC32
 	select HAVE_EBPF_JIT if SPARC64
 	select HAVE_DEBUG_BUGVERBOSE
+	select HAS_TERMIOS_INTERNAL
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_STRNCPY_FROM_USER
diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios_internal.h
similarity index 98%
rename from arch/sparc/include/asm/termios.h
rename to arch/sparc/include/asm/termios_internal.h
index 0652f870bb1a..028c6bd6e0a7 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios_internal.h
@@ -2,10 +2,6 @@
 #ifndef _SPARC_TERMIOS_H
 #define _SPARC_TERMIOS_H
 
-#include <uapi/asm/termios.h>
-#include <linux/uaccess.h>
-
-
 /*
  * c_cc characters in the termio structure.  Oh, how I love being
  * backwardly compatible.  Notice that character 4 and 5 are
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index dabb391909aa..ca3395994a43 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -101,7 +101,6 @@
 #include <linux/if.h>
 #include <linux/bitops.h>
 
-#include <asm/termios.h>
 #include <linux/uaccess.h>
 
 /*
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
deleted file mode 100644
index da3b0fe25442..000000000000
--- a/include/asm-generic/termios.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_TERMIOS_H
-#define _ASM_GENERIC_TERMIOS_H
-
-
-#include <linux/uaccess.h>
-#include <uapi/asm-generic/termios.h>
-
-#endif /* _ASM_GENERIC_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index d25b9a9c2faf..343f7868713d 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -4,6 +4,9 @@
 
 #include <linux/uaccess.h>
 #include <asm/termios.h>
+#ifdef CONFIG_HAS_TERMIOS_INTERNAL
+#include <asm/termios_internal.h>
+#endif
 
 #ifndef INIT_C_CC
 /*	intr=^C		quit=^\		erase=del	kill=^U
-- 
2.11.0
