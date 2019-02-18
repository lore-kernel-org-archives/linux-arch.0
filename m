Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33896 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730711AbfBRQaF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Feb 2019 11:30:05 -0500
Date: Mon, 18 Feb 2019 16:29:54 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190218162954.GB16713@fuggles.cambridge.arm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190218162954.UMgST8RTm71rYPzw1379cT-tO3o0aysSgcvkaDojIuI@z>

Hi Arnd,

On Tue, Feb 12, 2019 at 02:03:04PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 11, 2019 at 6:29 PM Will Deacon <will.deacon@arm.com> wrote:
> 
> > +     __iomem pointers obtained with non-default attributes (e.g. those returned
> > +     by ioremap_wc()) are unlikely to provide many of these guarantees. If
> > +     ordering is required for such mappings, then the mandatory barriers should
> > +     be used in conjunction with the _relaxed() accessors defined below.
> 
> I wonder if we are even able to guarantee consistent behavior across
> architectures
> in the last case here (wc mapping with relaxed accessors and barriers).
> 
> Fortunately, there are only five implementations that actually differ from
> ioremap_nocache(): arm32, arm64, ppc32, ppc64 and x86 (both 32/64), so
> that is something we can probably figure out between the people on Cc.

I'd be keen to try to document this as a follow-up patch, otherwise there's
the risk of biting off more than I can chew, which is easily done with this
stuff! For arm32 (v7) and arm64, ioremap_wc() returns "normal, non-cacheable
memory". Some notable differences between this and the memory type returned
by ioremap() are:

 * ioremap_wc() allows speculative reads
 * ioremap_wc() allows unaligned access
 * ioremap_wc() allows reordering of accesses to different addresses
 * ioremap_wc() allows merging of accesses

so for us, you really only want to use it to map things that look an awful
lot like memory.

> The problem with recommending *_relaxed() + barrier() is that it ends
> up being more expensive than the non-relaxed accessors whenever
> _relaxed() implies the barrier already (true on most architectures other
> than arm).
> 
> ioremap_wc() in turn is used almost exclusively to map RAM behind
> a bus, (typically for frame buffers) and we may be better off not
> assuming any particular MMIO barrier semantics for it at all, but possibly
> audit the few uses that are not frame buffers.

Right, my expectation is actually that you very rarely need ordering
guarantees for wc mappings, and so saying "relaxed + mandatory barriers"
is the best thing to say for portable driver code. I'm deliberately /not/
trying to enumerate arch or device-specific behaviours.

> > +     Since many CPU architectures ultimately access these peripherals via an
> > +     internal virtual memory mapping, the portable ordering guarantees provided
> > +     by inX() and outX() are the same as those provided by readX() and writeX()
> > +     respectively when accessing a mapping with the default I/O attributes.
> 
> This is notably weaker than the PCI mandated non-posted write semantics.
> As I said earlier, not all architectures or PCI host implementations can provide
> non-posted writes though, but maybe we can document that fact here, e.g.
> 
> | Device drivers may expect outX() to be a non-posted write, i.e. waiting for
> | a completion response from the I/O device, which may not be possible
> | on a particular hardware.

I can add something along these lines, since this seems like it could be a
bit of a "gotcha" given the macro names and implicit x86 heritage.

> >   (*) ioreadX(), iowriteX()
> >
> >       These will perform appropriately for the type of access they're actually
> >       doing, be it inX()/outX() or readX()/writeX().
> 
> This probably needs clarification as well then: On architectures that
> have a stronger barrier after outX() than writeX() but that use memory
> mapped access for both, the statement is currently not true. We could
> either strengthen the requirement by requiring CONFIG_GENERIC_IOMAP
> on such architectures, or we could document the current behavior
> as intentional and explicitly not allow iowriteX() on I/O ports to be posted.

At least on arm and arm64, the heavy barrier in outX() is *before* the I/O
access, and so it does nothing to prevent the access from being posted. It
looks like the asm-generic/io.h behaviour is the same in the case that none
of the __io_* barriers are provided by the architecture.

Do you think this is something we actually need to strengthen, or are
drivers that rely on this going to be x86-specific anyway?

> > +All of these accessors assume that the underlying peripheral is little-endian,
> > +and will therefore perform byte-swapping operations on big-endian architectures.
> 
> This sounds like a useful addition and the only sane way to do it IMHO, but
> I think at least traditionally we've had architectures that do not work like
> this but that make readX()/writeX() do native big-endian loads and stores, with
> a hardware byteswap on the PCI bus.

Sure, hence my disclaimer at the beginning about non-portable drivers :)
My goal here is really to document the portable semantics for the common
architectures, so that driver developers and reviewers can get the usual
case right.

Will
