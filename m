From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Date: Thu, 13 Sep 2018 14:18:27 +0200
Message-ID: <20180913141827.1776985e@mschwideX1>
References: <20180913092110.817204997@infradead.org>
        <20180913092811.894806629@infradead.org>
        <20180913123014.0d9321b8@mschwideX1>
        <20180913105738.GW24124@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913105738.GW24124@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
List-Id: linux-arch.vger.kernel.org

On Thu, 13 Sep 2018 12:57:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Sep 13, 2018 at 12:30:14PM +0200, Martin Schwidefsky wrote:
> 
> > > + * The mmu_gather data structure is used by the mm code to implement the
> > > + * correct and efficient ordering of freeing pages and TLB invalidations.
> > > + *
> > > + * This correct ordering is:
> > > + *
> > > + *  1) unhook page
> > > + *  2) TLB invalidate page
> > > + *  3) free page
> > > + *
> > > + * That is, we must never free a page before we have ensured there are no live
> > > + * translations left to it. Otherwise it might be possible to observe (or
> > > + * worse, change) the page content after it has been reused.
> > > + *  
> > 
> > This first comment already includes the reason why s390 is probably better off
> > with its own mmu-gather implementation. It depends on the situation if we have
> > 
> > 1) unhook the page and do a TLB flush at the same time
> > 2) free page
> > 
> > or
> > 
> > 1) unhook page
> > 2) free page
> > 3) final TLB flush of the whole mm  
> 
> that's the fullmm case, right?

That includes the fullmm case but we use it for e.g. munmap of a single-threaded
program as well.
 
> > A variant of the second order we had in the past is to do the mm TLB flush first,
> > then the unhooks and frees of the individual pages. The are some tricky corners
> > switching between the two variants, see finish_arch_post_lock_switch.
> > 
> > The point is: we *never* have the order 1) unhook, 2) TLB invalidate, 3) free.
> > If there is concurrency due to a multi-threaded application we have to do the
> > unhook of the page-table entry and the TLB flush with a single instruction.  
> 
> You can still get the thing you want if for !fullmm you have a no-op
> tlb_flush() implementation, assuming your arch page-table frobbing thing
> has the required TLB flush in.

We have a non-empty tlb_flush_mmu_tlbonly to do a full-mm flush for two cases
1) batches of page-table entries for single-threaded programs
2) flushing of the pages used for the page-table structure itself

In fact only the page-table pages are added to the mmu_gather batch, the target
page of the virtual mapping is always freed immediately.
 
> Note that that's not utterly unlike how the PowerPC/Sparc hash things
> work, they clear and invalidate entries different from others and don't
> use the mmu_gather tlb-flush.

We may get something working with a common code mmu_gather, but I fear the
day someone makes a "minor" change to that subtly break s390. The debugging of
TLB related problems is just horrible..

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
