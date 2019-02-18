Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33858 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfBRUhn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 15:37:43 -0500
MIME-Version: 1.0
References: <20190211172948.3322-1-will.deacon@arm.com> <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
 <20190218162954.GB16713@fuggles.cambridge.arm.com> <CAK8P3a1TY9S=zYsdZ5O021p2yYcZhehVuwB3_65dR6x6zbkTYQ@mail.gmail.com>
 <20190218175625.GD16713@fuggles.cambridge.arm.com>
In-Reply-To: <20190218175625.GD16713@fuggles.cambridge.arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 21:37:25 +0100
Message-ID: <CAK8P3a2mjjr94hwj_eXxfyKDKDuA=MogXW7xJygh-X0Hqgf6rg@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER
 EFFECTS" section
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Russell King - ARM Linux <linux@armlinux.org.uk>
Message-ID: <20190218203725.QKV4SFzS1ReEIkGA9CEzKbvQlChP_fzYu4yNJTzwpGE@z>

On Mon, Feb 18, 2019 at 6:56 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Feb 18, 2019 at 05:59:13PM +0100, Arnd Bergmann wrote:
> > On Mon, Feb 18, 2019 at 5:30 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > >
> > > > ioremap_wc() in turn is used almost exclusively to map RAM behind
> > > > a bus, (typically for frame buffers) and we may be better off not
> > > > assuming any particular MMIO barrier semantics for it at all, but possibly
> > > > audit the few uses that are not frame buffers.
> > >
> > > Right, my expectation is actually that you very rarely need ordering
> > > guarantees for wc mappings, and so saying "relaxed + mandatory barriers"
> > > is the best thing to say for portable driver code. I'm deliberately /not/
> > > trying to enumerate arch or device-specific behaviours.
> >
> > That's fine, my worry is more that you are already saying too much
> > by describing a behavior for ioremap_wc+relaxed+barrier that is
> > neither a good idea or guaranteed to do what you describe.
>
> I could drop the mention of relaxed accessors here for now, if you like?
> For example:
>
>   "__iomem pointers obtained with non-default attributes (e.g. those returned
>    by ioremap_wc()) are unlikely to provide many of these guarantees. If
>    ordering is required for such mappings, then the mandatory barriers should
>    be used."
>
> which we could flesh out if/when we have a notion of the portable semantics.

I'd go further then and drop the second sentence entirely until we are sure
what portable behaviour would be.

> >
> > I would say we should strengthen the behavior of outX() where possible.
> > I don't know if arm64 actually has a way of doing that, my understanding
> > earlier was that the AXI bus was already posted, so there is not much
> > you can do here to define __io_paw() in a way that will prevent posted
> > writes.
>
> If we could map I/O space using different page table attributes (probably by
> hacking pci_remap_iospace() ?) then we could disable the
> early-write-acknowledge hint and implement __io_paw() as a completion
> barrier, although it would be at the mercy of the system as to whether or
> not that requires a response from the RC.

Ah, it seems we actually do that on 32-bit ARM, at least on one platform,
see 6a02734d420f ("ARM: mvebu: map PCI I/O regions strongly ordered")
and prior commits.

> I would still prefer to document the weaker semantics as the portable
> interface, unless there are portable drivers relying on this today (which
> would imply that it's widely supported by other architectures).

I don't know of any portable driver that actually relies on it, but
that's mainly because there are very few portable drivers that
use inb()/outb() in the first place. How many of those require
the non-posted behavior I don't know

Adding Thomas, Gregory and Russell to Cc, as they were involved
in the discussion that led to the 32-bit change, maybe they are
aware of a specific example.

       Arnd
