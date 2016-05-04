From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: kmap_atomic and preemption
Date: Wed, 4 May 2016 17:01:38 +0200
Message-ID: <20160504150138.GR3430@twins.programming.kicks-ass.net>
References: <5729D0F4.9090907@synopsys.com>
 <20160504134729.GP3430@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075F4EA065E@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4EA065E@us01wembx1.internal.synopsys.com>
Sender: owner-linux-mm@kvack.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, May 04, 2016 at 02:16:11PM +0000, Vineet Gupta wrote:
> > static inline void *kmap_atomic(struct page *page)
> > {
> > 	preempt_disable();
> > 	pagefault_disable();
> > 	if (!PageHighMem(page))
> > 		return page_address(page);
> >
> > 	return __kmap_atomic(page);
> > }
> 
> I actually want to return early for !PageHighMem and avoid the pointless 2
> LD-ADD-ST to memory for map and 2 LD-SUB-ST for unmap for regular pages for such
> cases.

So I'm fairly sure people rely on the fact you cannot have pagefault
inside a kmap_atomic().

But you could potentially get away with leaving preemption enabled. Give
it a try, see if something goes *bang* ;-)

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
