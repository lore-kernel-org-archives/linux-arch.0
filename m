Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:53325 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeHXCwu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Aug 2018 22:52:50 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 2/2] kbuild: rename LDFLAGS to KBUILD_LDFLAGS
Date: Fri, 24 Aug 2018 08:20:39 +0900
Message-ID: <1535066439-11259-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1535066439-11259-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535066439-11259-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
Message-ID: <20180823232039.YZiirM7uih0sOPXnmsTL3ZJgo42qZAOcUmUNSS0yE_4@z>

Commit a0f97e06a43c ("kbuild: enable 'make CFLAGS=...' to add
additional options to CC") renamed CFLAGS to KBUILD_CFLAGS.

Commit 222d394d30e7 ("kbuild: enable 'make AFLAGS=...' to add
additional options to AS") renamed AFLAGS to KBUILD_AFLAGS.

Commit 06c5040cdb13 ("kbuild: enable 'make CPPFLAGS=...' to add
additional options to CPP") renamed CPPFLAGS to KBUILD_CPPFLAGS.

For some reason, LDFLAGS was not renamed.

Using a well-known variable like LDFLAGS may result in accidental
override of the variable.

Kbuild generally uses KBUILD_ prefixed variables for the internally
appended options, so here is one more conversion to sanitize the
naming convention.

I did not touch Makefiles under tools/ since the tools build system
is a different world.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---

Changes in v3:
 - Fix scripts/link-vmlinux.sh

Changes in v2:
 - Rebased on Linus's tree

 Makefile                           | 6 +++---
 arch/arc/Makefile                  | 2 +-
 arch/arm/Makefile                  | 4 ++--
 arch/arm64/Makefile                | 4 ++--
 arch/c6x/Makefile                  | 3 +--
 arch/h8300/Makefile                | 2 +-
 arch/hexagon/Makefile              | 4 +---
 arch/m68k/Makefile                 | 2 +-
 arch/microblaze/Makefile           | 4 ++--
 arch/mips/Makefile                 | 2 +-
 arch/mips/boot/compressed/Makefile | 2 +-
 arch/mips/lasat/image/Makefile     | 2 +-
 arch/nds32/Makefile                | 4 ++--
 arch/powerpc/Makefile              | 6 +++---
 arch/riscv/Makefile                | 4 ++--
 arch/s390/Makefile                 | 2 +-
 arch/sh/Makefile                   | 4 ++--
 arch/sparc/Makefile                | 4 ++--
 arch/um/Makefile                   | 2 +-
 arch/x86/Makefile                  | 4 ++--
 arch/x86/Makefile.um               | 4 ++--
 arch/x86/boot/compressed/Makefile  | 6 +++---
 arch/xtensa/Makefile               | 2 +-
 arch/xtensa/boot/boot-elf/Makefile | 2 +-
 scripts/Kbuild.include             | 4 ++--
 scripts/Makefile.build             | 6 +++---
 scripts/Makefile.lib               | 2 +-
 scripts/Makefile.modpost           | 2 +-
 scripts/link-vmlinux.sh            | 4 ++--
 29 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/Makefile b/Makefile
index 1623b8b..2e2b009 100644
--- a/Makefile
+++ b/Makefile
@@ -440,7 +440,7 @@ KBUILD_CFLAGS_KERNEL :=
 KBUILD_AFLAGS_MODULE  := -DMODULE
 KBUILD_CFLAGS_MODULE  := -DMODULE
 KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
-LDFLAGS :=
+KBUILD_LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
@@ -448,7 +448,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
 export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
 export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
-export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
+export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
 export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
@@ -1020,7 +1020,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
 cmd_link-vmlinux =                                                 \
-	$(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
+	$(CONFIG_SHELL) $< $(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_vmlinux) ;    \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 6c1b20d..fb02619 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -95,7 +95,7 @@ KBUILD_CFLAGS_MODULE	+= -mlong-calls -mno-millicode
 # Finally dump eveything into kernel build system
 KBUILD_CFLAGS	+= $(cflags-y)
 KBUILD_AFLAGS	+= $(KBUILD_CFLAGS)
-LDFLAGS		+= $(ldflags-y)
+KBUILD_LDFLAGS	+= $(ldflags-y)
 
 head-y		:= arch/arc/kernel/head.o
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e7d703d..360f80a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -43,12 +43,12 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__ARMEB__
 AS		+= -EB
-LDFLAGS		+= -EB
+KBUILD_LDFLAGS	+= -EB
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__ARMEL__
 AS		+= -EL
-LDFLAGS		+= -EL
+KBUILD_LDFLAGS	+= -EL
 endif
 
 #
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index efe61a2..106039d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -62,14 +62,14 @@ CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
 # Prefer the baremetal ELF build target, but not all toolchains include
 # it so fall back to the standard linux version if needed.
-LDFLAGS		+= -EB $(call ld-option, -maarch64elfb, -maarch64linuxb)
+KBUILD_LDFLAGS	+= -EB $(call ld-option, -maarch64elfb, -maarch64linuxb)
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
 # Same as above, prefer ELF but fall back to linux target if needed.
-LDFLAGS		+= -EL $(call ld-option, -maarch64elf, -maarch64linux)
+KBUILD_LDFLAGS	+= -EL $(call ld-option, -maarch64elf, -maarch64linux)
 UTS_MACHINE	:= aarch64
 endif
 
diff --git a/arch/c6x/Makefile b/arch/c6x/Makefile
index 6ab942e..3fe8a94 100644
--- a/arch/c6x/Makefile
+++ b/arch/c6x/Makefile
@@ -23,8 +23,7 @@ ifdef CONFIG_CPU_BIG_ENDIAN
 KBUILD_CFLAGS   += -mbig-endian
 KBUILD_AFLAGS   += -mbig-endian
 LINKFLAGS       += -mbig-endian
-KBUILD_LDFLAGS  += -mbig-endian
-LDFLAGS += -EB
+KBUILD_LDFLAGS  += -mbig-endian -EB
 CHECKFLAGS	+= -D_BIG_ENDIAN
 endif
 
diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index e1c02ca..f9cbbb1 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -20,7 +20,7 @@ KBUILD_CFLAGS += -mint32 -fno-builtin
 KBUILD_CFLAGS += -D__linux__
 KBUILD_CFLAGS += -DUTS_SYSNAME=\"uClinux\"
 KBUILD_AFLAGS += $(aflags-y)
-LDFLAGS += $(ldflags-y)
+KBUILD_LDFLAGS += $(ldflags-y)
 
 ifeq ($(CROSS_COMPILE),)
 CROSS_COMPILE := h8300-unknown-linux-
diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
index 2efaa18..4c5858b 100644
--- a/arch/hexagon/Makefile
+++ b/arch/hexagon/Makefile
@@ -22,9 +22,7 @@ ldflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
 
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_AFLAGS += $(aflags-y)
-
-#  no KBUILD_LDFLAGS?
-LDFLAGS += $(ldflags-y)
+KBUILD_LDFLAGS += $(ldflags-y)
 
 # Thread-info register will be r19.  This value is not configureable;
 # it is hard-coded in several files.
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index f0dd9fc..997c9f2 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -69,7 +69,7 @@ KBUILD_CFLAGS += -D__uClinux__
 KBUILD_AFLAGS += -D__uClinux__
 endif
 
-LDFLAGS := -m m68kelf
+KBUILD_LDFLAGS := -m m68kelf
 KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/m68k/kernel/module.lds
 
 ifdef CONFIG_SUN3
diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 7333036..4f3ab57 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -40,11 +40,11 @@ CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
 ifdef CONFIG_CPU_BIG_ENDIAN
 KBUILD_CFLAGS += -mbig-endian
 KBUILD_AFLAGS += -mbig-endian
-LDFLAGS += -EB
+KBUILD_LDFLAGS += -EB
 else
 KBUILD_CFLAGS += -mlittle-endian
 KBUILD_AFLAGS += -mlittle-endian
-LDFLAGS += -EL
+KBUILD_LDFLAGS += -EL
 endif
 
 CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 5425df0..d74b374 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -309,7 +309,7 @@ endif
 # instead of .eh_frame so we don't discard them.
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
-LDFLAGS			+= -m $(ld-emul)
+KBUILD_LDFLAGS		+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index abe77ad..3c453a1 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -92,7 +92,7 @@ UIMAGE_LOADADDR = $(VMLINUZ_LOAD_ADDRESS)
 vmlinuzobjs-y += $(obj)/piggy.o
 
 quiet_cmd_zld = LD      $@
-      cmd_zld = $(LD) $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T $< $(vmlinuzobjs-y) -o $@
+      cmd_zld = $(LD) $(KBUILD_LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T $< $(vmlinuzobjs-y) -o $@
 quiet_cmd_strip = STRIP	  $@
       cmd_strip = $(STRIP) -s $@
 vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/calc_vmlinuz_load_addr
diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
index 9ab1326..78ce4cf 100644
--- a/arch/mips/lasat/image/Makefile
+++ b/arch/mips/lasat/image/Makefile
@@ -38,7 +38,7 @@ $(obj)/rom.bin: $(obj)/rom
 
 # Rule to make the bootloader
 $(obj)/rom: $(addprefix $(obj)/,$(OBJECTS))
-	$(LD) $(LDFLAGS) $(LDSCRIPT) -o $@ $^
+	$(LD) $(KBUILD_LDFLAGS) $(LDSCRIPT) -o $@ $^
 
 $(obj)/%.o: $(obj)/%.gz
 	$(LD) -r -o $@ -b binary $<
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 031c676..63f4f17 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -33,12 +33,12 @@ endif
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CFLAGS   += $(call cc-option, -EL)
 KBUILD_AFLAGS   += $(call cc-option, -EL)
-LDFLAGS         += $(call cc-option, -EL)
+KBUILD_LDFLAGS  += $(call cc-option, -EL)
 CHECKFLAGS      += -D__NDS32_EL__
 else
 KBUILD_CFLAGS   += $(call cc-option, -EB)
 KBUILD_AFLAGS   += $(call cc-option, -EB)
-LDFLAGS         += $(call cc-option, -EB)
+KBUILD_LDFLAGS  += $(call cc-option, -EB)
 CHECKFLAGS      += -D__NDS32_EB__
 endif
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8397c7b..11a1acb 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -76,14 +76,14 @@ endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CFLAGS	+= -mlittle-endian
-LDFLAGS		+= -EL
+KBUILD_LDFLAGS	+= -EL
 LDEMULATION	:= lppc
 GNUTARGET	:= powerpcle
 MULTIPLEWORD	:= -mno-multiple
 KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-save-toc-indirect)
 else
 KBUILD_CFLAGS += $(call cc-option,-mbig-endian)
-LDFLAGS		+= -EB
+KBUILD_LDFLAGS	+= -EB
 LDEMULATION	:= ppc
 GNUTARGET	:= powerpc
 MULTIPLEWORD	:= -mmultiple
@@ -108,7 +108,7 @@ aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
 ifeq ($(HAS_BIARCH),y)
 KBUILD_CFLAGS	+= -m$(BITS)
 KBUILD_AFLAGS	+= -m$(BITS) -Wl,-a$(BITS)
-LDFLAGS		+= -m elf$(BITS)$(LDEMULATION)
+KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
 KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 9ddd88b..61ec424 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -29,7 +29,7 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
 	KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
 
 	KBUILD_MARCH = rv64im
-	LDFLAGS += -melf64lriscv
+	KBUILD_LDFLAGS += -melf64lriscv
 else
 	BITS := 32
 	UTS_MACHINE := riscv32
@@ -37,7 +37,7 @@ else
 	KBUILD_CFLAGS += -mabi=ilp32
 	KBUILD_AFLAGS += -mabi=ilp32
 	KBUILD_MARCH = rv32im
-	LDFLAGS += -melf32lriscv
+	KBUILD_LDFLAGS += -melf32lriscv
 endif
 
 KBUILD_CFLAGS += -Wall
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index ba6d122..ee65185 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -11,7 +11,7 @@
 #
 
 LD_BFD		:= elf64-s390
-LDFLAGS		:= -m elf64_s390
+KBUILD_LDFLAGS	:= -m elf64_s390
 KBUILD_AFLAGS_MODULE += -fPIC
 KBUILD_CFLAGS_MODULE += -fPIC
 KBUILD_AFLAGS	+= -m64
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 65300193..c521ade 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -122,11 +122,11 @@ endif
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 ld-bfd			:= elf32-$(UTS_MACHINE)-linux
 LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64 --oformat $(ld-bfd)
-LDFLAGS			+= -EL
+KBUILD_LDFLAGS		+= -EL
 else
 ld-bfd			:= elf32-$(UTS_MACHINE)big-linux
 LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64+4 --oformat $(ld-bfd)
-LDFLAGS			+= -EB
+KBUILD_LDFLAGS		+= -EB
 endif
 
 export ld-bfd BITS
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 966a13d..8ece494 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -21,7 +21,7 @@ ifeq ($(CONFIG_SPARC32),y)
 #
 
 CHECKFLAGS     += -D__sparc__
-LDFLAGS        := -m elf32_sparc
+KBUILD_LDFLAGS := -m elf32_sparc
 export BITS    := 32
 UTS_MACHINE    := sparc
 
@@ -40,7 +40,7 @@ else
 #
 
 CHECKFLAGS    += -D__sparc__ -D__sparc_v9__ -D__arch64__
-LDFLAGS       := -m elf64_sparc
+KBUILD_LDFLAGS := -m elf64_sparc
 export BITS   := 64
 UTS_MACHINE   := sparc64
 
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 44ddc3e..ab1066c 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -133,7 +133,7 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
-LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt))
+LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
 export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7e3c07d..9485924 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -219,7 +219,7 @@ sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA2
 KBUILD_AFLAGS += $(cfi) $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr)
 KBUILD_CFLAGS += $(cfi) $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr)
 
-LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 
 #
 # The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
@@ -227,7 +227,7 @@ LDFLAGS := -m elf_$(UTS_MACHINE)
 # by the linker.
 #
 ifdef CONFIG_X86_64
-LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
+KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
 endif
 
 # Speed up the build
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 5296f8c..91085a0 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -4,7 +4,7 @@ core-y += arch/x86/crypto/
 ifeq ($(CONFIG_X86_32),y)
 START := 0x8048000
 
-LDFLAGS			+= -m elf_i386
+KBUILD_LDFLAGS		+= -m elf_i386
 ELF_ARCH		:= i386
 ELF_FORMAT 		:= elf32-i386
 CHECKFLAGS	+= -D__i386__
@@ -43,7 +43,7 @@ KBUILD_CFLAGS += -fno-builtin -m64
 
 CHECKFLAGS  += -m64 -D__x86_64__
 KBUILD_AFLAGS += -m64
-LDFLAGS += -m elf_x86_64
+KBUILD_LDFLAGS += -m elf_x86_64
 KBUILD_CPPFLAGS += -m64
 
 ELF_ARCH := i386:x86-64
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 169c2fe..28764da 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -42,16 +42,16 @@ KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
-LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 ifeq ($(CONFIG_X86_32),y)
-LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
+KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
 else
 # To build 64-bit compressed kernel as PIE, we disable relocation
 # overflow check to avoid relocation overflow error with a new linker
 # command-line option, -z noreloc-overflow.
-LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
+KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
 endif
 LDFLAGS_vmlinux := -T
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 3a934b7..295c120 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -49,7 +49,7 @@ KBUILD_CFLAGS += $(call cc-option,-mno-serialize-volatile,)
 KBUILD_AFLAGS += -mlongcalls -mtext-section-literals
 
 ifneq ($(CONFIG_LD_NO_RELAX),)
-LDFLAGS := --no-relax
+KBUILD_LDFLAGS := --no-relax
 endif
 
 ifeq ($(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#"),1)
diff --git a/arch/xtensa/boot/boot-elf/Makefile b/arch/xtensa/boot/boot-elf/Makefile
index 5214719..12ae1e9 100644
--- a/arch/xtensa/boot/boot-elf/Makefile
+++ b/arch/xtensa/boot/boot-elf/Makefile
@@ -25,7 +25,7 @@ $(obj)/Image.o: vmlinux.bin $(OBJS)
 		$(OBJS) $@
 
 $(obj)/../Image.elf: $(obj)/Image.o $(obj)/boot.lds
-	$(Q)$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) \
+	$(Q)$(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_vmlinux) \
 		-T $(obj)/boot.lds \
 		--build-id=none \
 		-o $@ $(obj)/Image.o
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 7c98f60..c75413d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -163,8 +163,8 @@ cc-ldoption = $(call try-run,\
 	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # ld-option
-# Usage: LDFLAGS += $(call ld-option, -X, -Y)
-ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2),$(3))
+# Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
+ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f5d7612..1c48572 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -190,7 +190,7 @@ cmd_modversions_c =								\
 		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
 		    > $(@D)/.tmp_$(@F:.o=.ver);					\
 										\
-		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 			\
+		$(LD) $(KBUILD_LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
 			-T $(@D)/.tmp_$(@F:.o=.ver);				\
 		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);		\
 	else									\
@@ -220,7 +220,7 @@ sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
-	"$(LD) $(LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
+	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
@@ -394,7 +394,7 @@ cmd_modversions_S =								\
 		$(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
 		    > $(@D)/.tmp_$(@F:.o=.ver);					\
 										\
-		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 			\
+		$(LD) $(KBUILD_LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
 			-T $(@D)/.tmp_$(@F:.o=.ver);				\
 		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);		\
 	else									\
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index df0fff2..61e5966 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -162,7 +162,7 @@ a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(__cpp_flags)
 
-ld_flags       = $(LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
+ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 
 DTC_INCLUDE    := $(srctree)/scripts/dtc/include-prefixes
 
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index dd92dbb..7d4af0d 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -120,7 +120,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 # Step 6), final link of the modules with optional arch pass after final link
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o =                                                     \
-	$(LD) -r $(LDFLAGS)                                             \
+	$(LD) -r $(KBUILD_LDFLAGS)                                      \
                  $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)             \
                  -o $@ $(filter-out FORCE,$^) ;                         \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 4bf811c..c8cf453 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -75,7 +75,7 @@ modpost_link()
 		${KBUILD_VMLINUX_LIBS}				\
 		--end-group"
 
-	${LD} ${LDFLAGS} -r -o ${1} ${objects}
+	${LD} ${KBUILD_LDFLAGS} -r -o ${1} ${objects}
 }
 
 # Link of vmlinux
@@ -95,7 +95,7 @@ vmlinux_link()
 			--end-group				\
 			${1}"
 
-		${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}	\
+		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}	\
 			-T ${lds} ${objects}
 	else
 		objects="-Wl,--whole-archive			\
-- 
2.7.4
