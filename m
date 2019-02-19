Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfBSLgU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 06:36:20 -0500
Date: Tue, 19 Feb 2019 11:36:09 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190219113609.GC4027@fuggles.cambridge.arm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
 <20190218162954.GB16713@fuggles.cambridge.arm.com>
 <CAK8P3a1TY9S=zYsdZ5O021p2yYcZhehVuwB3_65dR6x6zbkTYQ@mail.gmail.com>
 <20190218175625.GD16713@fuggles.cambridge.arm.com>
 <CAK8P3a2mjjr94hwj_eXxfyKDKDuA=MogXW7xJygh-X0Hqgf6rg@mail.gmail.com>
 <20190219112747.7db95e58@windsurf.home>
 <CAK8P3a3n2meqogz7MeMUA48LBOEV9_AYQPxU3+V8A=Fn_63v4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3n2meqogz7MeMUA48LBOEV9_AYQPxU3+V8A=Fn_63v4A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Russell King - ARM Linux <linux@armlinux.org.uk>
Message-ID: <20190219113609.isjqGQJtPTbkGJL6oBKMvlK5Pp4J-lQUztX8pJaOBIA@z>

On Tue, Feb 19, 2019 at 12:31:50PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 19, 2019 at 11:27 AM Thomas Petazzoni
> <thomas.petazzoni@bootlin.com> wrote:
> > On Mon, 18 Feb 2019 21:37:25 +0100
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > Ah, it seems we actually do that on 32-bit ARM, at least on one platform,
> > > see 6a02734d420f ("ARM: mvebu: map PCI I/O regions strongly ordered")
> > > and prior commits.
> >
> > Yes, some Marvell Armada 32-bit platforms have an errata that require
> > the PCI MEM and PCI I/O regions to be mapped strongly ordered.
> >
> > BTW, this requirement prevents us from using the pci_remap_iospace()
> > API from drivers/pci, because it assumes page attributes of
> > pgprot_device(PAGE_KERNEL). That's why we're still using the
> > ARM-specific pci_ioremap_io() function.
> 
> Ok.
> 
> > > > I would still prefer to document the weaker semantics as the portable
> > > > interface, unless there are portable drivers relying on this today (which
> > > > would imply that it's widely supported by other architectures).
> > >
> > > I don't know of any portable driver that actually relies on it, but
> > > that's mainly because there are very few portable drivers that
> > > use inb()/outb() in the first place. How many of those require
> > > the non-posted behavior I don't know
> > >
> > > Adding Thomas, Gregory and Russell to Cc, as they were involved
> > > in the discussion that led to the 32-bit change, maybe they are
> > > aware of a specific example.
> >
> > I'm just arriving in the middle of this thread, and I'm not sure to
> > understand what is the question. If the question is whether PCI I/O is
> > really used in practice, then I've never seen it be used with Marvell
> > platforms (but I'm also not aware of all PCIe devices people are
> > using). I personally have a hacked-up version of the e1000e driver
> > that intentionally does some PCI I/O accesses, that I use as a way to
> > validate that PCI I/O support is minimally working, but that's it.
> 
> The main question is whether we know of a portable (not specific
> to a single architecture) driver for PCIe (or PCI, but probably not ISA)
> that uses outb/outw/outl in a way that relies on the on-posted
> behavior of those, compared to posted writeb/writew/writel that are
> only required to complete before another I/O operation on the same
> device but whose completion is not ordered with regard to the rest of
> the system.
> 
> I think an example of this would be a driver using outb() to disable
> an interrupt, and then relying on the the interrupt no longer happening
> after the outb().

Isn't that racy already? i.e. the interrupt could fire just before you
disabled it, but not get delivered by the irq controller until after you'd
disabled it at the device?

Will
