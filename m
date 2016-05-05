Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:46390 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757312AbcEEMhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2016 08:37:24 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: kmap_atomic and preemption
Date: Thu, 5 May 2016 12:37:17 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4EA086B@us01wembx1.internal.synopsys.com>
References: <5729D0F4.9090907@synopsys.com>
 <20160504134729.GP3430@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075F4EA065E@us01wembx1.internal.synopsys.com>
 <20160504150138.GR3430@twins.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20160505123717.vuiQt12DQiTOJVRg_6KHAk9Gr0BA4lekbLX8FHNiKpo@z>

On Wednesday 04 May 2016 08:31 PM, Peter Zijlstra wrote:
> So I'm fairly sure people rely on the fact you cannot have pagefault
> inside a kmap_atomic().

So this translates to: any hardware page faults inside kmap_atomic() can't lead to
do_page_fault() taking a lock - those can only be ex_table fixups, yes ?
Could you please also help explain your earlier comment about kmap_atomic needing
to disable preemption so that "returned pointer stayed valid". I can't quite
fathom how that can happen

> But you could potentially get away with leaving preemption enabled. Give
> it a try, see if something goes *bang* ;-)

So tried patch further below: on a quad core slowish FPGA setup, concurrent
hackbench and LMBench seem to run w/o issues  - so it is not obviously broken even
if not proven otherwise. But the point is highmem page is a slow path anyways -
needs a PTE update, new TLB entry etc. I hoped to not wiggle even a single cache
line for the low page - but seems like that is not possible.

OTOH, if we do keep the status quo - then making these 2 cache lines into 1 is not
possible either. From reading the orig "decoupling of prremption and page fault"
thread it seems to be because preempt count is per cpu on x86.

@@ -67,7 +67,6 @@ void *kmap_atomic(struct page *page)
        int idx, cpu_idx;
        unsigned long vaddr;
 
-       preempt_disable();
        pagefault_disable();
        if (!PageHighMem(page))
                return page_address(page);
@@ -107,7 +106,6 @@ void __kunmap_atomic(void *kv)
        }
 
        pagefault_enable();
-       preempt_enable();
 }

