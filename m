From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2] module: use relative references for __ksymtab entries
Date: Sun,  6 Aug 2017 13:46:24 +0100
Message-ID: <20170806124624.22915-1-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:37216 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdHFMrZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Aug 2017 08:47:25 -0400
Received: by mail-wr0-f173.google.com with SMTP id 33so30678574wrz.4
        for <linux-arch@vger.kernel.org>; Sun, 06 Aug 2017 05:47:24 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>, Thomas Garnier <thgarnie@google.com>, Nicolas Pitre <nico@linaro.org>

An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
entries, each consisting of two 64-bit fields containing absolute
references, to the symbol itself and to a char array containing
its name, respectively.

When we build the same configuration with KASLR enabled, we end
up with an additional ~192 KB of relocations in the .init section,
i.e., one 24 byte entry for each absolute reference, which all need
to be processed at boot time.

Given how the struct kernel_symbol that describes each entry is
completely local to module.c (except for the references emitted
by EXPORT_SYMBOL() itself), we can easily modify it to contain
two 32-bit relative references instead. This reduces the size of
the __ksymtab section by 50% for all 64-bit architectures, and
gets rid of the runtime relocations entirely for architectures
implementing KASLR, either via standard PIE linking (arm64) or
using custom host tools (x86).

Since EXPORT_SYMBOL() no longer refers to struct kernel_symbol,
move the definition into module.c, which is its only user.

Note that the binary search involving __ksymtab contents relies
on each section being sorted by symbol name. This is implemented
based on the input section names, not the names in the ksymtab
entries, so this patch does not interfere with that.

Cc: Jessica Yu <jeyu@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2: - fix error in modpost due to missing local __ksymtab_xxx symbol names

Note that ARM requires a little tweak to ensure that the unwind
info related to the discarded code is discarded as well. I'm sure
there will be an arch or two where something similar may be required.

 arch/arm/kernel/vmlinux.lds.S |  1 +
 include/asm-generic/export.h  | 10 +------
 include/linux/export.h        | 28 ++++++++++--------
 kernel/module.c               | 31 ++++++++++++++++----
 4 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index c83a7ba737d6..4bdba75e510c 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -89,6 +89,7 @@ SECTIONS
 #endif
 		*(.discard)
 		*(.discard.*)
+		*(.ARM.exidx.discard)
 	}
 
 	. = PAGE_OFFSET + TEXT_OFFSET;
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 719db1968d81..fac5b2e6df37 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -4,17 +4,9 @@
 #ifndef KSYM_FUNC
 #define KSYM_FUNC(x) x
 #endif
-#ifdef CONFIG_64BIT
-#define __put .quad
 #ifndef KSYM_ALIGN
 #define KSYM_ALIGN 8
 #endif
-#else
-#define __put .long
-#ifndef KSYM_ALIGN
-#define KSYM_ALIGN 4
-#endif
-#endif
 #ifndef KCRC_ALIGN
 #define KCRC_ALIGN 4
 #endif
@@ -35,7 +27,7 @@
 	.section ___ksymtab\sec+\name,"a"
 	.balign KSYM_ALIGN
 KSYM(__ksymtab_\name):
-	__put \val, KSYM(__kstrtab_\name)
+	.long \val - ., KSYM(__kstrtab_\name) - .
 	.previous
 	.section __ksymtab_strings,"a"
 KSYM(__kstrtab_\name):
diff --git a/include/linux/export.h b/include/linux/export.h
index 1a1dfdb2a5c6..943656d74f0c 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -24,12 +24,6 @@
 #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
 
 #ifndef __ASSEMBLY__
-struct kernel_symbol
-{
-	unsigned long value;
-	const char *name;
-};
-
 #ifdef MODULE
 extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
@@ -60,17 +54,27 @@ extern struct module __this_module;
 #define __CRC_SYMBOL(sym, sec)
 #endif
 
-/* For every exported symbol, place a struct in the __ksymtab section */
+/*
+ * For every exported symbol, place a struct in the __ksymtab section.
+ * Note that we have to visibly take the address of sym, so the compiler
+ * is forced to emit it, rather than inlining it or removing it
+ * altogether. Do so in a way that avoids taking the address statically,
+ * and emit that code into a section that is discarded by the linker.
+ */
 #define ___EXPORT_SYMBOL(sym, sec)					\
 	extern typeof(sym) sym;						\
 	__CRC_SYMBOL(sym, sec)						\
 	static const char __kstrtab_##sym[]				\
-	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
+	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
 	= VMLINUX_SYMBOL_STR(sym);					\
-	static const struct kernel_symbol __ksymtab_##sym		\
-	__used								\
-	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
-	= { (unsigned long)&sym, __kstrtab_##sym }
+	static void * __attribute__((section(".discard"), used))	\
+			__discard_##sym(void) { return (void *)&sym; }	\
+	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
+	    "	.balign	8					\n"	\
+	    VMLINUX_SYMBOL_STR(__ksymtab_##sym) ":		\n"	\
+	    "	.long "	VMLINUX_SYMBOL_STR(sym) "- .		\n"	\
+	    "	.long "	VMLINUX_SYMBOL_STR(__kstrtab_##sym) "- .\n"	\
+	    "	.previous					\n")
 
 #if defined(__KSYM_DEPS__)
 
diff --git a/kernel/module.c b/kernel/module.c
index 40f983cbea81..f09529f695f9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -88,6 +88,12 @@
 /* If this is set, the section belongs in the init part of the module */
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
 
+struct kernel_symbol
+{
+	signed int value_offset;
+	signed int name_offset;
+};
+
 /*
  * Mutex protects:
  * 1) List of modules (also safely readable with preempt_disable),
@@ -539,12 +545,23 @@ static bool check_symbol(const struct symsearch *syms,
 	return true;
 }
 
+static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
+{
+	return (unsigned long)&sym->value_offset + sym->value_offset;
+}
+
+static const char *kernel_symbol_name(const struct kernel_symbol *sym)
+{
+	return (const char *)((unsigned long)&sym->name_offset +
+			      sym->name_offset);
+}
+
 static int cmp_name(const void *va, const void *vb)
 {
 	const char *a;
 	const struct kernel_symbol *b;
 	a = va; b = vb;
-	return strcmp(a, b->name);
+	return strcmp(a, kernel_symbol_name(b));
 }
 
 static bool find_symbol_in_section(const struct symsearch *syms,
@@ -2190,7 +2207,7 @@ void *__symbol_get(const char *symbol)
 		sym = NULL;
 	preempt_enable();
 
-	return sym ? (void *)sym->value : NULL;
+	return sym ? (void *)kernel_symbol_value(sym) : NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
@@ -2220,10 +2237,12 @@ static int verify_export_symbols(struct module *mod)
 
 	for (i = 0; i < ARRAY_SIZE(arr); i++) {
 		for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
-			if (find_symbol(s->name, &owner, NULL, true, false)) {
+			if (find_symbol(kernel_symbol_name(s), &owner, NULL,
+					true, false)) {
 				pr_err("%s: exports duplicate symbol %s"
 				       " (owned by %s)\n",
-				       mod->name, s->name, module_name(owner));
+				       mod->name, kernel_symbol_name(s),
+				       module_name(owner));
 				return -ENOEXEC;
 			}
 		}
@@ -2272,7 +2291,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 			ksym = resolve_symbol_wait(mod, info, name);
 			/* Ok if resolved.  */
 			if (ksym && !IS_ERR(ksym)) {
-				sym[i].st_value = ksym->value;
+				sym[i].st_value = kernel_symbol_value(ksym);
 				break;
 			}
 
@@ -2532,7 +2551,7 @@ static int is_exported(const char *name, unsigned long value,
 		ks = lookup_symbol(name, __start___ksymtab, __stop___ksymtab);
 	else
 		ks = lookup_symbol(name, mod->syms, mod->syms + mod->num_syms);
-	return ks != NULL && ks->value == value;
+	return ks != NULL && kernel_symbol_value(ks) == value;
 }
 
 /* As per nm */
-- 
2.11.0
