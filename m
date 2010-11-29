From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 08/21] mm: Preemptible mmu_gather
Date: Mon, 29 Nov 2010 11:53:24 +0900
Message-ID: <20101129115324.31cc9005.kamezawa.hiroyu@jp.fujitsu.com>
References: <20101126143843.801484792@chello.nl>
	<20101126145410.712834114@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20101126145410.712834114@chello.nl>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@ad>
List-Id: linux-arch.vger.kernel.org

On Fri, 26 Nov 2010 15:38:51 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Make mmu_gather preemptible by using a small on stack list and use
> an option allocation to speed things up.
> 
> Preemptible mmu_gather is desired in general and usable once
> i_mmap_lock becomes a mutex. Doing it before the mutex conversion
> saves us from having to rework the code by moving the mmu_gather
> bits inside the i_mmap_lock.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: David Miller <davem@davemloft.net>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Interesting, Hmm, how about using the 1st freed pages as tlb->pages
rathet than calling alloc_page() ? no benefits ?

Thanks,
-Kame

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom policy in Canada: sign http://dissolvethecrtc.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
