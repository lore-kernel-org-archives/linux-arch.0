From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Fri, 9 Nov 2012 15:06:14 +0000
Message-ID: <201211091506.14940.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <5091513C.9040901@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59644 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab2KIPGS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2012 10:06:18 -0500
In-Reply-To: <5091513C.9040901@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch <linux-arch@vger.kernel.org>

On Wednesday 31 October 2012, James Hogan wrote:
> Apologies. It appears the following two patches were too large and got
> blocked. I'll split them up. In the mean time, here are github links:
> >   metag: Memory management
> 
> https://github.com/jahogan/metag-linux/commit/34c0fe0d6ab61f83a56f9e9d3ea04adddaa7a1d4
> 
pasting my comments here:

>diff --git a/arch/metag/include/asm/io.h b/arch/metag/include/asm/io.h
>new file mode 100644
>index 0000000..d67adb3
>--- /dev/null
>+++ b/arch/metag/include/asm/io.h
>@@ -0,0 +1,96 @@
>+#ifndef _ASM_METAG_IO_H
>+#define _ASM_METAG_IO_H
>+
>+#ifdef __KERNEL__
>+
>+#define IO_SPACE_LIMIT  0xFFFFFFFF

You should make this one 0 if you have no PCI I/O space. If you have it, it
should be the actual size of the window.

>+#define virt_to_bus virt_to_phys
>+#define bus_to_virt phys_to_virt

As mentioned in another patch, I would recommend removing these and defining
ARCH_NO_VIRT_TO_BUS in Kconfig.

>+ * Despite being a 32bit architecture, Meta can do 64bit memory accesses
>+ * (assuming the bus supports it).
>+ */
>+
>+static inline u64 __raw_readq(const volatile void __iomem *addr)
>+{
>+	return *(const volatile u64 __force *) addr;
>+}
>+#define readq(addr) __raw_readq(addr)
>+
>+static inline void __raw_writeq(u64 b, volatile void __iomem *addr)
>+{
>+	*(volatile u64 __force *) addr = b;
>+}
>+#define writeq(b, addr) __raw_writeq(b, addr)

These should be using an inline assembly to guarantee that it gets
turned into an atomic access, at least of the architecture has
an atomic 64-bit load/store from memory operation.

>+/*
>+ * A load of the architecture code uses read/write functions with raw physical
>+ * address numbers rather than __iomem pointers. Until these are fixed, do the
>+ * cast here to hide the warnings.
>+ */
>+
>+#undef readb
>+#undef readw
>+#undef readl
>+#undef readq
>+#define readb(addr)	__raw_readb((volatile void __iomem *)(addr))
>+#define readw(addr)	__raw_readw((volatile void __iomem *)(addr))
>+#define readl(addr)	__raw_readl((volatile void __iomem *)(addr))
>+#define readq(addr)	__raw_readq((volatile void __iomem *)(addr))

No, fix the drivers instead. We finally did the same thing on ARM,
so all common upstream drivers should be clean now. As for atomic accesses,
the same comment as above applies, so use inline assembly here.

You can of course keep an out-of-tree patch that puts the type casts
back here to help migrating any out-of-tree device drivers, just make
sure that whatever you merge upstream does it right.

>diff --git a/arch/metag/mm/mmu-meta1.c b/arch/metag/mm/mmu-meta1.c
>new file mode 100644
>index 0000000..5e1f7d8
>--- /dev/null
>+++ b/arch/metag/mm/mmu-meta1.c
>@@ -0,0 +1,157 @@
>+/*
>+ *  Copyright (C) 2005,2006,2007,2008,2009 Imagination Technologies
>+ *
>+ * Meta 1 MMU handling code.
>+ *
>+ */
>+
>+#include <linux/sched.h>
>+#include <linux/mm.h>
>+#include <linux/io.h>
>+
>+#include <asm/mmu.h>
>+
>+#define DM3_BASE (LINSYSDIRECT_BASE + (MMCU_DIRECTMAPn_ADDR_SCALE * 3))

Again, don't hardcode MMIO addresses like this, but instead get them
from the device tree to make the code more portable to future systems.

	Arnd
