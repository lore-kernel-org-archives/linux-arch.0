From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v4.1 4/8] mm, gup: Ensure real head page is ref-counted when using hugepages
Date: Mon, 12 Jun 2017 15:36:12 +0100
Message-ID: <87r2ypz31f.fsf@e105922-lin.cambridge.arm.com>
References: <20170524115409.31309-5-punit.agrawal@arm.com>
        <20170605125112.19530-1-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbdFLOgP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jun 2017 10:36:15 -0400
In-Reply-To: <20170605125112.19530-1-punit.agrawal@arm.com> (Punit Agrawal's
        message of "Mon, 5 Jun 2017 13:51:12 +0100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com, ynorov@caviumnetworks.com, Michal Hocko <mhocko@suse.com>

Punit Agrawal <punit.agrawal@arm.com> writes:

> When speculatively taking references to a hugepage using
> page_cache_add_speculative() in gup_huge_pmd(), it is assumed that the
> page returned by pmd_page() is the head page. Although normally true,
> this assumption doesn't hold when the hugepage comprises of successive
> page table entries such as when using contiguous bit on arm64 at PTE or
> PMD levels.
>
> This can be addressed by ensuring that the page passed to
> page_cache_add_speculative() is the real head or by de-referencing the
> head page within the function.
>
> We take the first approach to keep the usage pattern aligned with
> page_cache_get_speculative() where users already pass the appropriate
> page, i.e., the de-referenced head.
>
> Apply the same logic to fix gup_huge_[pud|pgd]() as well.
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>
> Hi Andrew,
>
> Please update the patch in your queue with this version.
>
> It fixes the ltp failures reported by Yury[0]. The original patch led
> to incorrect ref-count on certain pages due to taking a referencing on
> the following page in some instances. Should be fixed with this
> version.

Gentle ping!

Andrew, please update to this version of the patch - it fixes a breakage
on arm64.

Alternately, if you're OK with it, we could take the whole series via
the arm64 tree.

>
> Thanks,
> Punit
>
> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/510318.html
>
>  mm/gup.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index e74e0b5a0c7c..6bd39264d0e7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1354,8 +1354,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		return __gup_device_huge_pmd(orig, addr, end, pages, nr);
>  
>  	refs = 0;
> -	head = pmd_page(orig);
> -	page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> +	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>  	do {
>  		pages[*nr] = page;
>  		(*nr)++;
> @@ -1363,6 +1362,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		refs++;
>  	} while (addr += PAGE_SIZE, addr != end);
>  
> +	head = compound_head(pmd_page(orig));
>  	if (!page_cache_add_speculative(head, refs)) {
>  		*nr -= refs;
>  		return 0;
> @@ -1392,8 +1392,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  		return __gup_device_huge_pud(orig, addr, end, pages, nr);
>  
>  	refs = 0;
> -	head = pud_page(orig);
> -	page = head + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> +	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>  	do {
>  		pages[*nr] = page;
>  		(*nr)++;
> @@ -1401,6 +1400,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  		refs++;
>  	} while (addr += PAGE_SIZE, addr != end);
>  
> +	head = compound_head(pud_page(orig));
>  	if (!page_cache_add_speculative(head, refs)) {
>  		*nr -= refs;
>  		return 0;
> @@ -1429,8 +1429,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>  
>  	BUILD_BUG_ON(pgd_devmap(orig));
>  	refs = 0;
> -	head = pgd_page(orig);
> -	page = head + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
> +	page = pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
>  	do {
>  		pages[*nr] = page;
>  		(*nr)++;
> @@ -1438,6 +1437,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>  		refs++;
>  	} while (addr += PAGE_SIZE, addr != end);
>  
> +	head = compound_head(pgd_page(orig));
>  	if (!page_cache_add_speculative(head, refs)) {
>  		*nr -= refs;
>  		return 0;
