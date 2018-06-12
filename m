Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:54720 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754207AbeFLSOW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jun 2018 14:14:22 -0400
Received: by mail-it0-f65.google.com with SMTP id 76-v6so478867itx.4
        for <linux-arch@vger.kernel.org>; Tue, 12 Jun 2018 11:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180612071621.26775-1-npiggin@gmail.com> <20180612071621.26775-3-npiggin@gmail.com>
In-Reply-To: <20180612071621.26775-3-npiggin@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Jun 2018 11:14:10 -0700
Message-ID: <CA+55aFxaVyTZmKdywAGVopmWeDirb1Ou49XD_SfqGQL_ox_65Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] mm: mmu_gather track of invalidated TLB ranges
 explicitly for more precise flushing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arch <linux-arch@vger.kernel.org>, "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>, Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Nadav Amit <nadav.amit@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180612181410.SrQh1qozc6Au6cqbwvxgB7ft7czAeDmb3Q3WWMgYSqo@z>

On Tue, Jun 12, 2018 at 12:16 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> +static inline void __tlb_adjust_page_range(struct mmu_gather *tlb,
> +                                     unsigned long address,
> +                                     unsigned int range_size)
> +{
> +       tlb->page_start = min(tlb->page_start, address);
> +       tlb->page_end = max(tlb->page_end, address + range_size);
> +}

Why add this unnecessary complexity for architectures where it doesn't matter?

This is not "generic". This is some crazy powerpc special case. Why
add it to generic code, and why make everybody else take the cost?

                    Linus
