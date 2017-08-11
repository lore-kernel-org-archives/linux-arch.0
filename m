Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:50304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbdHKNbG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2017 09:31:06 -0400
Date: Fri, 11 Aug 2017 15:30:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 6/7] mm: fix MADV_[FREE|DONTNEED] TLB flush miss
 problem
Message-ID: <20170811133020.zozuuhbw72lzolj5@hirez.programming.kicks-ass.net>
References: <20170802000818.4760-1-namit@vmware.com>
 <20170802000818.4760-7-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170802000818.4760-7-namit@vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: linux-mm@kvack.org, nadav.amit@gmail.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Minchan Kim <minchan@kernel.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org
Message-ID: <20170811133020.QNHI6_MMClvBC0h1jHDliwjiOz3inYLqGxDPA8F5Y24@z>

On Tue, Aug 01, 2017 at 05:08:17PM -0700, Nadav Amit wrote:
>  void tlb_finish_mmu(struct mmu_gather *tlb,
>  		unsigned long start, unsigned long end)
>  {
> -	arch_tlb_finish_mmu(tlb, start, end);
> +	/*
> +	 * If there are parallel threads are doing PTE changes on same range
> +	 * under non-exclusive lock(e.g., mmap_sem read-side) but defer TLB
> +	 * flush by batching, a thread has stable TLB entry can fail to flush
> +	 * the TLB by observing pte_none|!pte_dirty, for example so flush TLB
> +	 * forcefully if we detect parallel PTE batching threads.
> +	 */
> +	bool force = mm_tlb_flush_nested(tlb->mm);
> +
> +	arch_tlb_finish_mmu(tlb, start, end, force);
>  }

I don't understand the comment nor the ordering. What guarantees we see
the increment if we need to?
