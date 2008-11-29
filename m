From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Sat, 29 Nov 2008 22:24:49 +0900
Message-ID: <20081129222449.e341f028.h.mitake@gmail.com>
References: <200811290056.mAT0uTuk028924@terminus.zytor.com>
	<20081129164736.0b5a71db.h.mitake@gmail.com>
	<20081129093858.GC26691@elte.hu>
	<20081129192610.716a2d57.h.mitake@gmail.com>
	<20081129105229.GA9643@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:65358 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbYK2NY4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Nov 2008 08:24:56 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1225526tic.23
        for <linux-arch@vger.kernel.org>; Sat, 29 Nov 2008 05:24:54 -0800 (PST)
In-Reply-To: <20081129105229.GA9643@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Luck, Tony" <tony.luck@intel.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, 29 Nov 2008 11:52:29 +0100
Sam Ravnborg <sam@ravnborg.org> wrote:

> > 
> > But this is old way. ARCH_HAS_READQ and ARCH_HAS_WRITEQ are new ways
> > to determine existence of readq/writeq. Drivers which use readq/writeq should
> > depend on these values in their Kconfig file.
> 
> If we look at arch/x86/Kconfig we see:
> ### Arch settings
> config X86
>         def_bool y
>         select HAVE_AOUT if X86_32
>         select HAVE_UNSTABLE_SCHED_CLOCK
>         select HAVE_IDE
>         select HAVE_OPROFILE
>         select HAVE_IOREMAP_PROT
>         select HAVE_KPROBES
>         select ARCH_WANT_OPTIONAL_GPIOLIB
> 	...
> 
> So the normal syntax here is "HAVE_XXX_XXX" - not ARCH_HAS_XXX_XXX
> 
> If you update your patch please use this syntax,
> and locate the select under X86 - not under the 32/64 entries.

Thanks for your notification. I didn't notice that syntax rule.

> 
> But I do not see why adding these in the first place.
> 

Andrew Morton told that drivers which need readq/writeq should use ones of kernel,
and if architecture part of kernel does not provide readq/writeq, drivers should be disabled.

This is Andrew's mail:
http://marc.info/?l=linux-kernel&m=122625885124798&w=2
===> Quote:

#ifdef readq

Is a suitable way of determining whether the architecture implements
readq and writeq.  It isn't pretty, but it will suffice.

A problem with it is that drivers will then do

#ifndef readq
<provide a local implementation here>
#endif

which rather sucks - we don't want lots of little private readq/writeq
implementations all over the tree.

Perhaps it would be better to have a CONFIG_ARCH_HAS_READQ and to then
disable these drivers on the architectures which don't provide
readq/writeq support.

<====

This is new patch.

description of this patch
Adding implementation of readq/writeq to x86_32,
and adding config value to x86 architecture to determine existence of readq/writeq

Signed-off-by: Hitoshi Mitake <h.mitake@gmail.com>
---
 arch/x86/Kconfig          |    2 ++
 arch/x86/include/asm/io.h |   24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ac22bb7..75408fe 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -34,6 +34,8 @@ config X86
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_GENERIC_DMA_COHERENT if X86_32
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_READQ
+	select HAVE_WRITEQ
 
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ac2abc8..ddc67aa 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -4,6 +4,7 @@
 #define ARCH_HAS_IOREMAP_WC
 
 #include <linux/compiler.h>
+#include <asm-generic/int-ll64.h>
 
 #define build_mmio_read(name, size, type, reg, barrier) \
 static inline type name(const volatile void __iomem *addr) \
@@ -57,6 +58,29 @@ build_mmio_write(__writeq, "q", unsigned long, "r", )
 /* Let people know we have them */
 #define readq readq
 #define writeq writeq
+
+#else  /* CONFIG_X86_32 from here */
+
+static inline __u64 readq(const volatile void __iomem *addr)
+{
+	const volatile u32 __iomem *p = addr;
+	u32 l, h;
+
+	l = readl(p);
+	h = readl(p+1);
+
+	return l + ((u64)h << 32);
+}
+
+static inline void writeq(__u64 val, volatile void __iomem *addr)
+{
+	writel(val, addr);
+	writel(val >> 32, addr+4);
+}
+
+#define readq readq
+#define writeq writeq
+
 #endif
 
 extern int iommu_bio_merge;
-- 
1.5.6.5
