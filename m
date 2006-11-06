Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:13457 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1753372AbWKFQco (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Nov 2006 11:32:44 -0500
Date: Mon, 6 Nov 2006 09:32:43 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Which architectures need 64-bit resources?
Message-ID: <20061106163243.GN27140@parisc-linux.org>
References: <20061106122337.GK27140@parisc-linux.org> <20061106160206.GA10447@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106160206.GA10447@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Nov 06, 2006 at 04:02:06PM +0000, Ralf Baechle wrote:
> On Mon, Nov 06, 2006 at 05:23:37AM -0700, Matthew Wilcox wrote:
> 
> > +       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && (ARM || X86 || MIPS || PPC) && EXPERIMENTAL)
> 
> For MIPS at least it would be needed for a few platforms only, so I'd
> like to do "select RESOURCES_64BIT" as suitable for a platform. in the
> big machine selection menu in arch/mips/Kconfig.

I don't see why you shouldn't do that anyway ... seems like ARM wants to
do the same thing.  In fact, I'd go so far as to say this isn't an option
that users should ever be asked.  You can tell by the help text for it:

	help
	  This option allows memory and IO resources to be 64 bit.

How ... helpful.

Here's a proposed patch (which needs buy-in from the ARM, MIPS and
PowerPC guys, plus anyone who knows about x86-32 machines with 64-bit
IO).  Grepping the arch/*/configs/* doesn't show anyone else using it by
default.

I got the info for ARM from Vince Sanders, and made my best guess for
MIPS & PPC.  This patch is entirely untested.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index adb05de..d73cf59 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -241,6 +241,7 @@ config ARCH_IXP23XX
  	bool "IXP23XX-based"
 	depends on MMU
  	select PCI
+	select RESOURCES_64BIT
 	help
 	  Support for Intel's IXP23xx (XScale) family of processors.
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8a49884..f0205e0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1556,6 +1556,7 @@ config SB1_PASS_2_1_WORKAROUNDS
 config 64BIT_PHYS_ADDR
 	bool "Support for 64-bit physical address space"
 	depends on (CPU_R4X00 || CPU_R5000 || CPU_RM7000 || CPU_RM9000 || CPU_R10000 || CPU_SB1 || CPU_MIPS32 || CPU_MIPS64) && 32BIT
+	select RESOURCES_64BIT
 
 config CPU_HAS_LLSC
 	bool
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8b69104..29ab1e0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -227,10 +227,11 @@ config PTE_64BIT
 config PHYS_64BIT
 	bool 'Large physical address support' if E500
 	depends on 44x || E500
+	select RESOURCES_64BIT
 	default y if 44x
 	---help---
 	  This option enables kernel support for larger than 32-bit physical
-	  addresses.  This features is not be available on all e500 cores.
+	  addresses.  This features is not available on all e500 cores.
 
 	  If in doubt, say N here.
 
diff --git a/lib/Kconfig b/lib/Kconfig
index 734ce95..613942d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -92,9 +92,14 @@ config TEXTSEARCH_FSM
 	tristate
 
 #
-# plist support is select#ed if needed
+# plist support is selected if needed
 #
 config PLIST
 	boolean
 
+# 64-bit resources are selected by individual architectures
+config RESOURCES_64BIT
+	bool
+	default 64BIT
+
 endmenu
diff --git a/mm/Kconfig b/mm/Kconfig
index db7c55d..089513f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -151,9 +151,3 @@ config MIGRATION
 	  while the virtual addresses are not changed. This is useful for
 	  example on NUMA systems to put pages nearer to the processors accessing
 	  the page.
-
-config RESOURCES_64BIT
-	bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && EXPERIMENTAL)
-	default 64BIT
-	help
-	  This option allows memory and IO resources to be 64 bit.
