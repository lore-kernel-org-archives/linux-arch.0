From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 02/12] EXPORT_SYMBOL() for asm
Date: Fri, 29 Jan 2016 19:18:24 +0000
Message-ID: <1454095114-4128-2-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49611 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbcA2TSf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2016 14:18:35 -0500
In-Reply-To: <20160129191744.GB17997@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Add asm-usable variants of EXPORT_SYMBOL/EXPORT_SYMBOL_GPL.  This
commit just adds the default implementation; most of the architectures
can simply add export.h to asm/Kbuild and start using <asm/export.h>
from assembler.  The area where the things might diverge from default
is the alignment; normally it's 8 bytes on 64bit targets and 4 on
32bit ones, both for unsigned long and for struct kernel_symbol.

Unfortunately, amd64 and m68k are unusual - m68k aligns to 2 bytes
(for both) and amd64 aligns struct kernel_symbol to 16 bytes.  For
those we'll need to have asm/export.h overriding the constants used
by generic version (KSYM_ALIGN and KCRC_ALIGN for kernel_symbol and
unsigned long resp.) and including asm-generic/export.h.

And no, __alignof__ would not do the trick - on amd64 __alignof__
of struct kernel_symbol is 8, not 16.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-generic/export.h | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 include/asm-generic/export.h

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
new file mode 100644
index 0000000..a1d44be
--- /dev/null
+++ b/include/asm-generic/export.h
@@ -0,0 +1,61 @@
+#ifndef __ASM_GENERIC_EXPORT_H
+#define __ASM_GENERIC_EXPORT_H
+
+#ifdef CONFIG_64BIT
+#define __put .quad
+#ifndef KSYM_ALIGN
+#define KSYM_ALIGN 8
+#endif
+#ifndef KCRC_ALIGN
+#define KCRC_ALIGN 8
+#endif
+#else
+#define __put .long
+#ifndef KSYM_ALIGN
+#define KSYM_ALIGN 4
+#endif
+#ifndef KCRC_ALIGN
+#define KCRC_ALIGN 4
+#endif
+#endif
+/*
+ * note on .section use: @progbits vs %progbits nastiness doesn't matter,
+ * since we immediately emit into those sections anyway.
+ */
+.macro __EXPORT_SYMBOL name,sec
+#ifdef CONFIG_MODULES
+	.globl __ksymtab_\name
+	.section ___ksymtab\sec+\name,"a"
+	.balign KSYM_ALIGN
+#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+	___ksymtab_\name: __put _\name, ___kstrtab_\name
+#else
+	__ksymtab_\name: __put \name, __kstrtab_\name
+#endif
+	.previous
+	.section __ksymtab_strings,"a"
+#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+	___kstrtab_\name: .asciz "_\name"
+#else
+	__kstrtab_\name: .asciz "\name"
+#endif
+	.previous
+#ifdef CONFIG_MODVERSIONS
+	.section ___kcrctab\sec+\name,"a"
+	.balign KCRC_ALIGN
+#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+	___kcrctab_\name: __put ___crc_\name
+	.weak	___crc_\name
+#else
+	__kcrctab_\name: __put __crc_\name
+	.weak	__crc_\name
+#endif
+	.previous
+#endif
+#endif
+.endm
+#undef __put
+#define EXPORT_SYMBOL(name) __EXPORT_SYMBOL name
+#define EXPORT_SYMBOL_GPL(name) __EXPORT_SYMBOL name, _gpl
+
+#endif
-- 
2.1.4
