From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: kmap_atomic and preemption
Date: Wed, 4 May 2016 14:16:11 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4EA065E@us01wembx1.internal.synopsys.com>
References: <5729D0F4.9090907@synopsys.com>
 <20160504134729.GP3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57416 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbcEDORJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2016 10:17:09 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Wednesday 04 May 2016 07:17 PM, Peter Zijlstra wrote:
> On Wed, May 04, 2016 at 04:07:40PM +0530, Vineet Gupta wrote:
>> Is preemption disabling a requirement of kmap_atomic() callers independent of
>> where page is or is it only needed when page is in highmem and can trigger page
>> faults or TLB Misses between kmap_atomic() and kunmap_atomic and wants protection
>> against reschedules etc.
> Traditionally kmap_atomic() disables preemption; and the reason is that
> the returned pointer must stay valid. This had a side effect in that it
> also disabled pagefaults.

But how could the ptr possibly get invalid. Say despite the disable calls, we
could actually take the page fault (or TLB Miss on ARC) - the pagefault_disable()
only makes do_page_fault() do reduced handling vs. calling handle_mm_fault() etc.
It is essentially restricting the fault handling to a kernel mode fixup only.

Now if we didn't do disable, on ARC the semantics of do_page_fault() are still the
same - since the address would be for fixmap which is handled under "kernel" only
category as well.

void do_page_fault(unsigned long address, struct pt_regs *regs)
{

    if (address >= VMALLOC_START) {
        ret = handle_kernel_vaddr_fault(address);
        return;
...
    if (faulthandler_disabled() || !mm)
        goto no_context;
...

> We've since de-coupled the pagefault from the preemption thing, so you
> could disable pagefaults while leaving preemption enabled.

Right - I've seen that patch set from David H.

> ...
>
> If you want a fast-slow path splt, you can easily do something like:
>
> static inline void *kmap_atomic(struct page *page)
> {
> 	preempt_disable();
> 	pagefault_disable();
> 	if (!PageHighMem(page))
> 		return page_address(page);
>
> 	return __kmap_atomic(page);
> }

I actually want to return early for !PageHighMem and avoid the pointless 2
LD-ADD-ST to memory for map and 2 LD-SUB-ST for unmap for regular pages for such
cases.
