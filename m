Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:53564 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbcEDNrr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2016 09:47:47 -0400
Date: Wed, 4 May 2016 15:47:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: kmap_atomic and preemption
Message-ID: <20160504134729.GP3430@twins.programming.kicks-ass.net>
References: <5729D0F4.9090907@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5729D0F4.9090907@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20160504134729.qv1VcmHD8L1SJFQfvdK3AxfFFmOWtYpRM-__L5uonsg@z>

On Wed, May 04, 2016 at 04:07:40PM +0530, Vineet Gupta wrote:
> Hi,
> 
> I was staring at some recent ARC highmem crashes and see that kmap_atomic()
> disables preemption even when page is in lowmem and call returns right away.
> This seems to be true for other arches as well.
> 
> arch/arc/mm/highmem.c:
> 
> void *kmap_atomic(struct page *page)
> {
> 	int idx, cpu_idx;
> 	unsigned long vaddr;
> 
> 	preempt_disable();
> 	pagefault_disable();
> 	if (!PageHighMem(page))
> 		return page_address(page);
> 
>         /* do the highmem foo ... */
> ..
> }
> 
> I would really like to implement a inline fastpath for !PageHighMem(page) case and
> do the highmem foo out-of-line.
> 
> Is preemption disabling a requirement of kmap_atomic() callers independent of
> where page is or is it only needed when page is in highmem and can trigger page
> faults or TLB Misses between kmap_atomic() and kunmap_atomic and wants protection
> against reschedules etc.

Traditionally kmap_atomic() disables preemption; and the reason is that
the returned pointer must stay valid. This had a side effect in that it
also disabled pagefaults.

We've since de-coupled the pagefault from the preemption thing, so you
could disable pagefaults while leaving preemption enabled.

Now, I've also done preemptible kmap_atomic() on -rt; which appears to
work, suggesting nothing relies on it disabling preemption (on -rt).

So sure; you can try and leave preemption enabled for lowmem pages, see
what comes apart -- if anything. It gives weird semantics for
kmap_atomic() though, and I'm not sure the cost of doing that
preempt_disable/preempt_enable() is worth the pain.

If you want a fast-slow path splt, you can easily do something like:


static inline void *kmap_atomic(struct page *page)
{
	preempt_disable();
	pagefault_disable();
	if (!PageHighMem(page))
		return page_address(page);

	return __kmap_atomic(page);
}
