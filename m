From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 4/7] mm: refactoring TLB gathering API
Date: Fri, 11 Aug 2017 11:23:34 +0200
Message-ID: <20170811092334.rmeazkklvordrmrl@hirez.programming.kicks-ass.net>
References: <20170802000818.4760-1-namit@vmware.com>
 <20170802000818.4760-5-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170802000818.4760-5-namit@vmware.com>
Sender: owner-linux-mm@kvack.org
To: Nadav Amit <namit@vmware.com>
Cc: linux-mm@kvack.org, nadav.amit@gmail.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Minchan Kim <minchan@kernel.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 01, 2017 at 05:08:15PM -0700, Nadav Amit wrote:
> From: Minchan Kim <minchan@kernel.org>
> 
> This patch is a preparatory patch for solving race problems caused by
> TLB batch.  For that, we will increase/decrease TLB flush pending count
> of mm_struct whenever tlb_[gather|finish]_mmu is called.
> 
> Before making it simple, this patch separates architecture specific
> part and rename it to arch_tlb_[gather|finish]_mmu and generic part
> just calls it.

I absolutely hate this. We should unify this stuff, not diverge it
further.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
