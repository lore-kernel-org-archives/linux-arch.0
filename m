From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 20/28] ARCv2: barriers
Date: Mon, 22 Jun 2015 14:36:56 +0100
Message-ID: <20150622133656.GG1583@arm.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-21-git-send-email-vgupta@synopsys.com>
 <20150609124008.GA3644@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075665A4FFE@IN01WEMBXB.internal.synopsys.com>
 <20150610105840.GG3644@twins.programming.kicks-ass.net>
 <20150610130140.GD22973@arm.com>
 <C2D7FE5348E1B147BCA15975FBA23075665A526F@IN01WEMBXB.internal.synopsys.com>
 <20150611133952.GA29425@arm.com>
 <5584155E.9060601@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5584155E.9060601@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 19, 2015 at 02:13:02PM +0100, Vineet Gupta wrote:
> On Thursday 11 June 2015 07:09 PM, Will Deacon wrote:
> > On Thu, Jun 11, 2015 at 01:13:28PM +0100, Vineet Gupta wrote:
> >> On Wednesday 10 June 2015 06:31 PM, Will Deacon wrote:
> >>> You also need that guarantee in your readl/writel family of macros. It's
> >>> extremely heavy and rarely needed, which is why I added the _relaxed
> >>> versions to all architectures.
> >>
> >> Wow - adding that to these accessors will really be heavy - given that a whole
> >> bunch of drivers still use the stock API (or perhaps don't know / care whether
> >> they need the readl or the relaxed api. And it is practically impossible to switch
> >> them over - after if ain't broken how can u fix it. So far we've been testing this
> >> implementation (readl/writel - w/o any explicit barrier) on slower FPGA builds and
> >> this includes a whole bunch of designware IP - mmc, eth, gpio.... and don't see
> >> any ill effects - do you reckon we still need to add it.
> > 
> > Unfortunately, yes, as that's effectively what the kernel requires:
> > 
> >   http://marc.info/?l=linux-kernel&m=121192394430581&w=2
> >   http://thread.gmane.org/gmane.linux.ide/46414
> 
> Oh great - thx for those !
> 
> > The conclusion is that x86 *does* provide this ordering in its accessors
> > and drivers are written to assume that, so either you go round fixing all
> > the drivers by adding the missing barriers or you implement it in your
> > accessors (like we have done on ARM). Subtle I/O ordering issues are no
> > fun to debug.
> > 
> > That's also the reason I added the _relaxed versions, so you can port
> > drivers one-by-one to the weaker semantics whilst having the potentially
> > broken drivers continue to work.
> > 
> 
> OK, so given that regular/mmio is also weakly ordered, it would seem that we need
> full mb() *before* and *after* the IO access in the non relaxed API. ARM code
> seems to put a rmb() after the readl and wmb() before the writel. Is that based on
> how h/w provides for some ?

We figured that you'd likely be doing something like:

<writel_relaxed DMA buffer>
<writel MMIO "go" reg>

or:

<readl MMIO "status" reg>
<readl_relaxed DMA buffer>

so ended up with writel doing {wmb(); writel_relaxed} and readl doing
{readl_relaxed; rmb()}.

> In one of the links you posted above, Catalin posed the same question, but I
> didn't see response to that.
> 
> | If we are to make the writel/readl on ARM fully ordered with both IO
> | (enforced by hardware) and uncached memory, do we add barriers on each
> | side of the writel/readl etc.? The common cases would require a barrier
> | before writel (write buffer flushing) and a barrier after readl (in case
> | of polling for a "DMA complete" state).
> |
> | So if io_wmb() just orders to IO writes (writel_relaxed), does it mean
> | that we still need a mighty wmb() that orders any type of accesses (i.e.
> | uncached memory vs IO)? Can drivers not use the strict writel() and no
> | longer rely on wmb() (wondering whether we could simplify it on ARM with
> | fully ordered IO accessors)?
> 
> Further readl/writel would be no different than ioread32/iowrite32 ?

ioread32/iowrite32 can be used with port addresses and dispatch to the
relevant accessors depending on that. The memory ordering semantics should
be the same as readl/writel.

> FWIW, h/w folks tell me that DMB guarentess local barrier semantics so we don't
> need to use DSYNC. Latter only provides full r+w+TLB/BPU stuff while DMB allows
> finer grained r/w/r+w. But if we need full mb then using one vs. other becomes a
> moot point.

I'd say go with what we do on ARM/arm64, then at least we have consistency
in the use of barriers.

Will
