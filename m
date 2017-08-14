From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v6 6/7] mm: fix MADV_[FREE|DONTNEED] TLB flush miss
 problem
Date: Mon, 14 Aug 2017 10:26:17 +0900
Message-ID: <20170814012617.GB25427@bbox>
References: <20170802000818.4760-1-namit@vmware.com>
 <20170802000818.4760-7-namit@vmware.com>
 <20170811133020.zozuuhbw72lzolj5@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:58483 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdHNB0T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Aug 2017 21:26:19 -0400
Content-Disposition: inline
In-Reply-To: <20170811133020.zozuuhbw72lzolj5@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nadav Amit <namit@vmware.com>, linux-mm@kvack.org, nadav.amit@gmail.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org

Hi Peter,

On Fri, Aug 11, 2017 at 03:30:20PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 01, 2017 at 05:08:17PM -0700, Nadav Amit wrote:
> >  void tlb_finish_mmu(struct mmu_gather *tlb,
> >  		unsigned long start, unsigned long end)
> >  {
> > -	arch_tlb_finish_mmu(tlb, start, end);
> > +	/*
> > +	 * If there are parallel threads are doing PTE changes on same range
> > +	 * under non-exclusive lock(e.g., mmap_sem read-side) but defer TLB
> > +	 * flush by batching, a thread has stable TLB entry can fail to flush
> > +	 * the TLB by observing pte_none|!pte_dirty, for example so flush TLB
> > +	 * forcefully if we detect parallel PTE batching threads.
> > +	 */
> > +	bool force = mm_tlb_flush_nested(tlb->mm);
> > +
> > +	arch_tlb_finish_mmu(tlb, start, end, force);
> >  }
> 
> I don't understand the comment nor the ordering. What guarantees we see
> the increment if we need to?

How about this about commenting part?

From 05f06fd6aba14447a9ca2df8b810fbcf9a58e14b Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 14 Aug 2017 10:16:56 +0900
Subject: [PATCH] mm: add describable comment for TLB batch race

[1] is a rather subtle/complicated bug so that it's hard to
understand it with limited code comment.

This patch adds a sequence diagaram to explain the problem
more easily, I hope.

[1] 99baac21e458, mm: fix MADV_[FREE|DONTNEED] TLB flush miss problem

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/memory.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index bcbe56f52163..f571b0eb9816 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -413,12 +413,37 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 void tlb_finish_mmu(struct mmu_gather *tlb,
 		unsigned long start, unsigned long end)
 {
+
+
 	/*
 	 * If there are parallel threads are doing PTE changes on same range
 	 * under non-exclusive lock(e.g., mmap_sem read-side) but defer TLB
 	 * flush by batching, a thread has stable TLB entry can fail to flush
 	 * the TLB by observing pte_none|!pte_dirty, for example so flush TLB
 	 * forcefully if we detect parallel PTE batching threads.
+	 *
+	 * Example: MADV_DONTNEED stale TLB problem on same range
+	 *
+	 * CPU 0				CPU 1
+	 * *a = 1;
+	 *					MADV_DONTNEED
+	 * MADV_DONTNEED			tlb_gather_mmu
+	 * tlb_gather_mmu
+	 * down_read(mmap_sem)			down_read(mmap_sem)
+	 *					pte_lock
+	 *					pte_get_and_clear
+	 *					tlb_remove_tlb_entry
+	 *					pte_unlock
+	 * pte_lock
+	 * found out the pte is none
+	 * pte_unlock
+	 * tlb_finish_mmu doesn't flush
+	 *
+	 * Access the address with stale TLB
+	 * *a = 2;ie, success without segfault
+	 *					tlb_finish_mmu flush on range
+	 *					but it is too late.
+	 *
 	 */
 	bool force = mm_tlb_flush_nested(tlb->mm);
 
-- 
2.7.4
