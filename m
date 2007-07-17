Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60684 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755773AbXGQWVr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2007 18:21:47 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: + sparc64-rename-tlb_flush_mmu.patch added to -mm tree
Date: Tue, 17 Jul 2007 15:21:45 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A01F2831B@scsmsx411.amr.corp.intel.com>
In-Reply-To: <20070717220448.GA19506@flint.arm.linux.org.uk>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, davem@davemloft.net, hugh@veritas.com
List-ID: <linux-arch.vger.kernel.org>

> Look at the next hunk in the patch.  The old path set *tlbp to NULL
> if we exit this function having called tlb_finish_mmu().  In that case,
> we avoid calling tlb_finish_mmu() again.  Otherwise, *tlbp is left
> pointing at the mmu_gather structure, and it's left for zap_page_range()
> to call tlb_finish_mmu().

Ah yes.  That does look a bit cleaner.

So on ia64 we are just swapping some tlb_finish_mmu() calls for
tlb_flush_mmu() (formerly known as ia64_tlb_flush_mmu()).  The
only work we save are the calls to check_pgt_cache() and
put_cpu_var(mmu_gathers) ... which sounds like we may have less
preemption opportunities in this loop (in the cases where we take
the !need_resched() path).

-Tony
