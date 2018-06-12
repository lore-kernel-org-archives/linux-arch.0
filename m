Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45828 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934418AbeFLWby (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jun 2018 18:31:54 -0400
Received: by mail-pf0-f193.google.com with SMTP id a22-v6so264028pfo.12
        for <linux-arch@vger.kernel.org>; Tue, 12 Jun 2018 15:31:54 -0700 (PDT)
Date: Wed, 13 Jun 2018 08:31:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 3/3] powerpc/64s/radix: optimise TLB flush with
 precise TLB ranges in mmu_gather
Message-ID: <20180613083131.139a3c34@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFzKBieD0Y3sgFQzt+x5esqb9vT6SEQ28xyCz5UWegfFVg@mail.gmail.com>
References: <20180612071621.26775-1-npiggin@gmail.com>
        <20180612071621.26775-4-npiggin@gmail.com>
        <CA+55aFzKBieD0Y3sgFQzt+x5esqb9vT6SEQ28xyCz5UWegfFVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arch <linux-arch@vger.kernel.org>, "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>, Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Nadav Amit <nadav.amit@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180612223131.Kho6JbiGWRPlTPdK9a596-uzL7eG_IMi6zFfVBQ6sGA@z>

On Tue, 12 Jun 2018 11:18:27 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Jun 12, 2018 at 12:16 AM Nicholas Piggin <npiggin@gmail.com> wrot=
e:
> >
> > This brings the number of tlbiel instructions required by a kernel
> > compile from 33M to 25M, most avoided from exec->shift_arg_pages. =20
>=20
> And this shows that "page_start/end" is purely for powerpc and used
> nowhere else.
>=20
> The previous patch should have been to purely powerpc page table
> walking and not touch asm-generic/tlb.h
>=20
> I think you should make those changes to
> arch/powerpc/include/asm/tlb.h. If that means you can't use the
> generic header, then so be it.

I can make it ppc specific if nobody else would use it. But at least
mmu notifiers AFAIKS would rather use a precise range.

> Or maybe you can embed the generic case in some ppc-specific
> structures, and use 90% of the generic code just with your added
> wrappers for that radix invalidation on top.

Would you mind another arch specific ifdefs in there?

>=20
> But don't make other architectures do pointless work that doesn't
> matter - or make sense - for them.

Okay sure, and this is the reason for the wide cc list. Intel does
need it of course, from 4.10.3.1 of the dev manual:

  =E2=80=94 The processor may create a PML4-cache entry even if there are no
    translations for any linear address that might use that entry
    (e.g., because the P flags are 0 in all entries in the referenced
    page-directory-pointer table).

But I'm sure others would not have paging structure caches at all
(some don't even walk the page tables in hardware right?). Maybe
they're all doing their own thing though.

Thanks,
Nick
