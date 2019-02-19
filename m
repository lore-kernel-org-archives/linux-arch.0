Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfBSLea (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 06:34:30 -0500
Date: Tue, 19 Feb 2019 11:34:24 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190219113424.GB4027@fuggles.cambridge.arm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
 <20190218162954.GB16713@fuggles.cambridge.arm.com>
 <CAK8P3a1TY9S=zYsdZ5O021p2yYcZhehVuwB3_65dR6x6zbkTYQ@mail.gmail.com>
 <20190218175625.GD16713@fuggles.cambridge.arm.com>
 <CAK8P3a2mjjr94hwj_eXxfyKDKDuA=MogXW7xJygh-X0Hqgf6rg@mail.gmail.com>
 <20190219112747.7db95e58@windsurf.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219112747.7db95e58@windsurf.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Russell King - ARM Linux <linux@armlinux.org.uk>
Message-ID: <20190219113424.uAu12M7iXmQNjwyOwqhoAQhjfDV5iRK8X1-jMzAm0QI@z>

Hi Thomas,

On Tue, Feb 19, 2019 at 11:27:47AM +0100, Thomas Petazzoni wrote:
> On Mon, 18 Feb 2019 21:37:25 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > > > I would say we should strengthen the behavior of outX() where possible.
> > > > I don't know if arm64 actually has a way of doing that, my understanding
> > > > earlier was that the AXI bus was already posted, so there is not much
> > > > you can do here to define __io_paw() in a way that will prevent posted
> > > > writes.  
> > >
> > > If we could map I/O space using different page table attributes (probably by
> > > hacking pci_remap_iospace() ?) then we could disable the
> > > early-write-acknowledge hint and implement __io_paw() as a completion
> > > barrier, although it would be at the mercy of the system as to whether or
> > > not that requires a response from the RC.  
> > 
> > Ah, it seems we actually do that on 32-bit ARM, at least on one platform,
> > see 6a02734d420f ("ARM: mvebu: map PCI I/O regions strongly ordered")
> > and prior commits.
> 
> Yes, some Marvell Armada 32-bit platforms have an errata that require
> the PCI MEM and PCI I/O regions to be mapped strongly ordered.
> 
> BTW, this requirement prevents us from using the pci_remap_iospace()
> API from drivers/pci, because it assumes page attributes of
> pgprot_device(PAGE_KERNEL). That's why we're still using the
> ARM-specific pci_ioremap_io() function.

Ah, I think I vaguely remember that. It was to avoid a hardware deadlock,
right? In which case, I'd rather consider this use of strongly-ordered
memory an exceptional case as opposed to a general property of I/O mappings.

> > > I would still prefer to document the weaker semantics as the portable
> > > interface, unless there are portable drivers relying on this today (which
> > > would imply that it's widely supported by other architectures).  
> > 
> > I don't know of any portable driver that actually relies on it, but
> > that's mainly because there are very few portable drivers that
> > use inb()/outb() in the first place. How many of those require
> > the non-posted behavior I don't know
> > 
> > Adding Thomas, Gregory and Russell to Cc, as they were involved
> > in the discussion that led to the 32-bit change, maybe they are
> > aware of a specific example.
> 
> I'm just arriving in the middle of this thread, and I'm not sure to
> understand what is the question. If the question is whether PCI I/O is
> really used in practice, then I've never seen it be used with Marvell
> platforms (but I'm also not aware of all PCIe devices people are
> using). I personally have a hacked-up version of the e1000e driver
> that intentionally does some PCI I/O accesses, that I use as a way to
> validate that PCI I/O support is minimally working, but that's it.

It was actually even more subtle than that! The question is whether outX()
is relied upon to be non-posted in portable drivers, because at the moment
it's typicall posted for arm/arm64 systems, with the exception of the Armada
erratum above.

Cheers,

Will
