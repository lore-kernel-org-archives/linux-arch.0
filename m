From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM: add support to dump the kernel page tables
Date: Thu, 24 Oct 2013 13:23:06 +0100
Message-ID: <20131024122306.GK16735@n2100.arm.linux.org.uk>
References: <20131024071600.GC16735@n2100.arm.linux.org.uk> <20131024105143.GA24288@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41625 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab3JXMXr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2013 08:23:47 -0400
Content-Disposition: inline
In-Reply-To: <20131024105143.GA24288@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

On Thu, Oct 24, 2013 at 11:51:44AM +0100, Steve Capper wrote:
> Hi Russell,
> I've given this a quick go on an Arndale with LPAE, and have a few
> suggestions below.

Thanks.

> > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> > index 5689c18..d7682cd 100644
> > --- a/arch/arm/include/asm/pgtable-3level.h
> > +++ b/arch/arm/include/asm/pgtable-3level.h
> > @@ -140,6 +140,7 @@
> >  						 PMD_TYPE_TABLE)
> >  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >  						 PMD_TYPE_SECT)
> > +#define pmd_large(pmd)		pmd_sect(pmd)
> 
> Could we please instead do something like:
> #define pmd_large(pmd)         (pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> 
> This matches the logic used in the huge pages patches (it picks up the
> PROT_NONE case) that would be missed above.

Is this used in the generic parts of the kernel?  Can you please point
out where?

> The logic here needs adjusting for LPAE. Without LPAE,
> USER_PGTABLES_CEILING is equal to zero and i at 0.
> 
> With LPAE enabled, USER_PGTABLES_CEILING / PGDIR_SIZE == 2 for me, but
> pgd refers to the first pgd (not the third). Thus we walk the pgds we
> don't want to walk and get empty output.
> 
> The following worked for me:
>   static void walk_pgd(struct seq_file *m)
>   {
>           pgd_t *pgd = swapper_pg_dir;
>           struct pg_state st;
>           unsigned long addr;
>           unsigned i, pgdoff = USER_PGTABLES_CEILING / PGDIR_SIZE;
> 
>           memset(&st, 0, sizeof(st));
>           st.seq = m;
>           st.marker = address_markers;
> 
>           pgd += pgdoff;
> 
>           for (i = pgdoff; i < PTRS_PER_PGD; i++, pgd++) {
>                   addr = i * PGDIR_SIZE;
>                   if (!pgd_none(*pgd)) {
>                           walk_pud(&st, pgd, addr);
>                   } else {
>                           note_page(&st, addr, 1, pgd_val(*pgd));
>                   }
>           }
> 
>           note_page(&st, 0, 0, 0);
>   }
> 
> But pgdoff is a terrible variable name :-).

Nevertheless, I've taken that change. :)  Just tested on non-LPAE and it
still works, thanks.
