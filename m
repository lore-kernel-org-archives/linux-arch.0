Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:59255 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758101AbXIISD4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 9 Sep 2007 14:03:56 -0400
Date: Sun, 9 Sep 2007 20:04:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 1/4] kbuild: enable 'make CFLAGS=...' to add additional options to CC
Message-ID: <20070909180430.GB20086@uranus.ravnborg.org>
References: <20070909180254.GA20086@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070909180254.GA20086@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: linux arch <linux-arch@vger.kernel.org>, Andi Kleen <ak@suse.de>, kbuild devel <kbuild-devel@lists.sourceforge.net>, Tony Luck <tony.luck@intel.com>
List-ID: <linux-arch.vger.kernel.org>

The variable CFLAGS is a wellknown variable and the usage by
kbuild may result in unexpected behaviour.
On top of that several people over time has asked for a way to
pass in additional flags to gcc.

This patch replace use of CFLAGS with KBUILD_CFLAGS all over the
tree and enabling one to use:
make CFLAGS=...
to specify additional gcc commandline options.

One specific usecase are when trying to find gcc bugs but other
usages has been requested too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/kbuild/makefiles.txt     |   15 +++++++++------
 Makefile                               |   23 +++++++++++++----------
 arch/alpha/Makefile                    |    2 +-
 arch/alpha/kernel/Makefile             |    2 +-
 arch/alpha/lib/Makefile                |    2 +-
 arch/arm/Makefile                      |    6 +++---
 arch/arm/boot/compressed/Makefile      |    2 +-
 arch/avr32/Makefile                    |    4 ++--
 arch/blackfin/Makefile                 |    2 +-
 arch/cris/Makefile                     |    8 ++++----
 arch/frv/Makefile                      |   22 +++++++++++-----------
 arch/h8300/Makefile                    |   12 ++++++------
 arch/i386/Makefile                     |   10 +++++-----
 arch/i386/boot/Makefile                |    4 ++--
 arch/i386/boot/compressed/Makefile     |    2 +-
 arch/i386/math-emu/Makefile            |    2 +-
 arch/ia64/Makefile                     |    2 +-
 arch/m32r/Makefile                     |    6 +++---
 arch/m68k/Makefile                     |    8 ++++----
 arch/m68knommu/Makefile                |    6 +++---
 arch/mips/Makefile                     |    6 +++---
 arch/mips/kernel/Makefile              |    2 +-
 arch/mips/lemote/lm2e/Makefile         |    2 +-
 arch/mips/sibyte/common/Makefile       |    2 +-
 arch/parisc/Makefile                   |    2 +-
 arch/powerpc/Makefile                  |   22 +++++++++++-----------
 arch/ppc/Makefile                      |   10 +++++-----
 arch/ppc/boot/Makefile                 |    2 +-
 arch/s390/Makefile                     |    8 ++++----
 arch/sh/Makefile                       |    4 ++--
 arch/sh/boot/compressed/Makefile       |    2 +-
 arch/sh64/Makefile                     |    4 ++--
 arch/sparc/Makefile                    |    6 +++---
 arch/sparc64/Makefile                  |    6 +++---
 arch/um/Makefile                       |   10 +++++-----
 arch/um/Makefile-i386                  |    4 ++--
 arch/um/Makefile-os-Linux              |    2 +-
 arch/um/Makefile-x86_64                |    2 +-
 arch/um/drivers/Makefile               |    2 +-
 arch/um/sys-i386/Makefile              |    2 +-
 arch/um/sys-x86_64/Makefile            |    2 +-
 arch/v850/Makefile                     |    8 ++++----
 arch/x86_64/Makefile                   |    2 +-
 arch/x86_64/boot/compressed/Makefile   |    4 ++--
 arch/x86_64/vdso/Makefile              |    4 ++--
 arch/xtensa/Makefile                   |    4 ++--
 arch/xtensa/boot/Makefile              |    4 ++--
 arch/xtensa/boot/boot-redboot/Makefile |    2 +-
 init/Makefile                          |    2 +-
 scripts/Kbuild.include                 |    6 +++---
 scripts/Makefile.lib                   |    2 +-
 51 files changed, 143 insertions(+), 137 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index e08ef87..4df47e4 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -294,7 +294,7 @@ more details, with real examples.
 
 
 	This variable is necessary because the top Makefile owns the
-	variable $(CFLAGS) and uses it for compilation flags for the
+	variable $(KBUILD_CFLAGS) and uses it for compilation flags for the
 	entire tree.
 
 	$(EXTRA_AFLAGS) is a similar string for per-directory options
@@ -438,6 +438,7 @@ more details, with real examples.
 	-march=pentium-mmx if supported by $(CC), otherwise -march=i586.
 	The second argument to cc-option is optional, and if omitted,
 	cflags-y will be assigned no value if first option is not supported.
+	Note: cc-option uses KBUILD_CFLAGS for $(CC) options
 
    cc-option-yn
 	cc-option-yn is used to check if gcc supports a given option
@@ -453,6 +454,7 @@ more details, with real examples.
 	option. When $(biarch) equals 'y', the expanded variables $(aflags-y)
 	and $(cflags-y) will be assigned the values -a32 and -m32,
 	respectively.
+	Note: cc-option-yn uses KBUILD_CFLAGS for $(CC) options
 
     cc-option-align
 	gcc versions >= 3.0 changed the type of options used to specify
@@ -464,10 +466,11 @@ more details, with real examples.
 		cc-option-align = -falign
 
 	Example:
-		CFLAGS += $(cc-option-align)-functions=4
+		KBUILD_CFLAGS += $(cc-option-align)-functions=4
 
 	In the above example, the option -falign-functions=4 is used for
 	gcc >= 3.00. For gcc < 3.00, -malign-functions=4 is used.
+	Note: cc-option-align uses KBUILD_CFLAGS for $(CC) options
 
     cc-version
 	cc-version returns a numerical version of the $(CC) compiler version.
@@ -826,17 +829,17 @@ When kbuild executes, the following steps are followed (roughly):
 		#arch/sparc64/Makefile
 		AFLAGS += -m64 -mcpu=ultrasparc
 
-    CFLAGS		$(CC) compiler flags
+    KBUILD_CFLAGS		$(CC) compiler flags
 
 	Default value - see top level Makefile
 	Append or modify as required per architecture.
 
-	Often, the CFLAGS variable depends on the configuration.
+	Often, the KBUILD_CFLAGS variable depends on the configuration.
 
 	Example:
 		#arch/i386/Makefile
 		cflags-$(CONFIG_M386) += -march=i386
-		CFLAGS += $(cflags-y)
+		KBUILD_CFLAGS += $(cflags-y)
 
 	Many arch Makefiles dynamically run the target C compiler to
 	probe supported options:
@@ -848,7 +851,7 @@ When kbuild executes, the following steps are followed (roughly):
 						-march=pentium2,-march=i686)
 		...
 		# Disable unit-at-a-time mode ...
-		CFLAGS += $(call cc-option,-fno-unit-at-a-time)
+		KBUILD_CFLAGS += $(call cc-option,-fno-unit-at-a-time)
 		...
 
 
diff --git a/Makefile b/Makefile
index 5118ae8..2a83bf3 100644
--- a/Makefile
+++ b/Makefile
@@ -312,7 +312,7 @@ LINUXINCLUDE    := -Iinclude \
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
-CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
+KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration
 AFLAGS          := -D__ASSEMBLY__
@@ -327,7 +327,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
-export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
+export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
 export AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 
 # When compiling out-of-tree modules, put MODVERDIR in the module
@@ -484,35 +484,38 @@ endif # $(dot-config)
 all: vmlinux
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-CFLAGS		+= -Os
+KBUILD_CFLAGS += -Os
 else
-CFLAGS		+= -O2
+KBUILD_CFLAGS += -O2
 endif
 
 include $(srctree)/arch/$(ARCH)/Makefile
 
 ifdef CONFIG_FRAME_POINTER
-CFLAGS		+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
+KBUILD_CFLAGS += -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
-CFLAGS		+= -fomit-frame-pointer
+KBUILD_CFLAGS += -fomit-frame-pointer
 endif
 
 ifdef CONFIG_DEBUG_INFO
-CFLAGS		+= -g
+KBUILD_CFLAGS += -g
 endif
 
 # Force gcc to behave correct even for buggy distributions
-CFLAGS          += $(call cc-option, -fno-stack-protector)
+KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
 
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
 
 # warn about C99 declaration after statement
-CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
+KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
 
 # disable pointer signed / unsigned warnings in gcc 4.0
-CFLAGS += $(call cc-option,-Wno-pointer-sign,)
+KBUILD_CFLAGS += $(call cc-option,-Wno-pointer-sign,)
+
+# Add user supplied CFLAGS as the last assignment
+KBUILD_CFLAGS += $(CFLAGS)
 
 # Use --build-id when available.
 LDFLAGS_BUILD_ID = $(patsubst -Wl$(comma)%,%,\
diff --git a/arch/alpha/Makefile b/arch/alpha/Makefile
index 1b704ee..2f283b2 100644
--- a/arch/alpha/Makefile
+++ b/arch/alpha/Makefile
@@ -84,7 +84,7 @@ endif
 # For TSUNAMI, we must have the assembler not emulate our instructions.
 # The same is true for IRONGATE, POLARIS, PYXIS.
 # BWX is most important, but we don't really want any emulation ever.
-CFLAGS += $(cflags-y) -Wa,-mev6
+KBUILD_CFLAGS += $(cflags-y) -Wa,-mev6
 
 head-y := arch/alpha/kernel/head.o
 
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index ab6fa54..dccf052 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -3,7 +3,7 @@
 #
 
 extra-y		:= head.o vmlinux.lds
-EXTRA_AFLAGS	:= $(CFLAGS)
+EXTRA_AFLAGS	:= $(KBUILD_CFLAGS)
 EXTRA_CFLAGS	:= -Werror -Wno-sign-compare
 
 obj-y    := entry.o traps.o process.o init_task.o osf_sys.o irq.o \
diff --git a/arch/alpha/lib/Makefile b/arch/alpha/lib/Makefile
index 266f78e..9b72c59 100644
--- a/arch/alpha/lib/Makefile
+++ b/arch/alpha/lib/Makefile
@@ -2,7 +2,7 @@
 # Makefile for alpha-specific library files..
 #
 
-EXTRA_AFLAGS := $(CFLAGS)
+EXTRA_AFLAGS := $(KBUILD_CFLAGS)
 EXTRA_CFLAGS := -Werror
 
 # Many of these routines have implementations tuned for ev6.
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index fa4ea9f..6eff3c9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,7 +16,7 @@ OBJCOPYFLAGS	:=-O binary -R .note -R .comment -S
 GZFLAGS		:=-9
 #CFLAGS		+=-pipe
 # Explicitly specifiy 32-bit ARM ISA since toolchain default can be -mthumb:
-CFLAGS		+=$(call cc-option,-marm,)
+KBUILD_CFLAGS	+=$(call cc-option,-marm,)
 
 # Do not use arch/arm/defconfig - it's always outdated.
 # Select a platform tht is kept up-to-date
@@ -28,7 +28,7 @@ MMUEXT		:= -nommu
 endif
 
 ifeq ($(CONFIG_FRAME_POINTER),y)
-CFLAGS		+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
+KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
 endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
@@ -85,7 +85,7 @@ CFLAGS_ABI	:=$(call cc-option,-mapcs-32,-mabi=apcs-gnu) $(call cc-option,-mno-th
 endif
 
 # Need -Uarm for gcc < 3.x
-CFLAGS		+=$(CFLAGS_ABI) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
+KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
 AFLAGS		+=$(CFLAGS_ABI) $(arch-y) $(tune-y) -msoft-float
 
 CHECKFLAGS	+= -D__arm__
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 6b8cbd6..5fde99f 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -87,7 +87,7 @@ ifneq ($(PARAMS_PHYS),)
 LDFLAGS_vmlinux += --defsym params_phys=$(PARAMS_PHYS)
 endif
 LDFLAGS_vmlinux += -p --no-undefined -X \
-	$(shell $(CC) $(CFLAGS) --print-libgcc-file-name) -T
+	$(shell $(CC) $(KBUILD_CFLAGS) --print-libgcc-file-name) -T
 
 # Don't allow any static data in misc.o, which
 # would otherwise mess up our GOT table
diff --git a/arch/avr32/Makefile b/arch/avr32/Makefile
index dc6bc01..9883c8b 100644
--- a/arch/avr32/Makefile
+++ b/arch/avr32/Makefile
@@ -11,14 +11,14 @@ all: uImage vmlinux.elf
 
 KBUILD_DEFCONFIG	:= atstk1002_defconfig
 
-CFLAGS		+= -pipe -fno-builtin -mno-pic
+KBUILD_CFLAGS	+= -pipe -fno-builtin -mno-pic
 AFLAGS		+= -mrelax -mno-pic
 CFLAGS_MODULE	+= -mno-relax
 LDFLAGS_vmlinux	+= --relax
 
 cpuflags-$(CONFIG_CPU_AT32AP7000)	+= -mcpu=ap7000
 
-CFLAGS		+= $(cpuflags-y)
+KBUILD_CFLAGS	+= $(cpuflags-y)
 AFLAGS		+= $(cpuflags-y)
 
 CHECKFLAGS	+= -D__avr32__ -D__BIG_ENDIAN
diff --git a/arch/blackfin/Makefile b/arch/blackfin/Makefile
index 2084166..52a6ac0 100644
--- a/arch/blackfin/Makefile
+++ b/arch/blackfin/Makefile
@@ -53,7 +53,7 @@ rev-$(CONFIG_BF_REV_0_5)  := 0.5
 rev-$(CONFIG_BF_REV_NONE) := none
 rev-$(CONFIG_BF_REV_ANY)  := any
 
-CFLAGS += -mcpu=$(cpu-y)-$(rev-y)
+KBUILD_CFLAGS += -mcpu=$(cpu-y)-$(rev-y)
 AFLAGS += -mcpu=$(cpu-y)-$(rev-y)
 
 head-y   := arch/$(ARCH)/mach-$(MACHINE)/head.o arch/$(ARCH)/kernel/init_task.o
diff --git a/arch/cris/Makefile b/arch/cris/Makefile
index ee11469..32ef6f3 100644
--- a/arch/cris/Makefile
+++ b/arch/cris/Makefile
@@ -31,16 +31,16 @@ OBJCOPYFLAGS := -O binary -R .note -R .comment -S
 CPPFLAGS_vmlinux.lds = -DDRAM_VIRTUAL_BASE=0x$(CONFIG_ETRAX_DRAM_VIRTUAL_BASE)
 AFLAGS += -mlinux
 
-CFLAGS := $(CFLAGS) -mlinux -march=$(arch-y) -pipe
+KBUILD_CFLAGS += -mlinux -march=$(arch-y) -pipe
 
 ifdef CONFIG_FRAME_POINTER
-CFLAGS := $(subst -fomit-frame-pointer,,$(CFLAGS)) -g
-CFLAGS += -fno-omit-frame-pointer
+KBUILD_CFLAGS := $(subst -fomit-frame-pointer,,$(KBUILD_CFLAGS)) -g
+KBUILD_CFLAGS += -fno-omit-frame-pointer
 endif
 
 head-y := arch/$(ARCH)/$(SARCH)/kernel/head.o
 
-LIBGCC = $(shell $(CC) $(CFLAGS) -print-file-name=libgcc.a)
+LIBGCC = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libgcc.a)
 
 core-y		+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
 core-y		+= arch/$(ARCH)/$(SARCH)/kernel/ arch/$(ARCH)/$(SARCH)/mm/
diff --git a/arch/frv/Makefile b/arch/frv/Makefile
index 9bf7345..ec89886 100644
--- a/arch/frv/Makefile
+++ b/arch/frv/Makefile
@@ -39,13 +39,13 @@ endif
 ARCHMODFLAGS	+= -G0 -mlong-calls
 
 ifdef CONFIG_GPREL_DATA_8
-CFLAGS		+= -G8
+KBUILD_CFLAGS	+= -G8
 else
 ifdef CONFIG_GPREL_DATA_4
-CFLAGS		+= -G4
+KBUILD_CFLAGS	+= -G4
 else
 ifdef CONFIG_GPREL_DATA_NONE
-CFLAGS		+= -G0
+KBUILD_CFLAGS	+= -G0
 endif
 endif
 endif
@@ -53,25 +53,25 @@ endif
 #LDFLAGS_vmlinux	:= -Map linkmap.txt
 
 ifdef CONFIG_GC_SECTIONS
-CFLAGS		+= -ffunction-sections -fdata-sections
+KBUILD_CFLAGS	+= -ffunction-sections -fdata-sections
 LINKFLAGS	+= --gc-sections
 endif
 
 ifndef CONFIG_FRAME_POINTER
-CFLAGS		+= -mno-linked-fp
+KBUILD_CFLAGS	+= -mno-linked-fp
 endif
 
 ifdef CONFIG_CPU_FR451_COMPILE
-CFLAGS		+= -mcpu=fr450
+KBUILD_CFLAGS	+= -mcpu=fr450
 AFLAGS		+= -mcpu=fr450
 ASFLAGS		+= -mcpu=fr450
 else
 ifdef CONFIG_CPU_FR551_COMPILE
-CFLAGS		+= -mcpu=fr550
+KBUILD_CFLAGS	+= -mcpu=fr550
 AFLAGS		+= -mcpu=fr550
 ASFLAGS		+= -mcpu=fr550
 else
-CFLAGS		+= -mcpu=fr400
+KBUILD_CFLAGS	+= -mcpu=fr400
 AFLAGS		+= -mcpu=fr400
 ASFLAGS		+= -mcpu=fr400
 endif
@@ -80,15 +80,15 @@ endif
 # pretend the kernel is going to run on an FR400 with no media-fp unit
 # - reserve CC3 for use with atomic ops
 # - all the extra registers are dealt with only at context switch time
-CFLAGS		+= -mno-fdpic -mgpr-32 -msoft-float -mno-media
-CFLAGS		+= -ffixed-fcc3 -ffixed-cc3 -ffixed-gr15 -ffixed-icc2
+KBUILD_CFLAGS	+= -mno-fdpic -mgpr-32 -msoft-float -mno-media
+KBUILD_CFLAGS	+= -ffixed-fcc3 -ffixed-cc3 -ffixed-gr15 -ffixed-icc2
 AFLAGS		+= -mno-fdpic
 ASFLAGS		+= -mno-fdpic
 
 # make sure the .S files get compiled with debug info
 # and disable optimisations that are unhelpful whilst debugging
 ifdef CONFIG_DEBUG_INFO
-#CFLAGS		+= -O1
+#KBUILD_CFLAGS	+= -O1
 AFLAGS		+= -Wa,--gdwarf2
 ASFLAGS		+= -Wa,--gdwarf2
 endif
diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index 53b5c1e..330e05f 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -30,16 +30,16 @@ ldflags-$(CONFIG_CPU_H8300H)	:= -mh8300helf
 cflags-$(CONFIG_CPU_H8S)	:= -ms
 ldflags-$(CONFIG_CPU_H8S)	:= -mh8300self
 
-CFLAGS += $(cflags-y)
-CFLAGS += -mint32 -fno-builtin
-CFLAGS += -g
-CFLAGS += -D__linux__
-CFLAGS += -DUTS_SYSNAME=\"uClinux\"
+KBUILD_CFLAGS += $(cflags-y)
+KBUILD_CFLAGS += -mint32 -fno-builtin
+KBUILD_CFLAGS += -g
+KBUILD_CFLAGS += -D__linux__
+KBUILD_CFLAGS += -DUTS_SYSNAME=\"uClinux\"
 AFLAGS += -DPLATFORM=$(PLATFORM) -DMODEL=$(MODEL) $(cflags-y)
 LDFLAGS += $(ldflags-y)
 
 CROSS_COMPILE = h8300-elf-
-LIBGCC := $(shell $(CROSS-COMPILE)$(CC) $(CFLAGS) -print-libgcc-file-name)
+LIBGCC := $(shell $(CROSS-COMPILE)$(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 head-y := arch/$(ARCH)/platform/$(PLATFORM)/$(BOARD)/crt0_$(MODEL).o
 
diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index 52b9324..252fcc2 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -31,10 +31,10 @@ LDFLAGS_vmlinux := --emit-relocs
 endif
 CHECKFLAGS	+= -D__i386__
 
-CFLAGS += -pipe -msoft-float -mregparm=3 -freg-struct-return
+KBUILD_CFLAGS += -pipe -msoft-float -mregparm=3 -freg-struct-return
 
 # prevent gcc from keeping the stack 16 byte aligned
-CFLAGS += $(call cc-option,-mpreferred-stack-boundary=2)
+KBUILD_CFLAGS += $(call cc-option,-mpreferred-stack-boundary=2)
 
 # CPU-specific tuning. Anything which can be shared with UML should go here.
 include $(srctree)/arch/i386/Makefile.cpu
@@ -48,7 +48,7 @@ cflags-y += -maccumulate-outgoing-args
 
 # Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
 # a lot more stack due to the lack of sharing of stacklots:
-CFLAGS				+= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo $(call cc-option,-fno-unit-at-a-time); fi ;)
+KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0400 ] ; then echo $(call cc-option,-fno-unit-at-a-time); fi ;)
 
 # do binutils support CFI?
 cflags-y += $(call as-instr,.cfi_startproc\n.cfi_rel_offset esp${comma}0\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
@@ -58,7 +58,7 @@ AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_rel_offset esp${comma}0\n.cfi_end
 cflags-y += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
 AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
 
-CFLAGS += $(cflags-y)
+KBUILD_CFLAGS += $(cflags-y)
 
 # Default subarch .c files
 mcore-y  := mach-default
@@ -113,7 +113,7 @@ drivers-$(CONFIG_OPROFILE)		+= arch/i386/oprofile/
 drivers-$(CONFIG_PM)			+= arch/i386/power/
 drivers-$(CONFIG_FB)                    += arch/i386/video/
 
-CFLAGS += $(mflags-y)
+KBUILD_CFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
 
 boot := arch/i386/boot
diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
index 93386a4..4e896dd 100644
--- a/arch/i386/boot/Makefile
+++ b/arch/i386/boot/Makefile
@@ -50,7 +50,7 @@ HOSTCFLAGS_build.o := $(LINUXINCLUDE)
 # that way we can complain to the user if the CPU is insufficient.
 cflags-i386   := 
 cflags-x86_64 := -m32
-CFLAGS		:= $(LINUXINCLUDE) -g -Os -D_SETUP -D__KERNEL__ \
+KBUILD_CFLAGS	:= $(LINUXINCLUDE) -g -Os -D_SETUP -D__KERNEL__ \
 		   $(cflags-$(ARCH)) \
 		   -Wall -Wstrict-prototypes \
 		   -march=i386 -mregparm=3 \
@@ -61,7 +61,7 @@ CFLAGS		:= $(LINUXINCLUDE) -g -Os -D_SETUP -D__KERNEL__ \
 			$(call cc-option, -fno-unit-at-a-time)) \
 		   $(call cc-option, -fno-stack-protector) \
 		   $(call cc-option, -mpreferred-stack-boundary=2)
-AFLAGS		:= $(CFLAGS) -D__ASSEMBLY__
+AFLAGS		:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 
 $(obj)/zImage:  IMAGE_OFFSET := 0x1000
 $(obj)/zImage:  EXTRA_AFLAGS := $(SVGA_MODE) $(RAMDISK)
diff --git a/arch/i386/boot/compressed/Makefile b/arch/i386/boot/compressed/Makefile
index 189fa1d..f625914 100644
--- a/arch/i386/boot/compressed/Makefile
+++ b/arch/i386/boot/compressed/Makefile
@@ -11,7 +11,7 @@ EXTRA_AFLAGS	:= -traditional
 LDFLAGS_vmlinux := -T
 hostprogs-y	:= relocs
 
-CFLAGS  := -m32 -D__KERNEL__ $(LINUX_INCLUDE) -O2 \
+KBUILD_CFLAGS  := -m32 -D__KERNEL__ $(LINUX_INCLUDE) -O2 \
 	   -fno-strict-aliasing -fPIC \
 	   $(call cc-option,-ffreestanding) \
 	   $(call cc-option,-fno-stack-protector)
diff --git a/arch/i386/math-emu/Makefile b/arch/i386/math-emu/Makefile
index 9c943fa..324836d 100644
--- a/arch/i386/math-emu/Makefile
+++ b/arch/i386/math-emu/Makefile
@@ -5,7 +5,7 @@
 #DEBUG	= -DDEBUGGING
 DEBUG	=
 PARANOID = -DPARANOID
-CFLAGS	:= $(CFLAGS) $(PARANOID) $(DEBUG) -fno-builtin $(MATH_EMULATION)
+KBUILD_CFLAGS += $(PARANOID) $(DEBUG) -fno-builtin $(MATH_EMULATION)
 
 EXTRA_AFLAGS	:= $(PARANOID)
 
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 21033ed..9708a29 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -44,7 +44,7 @@ ifeq ($(call cc-version),0304)
 	cflags-$(CONFIG_MCKINLEY)	+= -mtune=mckinley
 endif
 
-CFLAGS += $(cflags-y)
+KBUILD_CFLAGS += $(cflags-y)
 head-y := arch/ia64/kernel/head.o arch/ia64/kernel/init_task.o
 
 libs-y				+= arch/ia64/lib/
diff --git a/arch/m32r/Makefile b/arch/m32r/Makefile
index cdf63b2..6380ab6 100644
--- a/arch/m32r/Makefile
+++ b/arch/m32r/Makefile
@@ -9,7 +9,7 @@ LDFLAGS		:=
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux	:=
 
-CFLAGS += -pipe -fno-schedule-insns
+KBUILD_CFLAGS += -pipe -fno-schedule-insns
 CFLAGS_KERNEL += -mmodel=medium
 CFLAGS_MODULE += -mmodel=large
 
@@ -24,14 +24,14 @@ endif
 cflags-$(CONFIG_ISA_M32R)	+= -DNO_FPU
 aflags-$(CONFIG_ISA_M32R)	+= -DNO_FPU -O2 -Wa,-no-bitinst
 
-CFLAGS += $(cflags-y)
+KBUILD_CFLAGS += $(cflags-y)
 AFLAGS += $(aflags-y)
 
 CHECKFLAGS	+= -D__m32r__ -D__BIG_ENDIAN__=1
 
 head-y	:= arch/m32r/kernel/head.o arch/m32r/kernel/init_task.o
 
-LIBGCC	:= $(shell $(CC) $(CFLAGS) -print-libgcc-file-name)
+LIBGCC	:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 libs-y	+= arch/m32r/lib/ $(LIBGCC)
 core-y	+= arch/m32r/kernel/	\
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index aa383a5..4a1bd44 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -32,18 +32,18 @@ endif
 CHECKFLAGS += -D__mc68000__
 
 # without -fno-strength-reduce the 53c7xx.c driver fails ;-(
-CFLAGS += -pipe -fno-strength-reduce -ffixed-a2
+KBUILD_CFLAGS += -pipe -fno-strength-reduce -ffixed-a2
 
 # enable processor switch if compiled only for a single cpu
 ifndef CONFIG_M68020
 ifndef CONFIG_M68030
 
 ifndef CONFIG_M68060
-CFLAGS := $(CFLAGS) -m68040
+KBUILD_CFLAGS += -m68040
 endif
 
 ifndef CONFIG_M68040
-CFLAGS := $(CFLAGS) -m68060
+KBUILD_CFLAGS += -m68060
 endif
 
 endif
@@ -52,7 +52,7 @@ endif
 ifdef CONFIG_KGDB
 # If configured for kgdb support, include debugging infos and keep the
 # frame pointer
-CFLAGS := $(subst -fomit-frame-pointer,,$(CFLAGS)) -g
+KBUILD_CFLAGS := $(subst -fomit-frame-pointer,,$(KBUILD_CFLAGS)) -g
 endif
 
 ifndef CONFIG_SUN3
diff --git a/arch/m68knommu/Makefile b/arch/m68knommu/Makefile
index 1305cc9..1c1fbb6 100644
--- a/arch/m68knommu/Makefile
+++ b/arch/m68knommu/Makefile
@@ -104,9 +104,9 @@ cflags-$(CONFIG_M68360)		:= -m68332
 
 AFLAGS += $(cflags-y)
 
-CFLAGS += $(cflags-y)
-CFLAGS += -D__linux__
-CFLAGS += -DUTS_SYSNAME=\"uClinux\"
+KBUILD_CFLAGS += $(cflags-y)
+KBUILD_CFLAGS += -D__linux__
+KBUILD_CFLAGS += -DUTS_SYSNAME=\"uClinux\"
 
 head-y := arch/m68knommu/platform/$(cpuclass-y)/head.o
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 32c1c8f..6fc73c4 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -579,13 +579,13 @@ JIFFIES			= jiffies_64
 endif
 
 AFLAGS		+= $(cflags-y)
-CFLAGS		+= $(cflags-y) \
+KBUILD_CFLAGS	+= $(cflags-y) \
 			-D"VMLINUX_LOAD_ADDRESS=$(load-y)"
 
 LDFLAGS			+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
-CHECKFLAGS += $(shell $(CC) $(CFLAGS) -dM -E -xc /dev/null | \
+CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -xc /dev/null | \
 	egrep -vw '__GNUC_(|MINOR_|PATCHLEVEL_)_' | \
 	sed -e 's/^\#define /-D/' -e "s/ /='/" -e "s/$$/'/")
 ifdef CONFIG_64BIT
@@ -602,7 +602,7 @@ OBJCOPYFLAGS		+= --remove-section=.reginfo
 #
 
 CPPFLAGS_vmlinux.lds := \
-	$(CFLAGS) \
+	$(KBUILD_CFLAGS) \
 	-D"LOADADDR=$(load-y)" \
 	-D"JIFFIES=$(JIFFIES)" \
 	-D"DATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)"
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 2fd96d9..4937e46 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -69,7 +69,7 @@ obj-$(CONFIG_PCSPEAKER)		+= pcspeaker.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
-CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
+CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
 
 obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
diff --git a/arch/mips/lemote/lm2e/Makefile b/arch/mips/lemote/lm2e/Makefile
index dcaf6f4..b014a47 100644
--- a/arch/mips/lemote/lm2e/Makefile
+++ b/arch/mips/lemote/lm2e/Makefile
@@ -4,5 +4,5 @@
 
 obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o mem.o
 
-EXTRA_AFLAGS := $(CFLAGS)
+EXTRA_AFLAGS := $(KBUILD_CFLAGS)
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/sibyte/common/Makefile b/arch/mips/sibyte/common/Makefile
index f8ae300..412fce4 100644
--- a/arch/mips/sibyte/common/Makefile
+++ b/arch/mips/sibyte/common/Makefile
@@ -2,5 +2,5 @@ obj-y :=
 
 obj-$(CONFIG_SIBYTE_TBPROF)		+= sb_tbprof.o
 
-EXTRA_AFLAGS := $(CFLAGS)
+EXTRA_AFLAGS := $(KBUILD_CFLAGS)
 EXTRA_CFLAGS += -Werror
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 760567a..f3d0d7c 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -63,7 +63,7 @@ cflags-$(CONFIG_PA8X00)		+= -march=2.0 -mschedule=8000
 
 head-y			:= arch/parisc/kernel/head.o 
 
-CFLAGS	+= $(cflags-y)
+KBUILD_CFLAGS	+= $(cflags-y)
 
 kernel-y			:= mm/ kernel/ math-emu/ kernel/init_task.o
 kernel-$(CONFIG_HPUX)		+= hpux/
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6c1e36c..6515965 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -70,8 +70,8 @@ CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH) -ffixed-r2 -mmultiple
 CPPFLAGS	+= $(CPPFLAGS-y)
 AFLAGS		+= $(AFLAGS-y)
-CFLAGS		+= -msoft-float -pipe $(CFLAGS-y)
-CPP		= $(CC) -E $(CFLAGS)
+KBUILD_CFLAGS	+= -msoft-float -pipe $(CFLAGS-y)
+CPP		= $(CC) -E $(KBUILD_CFLAGS)
 # Temporary hack until we have migrated to asm-powerpc
 LINUXINCLUDE-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)/include
 LINUXINCLUDE    += $(LINUXINCLUDE-y)
@@ -84,31 +84,31 @@ GCC_BROKEN_VEC	:= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo "y"; fi
 ifeq ($(CONFIG_POWER4_ONLY),y)
 ifeq ($(CONFIG_ALTIVEC),y)
 ifeq ($(GCC_BROKEN_VEC),y)
-	CFLAGS += $(call cc-option,-mcpu=970)
+        KBUILD_CFLAGS += $(call cc-option,-mcpu=970)
 else
-	CFLAGS += $(call cc-option,-mcpu=power4)
+        KBUILD_CFLAGS += $(call cc-option,-mcpu=power4)
 endif
 else
-	CFLAGS += $(call cc-option,-mcpu=power4)
+        KBUILD_CFLAGS += $(call cc-option,-mcpu=power4)
 endif
 else
-	CFLAGS += $(call cc-option,-mtune=power4)
+        KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
 endif
 endif
 
 # No AltiVec instruction when building kernel
-CFLAGS += $(call cc-option,-mno-altivec)
+KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
 
 # Enable unit-at-a-time mode when possible. It shrinks the
 # kernel considerably.
-CFLAGS += $(call cc-option,-funit-at-a-time)
+KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
 
 # Never use string load/store instructions as they are
 # often slow when they are implemented at all
-CFLAGS		+= -mno-string
+KBUILD_CFLAGS += -mno-string
 
 ifeq ($(CONFIG_6xx),y)
-CFLAGS		+= -mcpu=powerpc
+KBUILD_CFLAGS += -mcpu=powerpc
 endif
 
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
@@ -118,7 +118,7 @@ cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
 AFLAGS += $(cpu-as-y)
-CFLAGS += $(cpu-as-y)
+KBUILD_CFLAGS += $(cpu-as-y)
 
 head-y				:= arch/powerpc/kernel/head_32.o
 head-$(CONFIG_PPC64)		:= arch/powerpc/kernel/head_64.o
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index 0db66dc..f4f22f7 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -24,20 +24,20 @@ LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 # The -Iarch/$(ARCH)/include is temporary while we are merging
 CPPFLAGS	+= -Iarch/$(ARCH) -Iarch/$(ARCH)/include
 AFLAGS		+= -Iarch/$(ARCH)
-CFLAGS		+= -Iarch/$(ARCH) -msoft-float -pipe \
+KBUILD_CFLAGS	+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -mmultiple
 
 # No AltiVec instruction when building kernel
-CFLAGS		+= $(call cc-option, -mno-altivec)
+KBUILD_CFLAGS	+= $(call cc-option, -mno-altivec)
 
-CPP		= $(CC) -E $(CFLAGS)
+CPP		= $(CC) -E $(KBUILD_CFLAGS)
 # Temporary hack until we have migrated to asm-powerpc
 LINUXINCLUDE    += -Iarch/$(ARCH)/include
 
 CHECKFLAGS	+= -D__powerpc__
 
 ifndef CONFIG_FSL_BOOKE
-CFLAGS		+= -mstring
+KBUILD_CFLAGS	+= -mstring
 endif
 
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
@@ -46,7 +46,7 @@ cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
 AFLAGS += $(cpu-as-y)
-CFLAGS += $(cpu-as-y)
+KBUILD_CFLAGS += $(cpu-as-y)
 
 # Default to the common case.
 KBUILD_DEFCONFIG := common_defconfig
diff --git a/arch/ppc/boot/Makefile b/arch/ppc/boot/Makefile
index b739e25..b0c4628 100644
--- a/arch/ppc/boot/Makefile
+++ b/arch/ppc/boot/Makefile
@@ -13,7 +13,7 @@
 # modified by Cort (cort@cs.nmt.edu)
 #
 
-CFLAGS	 	+= -fno-builtin -D__BOOTER__ -Iarch/$(ARCH)/boot/include
+KBUILD_CFLAGS	+= -fno-builtin -D__BOOTER__ -Iarch/$(ARCH)/boot/include
 HOSTCFLAGS	+= -Iarch/$(ARCH)/boot/include
 
 BOOT_TARGETS	= zImage zImage.initrd znetboot znetboot.initrd
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 143ed8e..62a0da4 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -15,7 +15,7 @@
 
 ifndef CONFIG_64BIT
 LDFLAGS		:= -m elf_s390
-CFLAGS		+= -m31
+KBUILD_CFLAGS	+= -m31
 AFLAGS		+= -m31
 UTS_MACHINE	:= s390
 STACK_SIZE	:= 8192
@@ -23,7 +23,7 @@ CHECKFLAGS	+= -D__s390__ -msize-long
 else
 LDFLAGS		:= -m elf64_s390
 MODFLAGS	+= -fpic -D__PIC__
-CFLAGS		+= -m64
+KBUILD_CFLAGS	+= -m64
 AFLAGS		+= -m64
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= 16384
@@ -77,8 +77,8 @@ cflags-$(CONFIG_WARN_STACK) += -mwarn-dynamicstack
 cflags-$(CONFIG_WARN_STACK) += -mwarn-framesize=$(CONFIG_WARN_STACK_SIZE)
 endif
 
-CFLAGS		+= -mbackchain -msoft-float $(cflags-y)
-CFLAGS 		+= -pipe -fno-strength-reduce -Wno-sign-compare 
+KBUILD_CFLAGS	+= -mbackchain -msoft-float $(cflags-y)
+KBUILD_CFLAGS	+= -pipe -fno-strength-reduce -Wno-sign-compare
 AFLAGS		+= $(aflags-y)
 
 OBJCOPYFLAGS	:= -O binary
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 97ac586..cd8a411 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -91,12 +91,12 @@ LDFLAGS_vmlinux		+= --defsym 'jiffies=jiffies_64+4'
 LDFLAGS			+= -EB
 endif
 
-CFLAGS		+= -pipe $(cflags-y)
+KBUILD_CFLAGS		+= -pipe $(cflags-y)
 AFLAGS		+= $(cflags-y)
 
 head-y := arch/sh/kernel/head.o arch/sh/kernel/init_task.o
 
-LIBGCC := $(shell $(CC) $(CFLAGS) -print-libgcc-file-name)
+LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 core-y				+= arch/sh/kernel/ arch/sh/mm/
 core-$(CONFIG_SH_FPU_EMU)	+= arch/sh/math-emu/
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index 013504a..906a13f 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -21,7 +21,7 @@ IMAGE_OFFSET	:= $(shell /bin/bash -c 'printf "0x%08x" \
 			$(CONFIG_MEMORY_START) + \
 			$(CONFIG_BOOT_LINK_OFFSET)]')
 
-LIBGCC	:= $(shell $(CC) $(CFLAGS) -print-libgcc-file-name)
+LIBGCC	:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup -T $(obj)/../../kernel/vmlinux.lds
 
diff --git a/arch/sh64/Makefile b/arch/sh64/Makefile
index ebf2004..9e874de 100644
--- a/arch/sh64/Makefile
+++ b/arch/sh64/Makefile
@@ -26,7 +26,7 @@ LDFLAGS			+= -EB  -mshelf32_linux
 endif
 
 # No requirements for endianess support from AFLAGS, 'as' always run through gcc
-CFLAGS		+= $(cpu-y)
+KBUILD_CFLAGS		+= $(cpu-y)
 
 LDFLAGS_vmlinux	+= --defsym phys_stext=_stext-$(CONFIG_CACHED_MEMORY_OFFSET) \
 		  --defsym phys_stext_shmedia=phys_stext+1 \
@@ -57,7 +57,7 @@ ifneq ($(machine-y),)
 core-y	+= arch/sh64/mach-$(machine-y)/
 endif
 
-LIBGCC := $(shell $(CC) $(CFLAGS) -print-libgcc-file-name)
+LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 libs-y	+= arch/$(ARCH)/lib/ $(LIBGCC)
 
 drivers-$(CONFIG_OPROFILE)	+= arch/sh64/oprofile/
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index f33c381..2ce781a 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -8,15 +8,15 @@
 #
 
 #
-# Uncomment the first CFLAGS if you are doing kgdb source level
+# Uncomment the first KBUILD_CFLAGS if you are doing kgdb source level
 # debugging of the kernel to get the proper debugging information.
 
 AS              := $(AS) -32
 LDFLAGS		:= -m elf32_sparc
 CHECKFLAGS	+= -D__sparc__
 
-#CFLAGS := $(CFLAGS) -g -pipe -fcall-used-g5 -fcall-used-g7
-CFLAGS := $(CFLAGS) -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
+#KBUILD_CFLAGS += -g -pipe -fcall-used-g5 -fcall-used-g7
+KBUILD_CFLAGS += -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
 AFLAGS := $(AFLAGS) -m32
 
 #LDFLAGS_vmlinux = -N -Ttext 0xf0004000
diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index cad10c5..b083dc4 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -39,17 +39,17 @@ AS		:= $(AS) --undeclared-regs
 endif
 
 ifneq ($(NEW_GCC),y)
-  CFLAGS := $(CFLAGS) -pipe -mno-fpu -mtune=ultrasparc -mmedlow \
+  KBUILD_CFLAGS += -pipe -mno-fpu -mtune=ultrasparc -mmedlow \
 	    -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare
 else
-  CFLAGS := $(CFLAGS) -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
+  KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
 	    -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare \
 	    $(CC_UNDECL)
   AFLAGS += -m64 -mcpu=ultrasparc $(CC_UNDECL)
 endif
 
 ifeq ($(CONFIG_MCOUNT),y)
-  CFLAGS := $(CFLAGS) -pg
+  KBUILD_CFLAGS += -pg
 endif
 
 head-y := arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 989224f..18123bf 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -58,14 +58,14 @@ SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 #
 # These apply to USER_CFLAGS to.
 
-CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\"	\
+KBUILD_CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\"	\
 	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
 	-Din6addr_loopback=kernel_in6addr_loopback
 
 AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -D__KERNEL__,,\
-	$(patsubst -I%,,$(CFLAGS)))) $(ARCH_INCLUDE) $(MODE_INCLUDE) \
+	$(patsubst -I%,,$(KBUILD_CFLAGS)))) $(ARCH_INCLUDE) $(MODE_INCLUDE) \
 	-D_FILE_OFFSET_BITS=64
 
 include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
@@ -75,14 +75,14 @@ include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
-# in CFLAGS.  Otherwise, it would cause ld to complain about the two different
+# in KBUILD_CFLAGS.  Otherwise, it would cause ld to complain about the two different
 # errnos.
 # These apply to kernelspace only.
 
 KERNEL_DEFINES = -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
 	-Dmktime=kernel_mktime $(ARCH_KERNEL_DEFINES)
-CFLAGS += $(KERNEL_DEFINES)
-CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
+KBUILD_CFLAGS += $(KERNEL_DEFINES)
+KBUILD_CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
 # These are needed for clean and mrproper, since in that case .config is not
 # included; the values here are meaningless
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index c9f1c5b..26bc786 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -15,7 +15,7 @@ OBJCOPYFLAGS  		:= -O binary -R .note -R .comment -S
 
 ifeq ("$(origin SUBARCH)", "command line")
 ifneq ("$(shell uname -m | sed -e s/i.86/i386/)", "$(SUBARCH)")
-CFLAGS			+= $(call cc-option,-m32)
+KBUILD_CFLAGS		+= $(call cc-option,-m32)
 AFLAGS			+= $(call cc-option,-m32)
 LINK-y			+= $(call cc-option,-m32)
 UML_OBJCOPYFLAGS	+= -F $(ELF_FORMAT)
@@ -36,4 +36,4 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
 # an unresolved reference.
 cflags-y += -ffreestanding
 
-CFLAGS += $(cflags-y)
+KBUILD_CFLAGS += $(cflags-y)
diff --git a/arch/um/Makefile-os-Linux b/arch/um/Makefile-os-Linux
index 0c0f9a1..5285948 100644
--- a/arch/um/Makefile-os-Linux
+++ b/arch/um/Makefile-os-Linux
@@ -5,4 +5,4 @@
 
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE -D_LARGEFILE64_SOURCE
-CFLAGS += -D_LARGEFILE64_SOURCE
+KBUILD_CFLAGS += -D_LARGEFILE64_SOURCE
diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 69ecea6..36d2bb5 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -9,7 +9,7 @@ _extra_flags_ = -fno-builtin -m64
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
 ARCH_KERNEL_DEFINES = -U__$(SUBARCH)__
-CFLAGS += $(_extra_flags_)
+KBUILD_CFLAGS += $(_extra_flags_)
 
 CHECKFLAGS  += -m64
 AFLAGS += -m64
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index de17d4c..0f780dd 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -17,7 +17,7 @@ ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
-LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libpcap.a)
+LDFLAGS_pcap.o := -r $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
 
 targets := pcap_kern.o pcap_user.o
 
diff --git a/arch/um/sys-i386/Makefile b/arch/um/sys-i386/Makefile
index d6b3ecd..8909b07 100644
--- a/arch/um/sys-i386/Makefile
+++ b/arch/um/sys-i386/Makefile
@@ -20,4 +20,4 @@ CFLAGS_stub_segv.o := $(CFLAGS_NO_HARDENING)
 
 include arch/um/scripts/Makefile.rules
 
-$(obj)/unmap.%: _c_flags = $(call unprofile,$(CFLAGS))
+$(obj)/unmap.%: _c_flags = $(call unprofile,$(KBUILD_CFLAGS))
diff --git a/arch/um/sys-x86_64/Makefile b/arch/um/sys-x86_64/Makefile
index 4d9e5ef..e446a99 100644
--- a/arch/um/sys-x86_64/Makefile
+++ b/arch/um/sys-x86_64/Makefile
@@ -28,4 +28,4 @@ CFLAGS_stub_segv.o := $(CFLAGS_NO_HARDENING)
 
 include arch/um/scripts/Makefile.rules
 
-$(obj)/unmap.%: _c_flags = $(call unprofile,$(CFLAGS))
+$(obj)/unmap.%: _c_flags = $(call unprofile,$(KBUILD_CFLAGS))
diff --git a/arch/v850/Makefile b/arch/v850/Makefile
index 8be9aac..8b629df 100644
--- a/arch/v850/Makefile
+++ b/arch/v850/Makefile
@@ -16,11 +16,11 @@
 
 arch_dir = arch/v850
 
-CFLAGS += -mv850e
+KBUILD_CFLAGS += -mv850e
 # r16 is a fixed pointer to the current task
-CFLAGS += -ffixed-r16 -mno-prolog-function
-CFLAGS += -fno-builtin
-CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uClinux\"
+KBUILD_CFLAGS += -ffixed-r16 -mno-prolog-function
+KBUILD_CFLAGS += -fno-builtin
+KBUILD_CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uClinux\"
 
 # By default, build a kernel that runs on the gdb v850 simulator.
 KBUILD_DEFCONFIG := sim_defconfig
diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
index b024e4a..876a85a 100644
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -67,7 +67,7 @@ AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONF
 cflags-$(CONFIG_CC_STACKPROTECTOR) += $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh "$(CC)" -fstack-protector )
 cflags-$(CONFIG_CC_STACKPROTECTOR_ALL) += $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh "$(CC)" -fstack-protector-all )
 
-CFLAGS += $(cflags-y)
+KBUILD_CFLAGS += $(cflags-y)
 CFLAGS_KERNEL += $(cflags-kernel-y)
 AFLAGS += -m64
 
diff --git a/arch/x86_64/boot/compressed/Makefile b/arch/x86_64/boot/compressed/Makefile
index 877c0bd..d89eda7 100644
--- a/arch/x86_64/boot/compressed/Makefile
+++ b/arch/x86_64/boot/compressed/Makefile
@@ -6,11 +6,11 @@
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 
-CFLAGS := -m64 -D__KERNEL__ $(LINUXINCLUDE) -O2  \
+KBUILD_CFLAGS := -m64 -D__KERNEL__ $(LINUXINCLUDE) -O2  \
 	  -fno-strict-aliasing -fPIC -mcmodel=small \
 	   $(call cc-option, -ffreestanding) \
 	   $(call cc-option, -fno-stack-protector)
-AFLAGS  := $(CFLAGS) -D__ASSEMBLY__
+AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 LDFLAGS := -m elf_x86_64
 
 LDFLAGS_vmlinux := -T
diff --git a/arch/x86_64/vdso/Makefile b/arch/x86_64/vdso/Makefile
index 8d03de0..dcd6bb9 100644
--- a/arch/x86_64/vdso/Makefile
+++ b/arch/x86_64/vdso/Makefile
@@ -34,8 +34,8 @@ $(obj)/vdso.so: $(src)/vdso.lds $(vobjs) FORCE
 
 CFL := $(PROFILING) -mcmodel=small -fPIC -g0 -O2 -fasynchronous-unwind-tables -m64
 
-$(obj)/vclock_gettime.o: CFLAGS = $(CFL)
-$(obj)/vgetcpu.o: CFLAGS = $(CFL)
+$(obj)/vclock_gettime.o: KBUILD_CFLAGS = $(CFL)
+$(obj)/vgetcpu.o: KBUILD_CFLAGS = $(CFL)
 
 # We also create a special relocatable object that should mirror the symbol
 # table and layout of the linked DSO.  With ld -R we can then refer to
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 95f836d..5acd105 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -27,7 +27,7 @@ platform-$(CONFIG_XTENSA_PLATFORM_ISS)		:= iss
 PLATFORM = $(platform-y)
 export PLATFORM
 
-CFLAGS		+= -pipe -mlongcalls
+KBUILD_CFLAGS	+= -pipe -mlongcalls
 
 KBUILD_DEFCONFIG := iss_defconfig
 
@@ -51,7 +51,7 @@ endif
 
 #
 
-LIBGCC := $(shell $(CC) $(CFLAGS) -print-libgcc-file-name)
+LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 head-y		:= arch/xtensa/kernel/head.o
 core-y		+= arch/xtensa/kernel/ arch/xtensa/mm/
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index 820b31d..217c82d 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -8,12 +8,12 @@
 #
 
 
-CFLAGS 		+= -fno-builtin -Iarch/$(ARCH)/boot/include
+KBUYILD_CFLAGS		+= -fno-builtin -Iarch/$(ARCH)/boot/include
 HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
 
 BIG_ENDIAN	:= $(shell echo -e __XTENSA_EB__ | $(CC) -E - | grep -v "\#")
 
-export CFLAGS
+export KBUILD_CFLAGS
 export AFLAGS
 export BIG_ENDIAN
 
diff --git a/arch/xtensa/boot/boot-redboot/Makefile b/arch/xtensa/boot/boot-redboot/Makefile
index f53262c..74d15d0 100644
--- a/arch/xtensa/boot/boot-redboot/Makefile
+++ b/arch/xtensa/boot/boot-redboot/Makefile
@@ -19,7 +19,7 @@ boot-y	:= bootstrap.o
 OBJS	:= $(addprefix $(obj)/,$(boot-y))
 LIBS	:= arch/xtensa/boot/lib/lib.a arch/xtensa/lib/lib.a
 
-LIBGCC := $(shell $(CC) $(CFLAGS) -print-libgcc-file-name)
+LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 zImage: vmlinux $(OBJS) $(LIBS)
 	$(OBJCOPY) --strip-all -R .comment -R .xt.insn -O binary \
diff --git a/init/Makefile b/init/Makefile
index 0154aea..633392f 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -30,4 +30,4 @@ $(obj)/version.o: include/linux/compile.h
 include/linux/compile.h: FORCE
 	@echo '  CHK     $@'
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@ \
-	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)" "$(CC) $(CFLAGS)"
+	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)" "$(CC) $(KBUILD_CFLAGS)"
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 677bc6c..b1a7c7d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -75,7 +75,7 @@ try-run = $(shell set -e;		\
 # Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) $(CFLAGS) $(1) -c -xassembler /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) $(KBUILD_CFLAGS) $(1) -c -xassembler /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
 # Usage: cflags-y += $(call as-instr,instr,option1,option2)
@@ -87,12 +87,12 @@ as-instr = $(call try-run,\
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
 
 cc-option = $(call try-run,\
-	$(CC) $(CFLAGS) $(1) -S -xc /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) $(KBUILD_CFLAGS) $(1) -S -xc /dev/null -o "$$TMP",$(1),$(2))
 
 # cc-option-yn
 # Usage: flag := $(call cc-option-yn,-march=winchip-c6)
 cc-option-yn = $(call try-run,\
-	$(CC) $(CFLAGS) $(1) -S -xc /dev/null -o "$$TMP",y,n)
+	$(CC) $(KBUILD_CFLAGS) $(1) -S -xc /dev/null -o "$$TMP",y,n)
 
 # cc-option-align
 # Prefix align with either -falign or -malign
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index fc498fe..37de2a9 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -86,7 +86,7 @@ basename_flags = -D"KBUILD_BASENAME=KBUILD_STR($(call name-fix,$(basetarget)))"
 modname_flags  = $(if $(filter 1,$(words $(modname))),\
                  -D"KBUILD_MODNAME=KBUILD_STR($(call name-fix,$(modname)))")
 
-_c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(basetarget).o)
+_c_flags       = $(KBUILD_CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(basetarget).o)
 _a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
 _cpp_flags     = $(CPPFLAGS) $(EXTRA_CPPFLAGS) $(CPPFLAGS_$(@F))
 
-- 
1.5.1.rc3.2928.g8e573-dirty

