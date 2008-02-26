Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate7.de.ibm.com ([195.212.29.156]:16151 "EHLO
	mtagate7.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760984AbYBZR5z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2008 12:57:55 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m1QHvrOW149812
	for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2008 17:57:53 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m1QHvst32195510
	for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2008 18:57:54 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m1QHvrUg010080
	for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2008 17:57:54 GMT
Subject: Re: regression: 2f569af (CONFIG_HIGHPTE vs. sub-page page tables.)
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080226143858.GA11590@digi.com>
References: <20080225132648.GA13791@digi.com>
	 <1203958582.3247.3.camel@localhost>  <20080226143858.GA11590@digi.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 26 Feb 2008 18:57:46 +0100
Message-Id: <1204048666.21725.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

Hi Uwe,

On Tue, 2008-02-26 at 15:38 +0100, Uwe Kleine-König wrote:
> Moreover a "grep PageTables /proc/meminfo" resulted in 
> 
> 	9x __dec_zone_state with item == NR_PAGETABLE
> 	7x __inc_zone_state with item == NR_PAGETABLE
> 
> All those 16 calles where done via __(inc|dec)_zone_page_state.
> 
> ... some time later ...
> 
> I got it.  This code is currently in free_pgd_slow():
> 
>         pte = pmd_page(*pmd);
>         pmd_clear(pmd);
>         dec_zone_page_state(virt_to_page((unsigned long *)pgd), NR_PAGETABLE);
>         pte_lock_deinit(pte);
>         pte_free(mm, pte);
>         pmd_free(mm, pmd);
>
> So because (since 2f569af) pte_free does dec_zone_page_state and
> pte_lock_deinit, these two happen twice here.

Ah, good. I wonder if there are any other pte_lock_deinit hidden in the
arch code... nope, arm is the only architecture that does it.

> Removing the calls to dec_zone_page_state() and pte_lock_deinit() in
> free_pgd_slow() fixed it for me.

That is imho the best way to fix it.

> For a complete fix we might want to change the type of pte?

You mean instead of a "struct page *" use a pgtable_t ? Yes, that would
be cleaner even if it is the same type.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.


