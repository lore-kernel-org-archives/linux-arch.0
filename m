From: Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH 07/13] powerpc: Preemptible mmu_gather
Date: Fri, 9 Apr 2010 14:07:56 +1000
Message-ID: <20100409040756.GK5683@laptop>
References: <20100408191737.296180458@chello.nl>
 <20100408192722.901224587@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45567 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab0DIEID (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Apr 2010 00:08:03 -0400
Content-Disposition: inline
In-Reply-To: <20100408192722.901224587@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>

On Thu, Apr 08, 2010 at 09:17:44PM +0200, Peter Zijlstra wrote:
> Fix up powerpc to the new mmu_gather stuffs.
> 
> PPC has an extra batching queue to RCU free the actual pagetable
> allocations, use the ARCH extentions for that for now.
> 
> For the ppc64_tlb_batch, which tracks the vaddrs to unhash from the
> hardware hash-table, keep using per-cpu arrays but flush on context
> switch and use a TIF bit to track the laxy_mmu state.

Hm. Pity powerpc can't just use tlb flush gathering for this batching,
(which is what it was designed for). Then it could avoid these tricks.
What's preventing this? Adding a tlb gather for COW case in
copy_page_range?
