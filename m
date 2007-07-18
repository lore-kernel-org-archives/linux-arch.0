Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:30092 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbXGRHqm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jul 2007 03:46:42 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6I7kLLQ052280
	for <linux-arch@vger.kernel.org>; Wed, 18 Jul 2007 07:46:21 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6I7kL3t1536168
	for <linux-arch@vger.kernel.org>; Wed, 18 Jul 2007 09:46:21 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6I7kEqF029039
	for <linux-arch@vger.kernel.org>; Wed, 18 Jul 2007 09:46:15 +0200
Subject: Re: + sparc64-rename-tlb_flush_mmu.patch added to -mm tree
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070717144245.7760a716.akpm@linux-foundation.org>
References: <200707170748.l6H7m1so005969@imap1.linux-foundation.org>
	 <20070717005551.cdb9504e.akpm@linux-foundation.org>
	 <20070717010324.833fee7e.akpm@linux-foundation.org>
	 <1184680583.21357.67.camel@localhost>
	 <20070717181843.GB16147@flint.arm.linux.org.uk>
	 <20070717120820.86a50e75.akpm@linux-foundation.org>
	 <20070717211445.GC16147@flint.arm.linux.org.uk>
	 <20070717144245.7760a716.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 09:48:57 +0200
Message-Id: <1184744937.17915.21.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch@vger.kernel.org, davem@davemloft.net, hugh@veritas.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2007-07-17 at 14:42 -0700, Andrew Morton wrote:
> umm, OK, well what is the spec for this new interface which Martin
> is proposing to add?

Actually the interface is already there but so far it has been internal
to the generic tlb gather code and most architecture variants.

> It _seems_ to be that if the arch implements tlb_flush_mmu() then its
> tlb_finish_mmu() can (should) be a no-op?

Yes, tlb_flush_mmu() can be a no-op, it basically says that "now is a
good time to get rid of the tlbs / pages gathered in the tlb gather
structure so far". In case you have already freed everything
tlb_flush_mmu is naturally a no-op, e.g. for arm. 

> Or if the arch's tlb_finish_mmu() does a full mm "flush" (god I hate that
> term - here we meant writeback, and perhaps invalidate??)) then its
> tlb_flush_mmu() can (should) be a no-op.

This is one case where the architecture can flush at the beginning of
the tlb gather operation and tlb_flush_mmu turns into a nop.
There are four difference batched tlb operations:
1) change_protection does a number of ptep_get_and_clear()/set_pte_at()
calls followed by a flush_tlb_range().
2) dup_mmap/copy_page_range does ptep_set_wrprotect() on a choice of
ptes followed by a flush_tlb_mm().
3) unmap_region() and zap_page_range() use the tlb gatherer with
fullmm==0 which will make zap_pte_range() call ptep_get_and_clear_full()
with fullmm==0.
4) exit_map() uses the tlb gatherer with fullmm==1 which will make
zap_pte_range() call ptep_get_and_clear_full() with fullmm==1.

So we have the "full" flush, the partial flush, the wrprotect flush and
the change protection flush. I've been halfway through the code that
introduces the notion of these four different flush types before I gave
up because it resulted in too much code.

> Or something like that.  Martin, I'd suggest that an update to
> Documentation/cachetlb.txt is in order, spell this all out.

Ok, I will see what I can do.

> Doing this properly would require that Documentation/cachetlb.txt say
> something about tlb_gather_mmu() and tlb_finish_mmu() too, I guess.
> Please ;)

That is the sore spot, we (I?) have to write documentation for all the
primitives of the tlb gatherer.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.


