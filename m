Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH] set_pte() part 2 arch usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20050225103730.75adf2f0.davem@davemloft.net>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	 <1109222328.15027.12.camel@gaston>
	 <20050224143601.12c340ca.davem@davemloft.net>
	 <1109309524.14993.56.camel@gaston> <1109316055.14992.60.camel@gaston>
	 <20050225103730.75adf2f0.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 26 Feb 2005 11:56:09 +1100
Message-Id: <1109379369.15027.99.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2005-02-25 at 10:37 -0800, David S. Miller wrote:
> On Fri, 25 Feb 2005 18:20:55 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Ok, LTP dies on POWER5, investigation in progress ;)
> 
> I bet the address arg is incorrect in some case.

Yes, probably. That's the same symptoms we had when zeromap_pud_range
had the bug getting the address wrong, which means we fail to properly
flush the hash & TLB for this PTE. I'm not at work (it's sat. already
here :) but I'll have a look asap.

> It is ea<sy
> to add debugging for this, for example in your set_pte_at()
> implementation you can do something like:
> 
> static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> 			      pte_t *ptep, pte_t pte)
> {
> #ifdef DEBUG_SET_PTE_AT
> 	{
> 		pgd_t *pgd_check = pgd_offset(mm, addr);
> 		pud_t *pud_check = pud_offset(pgd_check, addr);
> 		pmd_t *pmd_check = pmd_offset(pud_check, addr);
> 		pte_t *pte_check = pte_offset(pmd_check, addr);
> 
> 		BUG_ON(pte_check != ptep);
> 	}
> #endif
> }

Good idea.

> BUG_ON() may hinder debugging if you hit a range of such
> incorrect calculations, so maybe a single printk which
> just prints __builtin_return_address(0) or current_text_addr()
> as well.

Nah, just xmon(NULL); :=)

Ben.
