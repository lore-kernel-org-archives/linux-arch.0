From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 1/3] add support for exporting symbols from .S files
Date: Mon, 11 Aug 2008 16:18:07 +0200
Message-ID: <200808111618.08206.arnd@arndb.de>
References: <200808111606.44103.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51890 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbYHKOjH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Aug 2008 10:39:07 -0400
In-Reply-To: <200808111606.44103.arnd@arndb.de>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, David Woodhouse <dwmw2@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linuxppc-dev@ozlabs.org

This makes it possible to export symbols from assembly files, instead
of having to export them through an extra ksyms.c file.

I found this nicer to implement using a gas macro than a cpp macro.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
@@ -605,4 +607,54 @@ static inline void module_remove_modinfo_attrs(struct module *mod)
 
 #define __MODULE_STRING(x) __stringify(x)
 
+#else /* __ASSEMBLY__ */
+#include <asm/types.h>
+
+#ifdef CONFIG_MODULES
+.macro __EXPORT_SYMBOL sym section symtab strtab
+	.section \section,"a",@progbits
+	.type \symtab, @object
+	.ifeq BITS_PER_LONG-32
+	.align 3
+\symtab:
+	.long \sym
+	.long \strtab
+	.else
+	.align 4
+\symtab:
+	.quad \sym
+	.quad \strtab
+	.endif
+	.size \symtab,.-\symtab
+	.previous
+
+	.section __ksymtab_strings,"a",@progbits
+	.type \strtab, @object
+\strtab:
+	.string "\sym"
+	.size \strtab,.-\strtab
+	.previous
+	.endm
+
+#define EXPORT_SYMBOL(sym) \
+	 __EXPORT_SYMBOL sym,__ksymtab,__ksymtab_ ## sym,__kstrtab_ ## sym
+#define EXPORT_SYMBOL_GPL(sym) \
+	 __EXPORT_SYMBOL sym,__ksymtab_gpl,__ksymtab_ ## sym,__kstrtab_ ## sym
+#define EXPORT_SYMBOL_GPL_FUTURE(sym) \
+	 __EXPORT_SYMBOL sym,__ksymtab_gpl_future,__ksymtab_ ## sym,__kstrtab_ ## sym
+#define EXPORT_UNUSED_SYMBOL(sym) \
+	 __EXPORT_SYMBOL sym,__ksymtab_unused,__ksymtab_ ## sym,__kstrtab_ ## sym
+#define EXPORT_UNUSED_SYMBOL_GPL(sym) \
+	 __EXPORT_SYMBOL sym,__ksymtab_unused_gpl,__ksymtab_ ## sym,__kstrtab_ ## sym
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
