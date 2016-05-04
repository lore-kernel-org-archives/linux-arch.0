From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: kmap_atomic and preemption
Date: Wed, 4 May 2016 16:07:40 +0530
Message-ID: <5729D0F4.9090907@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:54170 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386AbcEDKh7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2016 06:37:59 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Hi,

I was staring at some recent ARC highmem crashes and see that kmap_atomic()
disables preemption even when page is in lowmem and call returns right away.
This seems to be true for other arches as well.

arch/arc/mm/highmem.c:

void *kmap_atomic(struct page *page)
{
	int idx, cpu_idx;
	unsigned long vaddr;

	preempt_disable();
	pagefault_disable();
	if (!PageHighMem(page))
		return page_address(page);

        /* do the highmem foo ... */
..
}

I would really like to implement a inline fastpath for !PageHighMem(page) case and
do the highmem foo out-of-line.

Is preemption disabling a requirement of kmap_atomic() callers independent of
where page is or is it only needed when page is in highmem and can trigger page
faults or TLB Misses between kmap_atomic() and kunmap_atomic and wants protection
against reschedules etc.

-Vineet
