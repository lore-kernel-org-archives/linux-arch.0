From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/3] add support for exporting symbols from .S files
Date: Tue, 12 Aug 2008 15:58:52 +0200
Message-ID: <200808121558.53576.arnd@arndb.de>
References: <200808111606.44103.arnd@arndb.de> <200808111618.08206.arnd@arndb.de> <20080812164352.ddcf1ef5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:63405 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbYHLOAX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Aug 2008 10:00:23 -0400
In-Reply-To: <20080812164352.ddcf1ef5.sfr@canb.auug.org.au>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, David Woodhouse <dwmw2@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linuxppc-dev@ozlabs.org

This makes it possible to export symbols from assembly files, instead
of having to export them through an extra ksyms.c file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

On Tuesday 12 August 2008, Stephen Rothwell wrote:
> This won't be portable across architectures as .align is sometimes in
> bytes and sometimes a power of two.  You can use .balign or .p2align
> portably on gas, though.

Ok, this version uses the .balign as suggested by rusty, and also
fixes building with modversions turned on, which did not work in the
first version.

	Arnd <><

--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -1,5 +1,7 @@
 #ifndef _LINUX_MODULE_H
 #define _LINUX_MODULE_H
+
+#ifndef __ASSEMBLY__
 /*
  * Dynamic loading of modules into the kernel.
  *
@@ -605,4 +607,72 @@ static inline void module_remove_modinfo_attrs(struct module *mod)
 
 #define __MODULE_STRING(x) __stringify(x)
 
+#else /* __ASSEMBLY__ */
+#include <asm/types.h>
+
+#ifdef CONFIG_MODULES
+.macro __EXPORT_SYMBOL sym section symtab strtab crctab crc
+	.section \section, "a", @progbits
+	.type \symtab, @object
+	.balign BITS_PER_LONG/8
+\symtab:
+	.ifeq BITS_PER_LONG - 32
+	.long \sym
+	.long \strtab
+	.else
+	.quad \sym
+	.quad \strtab
+	.endif
+	.size \symtab, . - \symtab
+	.previous
+
+	.section __ksymtab_strings, "a", @progbits
+	.type \strtab, @object
+\strtab:
+	.string "\sym"
+	.size \strtab, . - \strtab
+	.previous
+
+#ifdef CONFIG_MODVERSIONS
+	/*
+	 * Modversions doesn't work with assembly files,
+	 * so insert a dummy CRC.
+	 */
+	.section __kcrctab, "a", @progbits
+	.balign 4
+	.type \crctab, @object
+\crctab:
+	.long \crc
+	.size \crctab, . - \crctab
+	.set \crc, 0
+	.previous
+#endif
+	.endm
+
+#define EXPORT_SYMBOL(sym) \
+	 __EXPORT_SYMBOL sym, __ksymtab, __ksymtab_ ## sym, \
+		__kstrtab_ ## sym, __kcrctab_ ## sym, __crc_ ## sym
+#define EXPORT_SYMBOL_GPL(sym) \
+	 __EXPORT_SYMBOL sym, __ksymtab_gpl, __ksymtab_ ## sym, \
+		__kstrtab_ ## sym, __kcrctab_ ## sym, __crc_ ## sym
+#define EXPORT_SYMBOL_GPL_FUTURE(sym) \
+	 __EXPORT_SYMBOL sym, __ksymtab_gpl_future, __ksymtab_ ## sym, \
+		__kstrtab_ ## sym, __kcrctab_ ## sym, __crc_ ## sym
+#define EXPORT_UNUSED_SYMBOL(sym) \
+	 __EXPORT_SYMBOL sym, __ksymtab_unused, __ksymtab_ ## sym, \
+		__kstrtab_ ## sym, __kcrctab_ ## sym, __crc_ ## sym
+#define EXPORT_UNUSED_SYMBOL_GPL(sym) \
+	 __EXPORT_SYMBOL sym, __ksymtab_unused_gpl, __ksymtab_ ## sym, \
+		__kstrtab_ ## sym, __kcrctab_ ## sym, __crc_ ## sym
+
+#else /* CONFIG_MODULES... */
+#define EXPORT_SYMBOL(sym)
+#define EXPORT_SYMBOL_GPL(sym)
+#define EXPORT_SYMBOL_GPL_FUTURE(sym)
+#define EXPORT_UNUSED_SYMBOL(sym)
+#define EXPORT_UNUSED_SYMBOL_GPL(sym)
+#endif /* !CONFIG_MODULES... */
+
+#endif /* __ASSEMBLY__ */
+
 #endif /* _LINUX_MODULE_H */
