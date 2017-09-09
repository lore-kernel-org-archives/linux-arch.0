From: Jessica Yu <jeyu@kernel.org>
Subject: Re: module: use relative references for __ksymtab entries
Date: Sat, 9 Sep 2017 15:08:31 +0200
Message-ID: <20170909130831.kpsoaytew5cyvtb3@redbean>
References: <20170819181035.969-1-ard.biesheuvel@linaro.org>
 <20170819181035.969-3-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757514AbdIINIl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 Sep 2017 09:08:41 -0400
Content-Disposition: inline
In-Reply-To: <20170819181035.969-3-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>, Steven Rostedt <rosted>

+++ Ard Biesheuvel [19/08/17 19:10 +0100]:
>An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
>entries, each consisting of two 64-bit fields containing absolute
>references, to the symbol itself and to a char array containing
>its name, respectively.
>
>When we build the same configuration with KASLR enabled, we end
>up with an additional ~192 KB of relocations in the .init section,
>i.e., one 24 byte entry for each absolute reference, which all need
>to be processed at boot time.
>
>Given how the struct kernel_symbol that describes each entry is
>completely local to module.c (except for the references emitted
>by EXPORT_SYMBOL() itself), we can easily modify it to contain
>two 32-bit relative references instead. This reduces the size of
>the __ksymtab section by 50% for all 64-bit architectures, and
>gets rid of the runtime relocations entirely for architectures
>implementing KASLR, either via standard PIE linking (arm64) or
>using custom host tools (x86).
>
>Note that the binary search involving __ksymtab contents relies
>on each section being sorted by symbol name. This is implemented
>based on the input section names, not the names in the ksymtab
>entries, so this patch does not interfere with that.
>
>Given that the use of place-relative relocations requires support
>both in the toolchain and in the module loader, we cannot enable
>this feature for all architectures. So make it dependend on whether
>CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is defined.
>
>Cc: Jessica Yu <jeyu@kernel.org>
>Cc: Arnd Bergmann <arnd@arndb.de>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Ingo Molnar <mingo@kernel.org>
>Cc: Kees Cook <keescook@chromium.org>
>Cc: Thomas Garnier <thgarnie@google.com>
>Cc: Nicolas Pitre <nico@linaro.org>
>Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I ran this through some light testing and the relative ksymtab
references seem to work just fine:

Acked-by: Jessica Yu <jeyu@kernel.org> (for module changes)

> arch/x86/include/asm/Kbuild   |  1 +
> arch/x86/include/asm/export.h |  4 --
> include/asm-generic/export.h  | 12 +++++-
> include/linux/compiler.h      | 11 +++++
> include/linux/export.h        | 45 +++++++++++++++-----
> kernel/module.c               | 33 +++++++++++---
> 6 files changed, 83 insertions(+), 23 deletions(-)
>
>diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
>index 5d6a53fd7521..3e8a88dcaa1d 100644
>--- a/arch/x86/include/asm/Kbuild
>+++ b/arch/x86/include/asm/Kbuild
>@@ -9,5 +9,6 @@ generated-y += xen-hypercalls.h
> generic-y += clkdev.h
> generic-y += dma-contiguous.h
> generic-y += early_ioremap.h
>+generic-y += export.h
> generic-y += mcs_spinlock.h
> generic-y += mm-arch-hooks.h
>diff --git a/arch/x86/include/asm/export.h b/arch/x86/include/asm/export.h
>deleted file mode 100644
>index 138de56b13eb..000000000000
>--- a/arch/x86/include/asm/export.h
>+++ /dev/null
>@@ -1,4 +0,0 @@
>-#ifdef CONFIG_64BIT
>-#define KSYM_ALIGN 16
>-#endif
>-#include <asm-generic/export.h>
>diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>index 719db1968d81..97ce606459ae 100644
>--- a/include/asm-generic/export.h
>+++ b/include/asm-generic/export.h
>@@ -5,12 +5,10 @@
> #define KSYM_FUNC(x) x
> #endif
> #ifdef CONFIG_64BIT
>-#define __put .quad
> #ifndef KSYM_ALIGN
> #define KSYM_ALIGN 8
> #endif
> #else
>-#define __put .long
> #ifndef KSYM_ALIGN
> #define KSYM_ALIGN 4
> #endif
>@@ -25,6 +23,16 @@
> #define KSYM(name) name
> #endif
>
>+.macro __put, val, name
>+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>+	.long	\val - ., \name - .
>+#elif defined(CONFIG_64BIT)
>+	.quad	\val, \name
>+#else
>+	.long	\val, \name
>+#endif
>+.endm
>+
> /*
>  * note on .section use: @progbits vs %progbits nastiness doesn't matter,
>  * since we immediately emit into those sections anyway.
>diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>index eca8ad75e28b..363fb3e734ec 100644
>--- a/include/linux/compiler.h
>+++ b/include/linux/compiler.h
>@@ -590,4 +590,15 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
> 	(_________p1); \
> })
>
>+/*
>+ * Force the compiler to emit 'sym' as a symbol, so that we can reference
>+ * it from inline assembler. Necessary in case 'sym' could be inlined
>+ * otherwise, or eliminated entirely due to lack of references that are
>+ * visibile to the compiler.
>+ */
>+#define __ADDRESSABLE(sym) \
>+	static void *__attribute__((section(".discard.text"), used))	\
>+		__PASTE(__discard_##sym, __LINE__)(void)		\
>+			{ return (void *)&sym; }			\
>+
> #endif /* __LINUX_COMPILER_H */
>diff --git a/include/linux/export.h b/include/linux/export.h
>index 1a1dfdb2a5c6..156b974181a4 100644
>--- a/include/linux/export.h
>+++ b/include/linux/export.h
>@@ -24,12 +24,6 @@
> #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
>
> #ifndef __ASSEMBLY__
>-struct kernel_symbol
>-{
>-	unsigned long value;
>-	const char *name;
>-};
>-
> #ifdef MODULE
> extern struct module __this_module;
> #define THIS_MODULE (&__this_module)
>@@ -60,17 +54,46 @@ extern struct module __this_module;
> #define __CRC_SYMBOL(sym, sec)
> #endif
>
>+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>+/*
>+ * Emit the ksymtab entry as a pair of relative references: this reduces
>+ * the size by half on 64-bit architectures, and eliminates the need for
>+ * absolute relocations that require runtime processing on relocatable
>+ * kernels.
>+ */
>+#define __KSYMTAB_ENTRY(sym, sec)					\
>+	__ADDRESSABLE(sym)						\
>+	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
>+	    "	.balign	8					\n"	\
>+	    VMLINUX_SYMBOL_STR(__ksymtab_##sym) ":		\n"	\
>+	    "	.long "	VMLINUX_SYMBOL_STR(sym) "- .		\n"	\
>+	    "	.long "	VMLINUX_SYMBOL_STR(__kstrtab_##sym) "- .\n"	\
>+	    "	.previous					\n")
>+
>+struct kernel_symbol {
>+	signed int value_offset;
>+	signed int name_offset;
>+};
>+#else
>+#define __KSYMTAB_ENTRY(sym, sec)					\
>+	static const struct kernel_symbol __ksymtab_##sym		\
>+	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
>+	= { (unsigned long)&sym, __kstrtab_##sym }
>+
>+struct kernel_symbol {
>+	unsigned long value;
>+	const char *name;
>+};
>+#endif
>+
> /* For every exported symbol, place a struct in the __ksymtab section */
> #define ___EXPORT_SYMBOL(sym, sec)					\
> 	extern typeof(sym) sym;						\
> 	__CRC_SYMBOL(sym, sec)						\
> 	static const char __kstrtab_##sym[]				\
>-	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
>+	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
> 	= VMLINUX_SYMBOL_STR(sym);					\
>-	static const struct kernel_symbol __ksymtab_##sym		\
>-	__used								\
>-	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
>-	= { (unsigned long)&sym, __kstrtab_##sym }
>+	__KSYMTAB_ENTRY(sym, sec)
>
> #if defined(__KSYM_DEPS__)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 40f983cbea81..a45423dcc32d 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -539,12 +539,31 @@ static bool check_symbol(const struct symsearch *syms,
> 	return true;
> }
>
>+static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
>+{
>+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>+	return (unsigned long)&sym->value_offset + sym->value_offset;
>+#else
>+	return sym->value;
>+#endif
>+}
>+
>+static const char *kernel_symbol_name(const struct kernel_symbol *sym)
>+{
>+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>+	return (const char *)((unsigned long)&sym->name_offset +
>+			      sym->name_offset);
>+#else
>+	return sym->name;
>+#endif
>+}
>+
> static int cmp_name(const void *va, const void *vb)
> {
> 	const char *a;
> 	const struct kernel_symbol *b;
> 	a = va; b = vb;
>-	return strcmp(a, b->name);
>+	return strcmp(a, kernel_symbol_name(b));
> }
>
> static bool find_symbol_in_section(const struct symsearch *syms,
>@@ -2190,7 +2209,7 @@ void *__symbol_get(const char *symbol)
> 		sym = NULL;
> 	preempt_enable();
>
>-	return sym ? (void *)sym->value : NULL;
>+	return sym ? (void *)kernel_symbol_value(sym) : NULL;
> }
> EXPORT_SYMBOL_GPL(__symbol_get);
>
>@@ -2220,10 +2239,12 @@ static int verify_export_symbols(struct module *mod)
>
> 	for (i = 0; i < ARRAY_SIZE(arr); i++) {
> 		for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
>-			if (find_symbol(s->name, &owner, NULL, true, false)) {
>+			if (find_symbol(kernel_symbol_name(s), &owner, NULL,
>+					true, false)) {
> 				pr_err("%s: exports duplicate symbol %s"
> 				       " (owned by %s)\n",
>-				       mod->name, s->name, module_name(owner));
>+				       mod->name, kernel_symbol_name(s),
>+				       module_name(owner));
> 				return -ENOEXEC;
> 			}
> 		}
>@@ -2272,7 +2293,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
> 			ksym = resolve_symbol_wait(mod, info, name);
> 			/* Ok if resolved.  */
> 			if (ksym && !IS_ERR(ksym)) {
>-				sym[i].st_value = ksym->value;
>+				sym[i].st_value = kernel_symbol_value(ksym);
> 				break;
> 			}
>
>@@ -2532,7 +2553,7 @@ static int is_exported(const char *name, unsigned long value,
> 		ks = lookup_symbol(name, __start___ksymtab, __stop___ksymtab);
> 	else
> 		ks = lookup_symbol(name, mod->syms, mod->syms + mod->num_syms);
>-	return ks != NULL && ks->value == value;
>+	return ks != NULL && kernel_symbol_value(ks) == value;
> }
>
> /* As per nm */
>-- 
>2.11.0
>
