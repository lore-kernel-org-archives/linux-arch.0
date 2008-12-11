From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 01/19] add HAVE_ARCH_INIT_TASK
Date: Thu, 11 Dec 2008 03:52:39 +0000
Message-ID: <5b8db15f02f2016c2c89df205920f082360f0b7f.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
 <cover.1228966585.git.kyle@mcmartin.ca>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57634 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbYLKDxR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 22:53:17 -0500
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
References: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, Kyle McMartin <kyle@redhat.com>

Since some architectures faff about with init_task.c (*cough ia64 cough*)
for various reasons, we may not be able to entirely convert most architectures.
To ensure bisect-ability, this is an omnibus commit declaring a new config
option which all architectures will select to begin with, selecting the
status quo of arch/$a/kernel/init_task.c (or whatever.)

Once the maintainers apply a patch removing their init_task.c, the
option will be removed, and a generic kernel/init_task.c will be used.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 arch/Kconfig           |    9 +++++++++
 arch/alpha/Kconfig     |    1 +
 arch/arm/Kconfig       |    1 +
 arch/avr32/Kconfig     |    1 +
 arch/blackfin/Kconfig  |    1 +
 arch/cris/Kconfig      |    1 +
 arch/frv/Kconfig       |    1 +
 arch/h8300/Kconfig     |    1 +
 arch/ia64/Kconfig      |    1 +
 arch/m32r/Kconfig      |    1 +
 arch/m68k/Kconfig      |    1 +
 arch/m68knommu/Kconfig |    1 +
 arch/mips/Kconfig      |    1 +
 arch/mn10300/Kconfig   |    1 +
 arch/parisc/Kconfig    |    1 +
 arch/powerpc/Kconfig   |    1 +
 arch/s390/Kconfig      |    1 +
 arch/sh/Kconfig        |    1 +
 arch/sparc/Kconfig     |    1 +
 arch/sparc64/Kconfig   |    1 +
 arch/x86/Kconfig       |    1 +
 arch/xtensa/Kconfig    |    1 +
 22 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 471e72d..b0a7a30 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -89,6 +89,15 @@ config HAVE_KRETPROBES
 config HAVE_ARCH_TRACEHOOK
 	bool
 
+config HAVE_ARCH_INIT_TASK
+	bool
+	help
+	  Select this option from your arch Kconfig if your architecture
+	  provides its own init_task.c primitives. If your architecture
+	  has been converted to use the generic kernel/init_task.c, this
+	  option must be unselected. Once all have been converted, this
+	  option will be removed.
+
 config HAVE_DMA_ATTRS
 	bool
 
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 6110197..5752c74 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -8,6 +8,7 @@ config ALPHA
 	select HAVE_AOUT
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_ARCH_INIT_TASK
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9722f8b..8f13edb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,6 +18,7 @@ config ARM
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_ARCH_INIT_TASK
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index 26eca87..a69ad8d 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -13,6 +13,7 @@ config AVR32
 	select HAVE_CLK
 	select HAVE_OPROFILE
 	select HAVE_KPROBES
+	select HAVE_ARCH_INIT_TASK
 	help
 	  AVR32 is a high-performance 32-bit RISC microprocessor core,
 	  designed for cost-sensitive embedded applications, with particular
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index 29e71ed..e25d145 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -26,6 +26,7 @@ config BLACKFIN
 	default y
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_ARCH_INIT_TASK
 
 config ZONE_DMA
 	bool
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index b17aeea..5be6884 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -55,6 +55,7 @@ config CRIS
 	bool
 	default y
 	select HAVE_IDE
+	select HAVE_ARCH_INIT_TASK
 
 config HZ
 	int
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 9d1552a..f251d82 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -6,6 +6,7 @@ config FRV
 	bool
 	default y
 	select HAVE_IDE
+	select HAVE_ARCH_INIT_TASK
 
 config ZONE_DMA
 	bool
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 28f06fd..6ec26b4 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -9,6 +9,7 @@ config H8300
 	bool
 	default y
 	select HAVE_IDE
+	select HAVE_ARCH_INIT_TASK
 
 config MMU
 	bool
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 6bd91ed..9c66997 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -24,6 +24,7 @@ config IA64
 	select HAVE_DMA_ATTRS
 	select HAVE_KVM
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_INIT_TASK
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index dbaed4a..2b1aa23 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -10,6 +10,7 @@ config M32R
 	default y
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_ARCH_INIT_TASK
 
 config SBUS
 	bool
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 836fb66..acb1917 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -7,6 +7,7 @@ config M68K
 	default y
 	select HAVE_AOUT
 	select HAVE_IDE
+	select HAVE_ARCH_INIT_TASK
 
 config MMU
 	bool
diff --git a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
index 76b66fe..4019e0b 100644
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -9,6 +9,7 @@ config M68K
 	bool
 	default y
 	select HAVE_IDE
+	select HAVE_ARCH_INIT_TASK
 
 config MMU
 	bool
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f4af967..0d15668 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -7,6 +7,7 @@ config MIPS
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
 	select RTC_LIB
+	select HAVE_ARCH_INIT_TASK
 
 mainmenu "Linux/MIPS Kernel Configuration"
 
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index 9a9f433..7cb6f51 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -7,6 +7,7 @@ mainmenu "Linux Kernel Configuration"
 
 config MN10300
 	def_bool y
+	select HAVE_ARCH_INIT_TASK
 
 config AM33
 	def_bool y
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 644a70b..fe0a9d3 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -11,6 +11,7 @@ config PARISC
 	select HAVE_OPROFILE
 	select RTC_CLASS
 	select RTC_DRV_PARISC
+	select HAVE_ARCH_INIT_TASK
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
 	  in many of their workstations & servers (HP9000 700 and 800 series,
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 525c13a..9f1db45 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -121,6 +121,7 @@ config PPC
 	select HAVE_DMA_ATTRS if PPC64
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_OPROFILE
+	select HAVE_ARCH_INIT_TASK
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8116a33..4381302 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -75,6 +75,7 @@ config S390
 	select HAVE_KRETPROBES
 	select HAVE_KVM if 64BIT
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_INIT_TASK
 
 source "init/Kconfig"
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 80119b3..0ac7852 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -13,6 +13,7 @@ config SUPERH
 	select HAVE_OPROFILE
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IOREMAP_PROT if MMU
+	select HAVE_ARCH_INIT_TASK
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e594559..f2e9d53 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -79,6 +79,7 @@ config SPARC
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select RTC_CLASS
 	select RTC_DRV_M48T59
+	select HAVE_ARCH_INIT_TASK
 
 # Identify this as a Sparc32 build
 config SPARC32
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 3b96e70..96fedcb 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -24,6 +24,7 @@ config SPARC64
 	select RTC_DRV_BQ4802
 	select RTC_DRV_SUN4V
 	select RTC_DRV_STARFIRE
+	select HAVE_ARCH_INIT_TASK
 
 config GENERIC_TIME
 	bool
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ac22bb7..5b913d4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -34,6 +34,7 @@ config X86
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_GENERIC_DMA_COHERENT if X86_32
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_ARCH_INIT_TASK
 
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 6c873dc..da236cf 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -15,6 +15,7 @@ config XTENSA
 	bool
 	default y
 	select HAVE_IDE
+	select HAVE_ARCH_INIT_TASK
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
 	  primarily for embedded systems.  These processors are both
-- 
1.6.0.4
