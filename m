Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:33559 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172AbXGQSTS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2007 14:19:18 -0400
Date: Tue, 17 Jul 2007 19:18:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: + sparc64-rename-tlb_flush_mmu.patch added to -mm tree
Message-ID: <20070717181843.GB16147@flint.arm.linux.org.uk>
References: <200707170748.l6H7m1so005969@imap1.linux-foundation.org> <20070717005551.cdb9504e.akpm@linux-foundation.org> <20070717010324.833fee7e.akpm@linux-foundation.org> <1184680583.21357.67.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1184680583.21357.67.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, davem@davemloft.net, hugh@veritas.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jul 17, 2007 at 03:56:23PM +0200, Martin Schwidefsky wrote:
> On Tue, 2007-07-17 at 01:03 -0700, Andrew Morton wrote:
> > OK, I don't understand how this patch works - from a quick glance it
> > appears to be forgetting to flush stuff altogether on arm and arm26 at
> > least and I see no sign that Russell, Tony and Ian have even seen it.
> 
> Added linux-arch so that affected arch-maintainers can comment.

Having a little more information about Andrew's concern would be nice.
Under what circumstances do you think we're forgetting to flush stuff?

> > And it should have been loudly pointed out to various arch maintainers so
> > they have an opportunity to implement the optimisation which it offers.
> 
> The idea behind the optimization of this patch is that for a full mm
> flush (tlb_gather_mmu called with full_mm_flush==1) a single
> flush_tlb_mm is enough to remove all TLBs of the mm. New ones cannot be
> created since full_mm_flush==1 only for exit_mmap. The same is true for
> a normal unmap if there is only one user of the mm and the mm is the
> currently active mm.
> 
> -- 
> blue skies,
>   Martin.
> 
> "Reality continues to ruin my life." - Calvin.
> 
> ---
> Subject: [PATCH] avoid tlb gather restarts.
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> If need_resched() is false in the inner loop of unmap_vmas it is
> unnecessary to do a full blown tlb_finish_mmu / tlb_gather_mmu for
> each ZAP_BLOCK_SIZE ptes. Do a tlb_flush_mmu() instead. That gives
> architectures with a non-generic tlb flush implementation room for
> optimization. The tlb_flush_mmu primitive is a available with the
> generic tlb flush code, the ia64_tlb_flush_mm needs to be renamed
> and a dummy function is added to arm and arm26.

This description sounds sane.  Nothing really jumps out as a problem
from reading the patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
