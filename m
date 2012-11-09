From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Fri, 9 Nov 2012 15:58:47 +0000
Message-ID: <201211091558.48022.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091506.14940.arnd@arndb.de> <509D1F8C.4040501@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55505 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab2KIP6w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2012 10:58:52 -0500
In-Reply-To: <509D1F8C.4040501@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch <linux-arch@vger.kernel.org>

On Friday 09 November 2012, James Hogan wrote:
> On 09/11/12 15:06, Arnd Bergmann wrote:
> > On Wednesday 31 October 2012, James Hogan wrote:

> >> + * Despite being a 32bit architecture, Meta can do 64bit memory accesses
> >> + * (assuming the bus supports it).
> >> + */
> >> +
> >> +static inline u64 __raw_readq(const volatile void __iomem *addr)
> >> +{
> >> +	return *(const volatile u64 __force *) addr;
> >> +}
> >> +#define readq(addr) __raw_readq(addr)
> >> +
> >> +static inline void __raw_writeq(u64 b, volatile void __iomem *addr)
> >> +{
> >> +	*(volatile u64 __force *) addr = b;
> >> +}
> >> +#define writeq(b, addr) __raw_writeq(b, addr)
> > 
> > These should be using an inline assembly to guarantee that it gets
> > turned into an atomic access, at least of the architecture has
> > an atomic 64-bit load/store from memory operation.
> 
> Is there a particular case you have in mind where the compiler could be
> expected not to generate an atomic memory op (I presume you mean e.g. 2
> 32bit memory ops)? These are implemented the same as asm-generic/io.h
> which only omits these ones because metag is 32bit.
> 
> tbh I don't think the 64 bit accesses are ever actually used, so we
> could probably drop these ones.

There is nothing forcing a compiler to turn a dereferece of a volatile
pointer into a single load or store. We've had issues in the past
where a such an access got turned into a series of byte accesses
when an mmio data structure gets marked as '__packed', but it could
happen in other occasions as well.

> >> +/*
> >> + * A load of the architecture code uses read/write functions with raw physical
> >> + * address numbers rather than __iomem pointers. Until these are fixed, do the
> >> + * cast here to hide the warnings.
> >> + */
> >> +
> >> +#undef readb
> >> +#undef readw
> >> +#undef readl
> >> +#undef readq
> >> +#define readb(addr)	__raw_readb((volatile void __iomem *)(addr))
> >> +#define readw(addr)	__raw_readw((volatile void __iomem *)(addr))
> >> +#define readl(addr)	__raw_readl((volatile void __iomem *)(addr))
> >> +#define readq(addr)	__raw_readq((volatile void __iomem *)(addr))
> > 
> > No, fix the drivers instead. We finally did the same thing on ARM,
> > so all common upstream drivers should be clean now. As for atomic accesses,
> > the same comment as above applies, so use inline assembly here.
> 
> same again, does that mean asm-generic/io.h should never be used?

It's a reasonable default for bringup, but in general I would recommend
overriding these accessors. The rest of asm-generic/io.h is largely ok.

> >> +#define DM3_BASE (LINSYSDIRECT_BASE + (MMCU_DIRECTMAPn_ADDR_SCALE * 3))
> > 
> > Again, don't hardcode MMIO addresses like this, but instead get them
> > from the device tree to make the code more portable to future systems.
> 
> Even if the addresses are part of the core architecture? I guess DT
> could provide the blocks of registers, but it seems like unnecessary
> overhead for something that will never change.

The physical addresses might be part of the architecture, but it
looks like you are hardcoding the virtual address here, which is
the result of an ioremap operation or something similar (I have
not looked at this example). It's probably fine to put it into
fixmap if that provides a real advantage.

	Arnd
