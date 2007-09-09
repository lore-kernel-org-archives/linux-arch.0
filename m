Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:47426 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096AbXIISEE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 9 Sep 2007 14:04:04 -0400
Date: Sun, 9 Sep 2007 20:05:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 2/4] kbuild: enable 'make AFLAGS=...' to add additional options to AS
Message-ID: <20070909180526.GC20086@uranus.ravnborg.org>
References: <20070909180254.GA20086@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070909180254.GA20086@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: linux arch <linux-arch@vger.kernel.org>, Andi Kleen <ak@suse.de>, kbuild devel <kbuild-devel@lists.sourceforge.net>, Tony Luck <tony.luck@intel.com>
List-ID: <linux-arch.vger.kernel.org>

The variable AFLAGS is a wellknown variable and the usage by
kbuild may result in unexpected behaviour.
On top of that several people over time has asked for a way to
pass in additional flags to gcc.

This patch replace use of AFLAGS with KBUILD_AFLAGS all over the
tree and enabling one to use:
make AFLAGS=...
to specify additional gcc (as) commandline options.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/kbuild/makefiles.txt     |    5 +++--
 Makefile                               |    9 +++++----
 arch/arm/Makefile                      |    2 +-
 arch/arm/vfp/Makefile                  |    2 +-
 arch/avr32/Makefile                    |    4 ++--
 arch/blackfin/Makefile                 |    2 +-
 arch/cris/Makefile                     |    2 +-
 arch/frv/Makefile                      |   10 +++++-----
 arch/h8300/Makefile                    |    2 +-
 arch/h8300/lib/Makefile                |    2 +-
 arch/i386/Makefile                     |    6 +++---
 arch/i386/boot/Makefile                |    2 +-
 arch/m32r/Makefile                     |    2 +-
 arch/m68knommu/Makefile                |    2 +-
 arch/m68knommu/platform/5206/Makefile  |    2 +-
 arch/m68knommu/platform/5206e/Makefile |    2 +-
 arch/m68knommu/platform/520x/Makefile  |    2 +-
 arch/m68knommu/platform/523x/Makefile  |    2 +-
 arch/m68knommu/platform/5249/Makefile  |    2 +-
 arch/m68knommu/platform/5272/Makefile  |    2 +-
 arch/m68knommu/platform/527x/Makefile  |    2 +-
 arch/m68knommu/platform/528x/Makefile  |    2 +-
 arch/m68knommu/platform/5307/Makefile  |    2 +-
 arch/m68knommu/platform/532x/Makefile  |    2 +-
 arch/m68knommu/platform/5407/Makefile  |    2 +-
 arch/mips/Makefile                     |    2 +-
 arch/powerpc/Makefile                  |    4 ++--
 arch/ppc/Makefile                      |    4 ++--
 arch/s390/Makefile                     |    6 +++---
 arch/sh/Makefile                       |    2 +-
 arch/sparc/Makefile                    |    2 +-
 arch/sparc64/Makefile                  |    2 +-
 arch/um/Makefile                       |    2 +-
 arch/um/Makefile-i386                  |    2 +-
 arch/um/Makefile-x86_64                |    2 +-
 arch/um/sys-ppc/Makefile               |    6 +++---
 arch/x86_64/Makefile                   |    6 +++---
 arch/x86_64/boot/compressed/Makefile   |    2 +-
 arch/xtensa/boot/Makefile              |    2 +-
 scripts/Kbuild.include                 |    2 +-
 scripts/Makefile.lib                   |    2 +-
 41 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 4df47e4..15b3c11 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -425,6 +425,7 @@ more details, with real examples.
 	as-instr checks if the assembler reports a specific instruction
 	and then outputs either option1 or option2
 	C escapes are supported in the test instruction
+	Note: as-instr-option uses KBUILD_AFLAGS for $(AS) options
 
     cc-option
 	cc-option is used to check if $(CC) supports a given option, and not
@@ -820,14 +821,14 @@ When kbuild executes, the following steps are followed (roughly):
 	In this example, the binary $(obj)/image is a binary version of
 	vmlinux. The usage of $(call if_changed,xxx) will be described later.
 
-    AFLAGS		$(AS) assembler flags
+    KBUILD_AFLAGS		$(AS) assembler flags
 
 	Default value - see top level Makefile
 	Append or modify as required per architecture.
 
 	Example:
 		#arch/sparc64/Makefile
-		AFLAGS += -m64 -mcpu=ultrasparc
+		KBUILD_AFLAGS += -m64 -mcpu=ultrasparc
 
     KBUILD_CFLAGS		$(CC) compiler flags
 
diff --git a/Makefile b/Makefile
index 2a83bf3..5b2dbdd 100644
--- a/Makefile
+++ b/Makefile
@@ -315,7 +315,7 @@ CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration
-AFLAGS          := -D__ASSEMBLY__
+KBUILD_AFLAGS   := -D__ASSEMBLY__
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
 KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
@@ -328,7 +328,7 @@ export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
-export AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
+export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
@@ -514,7 +514,8 @@ KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
 # disable pointer signed / unsigned warnings in gcc 4.0
 KBUILD_CFLAGS += $(call cc-option,-Wno-pointer-sign,)
 
-# Add user supplied CFLAGS as the last assignment
+# Add user supplied AFLAGS and CFLAGS as the last assignments
+KBUILD_AFLAGS += $(AFLAGS)
 KBUILD_CFLAGS += $(CFLAGS)
 
 # Use --build-id when available.
@@ -1490,7 +1491,7 @@ quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files))
       cmd_rmfiles = rm -f $(rm-files)
 
 
-a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(AFLAGS_KERNEL) \
+a_flags = -Wp,-MD,$(depfile) $(KBUILD_AFLAGS) $(AFLAGS_KERNEL) \
 	  $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6eff3c9..e7eab5b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -86,7 +86,7 @@ endif
 
 # Need -Uarm for gcc < 3.x
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-AFLAGS		+=$(CFLAGS_ABI) $(arch-y) $(tune-y) -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(arch-y) $(tune-y) -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
diff --git a/arch/arm/vfp/Makefile b/arch/arm/vfp/Makefile
index 7e136e7..39f6d8e 100644
--- a/arch/arm/vfp/Makefile
+++ b/arch/arm/vfp/Makefile
@@ -7,7 +7,7 @@
 # EXTRA_CFLAGS := -DDEBUG
 # EXTRA_AFLAGS := -DDEBUG
 
-AFLAGS		:=$(AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp)
+KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp)
 LDFLAGS		+=--no-warn-mismatch
 
 obj-y			+= vfp.o
diff --git a/arch/avr32/Makefile b/arch/avr32/Makefile
index 9883c8b..8791864 100644
--- a/arch/avr32/Makefile
+++ b/arch/avr32/Makefile
@@ -12,14 +12,14 @@ all: uImage vmlinux.elf
 KBUILD_DEFCONFIG	:= atstk1002_defconfig
 
 KBUILD_CFLAGS	+= -pipe -fno-builtin -mno-pic
-AFLAGS		+= -mrelax -mno-pic
+KBUILD_AFLAGS	+= -mrelax -mno-pic
 CFLAGS_MODULE	+= -mno-relax
 LDFLAGS_vmlinux	+= --relax
 
 cpuflags-$(CONFIG_CPU_AT32AP7000)	+= -mcpu=ap7000
 
 KBUILD_CFLAGS	+= $(cpuflags-y)
-AFLAGS		+= $(cpuflags-y)
+KBUILD_AFLAGS	+= $(cpuflags-y)
 
 CHECKFLAGS	+= -D__avr32__ -D__BIG_ENDIAN
 
diff --git a/arch/blackfin/Makefile b/arch/blackfin/Makefile
index 52a6ac0..3689337 100644
--- a/arch/blackfin/Makefile
+++ b/arch/blackfin/Makefile
@@ -54,7 +54,7 @@ rev-$(CONFIG_BF_REV_NONE) := none
 rev-$(CONFIG_BF_REV_ANY)  := any
 
 KBUILD_CFLAGS += -mcpu=$(cpu-y)-$(rev-y)
-AFLAGS += -mcpu=$(cpu-y)-$(rev-y)
+KBUILD_AFLAGS += -mcpu=$(cpu-y)-$(rev-y)
 
 head-y   := arch/$(ARCH)/mach-$(MACHINE)/head.o arch/$(ARCH)/kernel/init_task.o
 
diff --git a/arch/cris/Makefile b/arch/cris/Makefile
index 32ef6f3..e6bf00c 100644
--- a/arch/cris/Makefile
+++ b/arch/cris/Makefile
@@ -29,7 +29,7 @@ LD = $(CROSS_COMPILE)ld -mcrislinux
 OBJCOPYFLAGS := -O binary -R .note -R .comment -S
 
 CPPFLAGS_vmlinux.lds = -DDRAM_VIRTUAL_BASE=0x$(CONFIG_ETRAX_DRAM_VIRTUAL_BASE)
-AFLAGS += -mlinux
+KBUILD_AFLAGS += -mlinux
 
 KBUILD_CFLAGS += -mlinux -march=$(arch-y) -pipe
 
diff --git a/arch/frv/Makefile b/arch/frv/Makefile
index ec89886..310c47a 100644
--- a/arch/frv/Makefile
+++ b/arch/frv/Makefile
@@ -63,16 +63,16 @@ endif
 
 ifdef CONFIG_CPU_FR451_COMPILE
 KBUILD_CFLAGS	+= -mcpu=fr450
-AFLAGS		+= -mcpu=fr450
+KBUILD_AFLAGS	+= -mcpu=fr450
 ASFLAGS		+= -mcpu=fr450
 else
 ifdef CONFIG_CPU_FR551_COMPILE
 KBUILD_CFLAGS	+= -mcpu=fr550
-AFLAGS		+= -mcpu=fr550
+KBUILD_AFLAGS	+= -mcpu=fr550
 ASFLAGS		+= -mcpu=fr550
 else
 KBUILD_CFLAGS	+= -mcpu=fr400
-AFLAGS		+= -mcpu=fr400
+KBUILD_AFLAGS	+= -mcpu=fr400
 ASFLAGS		+= -mcpu=fr400
 endif
 endif
@@ -82,14 +82,14 @@ endif
 # - all the extra registers are dealt with only at context switch time
 KBUILD_CFLAGS	+= -mno-fdpic -mgpr-32 -msoft-float -mno-media
 KBUILD_CFLAGS	+= -ffixed-fcc3 -ffixed-cc3 -ffixed-gr15 -ffixed-icc2
-AFLAGS		+= -mno-fdpic
+KBUILD_AFLAGS	+= -mno-fdpic
 ASFLAGS		+= -mno-fdpic
 
 # make sure the .S files get compiled with debug info
 # and disable optimisations that are unhelpful whilst debugging
 ifdef CONFIG_DEBUG_INFO
 #KBUILD_CFLAGS	+= -O1
-AFLAGS		+= -Wa,--gdwarf2
+KBUILD_AFLAGS	+= -Wa,--gdwarf2
 ASFLAGS		+= -Wa,--gdwarf2
 endif
 
diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index 330e05f..a556447 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -35,7 +35,7 @@ KBUILD_CFLAGS += -mint32 -fno-builtin
 KBUILD_CFLAGS += -g
 KBUILD_CFLAGS += -D__linux__
 KBUILD_CFLAGS += -DUTS_SYSNAME=\"uClinux\"
-AFLAGS += -DPLATFORM=$(PLATFORM) -DMODEL=$(MODEL) $(cflags-y)
+KBUILD_AFLAGS += -DPLATFORM=$(PLATFORM) -DMODEL=$(MODEL) $(cflags-y)
 LDFLAGS += $(ldflags-y)
 
 CROSS_COMPILE = h8300-elf-
diff --git a/arch/h8300/lib/Makefile b/arch/h8300/lib/Makefile
index 98272b6..9d5e1f8 100644
--- a/arch/h8300/lib/Makefile
+++ b/arch/h8300/lib/Makefile
@@ -3,6 +3,6 @@
 #
 
 .S.o:
-	$(CC) $(AFLAGS) -D__ASSEMBLY__ -c $< -o $@
+	$(CC) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -c $< -o $@
 
 lib-y  = ashrdi3.o checksum.o memcpy.o memset.o abs.o romfs.o
diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index 252fcc2..5761eb8 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -52,11 +52,11 @@ KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0400 ] ; then echo $(call c
 
 # do binutils support CFI?
 cflags-y += $(call as-instr,.cfi_startproc\n.cfi_rel_offset esp${comma}0\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
-AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_rel_offset esp${comma}0\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
+KBUILD_AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_rel_offset esp${comma}0\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
 
 # is .cfi_signal_frame supported too?
 cflags-y += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
-AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
+KBUILD_AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
 
 KBUILD_CFLAGS += $(cflags-y)
 
@@ -114,7 +114,7 @@ drivers-$(CONFIG_PM)			+= arch/i386/power/
 drivers-$(CONFIG_FB)                    += arch/i386/video/
 
 KBUILD_CFLAGS += $(mflags-y)
-AFLAGS += $(mflags-y)
+KBUILD_AFLAGS += $(mflags-y)
 
 boot := arch/i386/boot
 
diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
index 4e896dd..af97ab0 100644
--- a/arch/i386/boot/Makefile
+++ b/arch/i386/boot/Makefile
@@ -61,7 +61,7 @@ KBUILD_CFLAGS	:= $(LINUXINCLUDE) -g -Os -D_SETUP -D__KERNEL__ \
 			$(call cc-option, -fno-unit-at-a-time)) \
 		   $(call cc-option, -fno-stack-protector) \
 		   $(call cc-option, -mpreferred-stack-boundary=2)
-AFLAGS		:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
+KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 
 $(obj)/zImage:  IMAGE_OFFSET := 0x1000
 $(obj)/zImage:  EXTRA_AFLAGS := $(SVGA_MODE) $(RAMDISK)
diff --git a/arch/m32r/Makefile b/arch/m32r/Makefile
index 6380ab6..48d3759 100644
--- a/arch/m32r/Makefile
+++ b/arch/m32r/Makefile
@@ -25,7 +25,7 @@ cflags-$(CONFIG_ISA_M32R)	+= -DNO_FPU
 aflags-$(CONFIG_ISA_M32R)	+= -DNO_FPU -O2 -Wa,-no-bitinst
 
 KBUILD_CFLAGS += $(cflags-y)
-AFLAGS += $(aflags-y)
+KBUILD_AFLAGS += $(aflags-y)
 
 CHECKFLAGS	+= -D__m32r__ -D__BIG_ENDIAN__=1
 
diff --git a/arch/m68knommu/Makefile b/arch/m68knommu/Makefile
index 1c1fbb6..92227aa 100644
--- a/arch/m68knommu/Makefile
+++ b/arch/m68knommu/Makefile
@@ -102,7 +102,7 @@ cflags-$(CONFIG_M68EZ328)	:= -m68000
 cflags-$(CONFIG_M68VZ328)	:= -m68000
 cflags-$(CONFIG_M68360)		:= -m68332
 
-AFLAGS += $(cflags-y)
+KBUILD_AFLAGS += $(cflags-y)
 
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -D__linux__
diff --git a/arch/m68knommu/platform/5206/Makefile b/arch/m68knommu/platform/5206/Makefile
index 701b7ab..494def8 100644
--- a/arch/m68knommu/platform/5206/Makefile
+++ b/arch/m68knommu/platform/5206/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 obj-y := config.o
diff --git a/arch/m68knommu/platform/5206e/Makefile b/arch/m68knommu/platform/5206e/Makefile
index 701b7ab..494def8 100644
--- a/arch/m68knommu/platform/5206e/Makefile
+++ b/arch/m68knommu/platform/5206e/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 obj-y := config.o
diff --git a/arch/m68knommu/platform/520x/Makefile b/arch/m68knommu/platform/520x/Makefile
index e861b05..5e74830 100644
--- a/arch/m68knommu/platform/520x/Makefile
+++ b/arch/m68knommu/platform/520x/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 obj-y := config.o
diff --git a/arch/m68knommu/platform/523x/Makefile b/arch/m68knommu/platform/523x/Makefile
index c1578b0..fd2c46d 100644
--- a/arch/m68knommu/platform/523x/Makefile
+++ b/arch/m68knommu/platform/523x/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 obj-y := config.o
diff --git a/arch/m68knommu/platform/5249/Makefile b/arch/m68knommu/platform/5249/Makefile
index 701b7ab..494def8 100644
--- a/arch/m68knommu/platform/5249/Makefile
+++ b/arch/m68knommu/platform/5249/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 obj-y := config.o
diff --git a/arch/m68knommu/platform/5272/Makefile b/arch/m68knommu/platform/5272/Makefile
index 0871a29..c486b16 100644
--- a/arch/m68knommu/platform/5272/Makefile
+++ b/arch/m68knommu/platform/5272/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 obj-y := config.o
diff --git a/arch/m68knommu/platform/527x/Makefile b/arch/m68knommu/platform/527x/Makefile
index 0871a29..c486b16 100644
--- a/arch/m68knommu/platform/527x/Makefile
+++ b/arch/m68knommu/platform/527x/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 obj-y := config.o
diff --git a/arch/m68knommu/platform/528x/Makefile b/arch/m68knommu/platform/528x/Makefile
index 0871a29..c486b16 100644
--- a/arch/m68knommu/platform/528x/Makefile
+++ b/arch/m68knommu/platform/528x/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 obj-y := config.o
diff --git a/arch/m68knommu/platform/5307/Makefile b/arch/m68knommu/platform/5307/Makefile
index 719a313..0dba9f7 100644
--- a/arch/m68knommu/platform/5307/Makefile
+++ b/arch/m68knommu/platform/5307/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 obj-$(CONFIG_COLDFIRE)	+= entry.o vectors.o
diff --git a/arch/m68knommu/platform/532x/Makefile b/arch/m68knommu/platform/532x/Makefile
index 1230180..5d8575c 100644
--- a/arch/m68knommu/platform/532x/Makefile
+++ b/arch/m68knommu/platform/532x/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 #obj-y := config.o usb-mcf532x.o spi-mcf532x.o
diff --git a/arch/m68knommu/platform/5407/Makefile b/arch/m68knommu/platform/5407/Makefile
index 91b2f49..cb7ecd3 100644
--- a/arch/m68knommu/platform/5407/Makefile
+++ b/arch/m68knommu/platform/5407/Makefile
@@ -13,7 +13,7 @@
 #
 
 ifdef CONFIG_FULLDEBUG
-AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
+KBUILD_AFLAGS += -DDEBUGGER_COMPATIBLE_CACHE=1
 endif
 
 obj-y := config.o
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 6fc73c4..38ee1ad 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -578,7 +578,7 @@ else
 JIFFIES			= jiffies_64
 endif
 
-AFLAGS		+= $(cflags-y)
+KBUILD_AFLAGS	+= $(cflags-y)
 KBUILD_CFLAGS	+= $(cflags-y) \
 			-D"VMLINUX_LOAD_ADDRESS=$(load-y)"
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6515965..02fbeb1 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -69,7 +69,7 @@ AFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH) -ffixed-r2 -mmultiple
 CPPFLAGS	+= $(CPPFLAGS-y)
-AFLAGS		+= $(AFLAGS-y)
+KBUILD_AFLAGS	+= $(AFLAGS-y)
 KBUILD_CFLAGS	+= -msoft-float -pipe $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 # Temporary hack until we have migrated to asm-powerpc
@@ -117,7 +117,7 @@ cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
-AFLAGS += $(cpu-as-y)
+KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
 
 head-y				:= arch/powerpc/kernel/head_32.o
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index f4f22f7..bfe9993 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -23,7 +23,7 @@ endif
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 # The -Iarch/$(ARCH)/include is temporary while we are merging
 CPPFLAGS	+= -Iarch/$(ARCH) -Iarch/$(ARCH)/include
-AFLAGS		+= -Iarch/$(ARCH)
+KBUILD_AFLAGS	+= -Iarch/$(ARCH)
 KBUILD_CFLAGS	+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -mmultiple
 
@@ -45,7 +45,7 @@ cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
-AFLAGS += $(cpu-as-y)
+KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
 
 # Default to the common case.
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 62a0da4..f708be3 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -16,7 +16,7 @@
 ifndef CONFIG_64BIT
 LDFLAGS		:= -m elf_s390
 KBUILD_CFLAGS	+= -m31
-AFLAGS		+= -m31
+KBUILD_AFLAGS	+= -m31
 UTS_MACHINE	:= s390
 STACK_SIZE	:= 8192
 CHECKFLAGS	+= -D__s390__ -msize-long
@@ -24,7 +24,7 @@ else
 LDFLAGS		:= -m elf64_s390
 MODFLAGS	+= -fpic -D__PIC__
 KBUILD_CFLAGS	+= -m64
-AFLAGS		+= -m64
+KBUILD_AFLAGS	+= -m64
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= 16384
 CHECKFLAGS	+= -D__s390__ -D__s390x__
@@ -79,7 +79,7 @@ endif
 
 KBUILD_CFLAGS	+= -mbackchain -msoft-float $(cflags-y)
 KBUILD_CFLAGS	+= -pipe -fno-strength-reduce -Wno-sign-compare
-AFLAGS		+= $(aflags-y)
+KBUILD_AFLAGS	+= $(aflags-y)
 
 OBJCOPYFLAGS	:= -O binary
 LDFLAGS_vmlinux := -e start
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index cd8a411..0353296 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -92,7 +92,7 @@ LDFLAGS			+= -EB
 endif
 
 KBUILD_CFLAGS		+= -pipe $(cflags-y)
-AFLAGS		+= $(cflags-y)
+KBUILD_AFLAGS		+= $(cflags-y)
 
 head-y := arch/sh/kernel/head.o arch/sh/kernel/init_task.o
 
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 2ce781a..fef28e2 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -17,7 +17,7 @@ CHECKFLAGS	+= -D__sparc__
 
 #KBUILD_CFLAGS += -g -pipe -fcall-used-g5 -fcall-used-g7
 KBUILD_CFLAGS += -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
-AFLAGS := $(AFLAGS) -m32
+KBUILD_AFLAGS += -m32
 
 #LDFLAGS_vmlinux = -N -Ttext 0xf0004000
 #  Since 2.5.40, the first stage is left not btfix-ed.
diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index b083dc4..6c92a42 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -45,7 +45,7 @@ else
   KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
 	    -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare \
 	    $(CC_UNDECL)
-  AFLAGS += -m64 -mcpu=ultrasparc $(CC_UNDECL)
+  KBUILD_AFLAGS += -m64 -mcpu=ultrasparc $(CC_UNDECL)
 endif
 
 ifeq ($(CONFIG_MCOUNT),y)
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 18123bf..d08d3bc 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -62,7 +62,7 @@ KBUILD_CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\"	\
 	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
 	-Din6addr_loopback=kernel_in6addr_loopback
 
-AFLAGS += $(ARCH_INCLUDE)
+KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -D__KERNEL__,,\
 	$(patsubst -I%,,$(KBUILD_CFLAGS)))) $(ARCH_INCLUDE) $(MODE_INCLUDE) \
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index 26bc786..d10e4dc 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -16,7 +16,7 @@ OBJCOPYFLAGS  		:= -O binary -R .note -R .comment -S
 ifeq ("$(origin SUBARCH)", "command line")
 ifneq ("$(shell uname -m | sed -e s/i.86/i386/)", "$(SUBARCH)")
 KBUILD_CFLAGS		+= $(call cc-option,-m32)
-AFLAGS			+= $(call cc-option,-m32)
+KBUILD_AFLAGS		+= $(call cc-option,-m32)
 LINK-y			+= $(call cc-option,-m32)
 UML_OBJCOPYFLAGS	+= -F $(ELF_FORMAT)
 
diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 36d2bb5..8836f0d 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -12,7 +12,7 @@ ARCH_KERNEL_DEFINES = -U__$(SUBARCH)__
 KBUILD_CFLAGS += $(_extra_flags_)
 
 CHECKFLAGS  += -m64
-AFLAGS += -m64
+KBUILD_AFLAGS += -m64
 LDFLAGS += -m elf_x86_64
 CPPFLAGS += -m64
 
diff --git a/arch/um/sys-ppc/Makefile b/arch/um/sys-ppc/Makefile
index af20026..a9814a7 100644
--- a/arch/um/sys-ppc/Makefile
+++ b/arch/um/sys-ppc/Makefile
@@ -1,7 +1,7 @@
 OBJ = built-in.o
 
 .S.o:
-	$(CC) $(AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
+	$(CC) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
 
 OBJS = ptrace.o sigcontext.o semaphore.o checksum.o miscthings.o misc.o \
 	ptrace_user.o sysrq.o
@@ -57,13 +57,13 @@ ppc_defs.h: mk_defs.c ppc_defs.head \
 checksum.o: checksum.S
 	rm -f asm
 	ln -s $(TOPDIR)/include/asm-ppc asm
-	$(CC) $(EXTRA_AFLAGS) $(AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
+	$(CC) $(EXTRA_AFLAGS) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
 	rm -f asm
 
 misc.o: misc.S ppc_defs.h
 	rm -f asm
 	ln -s $(TOPDIR)/include/asm-ppc asm
-	$(CC) $(EXTRA_AFLAGS) $(AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
+	$(CC) $(EXTRA_AFLAGS) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
 	rm -f asm
 
 clean-files := $(OBJS) ppc_defs.h checksum.S semaphore.c mk_defs.c
diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
index 876a85a..01f76c2 100644
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -58,18 +58,18 @@ cflags-y += -maccumulate-outgoing-args
 
 # do binutils support CFI?
 cflags-y += $(call as-instr,.cfi_startproc\n.cfi_rel_offset rsp${comma}0\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
-AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_rel_offset rsp${comma}0\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
+KBUILD_AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_rel_offset rsp${comma}0\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
 
 # is .cfi_signal_frame supported too?
 cflags-y += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
-AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
+KBUILD_AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
 
 cflags-$(CONFIG_CC_STACKPROTECTOR) += $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh "$(CC)" -fstack-protector )
 cflags-$(CONFIG_CC_STACKPROTECTOR_ALL) += $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh "$(CC)" -fstack-protector-all )
 
 KBUILD_CFLAGS += $(cflags-y)
 CFLAGS_KERNEL += $(cflags-kernel-y)
-AFLAGS += -m64
+KBUILD_AFLAGS += -m64
 
 head-y := arch/x86_64/kernel/head.o arch/x86_64/kernel/head64.o arch/x86_64/kernel/init_task.o
 
diff --git a/arch/x86_64/boot/compressed/Makefile b/arch/x86_64/boot/compressed/Makefile
index d89eda7..d2fa8d0 100644
--- a/arch/x86_64/boot/compressed/Makefile
+++ b/arch/x86_64/boot/compressed/Makefile
@@ -10,7 +10,7 @@ KBUILD_CFLAGS := -m64 -D__KERNEL__ $(LINUXINCLUDE) -O2  \
 	  -fno-strict-aliasing -fPIC -mcmodel=small \
 	   $(call cc-option, -ffreestanding) \
 	   $(call cc-option, -fno-stack-protector)
-AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
+KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 LDFLAGS := -m elf_x86_64
 
 LDFLAGS_vmlinux := -T
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index 217c82d..7dfb5b7 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -14,7 +14,7 @@ HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
 BIG_ENDIAN	:= $(shell echo -e __XTENSA_EB__ | $(CC) -E - | grep -v "\#")
 
 export KBUILD_CFLAGS
-export AFLAGS
+export KBUILD_AFLAGS
 export BIG_ENDIAN
 
 subdir-y	:= lib
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index b1a7c7d..de7bb28 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -81,7 +81,7 @@ as-option = $(call try-run,\
 # Usage: cflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
-	echo -e "$(1)" | $(CC) $(AFLAGS) -c -xassembler -o "$$TMP" -,$(2),$(3))
+	echo -e "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -xassembler -o "$$TMP" -,$(2),$(3))
 
 # cc-option
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 37de2a9..b13d14e 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -87,7 +87,7 @@ modname_flags  = $(if $(filter 1,$(words $(modname))),\
                  -D"KBUILD_MODNAME=KBUILD_STR($(call name-fix,$(modname)))")
 
 _c_flags       = $(KBUILD_CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(basetarget).o)
-_a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
+_a_flags       = $(KBUILD_AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
 _cpp_flags     = $(CPPFLAGS) $(EXTRA_CPPFLAGS) $(CPPFLAGS_$(@F))
 
 # If building the kernel in a separate objtree expand all occurrences
-- 
1.5.1.rc3.2928.g8e573-dirty

