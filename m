From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Make most arch asm/module.h files use asm-generic/module.h [ver #2]
Date: Wed, 18 Jul 2012 15:50:53 +0100
Message-ID: <20105.1342623053@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22186 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab2GROvQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jul 2012 10:51:16 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Sam Ravnborg <sam@ravnborg.org>


Here's an updated version of the patch.

I've made the REL/RELA selection choices work so that you select the one(s)
you want to compile in and not the one(s) you don't.  So m68k and mips, for
example, turn both on.

Not turning one on converts the external ref to that particular
apply_relocate*() in linux/moduleloader.h into an inline function that gives
an error message.

The weak functions apply_relocate*() functions in kernel/module.c no longer
exist.

I've removed the unsupported relocation type stubs from those arches that had
them as they ought to be superfluous.

I've been through all the arch module loaders and selected the appropriate REL
or RELA config items, depending on which apply_relocate*() functions they
have.

I've moved the new config options to arch/Kconfig.

The patch can be found here also:

	http://git.kernel.org/?p=linux/kernel/git/dhowells/linux-modsign.git;a=shortlog;h=refs/heads/for-rusty

David
---
commit b64582d2ab63dabc1b2bf05143900c8b2ff4b4ee
Author: David Howells <dhowells@redhat.com>
Date:   Wed Jul 18 15:41:38 2012 +0100

    Make most arch asm/module.h files use asm-generic/module.h
    
    Use the mapping of Elf_[SPE]hdr, Elf_Addr, Elf_Sym, Elf_Dyn, Elf_Rel/Rela,
    ELF_R_TYPE() and ELF_R_SYM() to either the 32-bit version or the 64-bit version
    into asm-generic/module.h for all arches bar MIPS.
    
    Also, use the generic definition mod_arch_specific where possible.
    
    To this end, I've defined three new config bools:
    
     (*) HAVE_MOD_ARCH_SPECIFIC
    
         Arches define this if they don't want to use the empty generic
         mod_arch_specific struct.
    
     (*) MODULES_USE_ELF_RELA
    
         Arches define this if their modules can contain RELA records.  This causes
         the Elf_Rela mapping to be emitted and allows apply_relocate_add() to be
         defined by the arch rather than have the core emit an error message.
    
     (*) MODULES_USE_ELF_REL
    
         Arches define this if their modules can contain REL records.  This causes
         the Elf_Rel mapping to be emitted and allows apply_relocate() to be
         defined by the arch rather than have the core emit an error message.
    
    Note that it is possible to allow both REL and RELA records: m68k and mips are
    two arches that do this.
    
    With this, some arch asm/module.h files can be deleted entirely and replaced
    with a generic-y marker in the arch Kbuild file.
    
    Additionally, I have removed the bits from m32r and score that handle the
    unsupported type of relocation record as that's now handled centrally.
    
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/arch/Kconfig b/arch/Kconfig
index 8c3d957..51acb02 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -274,4 +274,23 @@ config SECCOMP_FILTER
 
 	  See Documentation/prctl/seccomp_filter.txt for details.
 
+config HAVE_MOD_ARCH_SPECIFIC
+	bool
+	help
+	  The arch uses struct mod_arch_specific to store data.  Many arches
+	  just need a simple module loader without arch specific data - those
+	  should not enable this.
+
+config MODULES_USE_ELF_RELA
+	bool
+	help
+	  Modules only use ELF RELA relocations.  Modules with ELF REL
+	  relocations will give an error.
+
+config MODULES_USE_ELF_REL
+	bool
+	help
+	  Modules only use ELF REL relocations.  Modules with ELF RELA
+	  relocations will give an error.
+
 source "kernel/gcov/Kconfig"
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 3de74c9..6f580de 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -17,6 +17,8 @@ config ALPHA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CMOS_UPDATE
+	select HAVE_MOD_ARCH_SPECIFIC
+	select MODULES_USE_ELF_RELA
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/alpha/include/asm/module.h b/arch/alpha/include/asm/module.h
index 7b63743..9cd13b5 100644
--- a/arch/alpha/include/asm/module.h
+++ b/arch/alpha/include/asm/module.h
@@ -1,19 +1,13 @@
 #ifndef _ALPHA_MODULE_H
 #define _ALPHA_MODULE_H
 
+#include <asm-generic/module.h>
+
 struct mod_arch_specific
 {
 	unsigned int gotsecindex;
 };
 
-#define Elf_Sym Elf64_Sym
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Ehdr Elf64_Ehdr
-#define Elf_Phdr Elf64_Phdr
-#define Elf_Dyn Elf64_Dyn
-#define Elf_Rel Elf64_Rel
-#define Elf_Rela Elf64_Rela
-
 #define ARCH_SHF_SMALL SHF_ALPHA_GPREL
 
 #ifdef MODULE
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..af8bf36 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -45,6 +45,8 @@ config ARM
 	select GENERIC_SMP_IDLE_THREAD
 	select KTIME_SCALAR
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND
+	select MODULES_USE_ELF_REL
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 6c6809f..0d3a28d 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -1,9 +1,7 @@
 #ifndef _ASM_ARM_MODULE_H
 #define _ASM_ARM_MODULE_H
 
-#define Elf_Shdr	Elf32_Shdr
-#define Elf_Sym		Elf32_Sym
-#define Elf_Ehdr	Elf32_Ehdr
+#include <asm-generic/module.h>
 
 struct unwind_table;
 
@@ -16,13 +14,11 @@ enum {
 	ARM_SEC_DEVEXIT,
 	ARM_SEC_MAX,
 };
-#endif
 
 struct mod_arch_specific {
-#ifdef CONFIG_ARM_UNWIND
 	struct unwind_table *unwind[ARM_SEC_MAX];
-#endif
 };
+#endif
 
 /*
  * Add the ARM architecture version to the version magic string
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index 71d38c7..2779913 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -14,6 +14,8 @@ config AVR32
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_CLOCKEVENTS
+	select HAVE_MOD_ARCH_SPECIFIC
+	select MODULES_USE_ELF_RELA
 	help
 	  AVR32 is a high-performance 32-bit RISC microprocessor core,
 	  designed for cost-sensitive embedded applications, with particular
diff --git a/arch/avr32/include/asm/module.h b/arch/avr32/include/asm/module.h
index 4514445..3f083d3 100644
--- a/arch/avr32/include/asm/module.h
+++ b/arch/avr32/include/asm/module.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_AVR32_MODULE_H
 #define __ASM_AVR32_MODULE_H
 
+#include <asm-generic/module.h>
+
 struct mod_arch_syminfo {
 	unsigned long got_offset;
 	int got_initialized;
@@ -17,10 +19,6 @@ struct mod_arch_specific {
 	struct mod_arch_syminfo *syminfo;
 };
 
-#define Elf_Shdr		Elf32_Shdr
-#define Elf_Sym			Elf32_Sym
-#define Elf_Ehdr		Elf32_Ehdr
-
 #define MODULE_PROC_FAMILY "AVR32v1"
 
 #define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index fef96f4..b8a7bc9 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -40,6 +40,8 @@ config BLACKFIN
 	select HAVE_NMI_WATCHDOG if NMI_WATCHDOG
 	select GENERIC_SMP_IDLE_THREAD
 	select ARCH_USES_GETTIMEOFFSET if !GENERIC_CLOCKEVENTS
+	select HAVE_MOD_ARCH_SPECIFIC
+	select MODULES_USE_ELF_RELA
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/blackfin/include/asm/module.h b/arch/blackfin/include/asm/module.h
index ed5689b..231a149 100644
--- a/arch/blackfin/include/asm/module.h
+++ b/arch/blackfin/include/asm/module.h
@@ -7,9 +7,7 @@
 #ifndef _ASM_BFIN_MODULE_H
 #define _ASM_BFIN_MODULE_H
 
-#define Elf_Shdr        Elf32_Shdr
-#define Elf_Sym         Elf32_Sym
-#define Elf_Ehdr        Elf32_Ehdr
+#include <asm-generic/module.h>
 
 struct mod_arch_specific {
 	Elf_Shdr	*text_l1;
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 052f81a..8f3a304 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -16,6 +16,7 @@ config C6X
 	select OF
 	select OF_EARLY_FLATTREE
 	select GENERIC_CLOCKEVENTS
+	select MODULES_USE_ELF_RELA
 
 config MMU
 	def_bool n
diff --git a/arch/c6x/include/asm/module.h b/arch/c6x/include/asm/module.h
index a453f97..5c7269c 100644
--- a/arch/c6x/include/asm/module.h
+++ b/arch/c6x/include/asm/module.h
@@ -13,17 +13,7 @@
 #ifndef _ASM_C6X_MODULE_H
 #define _ASM_C6X_MODULE_H
 
-#define Elf_Shdr	Elf32_Shdr
-#define Elf_Sym		Elf32_Sym
-#define Elf_Ehdr	Elf32_Ehdr
-#define Elf_Addr	Elf32_Addr
-#define Elf_Word	Elf32_Word
-
-/*
- * This file contains the C6x architecture specific module code.
- */
-struct mod_arch_specific {
-};
+#include <asm-generic/module.h>
 
 struct loaded_sections {
 	unsigned int new_vaddr;
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index bb34465..45782c7 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -46,6 +46,7 @@ config CRIS
 	select GENERIC_IOMAP
 	select GENERIC_SMP_IDLE_THREAD if ETRAX_ARCH_V32
 	select GENERIC_CMOS_UPDATE
+	select MODULES_USE_ELF_RELA
 
 config HZ
 	int
diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index 04d02a5..28b690d 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -7,3 +7,5 @@ header-y += ethernet.h
 header-y += etraxgpio.h
 header-y += rs485.h
 header-y += sync_serial.h
+
+generic-y += module.h
diff --git a/arch/cris/include/asm/module.h b/arch/cris/include/asm/module.h
deleted file mode 100644
index 7ee7231..0000000
--- a/arch/cris/include/asm/module.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef _ASM_CRIS_MODULE_H
-#define _ASM_CRIS_MODULE_H
-/* cris is simple */
-struct mod_arch_specific { };
-
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-#endif /* _ASM_CRIS_MODULE_H */
diff --git a/arch/frv/include/asm/module.h b/arch/frv/include/asm/module.h
index 3d5c636..a8848f0 100644
--- a/arch/frv/include/asm/module.h
+++ b/arch/frv/include/asm/module.h
@@ -11,13 +11,7 @@
 #ifndef _ASM_MODULE_H
 #define _ASM_MODULE_H
 
-struct mod_arch_specific
-{
-};
-
-#define Elf_Shdr	Elf32_Shdr
-#define Elf_Sym		Elf32_Sym
-#define Elf_Ehdr	Elf32_Ehdr
+#include <asm-generic/module.h>
 
 /*
  * Include the architecture version.
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 56e890d..9eaefdd 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -5,6 +5,7 @@ config H8300
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
+	select MODULES_USE_ELF_RELA
 
 config SYMBOL_PREFIX
 	string
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index c68e168..871382d 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -1 +1,3 @@
 include include/asm-generic/Kbuild.asm
+
+generic-y	+= module.h
diff --git a/arch/h8300/include/asm/module.h b/arch/h8300/include/asm/module.h
deleted file mode 100644
index 8e46724..0000000
--- a/arch/h8300/include/asm/module.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef _ASM_H8300_MODULE_H
-#define _ASM_H8300_MODULE_H
-/*
- * This file contains the H8/300 architecture specific module code.
- */
-struct mod_arch_specific { };
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-
-#endif /* _ASM_H8/300_MODULE_H */
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index b2fdfb7..0744f7d 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -30,6 +30,7 @@ config HEXAGON
 	select KTIME_SCALAR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
+	select MODULES_USE_ELF_RELA
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 8186ec5..6f1b7b1 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -39,6 +39,8 @@ config IA64
 	select ARCH_THREAD_INFO_ALLOCATOR
 	select ARCH_CLOCKSOURCE_DATA
 	select GENERIC_TIME_VSYSCALL
+	select HAVE_MOD_ARCH_SPECIFIC
+	select MODULES_USE_ELF_RELA
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/ia64/include/asm/module.h b/arch/ia64/include/asm/module.h
index 908eaef..dfba22a 100644
--- a/arch/ia64/include/asm/module.h
+++ b/arch/ia64/include/asm/module.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_IA64_MODULE_H
 #define _ASM_IA64_MODULE_H
 
+#include <asm-generic/module.h>
+
 /*
  * IA-64-specific support for kernel module loader.
  *
@@ -29,10 +31,6 @@ struct mod_arch_specific {
 	unsigned int next_got_entry;	/* index of next available got entry */
 };
 
-#define Elf_Shdr	Elf64_Shdr
-#define Elf_Sym		Elf64_Sym
-#define Elf_Ehdr	Elf64_Ehdr
-
 #define MODULE_PROC_FAMILY	"ia64"
 #define MODULE_ARCH_VERMAGIC	MODULE_PROC_FAMILY \
 	"gcc-" __stringify(__GNUC__) "." __stringify(__GNUC_MINOR__)
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index b638d5b..a30478e 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -12,6 +12,7 @@ config M32R
 	select GENERIC_IRQ_SHOW
 	select GENERIC_ATOMIC64
 	select ARCH_USES_GETTIMEOFFSET
+	select MODULES_USE_ELF_RELA
 
 config SBUS
 	bool
diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index c68e168..871382d 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -1 +1,3 @@
 include include/asm-generic/Kbuild.asm
+
+generic-y	+= module.h
diff --git a/arch/m32r/include/asm/module.h b/arch/m32r/include/asm/module.h
deleted file mode 100644
index eb73ee0..0000000
--- a/arch/m32r/include/asm/module.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef _ASM_M32R_MODULE_H
-#define _ASM_M32R_MODULE_H
-
-struct mod_arch_specific { };
-
-#define Elf_Shdr	Elf32_Shdr
-#define Elf_Sym		Elf32_Sym
-#define Elf_Ehdr	Elf32_Ehdr
-
-#endif /* _ASM_M32R_MODULE_H */
diff --git a/arch/m32r/kernel/module.c b/arch/m32r/kernel/module.c
index 3071fe8..38233b6 100644
--- a/arch/m32r/kernel/module.c
+++ b/arch/m32r/kernel/module.c
@@ -201,18 +201,3 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 	}
 	return 0;
 }
-
-int apply_relocate(Elf32_Shdr *sechdrs,
-		       const char *strtab,
-		       unsigned int symindex,
-		       unsigned int relsec,
-		       struct module *me)
-{
-#if 0
-	printk(KERN_ERR "module %s: REL RELOCATION unsupported\n",
-	       me->name);
-	return -ENOEXEC;
-#endif
-	return 0;
-
-}
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 1471201..3694301 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -11,6 +11,9 @@ config M68K
 	select GENERIC_STRNLEN_USER if MMU
 	select FPU if MMU
 	select ARCH_USES_GETTIMEOFFSET if MMU && !COLDFIRE
+	select HAVE_MOD_ARCH_SPECIFIC
+	select MODULES_USE_ELF_REL
+	select MODULES_USE_ELF_RELA
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
diff --git a/arch/m68k/include/asm/module.h b/arch/m68k/include/asm/module.h
index edffe66..8b58fce 100644
--- a/arch/m68k/include/asm/module.h
+++ b/arch/m68k/include/asm/module.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_M68K_MODULE_H
 #define _ASM_M68K_MODULE_H
 
+#include <asm-generic/module.h>
+
 enum m68k_fixup_type {
 	m68k_fixup_memoffset,
 	m68k_fixup_vnode_shift,
@@ -36,8 +38,4 @@ struct module;
 extern void module_fixup(struct module *mod, struct m68k_fixup_info *start,
 			 struct m68k_fixup_info *end);
 
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-
 #endif /* _ASM_M68K_MODULE_H */
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 0bf4423..ee395d3 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -23,6 +23,7 @@ config MICROBLAZE
 	select GENERIC_CPU_DEVICES
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
+	select MODULES_USE_ELF_RELA
 
 config SWAP
 	def_bool n
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 09ab87e..2901b41 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -34,6 +34,9 @@ config MIPS
 	select BUILDTIME_EXTABLE_SORT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
+	select HAVE_MOD_ARCH_SPECIFIC
+	select MODULES_USE_ELF_REL
+	select MODULES_USE_ELF_RELA if 64BIT
 
 menu "Machine selection"
 
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index 5300080..2c6a4f21 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -34,11 +34,14 @@ typedef struct {
 } Elf64_Mips_Rela;
 
 #ifdef CONFIG_32BIT
-
 #define Elf_Shdr	Elf32_Shdr
 #define Elf_Sym		Elf32_Sym
 #define Elf_Ehdr	Elf32_Ehdr
 #define Elf_Addr	Elf32_Addr
+#define Elf_Rel		Elf32_Rel
+#define Elf_Rela	Elf32_Rela
+#define ELF_R_TYPE(X)	ELF32_R_TYPE(X)
+#define ELF_R_SYM(X)	ELF32_R_SYM(X)
 
 #define Elf_Mips_Rel	Elf32_Rel
 #define Elf_Mips_Rela	Elf32_Rela
@@ -49,11 +52,14 @@ typedef struct {
 #endif
 
 #ifdef CONFIG_64BIT
-
 #define Elf_Shdr	Elf64_Shdr
 #define Elf_Sym		Elf64_Sym
 #define Elf_Ehdr	Elf64_Ehdr
 #define Elf_Addr	Elf64_Addr
+#define Elf_Rel		Elf64_Rel
+#define Elf_Rela	Elf64_Rela
+#define ELF_R_TYPE(X)	ELF64_R_TYPE(X)
+#define ELF_R_SYM(X)	ELF64_R_SYM(X)
 
 #define Elf_Mips_Rel	Elf64_Mips_Rel
 #define Elf_Mips_Rela	Elf64_Mips_Rela
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index a5066b1..1500c80 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -299,6 +299,7 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
+#ifdef CONFIG_MODULES_USE_ELF_RELA
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		       unsigned int symindex, unsigned int relsec,
 		       struct module *me)
@@ -338,6 +339,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 
 	return 0;
 }
+#endif
 
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_dbetables(unsigned long addr)
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index 687f9b4..f8fec1c 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -7,6 +7,7 @@ config MN10300
 	select HAVE_ARCH_KGDB
 	select HAVE_NMI_WATCHDOG if MN10300_WD_TIMER
 	select GENERIC_CLOCKEVENTS
+	select MODULES_USE_ELF_RELA
 
 config AM33_2
 	def_bool n
diff --git a/arch/mn10300/include/asm/module.h b/arch/mn10300/include/asm/module.h
index 5d7057d..6571103 100644
--- a/arch/mn10300/include/asm/module.h
+++ b/arch/mn10300/include/asm/module.h
@@ -12,12 +12,7 @@
 #ifndef _ASM_MODULE_H
 #define _ASM_MODULE_H
 
-struct mod_arch_specific {
-};
-
-#define Elf_Shdr	Elf32_Shdr
-#define Elf_Sym		Elf32_Sym
-#define Elf_Ehdr	Elf32_Ehdr
+#include <asm-generic/module.h>
 
 /*
  * Include the MN10300 architecture version.
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 49765b5..05f2ba4 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -21,6 +21,7 @@ config OPENRISC
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select MODULES_USE_ELF_RELA
 
 config MMU
 	def_bool y
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 3ff21b5..166d991 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -19,6 +19,8 @@ config PARISC
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
+	select HAVE_MOD_ARCH_SPECIFIC
+	select MODULES_USE_ELF_RELA
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
diff --git a/arch/parisc/include/asm/module.h b/arch/parisc/include/asm/module.h
index 1f41234..bab37e9 100644
--- a/arch/parisc/include/asm/module.h
+++ b/arch/parisc/include/asm/module.h
@@ -1,21 +1,11 @@
 #ifndef _ASM_PARISC_MODULE_H
 #define _ASM_PARISC_MODULE_H
+
+#include <asm-generic/module.h>
+
 /*
  * This file contains the parisc architecture specific module code.
  */
-#ifdef CONFIG_64BIT
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Sym Elf64_Sym
-#define Elf_Ehdr Elf64_Ehdr
-#define Elf_Addr Elf64_Addr
-#define Elf_Rela Elf64_Rela
-#else
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-#define Elf_Addr Elf32_Addr
-#define Elf_Rela Elf32_Rela
-#endif
 
 struct unwind_table;
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 050cb37..17d3267 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -137,6 +137,8 @@ config PPC
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select HAVE_MOD_ARCH_SPECIFIC
+	select MODULES_USE_ELF_RELA
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index 0192a4e..c1df590 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -11,6 +11,7 @@
 
 #include <linux/list.h>
 #include <asm/bug.h>
+#include <asm-generic/module.h>
 
 
 #ifndef __powerpc64__
@@ -60,16 +61,10 @@ struct mod_arch_specific {
  */
 
 #ifdef __powerpc64__
-#    define Elf_Shdr	Elf64_Shdr
-#    define Elf_Sym	Elf64_Sym
-#    define Elf_Ehdr	Elf64_Ehdr
 #    ifdef MODULE
 	asm(".section .stubs,\"ax\",@nobits; .align 3; .previous");
 #    endif
 #else
-#    define Elf_Shdr	Elf32_Shdr
-#    define Elf_Sym	Elf32_Sym
-#    define Elf_Ehdr	Elf32_Ehdr
 #    ifdef MODULE
 	asm(".section .plt,\"ax\",@nobits; .align 3; .previous");
 	asm(".section .init.plt,\"ax\",@nobits; .align 3; .previous");
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a39b469..7c16d31 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -121,6 +121,8 @@ config S390
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_CLOCKEVENTS
 	select KTIME_SCALAR if 32BIT
+	select HAVE_MOD_ARCH_SPECIFIC
+	select MODULES_USE_ELF_RELA
 
 config SCHED_OMIT_FRAME_POINTER
 	def_bool y
diff --git a/arch/s390/include/asm/module.h b/arch/s390/include/asm/module.h
index f0b6b26..df1f861 100644
--- a/arch/s390/include/asm/module.h
+++ b/arch/s390/include/asm/module.h
@@ -1,5 +1,8 @@
 #ifndef _ASM_S390_MODULE_H
 #define _ASM_S390_MODULE_H
+
+#include <asm-generic/module.h>
+
 /*
  * This file contains the s390 architecture specific module code.
  */
@@ -28,19 +31,4 @@ struct mod_arch_specific
 	struct mod_arch_syminfo *syminfo;
 };
 
-#ifdef CONFIG_64BIT
-#define ElfW(x) Elf64_ ## x
-#define ELFW(x) ELF64_ ## x
-#else
-#define ElfW(x) Elf32_ ## x
-#define ELFW(x) ELF32_ ## x
-#endif
-
-#define Elf_Addr ElfW(Addr)
-#define Elf_Rela ElfW(Rela)
-#define Elf_Shdr ElfW(Shdr)
-#define Elf_Sym ElfW(Sym)
-#define Elf_Ehdr ElfW(Ehdr)
-#define ELF_R_SYM ELFW(R_SYM)
-#define ELF_R_TYPE ELFW(R_TYPE)
 #endif /* _ASM_S390_MODULE_H */
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index ba0f412..e2c8db4 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -10,6 +10,8 @@ config SCORE
        select ARCH_DISCARD_MEMBLOCK
        select GENERIC_CPU_DEVICES
        select GENERIC_CLOCKEVENTS
+       select HAVE_MOD_ARCH_SPECIFIC
+	select MODULES_USE_ELF_REL
 
 choice
 	prompt "System type"
diff --git a/arch/score/include/asm/module.h b/arch/score/include/asm/module.h
index f0b5dc0..abf395b 100644
--- a/arch/score/include/asm/module.h
+++ b/arch/score/include/asm/module.h
@@ -3,6 +3,7 @@
 
 #include <linux/list.h>
 #include <asm/uaccess.h>
+#include <asm-generic/module.h>
 
 struct mod_arch_specific {
 	/* Data Bus Error exception tables */
@@ -13,11 +14,6 @@ struct mod_arch_specific {
 
 typedef uint8_t Elf64_Byte;		/* Type for a 8-bit quantity. */
 
-#define Elf_Shdr	Elf32_Shdr
-#define Elf_Sym		Elf32_Sym
-#define Elf_Ehdr	Elf32_Ehdr
-#define Elf_Addr	Elf32_Addr
-
 /* Given an address, look for it in the exception tables. */
 #ifdef CONFIG_MODULES
 const struct exception_table_entry *search_module_dbetables(unsigned long addr);
diff --git a/arch/score/kernel/module.c b/arch/score/kernel/module.c
index 469e3b6..1378d99 100644
--- a/arch/score/kernel/module.c
+++ b/arch/score/kernel/module.c
@@ -125,16 +125,6 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-		unsigned int symindex, unsigned int relsec,
-		struct module *me)
-{
-	/* Non-standard return value... most other arch's return -ENOEXEC
-	 * for an unsupported relocation variant
-	 */
-	return 0;
-}
-
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_dbetables(unsigned long addr)
 {
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 31d9db7..22c02bb 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -34,6 +34,8 @@ config SUPERH
 	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select HAVE_MOD_ARCH_SPECIFIC if DWARF_UNWINDER
+	select MODULES_USE_ELF_RELA
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sh/include/asm/module.h b/arch/sh/include/asm/module.h
index b7927de..81300d8b 100644
--- a/arch/sh/include/asm/module.h
+++ b/arch/sh/include/asm/module.h
@@ -1,21 +1,13 @@
 #ifndef _ASM_SH_MODULE_H
 #define _ASM_SH_MODULE_H
 
-struct mod_arch_specific {
+#include <asm-generic/module.h>
+
 #ifdef CONFIG_DWARF_UNWINDER
+struct mod_arch_specific {
 	struct list_head fde_list;
 	struct list_head cie_list;
-#endif
 };
-
-#ifdef CONFIG_64BIT
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Sym Elf64_Sym
-#define Elf_Ehdr Elf64_Ehdr
-#else
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
 #endif
 
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e74ff13..acf5577 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -36,6 +36,7 @@ config SPARC
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select MODULES_USE_ELF_RELA
 
 config SPARC32
 	def_bool !64BIT
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 67f83e0..fbe1cb5 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -21,4 +21,5 @@ generic-y += div64.h
 generic-y += local64.h
 generic-y += irq_regs.h
 generic-y += local.h
+generic-y += module.h
 generic-y += word-at-a-time.h
diff --git a/arch/sparc/include/asm/module.h b/arch/sparc/include/asm/module.h
deleted file mode 100644
index ff8e02d..0000000
--- a/arch/sparc/include/asm/module.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifndef __SPARC_MODULE_H
-#define __SPARC_MODULE_H
-struct mod_arch_specific { };
-
-/*
- * Use some preprocessor magic to define the correct symbol
- * for sparc32 and sparc64.
- * Elf_Addr becomes Elf32_Addr for sparc32 and Elf64_Addr for sparc64
- */
-#define ___ELF(a, b, c) a##b##c
-#define __ELF(a, b, c)  ___ELF(a, b, c)
-#define  _Elf(t)        __ELF(Elf, CONFIG_BITS, t)
-#define  _ELF(t)        __ELF(ELF, CONFIG_BITS, t)
-
-#define Elf_Shdr     _Elf(_Shdr)
-#define Elf_Sym      _Elf(_Sym)
-#define Elf_Ehdr     _Elf(_Ehdr)
-#define Elf_Rela     _Elf(_Rela)
-#define Elf_Addr     _Elf(_Addr)
-
-#define ELF_R_SYM    _ELF(_R_SYM)
-#define ELF_R_TYPE   _ELF(_R_TYPE)
-
-#endif /* __SPARC_MODULE_H */
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index fe12881..2d8bc27 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -15,6 +15,7 @@ config TILE
 	select SYS_HYPERVISOR
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_CLOCKEVENTS
+	select MODULES_USE_ELF_RELA
 
 # FIXME: investigate whether we need/want these options.
 #	select HAVE_IOREMAP_PROT
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 03c9ff8..942b553 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -14,6 +14,7 @@ config UNICORE32
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IOMAP
+	select MODULES_USE_ELF_REL
 	help
 	  UniCore-32 is 32-bit Instruction Set Architecture,
 	  including a series of low-power-consumption RISC chip
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c70684f..c38a60e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -95,6 +95,8 @@ config X86
 	select KTIME_SCALAR if X86_32
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select MODULES_USE_ELF_REL if X86_32
+	select MODULES_USE_ELF_RELA if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool (KPROBES || PERF_EVENTS || UPROBES)
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 8a3f835..516210a 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -10,6 +10,7 @@ config XTENSA
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
+	select MODULES_USE_ELF_RELA
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
 	  primarily for embedded systems.  These processors are both
diff --git a/arch/xtensa/include/asm/module.h b/arch/xtensa/include/asm/module.h
index d9b34be..488b40c 100644
--- a/arch/xtensa/include/asm/module.h
+++ b/arch/xtensa/include/asm/module.h
@@ -13,15 +13,8 @@
 #ifndef _XTENSA_MODULE_H
 #define _XTENSA_MODULE_H
 
-struct mod_arch_specific
-{
-	/* No special elements, yet. */
-};
-
 #define MODULE_ARCH_VERMAGIC "xtensa-" __stringify(XCHAL_CORE_ID) " "
 
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
+#include <asm-generic/module.h>
 
 #endif	/* _XTENSA_MODULE_H */
diff --git a/include/asm-generic/module.h b/include/asm-generic/module.h
index ed5b44d..14dc41d 100644
--- a/include/asm-generic/module.h
+++ b/include/asm-generic/module.h
@@ -5,18 +5,44 @@
  * Many architectures just need a simple module
  * loader without arch specific data.
  */
+#ifndef CONFIG_HAVE_MOD_ARCH_SPECIFIC
 struct mod_arch_specific
 {
 };
+#endif
 
 #ifdef CONFIG_64BIT
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Sym Elf64_Sym
-#define Elf_Ehdr Elf64_Ehdr
-#else
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
+#define Elf_Shdr	Elf64_Shdr
+#define Elf_Phdr	Elf64_Phdr
+#define Elf_Sym		Elf64_Sym
+#define Elf_Dyn		Elf64_Dyn
+#define Elf_Ehdr	Elf64_Ehdr
+#define Elf_Addr	Elf64_Addr
+#ifdef CONFIG_MODULES_USE_ELF_REL
+#define Elf_Rel		Elf64_Rel
+#endif
+#ifdef CONFIG_MODULES_USE_ELF_RELA
+#define Elf_Rela	Elf64_Rela
+#endif
+#define ELF_R_TYPE(X)	ELF64_R_TYPE(X)
+#define ELF_R_SYM(X)	ELF64_R_SYM(X)
+
+#else /* CONFIG_64BIT */
+
+#define Elf_Shdr	Elf32_Shdr
+#define Elf_Phdr	Elf32_Phdr
+#define Elf_Sym		Elf32_Sym
+#define Elf_Dyn		Elf32_Dyn
+#define Elf_Ehdr	Elf32_Ehdr
+#define Elf_Addr	Elf32_Addr
+#ifdef CONFIG_MODULES_USE_ELF_REL
+#define Elf_Rel		Elf32_Rel
+#endif
+#ifdef CONFIG_MODULES_USE_ELF_RELA
+#define Elf_Rela	Elf32_Rela
+#endif
+#define ELF_R_TYPE(X)	ELF32_R_TYPE(X)
+#define ELF_R_SYM(X)	ELF32_R_SYM(X)
 #endif
 
 #endif /* __ASM_GENERIC_MODULE_H */
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index b2be02e..b85dda8 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -28,21 +28,49 @@ void *module_alloc(unsigned long size);
 /* Free memory returned from module_alloc. */
 void module_free(struct module *mod, void *module_region);
 
-/* Apply the given relocation to the (simplified) ELF.  Return -error
-   or 0. */
+/*
+ * Apply the given relocation to the (simplified) ELF.  Return -error
+ * or 0.
+ */
+#ifdef CONFIG_MODULES_USE_ELF_REL
 int apply_relocate(Elf_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
 		   unsigned int relsec,
 		   struct module *mod);
+#else
+static inline int apply_relocate(Elf_Shdr *sechdrs,
+				 const char *strtab,
+				 unsigned int symindex,
+				 unsigned int relsec,
+				 struct module *me)
+{
+	pr_err("module %s: REL relocation unsupported\n", me->name);
+	return -ENOEXEC;
+}
+#endif
 
-/* Apply the given add relocation to the (simplified) ELF.  Return
-   -error or 0 */
+/*
+ * Apply the given add relocation to the (simplified) ELF.  Return
+ * -error or 0
+ */
+#ifdef CONFIG_MODULES_USE_ELF_RELA
 int apply_relocate_add(Elf_Shdr *sechdrs,
 		       const char *strtab,
 		       unsigned int symindex,
 		       unsigned int relsec,
 		       struct module *mod);
+#else
+static inline int apply_relocate_add(Elf_Shdr *sechdrs,
+				     const char *strtab,
+				     unsigned int symindex,
+				     unsigned int relsec,
+				     struct module *me)
+{
+	pr_err("module %s: RELA relocation unsupported\n", me->name);
+	return -ENOEXEC;
+}
+#endif
 
 /* Any final processing of module before access.  Return -error or 0. */
 int module_finalize(const Elf_Ehdr *hdr,
diff --git a/kernel/module.c b/kernel/module.c
index 4edbd9c..087aeed 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1949,26 +1949,6 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 	return ret;
 }
 
-int __weak apply_relocate(Elf_Shdr *sechdrs,
-			  const char *strtab,
-			  unsigned int symindex,
-			  unsigned int relsec,
-			  struct module *me)
-{
-	pr_err("module %s: REL relocation unsupported\n", me->name);
-	return -ENOEXEC;
-}
-
-int __weak apply_relocate_add(Elf_Shdr *sechdrs,
-			      const char *strtab,
-			      unsigned int symindex,
-			      unsigned int relsec,
-			      struct module *me)
-{
-	pr_err("module %s: RELA relocation unsupported\n", me->name);
-	return -ENOEXEC;
-}
-
 static int apply_relocations(struct module *mod, const struct load_info *info)
 {
 	unsigned int i;
