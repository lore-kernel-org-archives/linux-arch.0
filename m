Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44018 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfJNSZb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2019 14:25:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id u3so12466407lfl.10
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2019 11:25:30 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id e7sm4355218lfn.12.2019.10.14.11.25.24
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 11:25:25 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id x80so12497550lff.3
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2019 11:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191011121951.nxna6hruuskvdxod@box> <20191011223818.7238-1-vgupta@synopsys.com>
 <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com> <c0979d98-7236-b7c8-bd40-173ee2e87385@gmail.com>
In-Reply-To: <c0979d98-7236-b7c8-bd40-173ee2e87385@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Oct 2019 11:25:08 -0700
Message-ID: <CAHk-=wi3WXpKJkcpgHkUMgLiX9UdXnXhSFzBd8vTWkKgFpz0+Q@mail.gmail.com>
Subject: Re: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if __PAGETABLE_PMD_FOLDED
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <vineetg76@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20191014182508.ym3A3AW9_bE4p-76IjhasAB5Dc4QMjsswE5HrEdMVKw@z>

On Mon, Oct 14, 2019 at 11:02 AM Vineet Gupta <vineetg76@gmail.com> wrote:
>
> I suppose we could but
>
> (a) It would be asymmetric with the __p{u,4}d_free_tlb() changes in [1] and [2].

Your patch is already assymmetric wrt those anyway - you had to add that

  +#else
  +#define pmd_free_tlb(tlb, pmdp, address)        do { } while (0)
  +#endif

that the other cases don't currently have, so then you point to
another patch that makes the code uglier instead.

> Do you  prefer [1] and [2] be repun along the same lines as you propose above ?

In general, I absolutely detest how we have random

   #ifndef ARCH_HAS_ONE_DEFINE
   #define another_define_entirely()
   ...

which makes no sense and is ugly, and also wreaks havoc on simple
things like "git grep another_define_entirely"

I've long tried to convince people to just do

  #ifndef special_define
  #define special_define(xyz) ..
  #endif

instead, which doesn't mix up two completely unrelated names, and when
you grep for that function name, you _see_ all the context.

> Also would you care to shed light on my other question about not being able to
> fold away pmd_clear_bad() despite PMD_FOLDED given the pmd macros actually
> checking for pgd. Of all the people you are likely to have most insight on how the
> pmd folding actually evolved and works :-)

I think some of it is just ugly and historical, and confused.

In general, it should always be the "higher" level that folds away. So
I think the best example of this is

  include/asm-generic/pgtable-nop4d.h

where basically all the "pgd" functions become no-ops, and can never
not exist or be bad, because they are always just containers for the
lower level and don't have any data in them themselves:

  static inline int pgd_none(pgd_t pgd)           { return 0; }
  static inline int pgd_bad(pgd_t pgd)            { return 0; }
  static inline int pgd_present(pgd_t pgd)        { return 1; }
  static inline void pgd_clear(pgd_t *pgd)        { }

and walking from pgd to p4d is that nice folded op:

  static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
  { return (p4d_t *)pgd; }

and this is how it should always work.See "nopud" and "nopmd"(which
are 3rd/2nd level respectively) doing the same thing exactly.

And yes, pmd_clear_bad() should just go away. We have

  static inline int pmd_none_or_clear_bad(pmd_t *pmd)
  {
        if (pmd_none(*pmd))
                return 1;
        if (unlikely(pmd_bad(*pmd))) {
                pmd_clear_bad(pmd);
                return 1;
        }
        return 0;
  }

and if the pmd doesn't exist, then both pmd_none() and pmd_bad()
should just be zero (see above), and the pmd_none_or_clear_bad()
should just become "return 0";

Exactly what part isn't working for you?

I suspect part of the problem is exactly that we than have that stupid
confusion with some code checking "#ifdef __PAGETABLE_PMD_FOLDED" and
then making their own random decisions based on things like that
instead.

When you do that, the code ends up relying on other magic than just
the natural folding.

            Linus
