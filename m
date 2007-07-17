Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:33692 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbXGQWFT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2007 18:05:19 -0400
Date: Tue, 17 Jul 2007 23:04:49 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: + sparc64-rename-tlb_flush_mmu.patch added to -mm tree
Message-ID: <20070717220448.GA19506@flint.arm.linux.org.uk>
References: <1184680583.21357.67.camel@localhost> <617E1C2C70743745A92448908E030B2A01F28290@scsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617E1C2C70743745A92448908E030B2A01F28290@scsmsx411.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, davem@davemloft.net, hugh@veritas.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jul 17, 2007 at 02:55:05PM -0700, Luck, Tony wrote:
> -			tlb_finish_mmu(*tlbp, tlb_start, start);
> -
>  			if (need_resched() ||
>  				(i_mmap_lock && need_lockbreak(i_mmap_lock))) {
> -				if (i_mmap_lock) {
> -					*tlbp = NULL;
> +				if (i_mmap_lock)
>  					goto out;
> 
> If we take this "goto out" path, then we'll miss out on calling
> the tlb_finish_mmu() which you deleted just above.

Look at the next hunk in the patch.  The old path set *tlbp to NULL
if we exit this function having called tlb_finish_mmu().  In that case,
we avoid calling tlb_finish_mmu() again.  Otherwise, *tlbp is left
pointing at the mmu_gather structure, and it's left for zap_page_range()
to call tlb_finish_mmu().

The new path actually cleans this up - we always exit unmap_vmas()s
_with_ the tlb context requiring tlb_finish_mmu(), so the call in
zap_page_range() becomes unconditional.

So, if anything, this is a much needed cleanup of the behaviour of
unmap_vmas().

> At the very
> least this will leave preemption disabled (since we'll miss calling
> the put_cpu_var(mmu_gathers)).
> 
> I think I'm also missing the big picture view of what you are
> doing here.

Avoiding calling tlb_finish_mmu() and tlb_gather_mmu() unnecessarily,
and (eg) thereby avoiding some repetitive entire TLB invalidations on
ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
