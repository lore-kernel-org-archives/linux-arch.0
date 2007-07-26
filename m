Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:42221 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758876AbXGZNUJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jul 2007 09:20:09 -0400
Date: Thu, 26 Jul 2007 07:20:08 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Remove SBUS/MCA/EISA/etc from architectures that don't have them
Message-ID: <20070726132008.GC19275@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


This seems like something left over from the migration to Kconfig.
It's kind of confusing when you grep for SBUS and find out that umpteen
different architectures think they need to mention it ;-)  While I was
killing off SBUS, I thought I might as well get rid of MCA and EISA
while I was at it.

This should probably go in through each arch maintainers tree.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8501631..a811b75 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -41,32 +41,6 @@ config NO_IOPORT
 	bool
 	default n
 
-config EISA
-	bool
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
-config SBUS
-	bool
-
-config MCA
-	bool
-	help
-	  MicroChannel Architecture is found in some IBM PS/2 machines and
-	  laptops.  It is a bus system similar to PCI or ISA. See
-	  <file:Documentation/mca.txt> (and especially the web page given
-	  there) before attempting to build an MCA bus kernel.
-
 config GENERIC_HARDIRQS
 	bool
 	default y
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index abb582b..259dfc3 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -63,9 +63,6 @@ config QUICKLIST
 	bool
 	default y
 
-config SBUS
-	bool
-
 config GENERIC_ISA_DMA
 	bool
 	default y
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 8ccf3e4..83cb709 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -9,9 +9,6 @@ config M32R
 	bool
 	default y
 
-config SBUS
-	bool
-
 config GENERIC_ISA_DMA
 	bool
 	default y
@@ -322,7 +319,7 @@ config BOOT_IOREMAP
 endmenu
 
 
-menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
+menu "Bus options (PCI, PCMCIA, ISA)"
 
 config PCI
 	bool "PCI support"
@@ -331,8 +328,7 @@ config PCI
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
-	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
-	  VESA. If you have PCI, say Y, otherwise N.
+	  your box. If you have PCI, say Y, otherwise N.
 
 	  The PCI-HOWTO, available from
 	  <http://www.linuxdoc.org/docs.html#howto>, contains valuable
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 20a9c08..c6ecfe6 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -58,29 +58,6 @@ source "init/Kconfig"
 
 menu "Platform dependent setup"
 
-config EISA
-	bool
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
-config MCA
-	bool
-	help
-	  MicroChannel Architecture is found in some IBM PS/2 machines and
-	  laptops.  It is a bus system similar to PCI or ISA. See
-	  <file:Documentation/mca.txt> (and especially the web page given
-	  there) before attempting to build an MCA bus kernel.
-
 config PCMCIA
 	tristate
 	---help---
diff --git a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
index 185906b..5e472f6 100644
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -656,7 +656,7 @@ config ISA_DMA_API
 	depends on !M5272
 	default y
 
-menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
+menu "Bus options (PCI, PCMCIA, ISA)"
 
 config PCI
 	bool "PCI support"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 00099ef..4b63407 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -411,12 +411,6 @@ config PPC_INDIRECT_PCI
 	default y if 40x || 44x
 	default n
 
-config EISA
-	bool
-
-config SBUS
-	bool
-
 config FSL_SOC
 	bool
 
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 6bdeeb7..50294c8 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1212,15 +1212,6 @@ config PPC_INDIRECT_PCI
 	default y if 40x || 44x || 85xx || 83xx || PPC_PREP
 	default n
 
-config EISA
-	bool
-	help
-	  The Extended Industry Standard Architecture (EISA) bus is a bus
-	  architecture used on some older intel-based PCs.
-
-config SBUS
-	bool
-
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f87f429..d8e0014 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -638,36 +638,9 @@ config ISA
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
 	  name of a bus system, i.e. the way the CPU talks to the other stuff
-	  inside your box.  Other bus systems are PCI, EISA, MicroChannel
-	  (MCA) or VESA.  ISA is an older system, now being displaced by PCI;
+	  inside your box.  ISA is an older system, now being displaced by PCI;
 	  newer boards don't support it.  If you have ISA, say Y, otherwise N.
 
-config EISA
-	bool
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
-config MCA
-	bool
-	help
-	  MicroChannel Architecture is found in some IBM PS/2 machines and
-	  laptops.  It is a bus system similar to PCI or ISA. See
-	  <file:Documentation/mca.txt> (and especially the web page given
-	  there) before attempting to build an MCA bus kernel.
-
-config SBUS
-	bool
-
 config SUPERHYWAY
 	tristate "SuperHyway Bus support"
 	depends on CPU_SUBTYPE_SH4_202
diff --git a/arch/sh64/Kconfig b/arch/sh64/Kconfig
index ff65420..d9009e9 100644
--- a/arch/sh64/Kconfig
+++ b/arch/sh64/Kconfig
@@ -229,21 +229,14 @@ source "mm/Kconfig"
 
 endmenu
 
-menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
-
-config ISA
-	bool
-
-config SBUS
-	bool
+menu "Bus options (PCI, PCMCIA)"
 
 config PCI
 	bool "PCI support"
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
-	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
-	  VESA. If you have PCI, say Y, otherwise N.
+	  your box. If you have PCI, say Y, otherwise N.
 
 	  The PCI-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>, contains valuable
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index e6ff302..78931fd 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -21,18 +21,6 @@ config NO_IOMEM
 
 mainmenu "Linux/Usermode Kernel Configuration"
 
-config ISA
-	bool
-
-config SBUS
-	bool
-
-config PCI
-	bool
-
-config PCMCIA
-	bool
-
 # Yet to do!
 config TRACE_IRQFLAGS_SUPPORT
 	bool
diff --git a/arch/v850/Kconfig b/arch/v850/Kconfig
index ace479a..126b093 100644
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -53,21 +53,6 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default n
 
-# Turn off some random 386 crap that can affect device config
-config ISA
-	bool
-	default n
-config ISAPNP
-	bool
-	default n
-config EISA
-	bool
-	default n
-config MCA
-	bool
-	default n
-
-
 #############################################################################
 #### v850-specific config
 
@@ -251,7 +236,7 @@ source init/Kconfig
 
 #############################################################################
 
-menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
+menu "Bus options (PCI, PCMCIA)"
 
 #    config PCI
 # 	   bool "PCI support"
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 45f82ae..5992f1f 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -68,12 +68,6 @@ config NR_QUICK
 	int
 	default 2
 
-config ISA
-	bool
-
-config SBUS
-	bool
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
@@ -269,12 +263,6 @@ config X86_HT
 config MATH_EMULATION
 	bool
 
-config MCA
-	bool
-
-config EISA
-	bool
-
 config X86_IO_APIC
 	bool
 	default y
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 7fbb44b..0958fd4 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -171,8 +171,7 @@ config PCI
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
-	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
-	  VESA. If you have PCI, say Y, otherwise N.
+	  your box. If you have PCI, say Y, otherwise N.
 
 	  The PCI-HOWTO, available from
 	  <http://www.linuxdoc.org/docs.html#howto>, contains valuable

-- 
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
