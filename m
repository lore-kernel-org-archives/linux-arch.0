Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42354 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfJKMTy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2019 08:19:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so9582838lje.9
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2019 05:19:53 -0700 (PDT)
Date: Fri, 11 Oct 2019 15:19:51 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 0/3] eldie generated code for folded p4d/pud
Message-ID: <20191011121951.nxna6hruuskvdxod@box>
References: <20191009222658.961-1-vgupta@synopsys.com>
 <20191010085609.xgwkrbzea253wmfg@black.fi.intel.com>
 <8ba067a6-8b6a-2414-0f04-b251cd6bb47c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba067a6-8b6a-2414-0f04-b251cd6bb47c@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <vineetg76@gmail.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>
Message-ID: <20191011121951.qCcpC8QGNWqX4xkAZIvYfRV-smRFiuHFPytUxwM0GSs@z>

On Thu, Oct 10, 2019 at 01:05:56PM -0700, Vineet Gupta wrote:
> 
> Hi Kirill,
> 
> On 10/10/19 1:56 AM, Kirill A. Shutemov wrote:
> > On Wed, Oct 09, 2019 at 10:26:55PM +0000, Vineet Gupta wrote:
> >>
> >> This series elides extraneous generate code for folded p4d/pud.
> >> This came up when trying to remove __ARCH_USE_5LEVEL_HACK from ARC port.
> >> The code saving are not a while lot, but still worthwhile IMHO.
> > 
> > Agreed.
> 
> Thx.
> 
> So given we are folding pmd too, it seemed we could do the following as well.
> 
> +#ifndef __PAGETABLE_PMD_FOLDED
>  void pmd_clear_bad(pmd_t *);
> +#else
> +#define pmd_clear_bad(pmd)        do { } while (0)
> +#endif
> 
> +#ifndef __PAGETABLE_PMD_FOLDED
>  void pmd_clear_bad(pmd_t *pmd)
>  {
>         pmd_ERROR(*pmd);
>         pmd_clear(pmd);
>  }
> +#endif
> 
> I stared at generated code and it seems a bit wrong.
> free_pgd_range() -> pgd_none_or_clear_bad() is no longer checking for unmapped pgd
> entries as pgd_none/pgd_bad are all stubs returning 0.
> 
> This whole pmd folding is a bit confusing considering I only revisit it every few
> years :-) Abstraction wise, __PAGETABLE_PMD_FOLDED only has pgd, pte but even in
> this regime bunch of pmd macros are still valid
> 
>     pmd_set(pmdp, ptep) {
>         *pmdp.pud.p4d.pgd = (unsigned long)ptep
>     }
> 
> Is there a better way to make a mental model of this code folding.

I don't have any. PMD folding predates me and have never looked at it
closely. Quick look brings more confusion than clarity. :P

> In an ideal world pmd folded would have meant pmd_* routines just vanish - poof.
> So in that sense I like your implementation under #[45]LEVEL_HACK where the level
> simply vanishes by code like #define p4d_t pgd_t. Perhaps there is lot of historic
> baggage, proliferated into arch code so hard to untangle.

In ideal world all these pgd/p4d/pud/pmd/pte should die and we have
something more flexible to begin with.

I played with this before:

https://lore.kernel.org/lkml/20180424154355.mfjgkf47kdp2by4e@black.fi.intel.com/

-- 
 Kirill A. Shutemov
