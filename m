Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail29.messagelabs.com ([216.82.249.147]:62714 "HELO
	mail29.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752482AbYBZOjD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2008 09:39:03 -0500
Date: Tue, 26 Feb 2008 15:38:58 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: regression: 2f569af (CONFIG_HIGHPTE vs. sub-page page tables.)
Message-ID: <20080226143858.GA11590@digi.com>
References: <20080225132648.GA13791@digi.com> <1203958582.3247.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1203958582.3247.3.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

Hello Martin,

Martin Schwidefsky wrote:
> On Mon, 2008-02-25 at 14:26 +0100, Uwe Kleine-König wrote:
> > I see the following:
> > 
> > 	/ # for i in 1 2 3; do grep PageTables /proc/meminfo; done
> > 	PageTables:          4 kB
> > 	PageTables:   4294967292 kB
> > 	PageTables:   4294967284 kB
> > 
> > and I bisected it down to 2f569af (CONFIG_HIGHPTE vs. sub-page page
> > tables.)  This still happens in 2.6.25-rc3.
> > 
> > I have not investigated further, so I cannot tell if it's only the
> > output in meminfo that is broken.
> > 
> > This is on ARCH=arm, on a Digi cc9p9360 with ns9xxx_defconfig.
> 
> Hmm, not good. The number obviously went negative. There is an imbalance
> in the number of pgtable_page_ctor vs. pgtable_page_dtor. Could you try
> this patch and watch for warnings?
It doesn't trigger.

And your assumption that there is an imbalance between pgtable_page_ctor
and pgtable_page_dtor is wrong, too.  I added some debug output to both
of the two functions and for one grep both are executed seven times.

Moreover a "grep PageTables /proc/meminfo" resulted in 

	9x __dec_zone_state with item == NR_PAGETABLE
	7x __inc_zone_state with item == NR_PAGETABLE

All those 16 calles where done via __(inc|dec)_zone_page_state.

... some time later ...

I got it.  This code is currently in free_pgd_slow():

        pte = pmd_page(*pmd);
        pmd_clear(pmd);
        dec_zone_page_state(virt_to_page((unsigned long *)pgd), NR_PAGETABLE);
        pte_lock_deinit(pte);
        pte_free(mm, pte);
        pmd_free(mm, pmd);

So because (since 2f569af) pte_free does dec_zone_page_state and
pte_lock_deinit, these two happen twice here.

Removing the calls to dec_zone_page_state() and pte_lock_deinit() in
free_pgd_slow() fixed it for me.

For a complete fix we might want to change the type of pte?

Best regards
Uwe

-- 
Uwe Kleine-König, Software Engineer
Digi International GmbH Branch Breisach, Küferstrasse 8, 79206 Breisach, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962
