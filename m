From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] sata_sil24: Use memory barriers before issuing
 commands
Date: Sat, 19 Jun 2010 23:32:19 +0100
Message-ID: <1276986739.11824.33.camel@toshiba-laptop>
References: <20100615113150.GM6138@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20100615113150.GM6138@laptop>
Sender: linux-ide-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Colin Tuckley <colin.tuckley@arm.com>, Jeff Garzik <jeff@garzik.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 2010-06-15 at 12:31 +0100, Nick Piggin wrote:
> On Tue, Jun 15, 2010 at 12:10:53PM +0100, Catalin Marinas wrote:
> > On Sat, 2010-06-12 at 02:30 +0100, Robert Hancock wrote:
> > > > So if that's the API for the above case and we are strictly referring to
> > > > the sata_sil24 patch I sent - shouldn't we just add wmb() in the driver
> > > > between the write to the DMA buffer and the writel() to start the DMA
> > > > transfer? Do we need to move the wmb() to the writel() macro?
> > >
> > > I think it would be best if writel, etc. did the write buffer flushing
> > > by default. As Nick said, if there are some performance critical areas
> > > then those can use the relaxed versions but it's safest if the default
> > > behavior works as drivers expect.
> >
> > I went through the past discussion pointed to by Fujita (thanks!) but I
> > wouldn't say it resulted in a definitive guideline on how architectures
> > should implement the I/O accessors.
> >
> > From an ARM perspective, I would prefer to add wmb() in the drivers
> > where it matters - basically only those using DMA coherent buffers. A
> > lot of drivers already have this in place and that's already documented
> > in DMA-API.txt (maybe with a bit of clarification).
> >
> > Some statistics - grepping drivers/ for alloc_coherent shows 285 files.
> > Of these, 69 already use barriers. It's not trivial to go through 200+
> > drivers and add barriers but I wouldn't say that's impossible.
> 
> I disagree. Firstly, you will get subtle bugs, not able to be reproduced
> and situations where driver writers don't even have that architecture to
> test on. Secondly, it is not a one-time audit and be done with it, code
> is constantly being changed and added. Driver code is going to be
> written and tested and run on different archs or even different
> implementations that do different things to ordering.
> 
> On the other hand, a performance slowdown should be far more reproducible
> and traceable.

I need to do some benchmarks to see the overall impact on ARM. There are
many PIO drivers that will have the performance affected (and we
probably use more PIO than DMA drivers).

A solution may be to redefine the IO accessors in the dma-mapping.h file
so that you get the fully ordered ones when the DMA API is used.

Many drivers seem to convert a dma_addr_t value to u32/u64 and pass it
to the device for initiating the DMA transfer. Could we enforce an
arch-specific converter that contains the write barrier (similar to the
dma_map_* functions but without cache maintenance)?

> > If we go the other route of adding mb() in writel() (though I don't
> > prefer it), there are two additional issues:
> >
> > (1) how relaxed would the "writel_relaxed" etc. accessors be? Are they
> > relaxed only with regards to coherent DMA buffers or relaxed with other
> > I/O operations as well? Can the compiler reorder them?
> 
> That was up for debate. I think totally weak (like SMP ordering)
> should be fine, but that may require that we need some more barriers
> like io_wmb() (which just orders two writels from the same CPU).
> Remember we want to restrict their use outside critical fastpaths
> of important drivers -- this is a far smaller task than auditing all
> accesses in all drivers.

If we are to make the writel/readl on ARM fully ordered with both IO
(enforced by hardware) and uncached memory, do we add barriers on each
side of the writel/readl etc.? The common cases would require a barrier
before writel (write buffer flushing) and a barrier after readl (in case
of polling for a "DMA complete" state).

So if io_wmb() just orders to IO writes (writel_relaxed), does it mean
that we still need a mighty wmb() that orders any type of accesses (i.e.
uncached memory vs IO)? Can drivers not use the strict writel() and no
longer rely on wmb() (wondering whether we could simplify it on ARM with
fully ordered IO accessors)?

Apart from the DMA coherent, what are the other uses of wmb() in Linux?
I've seen some use cases in drivers on SMP systems in relation to
interrupt routines.

Thanks.

-- 
Catalin

