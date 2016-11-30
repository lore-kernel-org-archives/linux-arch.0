From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Thu, 1 Dec 2016 05:18:52 +1100
Message-ID: <20161201051852.28dc335f@roar.ozlabs.ibm.com>
References: <20161129131922.GA31466@angband.pl>
        <20161129135118.24696-1-kilobyte@angband.pl>
        <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
        <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
        <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
        <20161129195721.GI2697@decadent.org.uk>
        <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36575 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756039AbcK3STT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Nov 2016 13:19:19 -0500
In-Reply-To: <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 29 Nov 2016 12:35:57 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Nov 29, 2016 at 11:57 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> >
> > If the modversion is missing then the fallback should be to a full
> > vermagic match, i.e. including the release string.  Something like
> > this (untested):  
> 
> This really seems way too complicated for this situation.
> 
> And it's wrong too. The whole point of modversions was that you didn't
> want to do the full version check.
> 
> We already know there were *some* crc's (we checked that at the top of
> check_version(), but we've also checked it in "same_magic()" - it's
> what makes us ignore the exact version number), but this particular
> symbol doesn't have a crc. Just let it through, because we have bugs
> in binutils.
> 
> So your extra complexity logic seems actively wrong. It makes
> MODVERSIONS not work at all, rather than limp along. You're better off
> just not having MODVERSIONS.

Here's an initial rough hack at removing modversions. It gives an idea
of the complexity we're carrying for this feature (keeping in mind most
of the lines removed are generated parser).

Note I removed the `rm -r scripts/genksyms` hunks to reduce mail size.

In its place I just added a simple config option to override vermagic
so distros can manage it entirely themselves.

Thanks,
Nick

---
 .gitignore                               |    1 -
 Documentation/dontdiff                   |    2 -
 Documentation/kbuild/modules.txt         |    4 -
 Makefile                                 |    7 -
 arch/arm64/include/asm/module.h          |    4 -
 arch/avr32/boot/images/Makefile          |    2 -
 arch/powerpc/include/asm/module.h        |    4 -
 arch/powerpc/kernel/module_64.c          |   24 +-
 arch/x86/tools/relocs.c                  |    1 -
 drivers/char/ipmi/ipmi_ssif.c            |    5 -
 drivers/firmware/efi/libstub/Makefile    |    4 +-
 drivers/message/fusion/mptlan.h          |    3 -
 include/asm-generic/export.h             |    8 -
 include/asm-generic/vmlinux.lds.h        |   35 -
 include/linux/export.h                   |   17 +-
 include/linux/module.h                   |   12 -
 include/linux/vermagic.h                 |   12 +-
 init/Kconfig                             |   28 +-
 kernel/module.c                          |  213 +--
 scripts/Makefile                         |    1 -
 scripts/Makefile.build                   |  113 --
 scripts/Makefile.lib                     |    3 +-
 scripts/Makefile.modpost                 |    2 +-
 scripts/adjust_autoksyms.sh              |    5 -
 scripts/export_report.pl                 |   30 +-
 scripts/genksyms/.gitignore              |    5 -
 scripts/genksyms/Makefile                |   14 -
 scripts/genksyms/genksyms.c              |  880 -----------
 scripts/genksyms/genksyms.h              |   94 --
 scripts/genksyms/keywords.gperf          |   60 -
 scripts/genksyms/keywords.hash.c_shipped |  229 ---
 scripts/genksyms/lex.l                   |  481 ------
 scripts/genksyms/lex.lex.c_shipped       | 2291 ----------------------------
 scripts/genksyms/parse.tab.c_shipped     | 2396 ------------------------------
 scripts/genksyms/parse.tab.h_shipped     |  118 --
 scripts/genksyms/parse.y                 |  513 -------
 scripts/mksysmap                         |    6 +-
 scripts/mod/modpost.c                    |  122 +-
 scripts/module-common.lds                |    5 -
 scripts/namespace.pl                     |    2 -
 40 files changed, 60 insertions(+), 7696 deletions(-)
 delete mode 100644 scripts/genksyms/.gitignore
 delete mode 100644 scripts/genksyms/Makefile
 delete mode 100644 scripts/genksyms/genksyms.c
 delete mode 100644 scripts/genksyms/genksyms.h
 delete mode 100644 scripts/genksyms/keywords.gperf
 delete mode 100644 scripts/genksyms/keywords.hash.c_shipped
 delete mode 100644 scripts/genksyms/lex.l
 delete mode 100644 scripts/genksyms/lex.lex.c_shipped
 delete mode 100644 scripts/genksyms/parse.tab.c_shipped
 delete mode 100644 scripts/genksyms/parse.tab.h_shipped
 delete mode 100644 scripts/genksyms/parse.y

diff --git a/.gitignore b/.gitignore
index c2ed4ec..cde8773 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,7 +20,6 @@
 *.mod.c
 *.i
 *.lst
-*.symtypes
 *.order
 *.elf
 *.bin
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 5385cba..40eb3e0 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -47,7 +47,6 @@
 *.sgml
 *.so
 *.so.dbg
-*.symtypes
 *.tab.c
 *.tab.h
 *.tex
@@ -180,7 +179,6 @@ mktree
 modpost
 modules.builtin
 modules.order
-modversions.h*
 nconf
 ncscope.*
 offset.h
diff --git a/Documentation/kbuild/modules.txt b/Documentation/kbuild/modules.txt
index 3fb39e0..1568b8a 100644
--- a/Documentation/kbuild/modules.txt
+++ b/Documentation/kbuild/modules.txt
@@ -61,10 +61,6 @@ make sure the kernel contains the information required. The target
 exists solely as a simple way to prepare a kernel source tree for
 building external modules.
 
-NOTE: "modules_prepare" will not build Module.symvers even if
-CONFIG_MODVERSIONS is set; therefore, a full kernel build needs to be
-executed to make module versioning work.
-
 --- 2.1 Command Syntax
 
 	The command to build an external module is:
diff --git a/Makefile b/Makefile
index 694111b..2066419 100644
--- a/Makefile
+++ b/Makefile
@@ -316,13 +316,6 @@ KBUILD_MODULES :=
 KBUILD_BUILTIN := 1
 
 # If we have only "make modules", don't compile built-in objects.
-# When we're building modules with modversions, we need to consider
-# the built-in objects during the descend as well, in order to
-# make sure the checksums are up to date before we record them.
-
-ifeq ($(MAKECMDGOALS),modules)
-  KBUILD_BUILTIN := $(if $(CONFIG_MODVERSIONS),1)
-endif
 
 # If we have "make <whatever> modules", compile modules
 # in addition to whatever we do anyway.
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 06ff7fd..253f6ca 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -33,10 +33,6 @@ u64 module_emit_plt_entry(struct module *mod, const Elf64_Rela *rela,
 			  Elf64_Sym *sym);
 
 #ifdef CONFIG_RANDOMIZE_BASE
-#ifdef CONFIG_MODVERSIONS
-#define ARCH_RELOCATES_KCRCTAB
-#define reloc_start 		(kimage_vaddr - KIMAGE_VADDR)
-#endif
 extern u64 module_alloc_base;
 #else
 #define module_alloc_base	((u64)_etext - MODULES_VSIZE)
diff --git a/arch/avr32/boot/images/Makefile b/arch/avr32/boot/images/Makefile
index 2a3b539..0878bef 100644
--- a/arch/avr32/boot/images/Makefile
+++ b/arch/avr32/boot/images/Makefile
@@ -37,8 +37,6 @@ OBJCOPYFLAGS_vmlinux.elf := --change-section-lma .text-0x80000000 \
 			    --change-section-lma __param-0x80000000 \
 			    --change-section-lma __ksymtab-0x80000000 \
 			    --change-section-lma __ksymtab_gpl-0x80000000 \
-			    --change-section-lma __kcrctab-0x80000000 \
-			    --change-section-lma __kcrctab_gpl-0x80000000 \
 			    --change-section-lma __ksymtab_strings-0x80000000 \
 			    --set-start 0xa0000000
 $(obj)/vmlinux.elf: vmlinux FORCE
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index cd4ffd8..94a7f7a 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -94,9 +94,5 @@ struct exception_table_entry;
 void sort_ex_table(struct exception_table_entry *start,
 		   struct exception_table_entry *finish);
 
-#if defined(CONFIG_MODVERSIONS) && defined(CONFIG_PPC64)
-#define ARCH_RELOCATES_KCRCTAB
-#define reloc_start PHYSICAL_START
-#endif
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_MODULE_H */
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 183368e..3e59856 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -277,30 +277,11 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 	return relocs * sizeof(struct ppc64_stub_entry);
 }
 
-/* Still needed for ELFv2, for .TOC. */
-static void dedotify_versions(struct modversion_info *vers,
-			      unsigned long size)
-{
-	struct modversion_info *end;
-
-	for (end = (void *)vers + size; vers < end; vers++)
-		if (vers->name[0] == '.') {
-			memmove(vers->name, vers->name+1, strlen(vers->name));
-#ifdef ARCH_RELOCATES_KCRCTAB
-			/* The TOC symbol has no CRC computed. To avoid CRC
-			 * check failing, we must force it to the expected
-			 * value (see CRC check in module.c).
-			 */
-			if (!strcmp(vers->name, "TOC."))
-				vers->crc = -(unsigned long)reloc_start;
-#endif
-		}
-}
-
 /*
  * Undefined symbols which refer to .funcname, hack to funcname. Make .TOC.
  * seem to be defined (value set later).
  */
+/* XXX: remove for ELFv2? */
 static void dedotify(Elf64_Sym *syms, unsigned int numsyms, char *strtab)
 {
 	unsigned int i;
@@ -349,9 +330,6 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 			me->arch.stubs_section = i;
 		else if (strcmp(secstrings + sechdrs[i].sh_name, ".toc") == 0)
 			me->arch.toc_section = i;
-		else if (strcmp(secstrings+sechdrs[i].sh_name,"__versions")==0)
-			dedotify_versions((void *)hdr + sechdrs[i].sh_offset,
-					  sechdrs[i].sh_size);
 
 		/* We don't handle .init for the moment: rename to _init */
 		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init")))
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 0c2fae8..4c15dc0 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -59,7 +59,6 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"__(start|end)_pci_.*|"
 	"__(start|end)_builtin_fw|"
 	"__(start|stop)___ksymtab(|_gpl|_unused|_unused_gpl|_gpl_future)|"
-	"__(start|stop)___kcrctab(|_gpl|_unused|_unused_gpl|_gpl_future)|"
 	"__(start|stop)___param|"
 	"__(start|stop)___modver|"
 	"__(start|stop)___bug_table|"
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 5673fff..89c3ece 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -30,11 +30,6 @@
  * TODO: Figure out how to use SMB alerts.  This will require a new
  * interface into the I2C driver, I believe.
  */
-
-#if defined(MODVERSIONS)
-#include <linux/modversions.h>
-#endif
-
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 5e23e2d..0d9d84e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -60,7 +60,7 @@ CFLAGS_arm64-stub.o 		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 extra-$(CONFIG_EFI_ARMSTUB)	:= $(lib-y)
 lib-$(CONFIG_EFI_ARMSTUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
 
-STUBCOPY_FLAGS-y		:= -R .debug* -R *ksymtab* -R *kcrctab*
+STUBCOPY_FLAGS-y		:= -R .debug* -R *ksymtab*
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
@@ -80,5 +80,5 @@ quiet_cmd_stubcopy = STUBCPY $@
 # explicitly by the decompressor linker script.
 #
 STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub \
-				   -R ___ksymtab+sort -R ___kcrctab+sort
+				   -R ___ksymtab+sort
 STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
diff --git a/drivers/message/fusion/mptlan.h b/drivers/message/fusion/mptlan.h
index 69e9d54..f976a5b 100644
--- a/drivers/message/fusion/mptlan.h
+++ b/drivers/message/fusion/mptlan.h
@@ -51,10 +51,7 @@
 #define LINUX_MPTLAN_H_INCLUDED
 /*****************************************************************************/
 
-#if !defined(__GENKSYMS__)
 #include <linux/module.h>
-#endif
-
 #include <linux/netdevice.h>
 #include <linux/errno.h>
 // #include <linux/etherdevice.h>
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 63554e9..cb0c6cf 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -48,14 +48,6 @@ KSYM(__kstrtab_\name):
 	.asciz "\name"
 #endif
 	.previous
-#ifdef CONFIG_MODVERSIONS
-	.section ___kcrctab\sec+\name,"a"
-	.balign KCRC_ALIGN
-KSYM(__kcrctab_\name):
-	__put KSYM(__crc_\name)
-	.weak KSYM(__crc_\name)
-	.previous
-#endif
 #endif
 .endm
 #undef __put
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6d5d35f..8b52b57 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -360,41 +360,6 @@
 		VMLINUX_SYMBOL(__stop___ksymtab_gpl_future) = .;	\
 	}								\
 									\
-	/* Kernel symbol table: Normal symbols */			\
-	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
-		VMLINUX_SYMBOL(__start___kcrctab) = .;			\
-		KEEP(*(SORT(___kcrctab+*)))				\
-		VMLINUX_SYMBOL(__stop___kcrctab) = .;			\
-	}								\
-									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__start___kcrctab_gpl) = .;		\
-		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-		VMLINUX_SYMBOL(__stop___kcrctab_gpl) = .;		\
-	}								\
-									\
-	/* Kernel symbol table: Normal unused symbols */		\
-	__kcrctab_unused  : AT(ADDR(__kcrctab_unused) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__start___kcrctab_unused) = .;		\
-		KEEP(*(SORT(___kcrctab_unused+*)))			\
-		VMLINUX_SYMBOL(__stop___kcrctab_unused) = .;		\
-	}								\
-									\
-	/* Kernel symbol table: GPL-only unused symbols */		\
-	__kcrctab_unused_gpl : AT(ADDR(__kcrctab_unused_gpl) - LOAD_OFFSET) { \
-		VMLINUX_SYMBOL(__start___kcrctab_unused_gpl) = .;	\
-		KEEP(*(SORT(___kcrctab_unused_gpl+*)))			\
-		VMLINUX_SYMBOL(__stop___kcrctab_unused_gpl) = .;	\
-	}								\
-									\
-	/* Kernel symbol table: GPL-future-only symbols */		\
-	__kcrctab_gpl_future : AT(ADDR(__kcrctab_gpl_future) - LOAD_OFFSET) { \
-		VMLINUX_SYMBOL(__start___kcrctab_gpl_future) = .;	\
-		KEEP(*(SORT(___kcrctab_gpl_future+*)))			\
-		VMLINUX_SYMBOL(__stop___kcrctab_gpl_future) = .;	\
-	}								\
-									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		KEEP(*(__ksymtab_strings))				\
diff --git a/include/linux/export.h b/include/linux/export.h
index 2a0f61f..ba359cf 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -39,24 +39,11 @@ extern struct module __this_module;
 
 #ifdef CONFIG_MODULES
 
-#if defined(__KERNEL__) && !defined(__GENKSYMS__)
-#ifdef CONFIG_MODVERSIONS
-/* Mark the CRC weak since genksyms apparently decides not to
- * generate a checksums for some symbols */
-#define __CRC_SYMBOL(sym, sec)						\
-	extern __visible void *__crc_##sym __attribute__((weak));	\
-	static const unsigned long __kcrctab_##sym			\
-	__used								\
-	__attribute__((section("___kcrctab" sec "+" #sym), used))	\
-	= (unsigned long) &__crc_##sym;
-#else
-#define __CRC_SYMBOL(sym, sec)
-#endif
+#if defined(__KERNEL__)
 
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define ___EXPORT_SYMBOL(sym, sec)					\
 	extern typeof(sym) sym;						\
-	__CRC_SYMBOL(sym, sec)						\
 	static const char __kstrtab_##sym[]				\
 	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
 	= VMLINUX_SYMBOL_STR(sym);					\
@@ -110,7 +97,7 @@ extern struct module __this_module;
 #define EXPORT_UNUSED_SYMBOL_GPL(sym)
 #endif
 
-#endif	/* __GENKSYMS__ */
+#endif	/* __KERNEL__ */
 
 #else /* !CONFIG_MODULES... */
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 0c3207d..ee121f2 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -32,11 +32,6 @@
 
 #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
 
-struct modversion_info {
-	unsigned long crc;
-	char name[MODULE_NAME_LEN];
-};
-
 struct module;
 struct exception_table_entry;
 
@@ -346,7 +341,6 @@ struct module {
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
-	const unsigned long *crcs;
 	unsigned int num_syms;
 
 	/* Kernel parameters. */
@@ -359,18 +353,15 @@ struct module {
 	/* GPL-only exported symbols. */
 	unsigned int num_gpl_syms;
 	const struct kernel_symbol *gpl_syms;
-	const unsigned long *gpl_crcs;
 
 #ifdef CONFIG_UNUSED_SYMBOLS
 	/* unused exported symbols. */
 	const struct kernel_symbol *unused_syms;
-	const unsigned long *unused_crcs;
 	unsigned int num_unused_syms;
 
 	/* GPL-only, unused exported symbols. */
 	unsigned int num_unused_gpl_syms;
 	const struct kernel_symbol *unused_gpl_syms;
-	const unsigned long *unused_gpl_crcs;
 #endif
 
 #ifdef CONFIG_MODULE_SIG
@@ -382,7 +373,6 @@ struct module {
 
 	/* symbols that will be GPL-only in the near future. */
 	const struct kernel_symbol *gpl_future_syms;
-	const unsigned long *gpl_future_crcs;
 	unsigned int num_gpl_future_syms;
 
 	/* Exception table */
@@ -523,7 +513,6 @@ struct module *find_module(const char *name);
 
 struct symsearch {
 	const struct kernel_symbol *start, *stop;
-	const unsigned long *crcs;
 	enum {
 		NOT_GPL_ONLY,
 		GPL_ONLY,
@@ -539,7 +528,6 @@ struct symsearch {
  */
 const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
-					const unsigned long **crc,
 					bool gplok,
 					bool warn);
 
diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index 6f8fbcf..fafeea0 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -16,18 +16,16 @@
 #else
 #define MODULE_VERMAGIC_MODULE_UNLOAD ""
 #endif
-#ifdef CONFIG_MODVERSIONS
-#define MODULE_VERMAGIC_MODVERSIONS "modversions "
-#else
-#define MODULE_VERMAGIC_MODVERSIONS ""
-#endif
 #ifndef MODULE_ARCH_VERMAGIC
 #define MODULE_ARCH_VERMAGIC ""
 #endif
 
+#ifdef CONFIG_MODULE_ABI_EXPLICIT
+#define VERMAGIC_STRING CONFIG_MODULE_ABI_EXPLICIT_STRING
+#else
 #define VERMAGIC_STRING 						\
 	UTS_RELEASE " "							\
 	MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT 			\
-	MODULE_VERMAGIC_MODULE_UNLOAD MODULE_VERMAGIC_MODVERSIONS	\
+	MODULE_VERMAGIC_MODULE_UNLOAD					\
 	MODULE_ARCH_VERMAGIC
-
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index 34407f1..7a1b6ac 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1943,15 +1943,25 @@ config MODULE_FORCE_UNLOAD
 	  rmmod).  This is mainly for kernel developers and desperate users.
 	  If unsure, say N.
 
-config MODVERSIONS
-	bool "Module versioning support"
-	help
-	  Usually, you have to use modules compiled with your kernel.
-	  Saying Y here makes it sometimes possible to use modules
-	  compiled for different kernels, by adding enough information
-	  to the modules to (hopefully) spot any changes which would
-	  make them incompatible with the kernel you are running.  If
-	  unsure, say N.
+config MODULE_ABI_EXPLICIT
+	bool "Provide explicit module ABI version string" if EXPERT
+	default n
+	help
+	  This option is mostly for distro maintainers.
+
+	  When this option is NOT set, the kernel/module ABI version string
+	  is based on the kernel version (among other things), which means
+	  modules are not compatible when there is any change to kernel
+	  version. This is what most people want.
+
+	  Enabling this option allows you to provide an explicit module
+	  ABI version string. This allows modules to be usable between kernel
+	  version bumps.
+
+	  If unusure, say N.
+
+config MODULE_ABI_EXPLICIT_STRING
+	string "Explicit module ABI version string" if MODULE_ABI_EXPLICIT
 
 config MODULE_SRCVERSION_ALL
 	bool "Source checksum for all modules"
diff --git a/kernel/module.c b/kernel/module.c
index 0e54d5b..ff68854 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -309,7 +309,7 @@ struct load_info {
 	unsigned long mod_kallsyms_init_off;
 #endif
 	struct {
-		unsigned int sym, str, mod, vers, info, pcpu;
+		unsigned int sym, str, mod, info, pcpu;
 	} index;
 };
 
@@ -386,22 +386,11 @@ extern const struct kernel_symbol __start___ksymtab_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const struct kernel_symbol __start___ksymtab_gpl_future[];
 extern const struct kernel_symbol __stop___ksymtab_gpl_future[];
-extern const unsigned long __start___kcrctab[];
-extern const unsigned long __start___kcrctab_gpl[];
-extern const unsigned long __start___kcrctab_gpl_future[];
 #ifdef CONFIG_UNUSED_SYMBOLS
 extern const struct kernel_symbol __start___ksymtab_unused[];
 extern const struct kernel_symbol __stop___ksymtab_unused[];
 extern const struct kernel_symbol __start___ksymtab_unused_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_unused_gpl[];
-extern const unsigned long __start___kcrctab_unused[];
-extern const unsigned long __start___kcrctab_unused_gpl[];
-#endif
-
-#ifndef CONFIG_MODVERSIONS
-#define symversion(base, idx) NULL
-#else
-#define symversion(base, idx) ((base != NULL) ? ((base) + (idx)) : NULL)
 #endif
 
 static bool each_symbol_in_section(const struct symsearch *arr,
@@ -430,20 +419,16 @@ bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
 {
 	struct module *mod;
 	static const struct symsearch arr[] = {
-		{ __start___ksymtab, __stop___ksymtab, __start___kcrctab,
+		{ __start___ksymtab, __stop___ksymtab,
 		  NOT_GPL_ONLY, false },
 		{ __start___ksymtab_gpl, __stop___ksymtab_gpl,
-		  __start___kcrctab_gpl,
 		  GPL_ONLY, false },
 		{ __start___ksymtab_gpl_future, __stop___ksymtab_gpl_future,
-		  __start___kcrctab_gpl_future,
 		  WILL_BE_GPL_ONLY, false },
 #ifdef CONFIG_UNUSED_SYMBOLS
 		{ __start___ksymtab_unused, __stop___ksymtab_unused,
-		  __start___kcrctab_unused,
 		  NOT_GPL_ONLY, true },
 		{ __start___ksymtab_unused_gpl, __stop___ksymtab_unused_gpl,
-		  __start___kcrctab_unused_gpl,
 		  GPL_ONLY, true },
 #endif
 	};
@@ -455,23 +440,19 @@ bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
 
 	list_for_each_entry_rcu(mod, &modules, list) {
 		struct symsearch arr[] = {
-			{ mod->syms, mod->syms + mod->num_syms, mod->crcs,
+			{ mod->syms, mod->syms + mod->num_syms,
 			  NOT_GPL_ONLY, false },
 			{ mod->gpl_syms, mod->gpl_syms + mod->num_gpl_syms,
-			  mod->gpl_crcs,
 			  GPL_ONLY, false },
 			{ mod->gpl_future_syms,
 			  mod->gpl_future_syms + mod->num_gpl_future_syms,
-			  mod->gpl_future_crcs,
 			  WILL_BE_GPL_ONLY, false },
 #ifdef CONFIG_UNUSED_SYMBOLS
 			{ mod->unused_syms,
 			  mod->unused_syms + mod->num_unused_syms,
-			  mod->unused_crcs,
 			  NOT_GPL_ONLY, true },
 			{ mod->unused_gpl_syms,
 			  mod->unused_gpl_syms + mod->num_unused_gpl_syms,
-			  mod->unused_gpl_crcs,
 			  GPL_ONLY, true },
 #endif
 		};
@@ -494,7 +475,6 @@ struct find_symbol_arg {
 
 	/* Output */
 	struct module *owner;
-	const unsigned long *crc;
 	const struct kernel_symbol *sym;
 };
 
@@ -527,7 +507,6 @@ static bool check_symbol(const struct symsearch *syms,
 #endif
 
 	fsa->owner = owner;
-	fsa->crc = symversion(syms->crcs, symnum);
 	fsa->sym = &syms->start[symnum];
 	return true;
 }
@@ -556,11 +535,12 @@ static bool find_symbol_in_section(const struct symsearch *syms,
 	return false;
 }
 
-/* Find a symbol and return it, along with, (optional) crc and
- * (optional) module which owns it.  Needs preempt disabled or module_mutex. */
+/*
+ * Find a symbol and return it, along with, and (optional) module which owns
+ * it.  Needs preempt disabled or module_mutex.
+ */
 const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
-					const unsigned long **crc,
 					bool gplok,
 					bool warn)
 {
@@ -573,8 +553,6 @@ const struct kernel_symbol *find_symbol(const char *name,
 	if (each_symbol_section(find_symbol_in_section, &fsa)) {
 		if (owner)
 			*owner = fsa.owner;
-		if (crc)
-			*crc = fsa.crc;
 		return fsa.sym;
 	}
 
@@ -1031,7 +1009,7 @@ void __symbol_put(const char *symbol)
 	struct module *owner;
 
 	preempt_disable();
-	if (!find_symbol(symbol, &owner, NULL, true, false))
+	if (!find_symbol(symbol, &owner, true, false))
 		BUG();
 	module_put(owner);
 	preempt_enable();
@@ -1256,118 +1234,6 @@ static int try_to_force_load(struct module *mod, const char *reason)
 #endif
 }
 
-#ifdef CONFIG_MODVERSIONS
-/* If the arch applies (non-zero) relocations to kernel kcrctab, unapply it. */
-static unsigned long maybe_relocated(unsigned long crc,
-				     const struct module *crc_owner)
-{
-#ifdef ARCH_RELOCATES_KCRCTAB
-	if (crc_owner == NULL)
-		return crc - (unsigned long)reloc_start;
-#endif
-	return crc;
-}
-
-static int check_version(Elf_Shdr *sechdrs,
-			 unsigned int versindex,
-			 const char *symname,
-			 struct module *mod,
-			 const unsigned long *crc,
-			 const struct module *crc_owner)
-{
-	unsigned int i, num_versions;
-	struct modversion_info *versions;
-
-	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
-	if (!crc)
-		return 1;
-
-	/* No versions at all?  modprobe --force does this. */
-	if (versindex == 0)
-		return try_to_force_load(mod, symname) == 0;
-
-	versions = (void *) sechdrs[versindex].sh_addr;
-	num_versions = sechdrs[versindex].sh_size
-		/ sizeof(struct modversion_info);
-
-	for (i = 0; i < num_versions; i++) {
-		if (strcmp(versions[i].name, symname) != 0)
-			continue;
-
-		if (versions[i].crc == maybe_relocated(*crc, crc_owner))
-			return 1;
-		pr_debug("Found checksum %lX vs module %lX\n",
-		       maybe_relocated(*crc, crc_owner), versions[i].crc);
-		goto bad_version;
-	}
-
-	/* Broken toolchain. Warn once, then let it go.. */
-	pr_warn_once("%s: no symbol version for %s\n", mod->name, symname);
-	return 1;
-
-bad_version:
-	pr_warn("%s: disagrees about version of symbol %s\n",
-	       mod->name, symname);
-	return 0;
-}
-
-static inline int check_modstruct_version(Elf_Shdr *sechdrs,
-					  unsigned int versindex,
-					  struct module *mod)
-{
-	const unsigned long *crc;
-
-	/*
-	 * Since this should be found in kernel (which can't be removed), no
-	 * locking is necessary -- use preempt_disable() to placate lockdep.
-	 */
-	preempt_disable();
-	if (!find_symbol(VMLINUX_SYMBOL_STR(module_layout), NULL,
-			 &crc, true, false)) {
-		preempt_enable();
-		BUG();
-	}
-	preempt_enable();
-	return check_version(sechdrs, versindex,
-			     VMLINUX_SYMBOL_STR(module_layout), mod, crc,
-			     NULL);
-}
-
-/* First part is kernel version, which we ignore if module has crcs. */
-static inline int same_magic(const char *amagic, const char *bmagic,
-			     bool has_crcs)
-{
-	if (has_crcs) {
-		amagic += strcspn(amagic, " ");
-		bmagic += strcspn(bmagic, " ");
-	}
-	return strcmp(amagic, bmagic) == 0;
-}
-#else
-static inline int check_version(Elf_Shdr *sechdrs,
-				unsigned int versindex,
-				const char *symname,
-				struct module *mod,
-				const unsigned long *crc,
-				const struct module *crc_owner)
-{
-	return 1;
-}
-
-static inline int check_modstruct_version(Elf_Shdr *sechdrs,
-					  unsigned int versindex,
-					  struct module *mod)
-{
-	return 1;
-}
-
-static inline int same_magic(const char *amagic, const char *bmagic,
-			     bool has_crcs)
-{
-	return strcmp(amagic, bmagic) == 0;
-}
-#endif /* CONFIG_MODVERSIONS */
-
 /* Resolve a symbol for this module.  I.e. if we find one, record usage. */
 static const struct kernel_symbol *resolve_symbol(struct module *mod,
 						  const struct load_info *info,
@@ -1376,7 +1242,6 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 {
 	struct module *owner;
 	const struct kernel_symbol *sym;
-	const unsigned long *crc;
 	int err;
 
 	/*
@@ -1386,24 +1251,15 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 	 */
 	sched_annotate_sleep();
 	mutex_lock(&module_mutex);
-	sym = find_symbol(name, &owner, &crc,
-			  !(mod->taints & (1 << TAINT_PROPRIETARY_MODULE)), true);
+	sym = find_symbol(name, &owner,
+			!(mod->taints & (1 << TAINT_PROPRIETARY_MODULE)), true);
 	if (!sym)
 		goto unlock;
 
-	if (!check_version(info->sechdrs, info->index.vers, name, mod, crc,
-			   owner)) {
-		sym = ERR_PTR(-EINVAL);
-		goto getname;
-	}
-
 	err = ref_module(mod, owner);
-	if (err) {
+	if (err)
 		sym = ERR_PTR(err);
-		goto getname;
-	}
 
-getname:
 	/* We must make copy under the lock if we failed to get ref. */
 	strncpy(ownername, module_name(owner), MODULE_NAME_LEN);
 unlock:
@@ -2149,7 +2005,7 @@ void *__symbol_get(const char *symbol)
 	const struct kernel_symbol *sym;
 
 	preempt_disable();
-	sym = find_symbol(symbol, &owner, NULL, true, true);
+	sym = find_symbol(symbol, &owner, true, true);
 	if (sym && strong_try_module_get(owner))
 		sym = NULL;
 	preempt_enable();
@@ -2184,7 +2040,7 @@ static int verify_export_symbols(struct module *mod)
 
 	for (i = 0; i < ARRAY_SIZE(arr); i++) {
 		for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
-			if (find_symbol(s->name, &owner, NULL, true, false)) {
+			if (find_symbol(s->name, &owner, true, false)) {
 				pr_err("%s: exports duplicate symbol %s"
 				       " (owned by %s)\n",
 				       mod->name, s->name, module_name(owner));
@@ -2876,14 +2732,9 @@ static int rewrite_section_headers(struct load_info *info, int flags)
 #endif
 	}
 
-	/* Track but don't keep modinfo and version sections. */
-	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
-		info->index.vers = 0; /* Pretend no __versions section! */
-	else
-		info->index.vers = find_sec(info, "__versions");
 	info->index.info = find_sec(info, ".modinfo");
 	info->sechdrs[info->index.info].sh_flags &= ~(unsigned long)SHF_ALLOC;
-	info->sechdrs[info->index.vers].sh_flags &= ~(unsigned long)SHF_ALLOC;
+
 	return 0;
 }
 
@@ -2936,10 +2787,6 @@ static struct module *setup_load_info(struct load_info *info, int flags)
 
 	info->index.pcpu = find_pcpusec(info);
 
-	/* Check module struct version now, before we try to use module. */
-	if (!check_modstruct_version(info->sechdrs, info->index.vers, mod))
-		return ERR_PTR(-ENOEXEC);
-
 	return mod;
 }
 
@@ -2956,7 +2803,7 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 		err = try_to_force_load(mod, "bad vermagic");
 		if (err)
 			return err;
-	} else if (!same_magic(modmagic, vermagic, info->index.vers)) {
+	} else if (strcmp(modmagic, vermagic)) {
 		pr_err("%s: version magic '%s' should be '%s'\n",
 		       mod->name, modmagic, vermagic);
 		return -ENOEXEC;
@@ -2991,26 +2838,21 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 			       sizeof(*mod->kp), &mod->num_kp);
 	mod->syms = section_objs(info, "__ksymtab",
 				 sizeof(*mod->syms), &mod->num_syms);
-	mod->crcs = section_addr(info, "__kcrctab");
 	mod->gpl_syms = section_objs(info, "__ksymtab_gpl",
 				     sizeof(*mod->gpl_syms),
 				     &mod->num_gpl_syms);
-	mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
 	mod->gpl_future_syms = section_objs(info,
 					    "__ksymtab_gpl_future",
 					    sizeof(*mod->gpl_future_syms),
 					    &mod->num_gpl_future_syms);
-	mod->gpl_future_crcs = section_addr(info, "__kcrctab_gpl_future");
 
 #ifdef CONFIG_UNUSED_SYMBOLS
 	mod->unused_syms = section_objs(info, "__ksymtab_unused",
 					sizeof(*mod->unused_syms),
 					&mod->num_unused_syms);
-	mod->unused_crcs = section_addr(info, "__kcrctab_unused");
 	mod->unused_gpl_syms = section_objs(info, "__ksymtab_unused_gpl",
 					    sizeof(*mod->unused_gpl_syms),
 					    &mod->num_unused_gpl_syms);
-	mod->unused_gpl_crcs = section_addr(info, "__kcrctab_unused_gpl");
 #endif
 #ifdef CONFIG_CONSTRUCTORS
 	mod->ctors = section_objs(info, ".ctors",
@@ -3159,19 +3001,6 @@ static int check_module_license_and_versions(struct module *mod)
 	if (!prev_taint && test_taint(TAINT_PROPRIETARY_MODULE))
 		pr_warn("%s: module license taints kernel.\n", mod->name);
 
-#ifdef CONFIG_MODVERSIONS
-	if ((mod->num_syms && !mod->crcs)
-	    || (mod->num_gpl_syms && !mod->gpl_crcs)
-	    || (mod->num_gpl_future_syms && !mod->gpl_future_crcs)
-#ifdef CONFIG_UNUSED_SYMBOLS
-	    || (mod->num_unused_syms && !mod->unused_crcs)
-	    || (mod->num_unused_gpl_syms && !mod->unused_gpl_crcs)
-#endif
-		) {
-		return try_to_force_load(mod,
-					 "no versions for exported symbols");
-	}
-#endif
 	return 0;
 }
 
@@ -4273,15 +4102,3 @@ void print_modules(void)
 	pr_cont("\n");
 }
 
-#ifdef CONFIG_MODVERSIONS
-/* Generate the signature for all relevant module structures here.
- * If these change, we don't want to try to parse the module. */
-void module_layout(struct module *mod,
-		   struct modversion_info *ver,
-		   struct kernel_param *kp,
-		   struct kernel_symbol *ks,
-		   struct tracepoint * const *tp)
-{
-}
-EXPORT_SYMBOL(module_layout);
-#endif
diff --git a/scripts/Makefile b/scripts/Makefile
index 1d80897..675a266 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -40,7 +40,6 @@ build_docproc: $(obj)/docproc
 build_check-lc_ctype: $(obj)/check-lc_ctype
 	@:
 
-subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-y                     += mod
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 subdir-$(CONFIG_DTC)         += dtc
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 7675d11..5aa0fea 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -159,60 +159,12 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
 $(obj)/%.i: $(src)/%.c FORCE
 	$(call if_changed_dep,cpp_i_c)
 
-# These mirror gensymtypes_S and co below, keep them in synch.
-cmd_gensymtypes_c =                                                         \
-    $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
-    $(GENKSYMS) $(if $(1), -T $(2))                                         \
-     $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
-     $(if $(KBUILD_PRESERVE),-p)                                            \
-     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
-
-quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
-cmd_cc_symtypes_c =                                                         \
-    set -e;                                                                 \
-    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
-    test -s $@ || rm -f $@
-
-$(obj)/%.symtypes : $(src)/%.c FORCE
-	$(call cmd,cc_symtypes_c)
-
 # C (.c) files
 # The C file is compiled and updated dependency information is generated.
 # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
-
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
-
-ifndef CONFIG_MODVERSIONS
 cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
 
-else
-# When module versioning is enabled the following steps are executed:
-# o compile a .tmp_<file>.o from <file>.c
-# o if .tmp_<file>.o doesn't contain a __ksymtab version, i.e. does
-#   not export symbols, we just rename .tmp_<file>.o to <file>.o and
-#   are done.
-# o otherwise, we calculate symbol versions using the good old
-#   genksyms on the preprocessed source and postprocess them in a way
-#   that they are usable as a linker script
-# o generate <file>.o from .tmp_<file>.o using the linker to
-#   replace the unresolved symbols __crc_exported_symbol with
-#   the actual value of the checksum generated by genksyms
-
-cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
-
-cmd_modversions_c =								\
-	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
-		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
-		    > $(@D)/.tmp_$(@F:.o=.ver);					\
-										\
-		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 			\
-			-T $(@D)/.tmp_$(@F:.o=.ver);				\
-		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);		\
-	else									\
-		mv -f $(@D)/.tmp_$(@F) $@;					\
-	fi;
-endif
-
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
@@ -270,14 +222,12 @@ endif # CONFIG_STACK_VALIDATION
 define rule_cc_o_c
 	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
 	$(call cmd_and_fixdep,cc_o_c)					  \
-	$(cmd_modversions_c)						  \
 	$(cmd_objtool)						          \
 	$(call echo-cmd,record_mcount) $(cmd_record_mcount)
 endef
 
 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)					  \
-	$(cmd_modversions_S)						  \
 	$(cmd_objtool)
 endef
 
@@ -317,39 +267,6 @@ modkern_aflags := $(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL)
 $(real-objs-m)      : modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 $(real-objs-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 
-# .S file exports must have their C prototypes defined in asm/asm-prototypes.h
-# or a file that it includes, in order to get versioned symbols. We build a
-# dummy C file that includes asm-prototypes and the EXPORT_SYMBOL lines from
-# the .S file (with trailing ';'), and run genksyms on that, to extract vers.
-#
-# This is convoluted. The .S file must first be preprocessed to run guards and
-# expand names, then the resulting exports must be constructed into plain
-# EXPORT_SYMBOL(symbol); to build our dummy C file, and that gets preprocessed
-# to make the genksyms input.
-#
-# These mirror gensymtypes_c and co above, keep them in synch.
-cmd_gensymtypes_S =                                                         \
-    (echo "\#include <linux/kernel.h>" ;                                    \
-     echo "\#include <asm/asm-prototypes.h>" ;                              \
-    $(CPP) $(a_flags) $< |                                                  \
-     grep "\<___EXPORT_SYMBOL\>" |                                          \
-     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ) | \
-    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
-    $(GENKSYMS) $(if $(1), -T $(2))                                         \
-     $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
-     $(if $(KBUILD_PRESERVE),-p)                                            \
-     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
-
-quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
-cmd_cc_symtypes_S =                                                         \
-    set -e;                                                                 \
-    $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
-    test -s $@ || rm -f $@
-
-$(obj)/%.symtypes : $(src)/%.S FORCE
-	$(call cmd,cc_symtypes_S)
-
-
 quiet_cmd_cpp_s_S = CPP $(quiet_modtag) $@
 cmd_cpp_s_S       = $(CPP) $(a_flags) -o $@ $<
 
@@ -357,38 +274,8 @@ $(obj)/%.s: $(src)/%.S FORCE
 	$(call if_changed_dep,cpp_s_S)
 
 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
-
-ifndef CONFIG_MODVERSIONS
 cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
 
-else
-
-ASM_PROTOTYPES := $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h)
-
-ifeq ($(ASM_PROTOTYPES),)
-cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
-
-else
-
-# versioning matches the C process described above, with difference that
-# we parse asm-prototypes.h C header to get function definitions.
-
-cmd_as_o_S = $(CC) $(a_flags) -c -o $(@D)/.tmp_$(@F) $<
-
-cmd_modversions_S =								\
-	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
-		$(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
-		    > $(@D)/.tmp_$(@F:.o=.ver);					\
-										\
-		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 			\
-			-T $(@D)/.tmp_$(@F:.o=.ver);				\
-		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);		\
-	else									\
-		mv -f $(@D)/.tmp_$(@F) $@;					\
-	fi;
-endif
-endif
-
 $(obj)/%.o: $(src)/%.S $(objtool_obj) FORCE
 	$(call if_changed_rule,as_o_S)
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0a07f90..68018a6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -89,8 +89,7 @@ multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
 obj-dirs	:= $(addprefix $(obj)/,$(obj-dirs))
 
-# These flags are needed for modversions and compiling, so we define them here
-# already
+# These flags are needed for compiling, so we define them here already
 # $(modname_flags) #defines KBUILD_MODNAME as the name of the module it will
 # end up in (or would, if it gets compiled in)
 # Note: Files that end up in two or more modules are compiled without the
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 16923ba..eb3d3c6 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -1,5 +1,5 @@
 # ===========================================================================
-# Module versions
+# Module final link
 # ===========================================================================
 #
 # Stage one of module building created the following:
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 8dc1918..944c0bf 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -67,11 +67,6 @@ while read sym; do
 	echo "#define __KSYM_${sym} 1"
 done >> "$new_ksyms_file"
 
-# Special case for modversions (see modpost.c)
-if [ -n "$CONFIG_MODVERSIONS" ]; then
-	echo "#define __KSYM_module_layout 1" >> "$new_ksyms_file"
-fi
-
 # Extract changes between old and new list and touch corresponding
 # dependency files.
 changed=$(
diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index 8f79b70..255ef81 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -102,8 +102,6 @@ close($module_symvers);
 #
 # collect the usage count of each symbol.
 #
-my $modversion_warnings = 0;
-
 foreach my $thismod (@allcfiles) {
 	my $module;
 
@@ -112,30 +110,15 @@ foreach my $thismod (@allcfiles) {
 		next;
 	}
 
-	my $state=0;
 	while ( <$module> ) {
 		chomp;
-		if ($state == 0) {
-			$state = 1 if ($_ =~ /static const struct modversion_info/);
-			next;
-		}
-		if ($state == 1) {
-			$state = 2 if ($_ =~ /__attribute__\(\(section\("__versions"\)\)\)/);
+		if ( $_ !~ /0x[0-9a-f]+,/ ) {
 			next;
 		}
-		if ($state == 2) {
-			if ( $_ !~ /0x[0-9a-f]+,/ ) {
-				next;
-			}
-			my $sym = (split /([,"])/,)[4];
-			my ($module, $value, $symbol, $gpl) = @{$SYMBOL{$sym}};
-			$SYMBOL{ $sym } =  [ $module, $value+1, $symbol, $gpl];
-			push(@{$MODULE{$thismod}} , $sym);
-		}
-	}
-	if ($state != 2) {
-		warn "WARNING:$thismod is not built with CONFIG_MODVERSIONS enabled\n";
-		$modversion_warnings++;
+		my $sym = (split /([,"])/,)[4];
+		my ($module, $value, $symbol, $gpl) = @{$SYMBOL{$sym}};
+		$SYMBOL{ $sym } =  [ $module, $value+1, $symbol, $gpl];
+		push(@{$MODULE{$thismod}} , $sym);
 	}
 	close($module);
 }
@@ -169,9 +152,6 @@ printf("SECTION 2:\n\tThis section reports export-symbol-usage of in-kernel
 modules. Each module lists the modules, and the symbols from that module that
 it uses.  Each listed symbol reports the number of modules using it\n");
 
-print "\nNOTE: Got $modversion_warnings CONFIG_MODVERSIONS warnings\n\n"
-    if $modversion_warnings;
-
 print "~"x80 , "\n";
 for my $thismod (sort keys %MODULE) {
 	my $list = $MODULE{$thismod};
diff --git a/scripts/mksysmap b/scripts/mksysmap
index a35acc0..7226ade 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -37,8 +37,6 @@
 
 # readprofile starts reading symbols when _stext is found, and
 # continue until it finds a symbol which is not either of 'T', 't',
-# 'W' or 'w'. __crc_ are 'A' and placed in the middle
-# so we just ignore them to let readprofile continue to work.
-# (At least sparc64 has __crc_ in the middle).
+# 'W' or 'w'.
 
-$NM -n $1 | grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \$[adt]\)\|\( .L\)' > $2
+$NM -n $1 | grep -v '\( [aNUw] \)\|\( \$[adt]\)\|\( .L\)' > $2
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index bd83497..c929794 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -23,8 +23,6 @@
 #include "../../include/linux/license.h"
 #include "../../include/linux/export.h"
 
-/* Are we using CONFIG_MODVERSIONS? */
-static int modversions = 0;
 /* Warn about undefined symbols? (do so if we have vmlinux) */
 static int have_vmlinux = 0;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
@@ -159,13 +157,11 @@ static struct module *new_module(const char *modname)
 struct symbol {
 	struct symbol *next;
 	struct module *module;
-	unsigned int crc;
-	int crc_valid;
 	unsigned int weak:1;
 	unsigned int vmlinux:1;    /* 1 if symbol is defined in vmlinux */
 	unsigned int kernel:1;     /* 1 if symbol is from kernel
 				    *  (only for external modules) **/
-	unsigned int preloaded:1;  /* 1 if symbol from Module.symvers, or crc */
+	unsigned int preloaded:1;  /* 1 if symbol from Module.symvers */
 	enum export  export;       /* Type of export */
 	char name[0];
 };
@@ -328,20 +324,6 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	return s;
 }
 
-static void sym_update_crc(const char *name, struct module *mod,
-			   unsigned int crc, enum export export)
-{
-	struct symbol *s = find_symbol(name);
-
-	if (!s) {
-		s = new_symbol(name, mod, export);
-		/* Don't complain when we find it later. */
-		s->preloaded = 1;
-	}
-	s->crc = crc;
-	s->crc_valid = 1;
-}
-
 void *grab_file(const char *filename, unsigned long *size)
 {
 	struct stat st;
@@ -601,13 +583,11 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
 	return 0;
 }
 
-#define CRC_PFX     VMLINUX_SYMBOL_STR(__crc_)
 #define KSYMTAB_PFX VMLINUX_SYMBOL_STR(__ksymtab_)
 
 static void handle_modversions(struct module *mod, struct elf_info *info,
 			       Elf_Sym *sym, const char *symname)
 {
-	unsigned int crc;
 	enum export export;
 
 	if ((!is_vmlinux(mod->name) || mod->is_dot_o) &&
@@ -616,13 +596,6 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 	else
 		export = export_from_sec(info, get_secindex(info, sym));
 
-	/* CRC'd symbol */
-	if (strncmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
-		crc = (unsigned int) sym->st_value;
-		sym_update_crc(symname + strlen(CRC_PFX), mod, crc,
-				export);
-	}
-
 	switch (sym->st_shndx) {
 	case SHN_COMMON:
 		if (!strncmp(symname, "__gnu_lto_", sizeof("__gnu_lto_")-1)) {
@@ -1979,13 +1952,6 @@ static void read_symbols(char *modname)
 				sizeof(mod->srcversion)-1);
 
 	parse_elf_finish(&info);
-
-	/* Our trick to get versioning for module struct etc. - it's
-	 * never passed as an argument to an exported function, so
-	 * the automatic versioning doesn't pick it up, but it's really
-	 * important anyhow */
-	if (modversions)
-		mod->unres = alloc_symbol("module_layout", 0, mod->unres);
 }
 
 static void read_symbols_from_files(const char *filename)
@@ -2137,70 +2103,6 @@ static void add_staging_flag(struct buffer *b, const char *name)
 		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
 }
 
-/* In kernel, this size is defined in linux/module.h;
- * here we use Elf_Addr instead of long for covering cross-compile
- */
-#define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
-
-/**
- * Record CRCs for unresolved symbols
- **/
-static int add_versions(struct buffer *b, struct module *mod)
-{
-	struct symbol *s, *exp;
-	int err = 0;
-
-	for (s = mod->unres; s; s = s->next) {
-		exp = find_symbol(s->name);
-		if (!exp || exp->module == mod) {
-			if (have_vmlinux && !s->weak) {
-				if (warn_unresolved) {
-					warn("\"%s\" [%s.ko] undefined!\n",
-					     s->name, mod->name);
-				} else {
-					merror("\"%s\" [%s.ko] undefined!\n",
-					       s->name, mod->name);
-					err = 1;
-				}
-			}
-			continue;
-		}
-		s->module = exp->module;
-		s->crc_valid = exp->crc_valid;
-		s->crc = exp->crc;
-	}
-
-	if (!modversions)
-		return err;
-
-	buf_printf(b, "\n");
-	buf_printf(b, "static const struct modversion_info ____versions[]\n");
-	buf_printf(b, "__used\n");
-	buf_printf(b, "__attribute__((section(\"__versions\"))) = {\n");
-
-	for (s = mod->unres; s; s = s->next) {
-		if (!s->module)
-			continue;
-		if (!s->crc_valid) {
-			warn("\"%s\" [%s.ko] has no CRC!\n",
-				s->name, mod->name);
-			continue;
-		}
-		if (strlen(s->name) >= MODULE_NAME_LEN) {
-			merror("too long symbol \"%s\" [%s.ko]\n",
-			       s->name, mod->name);
-			err = 1;
-			break;
-		}
-		buf_printf(b, "\t{ %#8x, __VMLINUX_SYMBOL_STR(%s) },\n",
-			   s->crc, s->name);
-	}
-
-	buf_printf(b, "};\n");
-
-	return err;
-}
-
 static void add_depends(struct buffer *b, struct module *mod,
 			struct module *modules)
 {
@@ -2290,7 +2192,7 @@ static void write_if_changed(struct buffer *b, const char *fname)
 }
 
 /* parse Module.symvers file. line format:
- * 0x12345678<tab>symbol<tab>module[[<tab>export]<tab>something]
+ * symbol<tab>module[[<tab>export]<tab>something]
  **/
 static void read_dump(const char *fname, unsigned int kernel)
 {
@@ -2303,14 +2205,11 @@ static void read_dump(const char *fname, unsigned int kernel)
 		return;
 
 	while ((line = get_next_line(&pos, file, size))) {
-		char *symname, *modname, *d, *export, *end;
-		unsigned int crc;
+		char *symname, *modname, *export, *end;
 		struct module *mod;
 		struct symbol *s;
 
-		if (!(symname = strchr(line, '\t')))
-			goto fail;
-		*symname++ = '\0';
+		symname = line;
 		if (!(modname = strchr(symname, '\t')))
 			goto fail;
 		*modname++ = '\0';
@@ -2318,8 +2217,7 @@ static void read_dump(const char *fname, unsigned int kernel)
 			*export++ = '\0';
 		if (export && ((end = strchr(export, '\t')) != NULL))
 			*end = '\0';
-		crc = strtoul(line, &d, 16);
-		if (*symname == '\0' || *modname == '\0' || *d != '\0')
+		if (*symname == '\0' || *modname == '\0')
 			goto fail;
 		mod = find_module(modname);
 		if (!mod) {
@@ -2331,7 +2229,6 @@ static void read_dump(const char *fname, unsigned int kernel)
 		s = sym_add_exported(symname, mod, export_no(export));
 		s->kernel    = kernel;
 		s->preloaded = 1;
-		sym_update_crc(symname, mod, crc, export_no(export));
 	}
 	release_file(file, size);
 	return;
@@ -2363,9 +2260,8 @@ static void write_dump(const char *fname)
 		symbol = symbolhash[n];
 		while (symbol) {
 			if (dump_sym(symbol))
-				buf_printf(&buf, "0x%08x\t%s\t%s\t%s\n",
-					symbol->crc, symbol->name,
-					symbol->module->name,
+				buf_printf(&buf, "%s\t%s\t%s\n",
+					symbol->name, symbol->module->name,
 					export_str(symbol->export));
 			symbol = symbol->next;
 		}
@@ -2406,9 +2302,6 @@ int main(int argc, char **argv)
 			extsym_iter->file = optarg;
 			extsym_start = extsym_iter;
 			break;
-		case 'm':
-			modversions = 1;
-			break;
 		case 'n':
 			ignore_missing_files = 1;
 			break;
@@ -2474,7 +2367,6 @@ int main(int argc, char **argv)
 		add_header(&buf, mod);
 		add_intree_flag(&buf, !external_module);
 		add_staging_flag(&buf, mod->name);
-		err |= add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
 		add_moddevtable(&buf, mod);
 		add_srcversion(&buf, mod);
diff --git a/scripts/module-common.lds b/scripts/module-common.lds
index 73a2c7d..da76f519a 100644
--- a/scripts/module-common.lds
+++ b/scripts/module-common.lds
@@ -11,11 +11,6 @@ SECTIONS {
 	__ksymtab_unused	0 : { *(SORT(___ksymtab_unused+*)) }
 	__ksymtab_unused_gpl	0 : { *(SORT(___ksymtab_unused_gpl+*)) }
 	__ksymtab_gpl_future	0 : { *(SORT(___ksymtab_gpl_future+*)) }
-	__kcrctab		0 : { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		0 : { *(SORT(___kcrctab_gpl+*)) }
-	__kcrctab_unused	0 : { *(SORT(___kcrctab_unused+*)) }
-	__kcrctab_unused_gpl	0 : { *(SORT(___kcrctab_unused_gpl+*)) }
-	__kcrctab_gpl_future	0 : { *(SORT(___kcrctab_gpl_future+*)) }
 
 	. = ALIGN(8);
 	.init_array		0 : { *(SORT(.init_array.*)) *(.init_array) }
diff --git a/scripts/namespace.pl b/scripts/namespace.pl
index 9f3c9d4..e76f858 100755
--- a/scripts/namespace.pl
+++ b/scripts/namespace.pl
@@ -306,14 +306,12 @@ sub do_nm
 				$name !~ /^__parm_/ &&
 				$name !~ /^__kstrtab/ &&
 				$name !~ /^__ksymtab/ &&
-				$name !~ /^__kcrctab_/ &&
 				$name !~ /^__exitcall_/ &&
 				$name !~ /^__initcall_/ &&
 				$name !~ /^__kdb_initcall_/ &&
 				$name !~ /^__kdb_exitcall_/ &&
 				$name !~ /^__module_/ &&
 				$name !~ /^__mod_/ &&
-				$name !~ /^__crc_/ &&
 				$name ne '__this_module' &&
 				$name ne 'kernel_version') {
 				if (!exists($def{$name})) {
-- 
2.10.2
