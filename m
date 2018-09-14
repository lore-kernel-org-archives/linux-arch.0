From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Date: Fri, 14 Sep 2018 16:07:14 +0200
Message-ID: <20180914160714.45a11f13@mschwideX1>
References: <20180913092110.817204997@infradead.org>
        <20180913092811.894806629@infradead.org>
        <20180913123014.0d9321b8@mschwideX1>
        <20180913105738.GW24124@hirez.programming.kicks-ass.net>
        <20180913141827.1776985e@mschwideX1>
        <20180913123937.GX24124@hirez.programming.kicks-ass.net>
        <20180914122824.181d9778@mschwideX1>
        <20180914130207.GD24106@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180914130207.GD24106@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 14 Sep 2018 15:02:07 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Sep 14, 2018 at 12:28:24PM +0200, Martin Schwidefsky wrote:
> 
> > I spent some time to get s390 converted to the common mmu_gather code.
> > There is one thing I would like to request, namely the ability to
> > disable the page gather part of mmu_gather. For my prototype patch
> > see below, it defines the negative HAVE_RCU_NO_GATHER_PAGES Kconfig
> > symbol that if defined will remove some parts from common code.
> > Ugly but good enough for the prototype to convey the idea.
> > For the final solution we better use a positive Kconfig symbol and
> > add that to all arch Kconfig files except for s390.  
> 
> In a private thread ealier Linus raised the point that the batching and
> freeing of lots of pages at once is probably better for I$.

That would be something to try. For now I would like to do a conversion
that more or less preserves the old behavior. You know these pesky TLB
related bugs..

> > +config HAVE_RCU_NO_GATHER_PAGES
> > +	bool  
> 
> I have a problem with the name more than anything else; this name
> suggests it is the RCU table freeing that should not batch, which is not
> the case, you want the regular page gather gone, but very much require
> the RCU table gather to batch.
> 
> So I would like to propose calling it:
> 
> config HAVE_MMU_GATHER_NO_GATHER
> 
> Or something along those lines.
 
Imho a positive config option like HAVE_MMU_GATHER_PAGES would make the
most sense. It has the downside that it needs to be added to all
arch/*/Kconfig files except for s390. 

But I am not hung-up on a name, whatever does not sound to awful will do
for me. HAVE_MMU_GATHER_NO_GATHER would be ok.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
