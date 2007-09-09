Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:59641 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932100AbXIISFs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 9 Sep 2007 14:05:48 -0400
Date: Sun, 9 Sep 2007 20:07:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 4/4] kbuild: enable 'make CPPFLAGS=...' to add additional options to CPP
Message-ID: <20070909180711.GE20086@uranus.ravnborg.org>
References: <20070909180254.GA20086@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070909180254.GA20086@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: linux arch <linux-arch@vger.kernel.org>, Andi Kleen <ak@suse.de>, kbuild devel <kbuild-devel@lists.sourceforge.net>, Tony Luck <tony.luck@intel.com>
List-ID: <linux-arch.vger.kernel.org>

The variable CPPFLAGS is a wellknown variable and the usage by
kbuild may result in unexpected behaviour.

This patch replace use of CPPFLAGS with KBUILD_AFLAGS all over the
tree and enabling one to use:
make CPPFLAGS=...
to specify additional CPP commandline options.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/kbuild/makefiles.txt |    2 +-
 Makefile                           |   13 +++++++------
 arch/arm/Makefile                  |    4 ++--
 arch/ia64/Makefile                 |    2 +-
 arch/powerpc/Makefile              |    2 +-
 arch/ppc/Makefile                  |    2 +-
 arch/um/Makefile-x86_64            |    2 +-
 drivers/atm/Makefile               |    2 +-
 scripts/Makefile.lib               |    6 +++---
 9 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 15b3c11..29d070f 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1100,7 +1100,7 @@ When kbuild executes, the following steps are followed (roughly):
 	specified options when building the target vmlinux.lds.
 
 	When building the *.lds target, kbuild uses the variables:
-	CPPFLAGS	: Set in top-level Makefile
+	KBUILD_CPPFLAGS	: Set in top-level Makefile
 	EXTRA_CPPFLAGS	: May be set in the kbuild makefile
 	CPPFLAGS_$(@F)  : Target specific flags.
 	                  Note that the full filename is used in this
diff --git a/Makefile b/Makefile
index 5b2dbdd..771ecd8 100644
--- a/Makefile
+++ b/Makefile
@@ -310,7 +310,7 @@ LINUXINCLUDE    := -Iinclude \
                    $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
 		   -include include/linux/autoconf.h
 
-CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
+KBUILD_CPPFLAGS := -D__KERNEL__ $(LINUXINCLUDE)
 
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
@@ -326,7 +326,7 @@ export ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
-export CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
+export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 
@@ -514,9 +514,10 @@ KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
 # disable pointer signed / unsigned warnings in gcc 4.0
 KBUILD_CFLAGS += $(call cc-option,-Wno-pointer-sign,)
 
-# Add user supplied AFLAGS and CFLAGS as the last assignments
-KBUILD_AFLAGS += $(AFLAGS)
-KBUILD_CFLAGS += $(CFLAGS)
+# Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
+KBUILD_CPPFLAGS += $(CPPFLAGS)
+KBUILD_AFLAGS   += $(AFLAGS)
+KBUILD_CFLAGS   += $(CFLAGS)
 
 # Use --build-id when available.
 LDFLAGS_BUILD_ID = $(patsubst -Wl$(comma)%,%,\
@@ -1492,7 +1493,7 @@ quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files))
 
 
 a_flags = -Wp,-MD,$(depfile) $(KBUILD_AFLAGS) $(AFLAGS_KERNEL) \
-	  $(NOSTDINC_FLAGS) $(CPPFLAGS) \
+	  $(NOSTDINC_FLAGS) $(KBUILD_CPPFLAGS) \
 	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
 
 quiet_cmd_as_o_S = AS      $@
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e7eab5b..b315899 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -32,11 +32,11 @@ KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
 endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
-CPPFLAGS	+= -mbig-endian
+KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
 LD		+= -EB
 else
-CPPFLAGS	+= -mlittle-endian
+KBUILD_CPPFLAGS	+= -mlittle-endian
 AS		+= -EL
 LD		+= -EL
 endif
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 9708a29..34951aa 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -29,7 +29,7 @@ cflags-y	:= -pipe $(EXTRA) -ffixed-r13 -mfixed-range=f12-f15,f32-f127 \
 CFLAGS_KERNEL	:= -mconstant-gp
 
 GAS_STATUS	= $(shell $(srctree)/arch/ia64/scripts/check-gas "$(CC)" "$(OBJDUMP)")
-CPPFLAGS += $(shell $(srctree)/arch/ia64/scripts/toolchain-flags "$(CC)" "$(OBJDUMP)" "$(READELF)")
+KBUILD_CPPFLAGS += $(shell $(srctree)/arch/ia64/scripts/toolchain-flags "$(CC)" "$(OBJDUMP)" "$(READELF)")
 
 ifeq ($(GAS_STATUS),buggy)
 $(error Sorry, you need a newer version of the assember, one that is built from	\
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 02fbeb1..8138ac2 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -68,7 +68,7 @@ CPPFLAGS-$(CONFIG_PPC32) := -Iarch/$(ARCH) -Iarch/$(ARCH)/include
 AFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH) -ffixed-r2 -mmultiple
-CPPFLAGS	+= $(CPPFLAGS-y)
+KBUILD_CPPFLAGS	+= $(CPPFLAGS-y)
 KBUILD_AFLAGS	+= $(AFLAGS-y)
 KBUILD_CFLAGS	+= -msoft-float -pipe $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index bfe9993..3a743dc 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -22,7 +22,7 @@ endif
 
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 # The -Iarch/$(ARCH)/include is temporary while we are merging
-CPPFLAGS	+= -Iarch/$(ARCH) -Iarch/$(ARCH)/include
+KBUILD_CPPFLAGS	+= -Iarch/$(ARCH) -Iarch/$(ARCH)/include
 KBUILD_AFLAGS	+= -Iarch/$(ARCH)
 KBUILD_CFLAGS	+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -mmultiple
diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 8836f0d..bcfd6ea 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -14,7 +14,7 @@ KBUILD_CFLAGS += $(_extra_flags_)
 CHECKFLAGS  += -m64
 KBUILD_AFLAGS += -m64
 LDFLAGS += -m elf_x86_64
-CPPFLAGS += -m64
+KBUILD_CPPFLAGS += -m64
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
diff --git a/drivers/atm/Makefile b/drivers/atm/Makefile
index 1b16f81..e4fa996 100644
--- a/drivers/atm/Makefile
+++ b/drivers/atm/Makefile
@@ -41,7 +41,7 @@ ifeq ($(CONFIG_ATM_FORE200E_PCA),y)
   # guess the target endianess to choose the right PCA-200E firmware image
   ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
     byteorder.h			:= include$(if $(patsubst $(srctree),,$(objtree)),2)/asm/byteorder.h
-    CONFIG_ATM_FORE200E_PCA_FW	:= $(obj)/pca200e$(if $(shell $(CC) $(CPPFLAGS) -E -dM $(byteorder.h) | grep ' __LITTLE_ENDIAN '),.bin,_ecd.bin2)
+    CONFIG_ATM_FORE200E_PCA_FW	:= $(obj)/pca200e$(if $(shell $(CC) $(KBUILD_CPPFLAGS) -E -dM $(byteorder.h) | grep ' __LITTLE_ENDIAN '),.bin,_ecd.bin2)
   endif
 endif
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b13d14e..f57c829 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -88,7 +88,7 @@ modname_flags  = $(if $(filter 1,$(words $(modname))),\
 
 _c_flags       = $(KBUILD_CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(basetarget).o)
 _a_flags       = $(KBUILD_AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
-_cpp_flags     = $(CPPFLAGS) $(EXTRA_CPPFLAGS) $(CPPFLAGS_$(@F))
+_cpp_flags     = $(KBUILD_CPPFLAGS) $(EXTRA_CPPFLAGS) $(CPPFLAGS_$(@F))
 
 # If building the kernel in a separate objtree expand all occurrences
 # of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
@@ -108,11 +108,11 @@ __a_flags	=                          $(call flags,_a_flags)
 __cpp_flags     =                          $(call flags,_cpp_flags)
 endif
 
-c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
+c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(KBUILD_CPPFLAGS) \
 		 $(__c_flags) $(modkern_cflags) \
 		 -D"KBUILD_STR(s)=\#s" $(basename_flags) $(modname_flags)
 
-a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
+a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(KBUILD_CPPFLAGS) \
 		 $(__a_flags) $(modkern_aflags)
 
 cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(__cpp_flags)
-- 
1.5.1.rc3.2928.g8e573-dirty

