From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 02/13] mm: Revalidate anon_vma in page_lock_anon_vma()
Date: Fri,  9 Apr 2010 11:19:52 +0900 (JST)
Message-ID: <20100409110235.80DD.A69D9226@jp.fujitsu.com>
References: <20100408142051.717b278c.akpm@linux-foundation.org> <1270763666.20295.3198.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:59893 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab0DICT4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2010 22:19:56 -0400
In-Reply-To: <1270763666.20295.3198.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kosaki.motohiro@jp.fujitsu.com, Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>

Hi

> > - Then checks page_mapped() without having any apparent defence
> >   against page_mapped() becoming untrue one nanosecond later.
> > 
> > - Checks page_mapped() inside the rcu_read_locked() section for
> >   inscrutable reasons.
> 
> Right, I think the page_mapped() stuff is just an early bail out.

FWIW, not only early bail out.
page_remove_rmap() don't have "page->mapping = NULL". page_remove_rmap's
comment says

        /*
         * It would be tidy to reset the PageAnon mapping here,
         * but that might overwrite a racing page_add_anon_rmap
         * which increments mapcount after us but sets mapping
         * before us: so leave the reset to free_hot_cold_page,
         * and remember that it's only reliable while mapped.
         * Leaving it set also helps swapoff to reinstate ptes
         * faster for those pages still in swapcache.
         */

So, If following scenario happen, we can't dereference page->mapping
(iow, can't call spin_lock(&anon_vma->lock)). It might be pointed 
invalid address.


   CPU0                                CPU1
===============================================================
page->mappings become -1
anon_vma_unlink()
-- grace period --
                                      page_lock_anon_vma
                                      page_mapped()
                                      spin_lock(&anon_vma->lock);



Of cource, this statement doesn't mean I'm against your patch at all.
I like it.
