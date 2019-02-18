Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40766 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfBRQ7b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 11:59:31 -0500
MIME-Version: 1.0
References: <20190211172948.3322-1-will.deacon@arm.com> <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
 <20190218162954.GB16713@fuggles.cambridge.arm.com>
In-Reply-To: <20190218162954.GB16713@fuggles.cambridge.arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 17:59:13 +0100
Message-ID: <CAK8P3a1TY9S=zYsdZ5O021p2yYcZhehVuwB3_65dR6x6zbkTYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER
 EFFECTS" section
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190218165913.E2DL95EgelMNFe_ZWfNaJBLlX1_O5I5o-GHC7ZvNsM0@z>

On Mon, Feb 18, 2019 at 5:30 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Feb 12, 2019 at 02:03:04PM +0100, Arnd Bergmann wrote:
> > On Mon, Feb 11, 2019 at 6:29 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > > +     __iomem pointers obtained with non-default attributes (e.g. those returned
> > > +     by ioremap_wc()) are unlikely to provide many of these guarantees. If
> > > +     ordering is required for such mappings, then the mandatory barriers should
> > > +     be used in conjunction with the _relaxed() accessors defined below.
> >
> > I wonder if we are even able to guarantee consistent behavior across
> > architectures
> > in the last case here (wc mapping with relaxed accessors and barriers).
> >
> > Fortunately, there are only five implementations that actually differ from
> > ioremap_nocache(): arm32, arm64, ppc32, ppc64 and x86 (both 32/64), so
> > that is something we can probably figure out between the people on Cc.
>
...
> > The problem with recommending *_relaxed() + barrier() is that it ends
> > up being more expensive than the non-relaxed accessors whenever
> > _relaxed() implies the barrier already (true on most architectures other
> > than arm).
> >
> > ioremap_wc() in turn is used almost exclusively to map RAM behind
> > a bus, (typically for frame buffers) and we may be better off not
> > assuming any particular MMIO barrier semantics for it at all, but possibly
> > audit the few uses that are not frame buffers.
>
> Right, my expectation is actually that you very rarely need ordering
> guarantees for wc mappings, and so saying "relaxed + mandatory barriers"
> is the best thing to say for portable driver code. I'm deliberately /not/
> trying to enumerate arch or device-specific behaviours.

That's fine, my worry is more that you are already saying too much
by describing a behavior for ioremap_wc+relaxed+barrier that is
neither a good idea or guaranteed to do what you describe.

> > > +     Since many CPU architectures ultimately access these peripherals via an
> > > +     internal virtual memory mapping, the portable ordering guarantees provided
> > > +     by inX() and outX() are the same as those provided by readX() and writeX()
> > > +     respectively when accessing a mapping with the default I/O attributes.
> >
> > This is notably weaker than the PCI mandated non-posted write semantics.
> > As I said earlier, not all architectures or PCI host implementations can provide
> > non-posted writes though, but maybe we can document that fact here, e.g.
> >
> > | Device drivers may expect outX() to be a non-posted write, i.e. waiting for
> > | a completion response from the I/O device, which may not be possible
> > | on a particular hardware.
>
> I can add something along these lines, since this seems like it could be a
> bit of a "gotcha" given the macro names and implicit x86 heritage.

Ok.

> > >   (*) ioreadX(), iowriteX()
> > >
> > >       These will perform appropriately for the type of access they're actually
> > >       doing, be it inX()/outX() or readX()/writeX().
> >
> > This probably needs clarification as well then: On architectures that
> > have a stronger barrier after outX() than writeX() but that use memory
> > mapped access for both, the statement is currently not true. We could
> > either strengthen the requirement by requiring CONFIG_GENERIC_IOMAP
> > on such architectures, or we could document the current behavior
> > as intentional and explicitly not allow iowriteX() on I/O ports to be posted.
>
> At least on arm and arm64, the heavy barrier in outX() is *before* the I/O
> access, and so it does nothing to prevent the access from being posted. It
> looks like the asm-generic/io.h behaviour is the same in the case that none
> of the __io_* barriers are provided by the architecture.
>
> Do you think this is something we actually need to strengthen, or are
> drivers that rely on this going to be x86-specific anyway?

I would say we should strengthen the behavior of outX() where possible.
I don't know if arm64 actually has a way of doing that, my understanding
earlier was that the AXI bus was already posted, so there is not much
you can do here to define __io_paw() in a way that will prevent posted
writes.

> > > +All of these accessors assume that the underlying peripheral is little-endian,
> > > +and will therefore perform byte-swapping operations on big-endian architectures.
> >
> > This sounds like a useful addition and the only sane way to do it IMHO, but
> > I think at least traditionally we've had architectures that do not work like
> > this but that make readX()/writeX() do native big-endian loads and stores, with
> > a hardware byteswap on the PCI bus.
>
> Sure, hence my disclaimer at the beginning about non-portable drivers :)
> My goal here is really to document the portable semantics for the common
> architectures, so that driver developers and reviewers can get the usual
> case right.

Fair enough.

      Arnd
