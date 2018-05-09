From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 5/8] export.h: remove code for prefixing symbols with underscore
Date: Wed,  9 May 2018 16:23:49 +0900
Message-ID: <1525850632-10921-6-git-send-email-yamada.masahiro@socionext.com>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, Sam Ravnborg <sam@ravnborg.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected by BLACKFIN, METAG.
They were removed by commit 4ba66a976072 ("arch: remove blackfin port"),
commit bb6fb6dfcc17 ("metag: Remove arch/metag/"), respectively.

No more architecture enables CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX.
Clean up the export.h headers.  I am keeping VMLINUX_SYMBOL() and
VMLINUX_SYMBOL_STR() because they are widely used.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/export.h | 34 ++++++++++++----------------------
 include/linux/export.h       | 16 +++++-----------
 2 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 719db19..68efb95 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -19,42 +19,32 @@
 #define KCRC_ALIGN 4
 #endif
 
-#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
-#define KSYM(name) _##name
-#else
-#define KSYM(name) name
-#endif
-
 /*
  * note on .section use: @progbits vs %progbits nastiness doesn't matter,
  * since we immediately emit into those sections anyway.
  */
 .macro ___EXPORT_SYMBOL name,val,sec
 #ifdef CONFIG_MODULES
-	.globl KSYM(__ksymtab_\name)
+	.globl __ksymtab_\name
 	.section ___ksymtab\sec+\name,"a"
 	.balign KSYM_ALIGN
-KSYM(__ksymtab_\name):
-	__put \val, KSYM(__kstrtab_\name)
+__ksymtab_\name:
+	__put \val, __kstrtab_\name
 	.previous
 	.section __ksymtab_strings,"a"
-KSYM(__kstrtab_\name):
-#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
-	.asciz "_\name"
-#else
+__kstrtab_\name:
 	.asciz "\name"
-#endif
 	.previous
 #ifdef CONFIG_MODVERSIONS
 	.section ___kcrctab\sec+\name,"a"
 	.balign KCRC_ALIGN
-KSYM(__kcrctab_\name):
+__kcrctab_\name:
 #if defined(CONFIG_MODULE_REL_CRCS)
-	.long KSYM(__crc_\name) - .
+	.long __crc_\name - .
 #else
-	.long KSYM(__crc_\name)
+	.long __crc_\name
 #endif
-	.weak KSYM(__crc_\name)
+	.weak __crc_\name
 	.previous
 #endif
 #endif
@@ -84,12 +74,12 @@ KSYM(__kcrctab_\name):
 #endif
 
 #define EXPORT_SYMBOL(name)					\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(KSYM(name)),)
+	__EXPORT_SYMBOL(name, KSYM_FUNC(name),)
 #define EXPORT_SYMBOL_GPL(name) 				\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(KSYM(name)), _gpl)
+	__EXPORT_SYMBOL(name, KSYM_FUNC(name), _gpl)
 #define EXPORT_DATA_SYMBOL(name)				\
-	__EXPORT_SYMBOL(name, KSYM(name),)
+	__EXPORT_SYMBOL(name, name,)
 #define EXPORT_DATA_SYMBOL_GPL(name)				\
-	__EXPORT_SYMBOL(name, KSYM(name),_gpl)
+	__EXPORT_SYMBOL(name, name,_gpl)
 
 #endif
diff --git a/include/linux/export.h b/include/linux/export.h
index 1a1dfdb..b768d6d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -10,14 +10,8 @@
  * hackers place grumpy comments in header files.
  */
 
-/* Some toolchains use a `_' prefix for all user symbols. */
-#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
-#define __VMLINUX_SYMBOL(x) _##x
-#define __VMLINUX_SYMBOL_STR(x) "_" #x
-#else
 #define __VMLINUX_SYMBOL(x) x
 #define __VMLINUX_SYMBOL_STR(x) #x
-#endif
 
 /* Indirect, so macros are expanded before pasting. */
 #define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)
@@ -46,14 +40,14 @@ extern struct module __this_module;
 #if defined(CONFIG_MODULE_REL_CRCS)
 #define __CRC_SYMBOL(sym, sec)						\
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
-	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) " - .	\n"	\
+	    "	.weak	__crc_" #sym "				\n"	\
+	    "	.long	__crc_" #sym " - .			\n"	\
 	    "	.previous					\n");
 #else
 #define __CRC_SYMBOL(sym, sec)						\
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
-	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.weak	__crc_" #sym "				\n"	\
+	    "	.long	__crc_" #sym "				\n"	\
 	    "	.previous					\n");
 #endif
 #else
@@ -66,7 +60,7 @@ extern struct module __this_module;
 	__CRC_SYMBOL(sym, sec)						\
 	static const char __kstrtab_##sym[]				\
 	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
-	= VMLINUX_SYMBOL_STR(sym);					\
+	= #sym;								\
 	static const struct kernel_symbol __ksymtab_##sym		\
 	__used								\
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
-- 
2.7.4
