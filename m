From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Fri, 29 Jan 2016 00:07:21 +0100
Message-ID: <7619136.niuXthzi6R@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <20160128031435.GA25625@wfg-t540p.sh.intel.com> <20160128174241.GN10826@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:50075 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbcA1XID (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jan 2016 18:08:03 -0500
In-Reply-To: <20160128174241.GN10826@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Fengguang Wu <fengguang.wu@intel.com>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, linux-kbuild@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Michal Marek <mmarek@suse.com>, linux-arm-kernel@lists.infradead.org

On Thursday 28 January 2016 17:42:41 you wrote:
> On Thu, Jan 28, 2016 at 11:14:35AM +0800, Fengguang Wu wrote:
> > On Wed, Jan 27, 2016 at 10:44:01AM +0100, Arnd Bergmann wrote:
> > > - CONFIG_PHYS_OFFSET needs to be entered manually to be a number
> > >   in 'make config'
> > 
> > That's a problem for auto tests.
> 
> I'm really against the idea of providing some kind of "default" to it.
> Not providing a default means that people _have_ to do some research
> for their particular system in order to provide a value, and they're
> more likely to get the right value.  Providing a default will lead to
> the assumption that the value is okay, and then we'll end up with
> people complaining that their kernel doesn't boot, and is totally
> silent.
> 
> The only default I'd accept is one based on the rest of the config -
> in other words, re-introducing all the physical address of RAM that
> we used to have in the mach/memory.h files...

This doesn't sound too hard. I've picked the defaults out of the
git history in the patch below. The only tricky part was davinci,
which has two different addresses and requires a little rework
to avoid circular dependencies.

Most platforms these days hardcode ARCH_PATCH_PHS_VIRT anyway,
so we only need to list the bunch of remaining ones.

> There's other ways around these kinds of things, the Kconfig system
> does allow a Kconfig fragment which can be used to pre-set some
> configuration options to particular values - and so which can be used
> to set CONFIG_PHYS_OFFSET prior to an allrandconfig or similar.

I don't know what Fenguang's problem was with that approach, but
at least at the moment he's using a fixup after running randconfig.
In my own tests, I'm doing yet another approach by marking a
handful of symbols as 'depends on BROKEN' in my testing patches,
but clearly that does not work when building other people's trees.

The other related issue is the DEBUG_UART_{VIRT,PHYS} setting,
where there is no safe platform-specific default. I have two
ideas for working around that, maybe one of them sounds ok to
you:

a) find a way to warn and/or disable DEBUG_LL when no address
   is set, rather than failing the build

b) add 'default 0 if COMPILE_TEST' to make it harder to get this
   wrong by accident (hopefully nobody tries to run a COMPILE_TEST
   kernel). Also maybe add a #warning if DEBUG_UART_VIRT is
   outside of VMALLOC_START...PCI_IOBASE area, which would cover
   this case as well.

	Arnd

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2217ec9726c9..1d2b5e6cab14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -273,15 +273,29 @@ config PHYS_OFFSET
 	depends on !ARM_PATCH_PHYS_VIRT
 	default DRAM_BASE if !MMU
 	default 0x00000000 if ARCH_EBSA110 || \
+			ARCH_DOVE || \
 			ARCH_FOOTBRIDGE || \
+			(ARCH_GEMINI && GEMINI_MEM_SWAP) || \
 			ARCH_INTEGRATOR || \
+			ARCH_IOP33X || \
 			ARCH_IOP13XX || \
+			ARCH_IXP4XX || \
 			ARCH_KS8695 || \
-			(ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET)
-	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
+			(ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET) || \
+			ARCH_W90X900
+	default 0x10000000 if (ARCH_GEMINI && !GEMINI_MEM_SWAP) || \
+			ARCH_OMAP1 || \
+			ARCH_RPC
 	default 0x20000000 if ARCH_S5PV210
+	default 0x30000000 if ARCH_S3C24XX
 	default 0x70000000 if REALVIEW_HIGH_PHYS_OFFSET
-	default 0xc0000000 if ARCH_SA1100
+	default 0x80000000 if (ARCH_DAVINCI_DMx && !ARCH_DAVINCI_DA8XX) || \
+			ARCH_NETX || \
+			ARCH_LPC32XX
+	default 0xa0000000 if ARCH_IOP32X || ARCH_PXA
+	default 0xc0000000 if (ARCH_DAVINCI_DA8XX && !ARCH_DAVINCI_DMx) || \
+			ARCH_CLPS711X || \
+			ARCH_SA1100
 	help
 	  Please provide the physical address corresponding to the
 	  location of main memory in your system.
@@ -627,6 +641,7 @@ config ARCH_DAVINCI
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select CPU_ARM926T
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 7a9f2b8c0a42..36c8f5324e43 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -9,7 +9,6 @@ config CP_INTC
 
 config ARCH_DAVINCI_DMx
 	bool
-	select CPU_ARM926T
 
 menu "TI DaVinci Implementations"
 
@@ -32,7 +31,7 @@ config ARCH_DAVINCI_DM646x
 
 config ARCH_DAVINCI_DA830
 	bool "DA830/OMAP-L137/AM17x based system"
-	depends on !ARCH_DAVINCI_DMx || AUTO_ZRELADDR
+	depends on !ARCH_DAVINCI_DMx || (AUTO_ZRELADDR && ARM_PATCH_PHYS_VIRT)
 	select ARCH_DAVINCI_DA8XX
 	# needed on silicon revs 1.0, 1.1:
 	select CPU_DCACHE_WRITETHROUGH if !CPU_DCACHE_DISABLE
@@ -40,13 +39,12 @@ config ARCH_DAVINCI_DA830
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
-	depends on !ARCH_DAVINCI_DMx || AUTO_ZRELADDR
+	depends on !ARCH_DAVINCI_DMx || (AUTO_ZRELADDR && ARM_PATCH_PHYS_VIRT)
 	select ARCH_DAVINCI_DA8XX
 	select CP_INTC
 
 config ARCH_DAVINCI_DA8XX
 	bool
-	select CPU_ARM926T
 
 config ARCH_DAVINCI_DM365
 	bool "DaVinci 365 based system"
