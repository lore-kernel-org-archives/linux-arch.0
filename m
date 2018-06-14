Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:52321 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeFNGP7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jun 2018 02:15:59 -0400
Received: by mail-it0-f65.google.com with SMTP id m194-v6so6851951itg.2
        for <linux-arch@vger.kernel.org>; Wed, 13 Jun 2018 23:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180612071621.26775-1-npiggin@gmail.com> <20180612071621.26775-4-npiggin@gmail.com>
 <CA+55aFzKBieD0Y3sgFQzt+x5esqb9vT6SEQ28xyCz5UWegfFVg@mail.gmail.com>
 <20180613083131.139a3c34@roar.ozlabs.ibm.com> <CA+55aFyk9VBLUk8VYhfEUR55x0TXY9_QX1dE4wE0A_ias9tMNQ@mail.gmail.com>
 <20180613090950.50566245@roar.ozlabs.ibm.com> <CA+55aFxd97-29qi-JMxyPPoZMxw=eObQHB5XXGiLj7SNV8B-oQ@mail.gmail.com>
 <CA+55aFzbYBXUDcAGaP_HoCxjTvOgkixc0+7nJqMea0yKjLSnhw@mail.gmail.com>
 <20180613101241.004fd64e@roar.ozlabs.ibm.com> <CA+55aFzJRknbQD6Mv3OSOvUVozQ4H8ni8jPP7UEEi9wKXmVhQA@mail.gmail.com>
 <20180614124931.703e5b54@roar.ozlabs.ibm.com>
In-Reply-To: <20180614124931.703e5b54@roar.ozlabs.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Jun 2018 15:15:47 +0900
Message-ID: <CA+55aFwP-6QZ0u2ZYCjTebP6OmkeTpbUHyLT0ih-57TbvJBPxg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] powerpc/64s/radix: optimise TLB flush with
 precise TLB ranges in mmu_gather
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arch <linux-arch@vger.kernel.org>, "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>, Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Nadav Amit <nadav.amit@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180614061547.-H_7Dc-jPrrGTqRmnVcedEOXpFxWTJwWJ_hPvsrXEy8@z>

On Thu, Jun 14, 2018 at 11:49 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> +#ifndef pte_free_tlb
>  #define pte_free_tlb(tlb, ptep, address)                       \
>         do {                                                    \
>                 __tlb_adjust_range(tlb, address, PAGE_SIZE);    \
>                 __pte_free_tlb(tlb, ptep, address);             \
>         } while (0)
> +#endif

Do you really want to / need to take over the whole pte_free_tlb macro?

I was hoping that you'd just replace the __tlv_adjust_range() instead.

Something like

 - replace the

        __tlb_adjust_range(tlb, address, PAGE_SIZE);

   with a "page directory" version:

        __tlb_free_directory(tlb, address, size);

 - have the default implementation for that be the old code:

        #ifndef __tlb_free_directory
          #define __tlb_free_directory(tlb,addr,size)
__tlb_adjust_range(tlb, addr, PAGE_SIZE)
        #endif

and that way architectures can now just hook into that
"__tlb_free_directory()" thing.

Hmm?

             Linus
