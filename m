From: Steve Capper <steve.capper@arm.com>
Subject: Re: [RFC PATCH 2/6] ARM: mm: Add support for flushing HugeTLB pages.
Date: Tue, 8 Jan 2013 17:56:47 +0000
Message-ID: <20130108175647.GB18347@e103986-lin>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
 <1350576942-25299-3-git-send-email-steve.capper@arm.com>
 <CANM98q+xSxqymrHnuDztZzY86p2gG_wSifOiSsSHj0kOTFAPyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54872 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756231Ab3AHR4v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2013 12:56:51 -0500
In-Reply-To: <CANM98q+xSxqymrHnuDztZzY86p2gG_wSifOiSsSHj0kOTFAPyw@mail.gmail.com>
Content-Language: en-US
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoffer Dall <c.dall@virtualopensystems.com>
Cc: Steve Capper <Steve.Capper@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "bill4carson@gmail.com" <bill4carson@gmail.com>, "tawfik@marvell.com" <tawfik@marvell.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "mhocko@suse.cz" <mhocko@suse.cz>, "maen@marvell.com" <maen@marvell.com>, "hoffman@marvell.com" <hoffman@marvell.com>, "notasas@gmail.com" <notasas@gmail.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "shadi@marvell.com" <shadi@marvell.com>

On Fri, Jan 04, 2013 at 05:03:36AM +0000, Christoffer Dall wrote:
> On Thu, Oct 18, 2012 at 12:15 PM, Steve Capper <steve.capper@arm.com> wrote:

> > diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> > index 1c8f7f5..0a69cb8 100644
> > --- a/arch/arm/mm/flush.c
> > +++ b/arch/arm/mm/flush.c
> > @@ -17,6 +17,7 @@
> >  #include <asm/highmem.h>
> >  #include <asm/smp_plat.h>
> >  #include <asm/tlbflush.h>
> > +#include <linux/hugetlb.h>
> >
> >  #include "mm.h"
> >
> > @@ -168,17 +169,21 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
> >          * coherent with the kernels mapping.
> >          */
> 
> I think it would be good to have a VM_BUG_ON(PageTail(page)) here.
> 

Yes, very much so :-).

> >         if (!PageHighMem(page)) {
> > -               __cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
> > +               __cpuc_flush_dcache_area(page_address(page), (PAGE_SIZE << compound_order(page)));
> 
> I think 98 characters is a stretch. You could do:
> 
> size_t page_size = PAGE_SIZE << compound_order(page);
> __cpuc_flush_dcache_area(page_address(page), page_size);
> 
> 

Yes, thanks, that does look better.

> >         } else {
> > -               void *addr = kmap_high_get(page);
> > -               if (addr) {
> > -                       __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > -                       kunmap_high(page);
> > -               } else if (cache_is_vipt()) {
> > -                       /* unmapped pages might still be cached */
> > -                       addr = kmap_atomic(page);
> > -                       __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > -                       kunmap_atomic(addr);
> > +               unsigned long i;
> > +               for(i = 0; i < (1 << compound_order(page)); i++) {
> > +                       struct page *cpage = page + i;
> > +                       void *addr = kmap_high_get(cpage);
> > +                       if (addr) {
> > +                               __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > +                               kunmap_high(cpage);
> > +                       } else if (cache_is_vipt()) {
> > +                               /* unmapped pages might still be cached */
> > +                               addr = kmap_atomic(cpage);
> > +                               __cpuc_flush_dcache_area(addr, PAGE_SIZE);
> > +                               kunmap_atomic(addr);
> > +                       }
> >                 }
> >         }
> >
> > --
> > 1.7.9.5
> >
> 
> otherwise it looks good to me.
> 
> -Christoffer
> 
