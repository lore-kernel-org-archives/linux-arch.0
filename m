From: Christoffer Dall <c.dall@virtualopensystems.com>
Subject: Re: [RFC PATCH 2/6] ARM: mm: Add support for flushing HugeTLB pages.
Date: Fri, 4 Jan 2013 00:03:36 -0500
Message-ID: <CANM98q+xSxqymrHnuDztZzY86p2gG_wSifOiSsSHj0kOTFAPyw@mail.gmail.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
	<1350576942-25299-3-git-send-email-steve.capper@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:65030 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3ADFDh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jan 2013 00:03:37 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so19190661iea.21
        for <linux-arch@vger.kernel.org>; Thu, 03 Jan 2013 21:03:36 -0800 (PST)
In-Reply-To: <1350576942-25299-3-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, aarcange@redhat.com, bill4carson@gmail.com, tawfik@marvell.com, catalin.marinas@arm.com, will.deacon@arm.com, cmetcalf@tilera.com, mhocko@suse.cz, maen@marvell.com, hoffman@marvell.com, notasas@gmail.com, kirill@shutemov.name, akpm@linux-foundation.org, shadi@marvell.com

On Thu, Oct 18, 2012 at 12:15 PM, Steve Capper <steve.capper@arm.com> wrote:
> On ARM we use the __flush_dcache_page function to flush the dcache of pages
> when needed; usually when the PG_dcache_clean bit is unset and we are setting a
> PTE.
>
> A HugeTLB page is represented as a compound page consisting of an array of
> pages. Thus to flush the dcache of a HugeTLB page, one must flush more than a
> single page.
>
> This patch modifies __flush_dcache_page such that all constituent pages of a
> HugeTLB page are flushed.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> ---
>  arch/arm/mm/flush.c |   25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 1c8f7f5..0a69cb8 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -17,6 +17,7 @@
>  #include <asm/highmem.h>
>  #include <asm/smp_plat.h>
>  #include <asm/tlbflush.h>
> +#include <linux/hugetlb.h>
>
>  #include "mm.h"
>
> @@ -168,17 +169,21 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
>          * coherent with the kernels mapping.
>          */

I think it would be good to have a VM_BUG_ON(PageTail(page)) here.

>         if (!PageHighMem(page)) {
> -               __cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
> +               __cpuc_flush_dcache_area(page_address(page), (PAGE_SIZE << compound_order(page)));

I think 98 characters is a stretch. You could do:

size_t page_size = PAGE_SIZE << compound_order(page);
__cpuc_flush_dcache_area(page_address(page), page_size);


>         } else {
> -               void *addr = kmap_high_get(page);
> -               if (addr) {
> -                       __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> -                       kunmap_high(page);
> -               } else if (cache_is_vipt()) {
> -                       /* unmapped pages might still be cached */
> -                       addr = kmap_atomic(page);
> -                       __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> -                       kunmap_atomic(addr);
> +               unsigned long i;
> +               for(i = 0; i < (1 << compound_order(page)); i++) {
> +                       struct page *cpage = page + i;
> +                       void *addr = kmap_high_get(cpage);
> +                       if (addr) {
> +                               __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> +                               kunmap_high(cpage);
> +                       } else if (cache_is_vipt()) {
> +                               /* unmapped pages might still be cached */
> +                               addr = kmap_atomic(cpage);
> +                               __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> +                               kunmap_atomic(addr);
> +                       }
>                 }
>         }
>
> --
> 1.7.9.5
>

otherwise it looks good to me.

-Christoffer
