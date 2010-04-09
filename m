From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 02/13] mm: Revalidate anon_vma in page_lock_anon_vma()
Date: Fri, 09 Apr 2010 10:44:53 +0200
Message-ID: <1270802693.20295.3272.camel@laptop>
References: <20100409150335.80E3.A69D9226@jp.fujitsu.com>
	 <20100409154730.e9945cbc.kamezawa.hiroyu@jp.fujitsu.com>
	 <20100409160252.80E6.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:53719 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab0DIIo6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2010 04:44:58 -0400
Received: from e35131.upc-e.chello.nl ([213.93.35.131] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O09ph-0000xl-Ku
	for linux-arch@vger.kernel.org; Fri, 09 Apr 2010 08:44:57 +0000
In-Reply-To: <20100409160252.80E6.A69D9226@jp.fujitsu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>

On Fri, 2010-04-09 at 16:29 +0900, KOSAKI Motohiro wrote:
> 
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 8b088f0..b4a0b5b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -295,7 +295,7 @@ struct anon_vma *page_lock_anon_vma(struct page
> *page)
>         unsigned long anon_mapping;
>  
>         rcu_read_lock();
> -       anon_mapping = (unsigned long) ACCESS_ONCE(page->mapping);
> +       anon_mapping = (unsigned long) rcu_dereference(page->mapping);
>         if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
>                 goto out;
>         if (!page_mapped(page)) 

Yes, I think this is indeed required.

I'll do a new version of the patch that includes the comment updates
requested by Andrew.
