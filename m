Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35131 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfJNTIH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2019 15:08:07 -0400
Subject: Re: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if
 __PAGETABLE_PMD_FOLDED
References: <20191011121951.nxna6hruuskvdxod@box>
 <20191011223818.7238-1-vgupta@synopsys.com>
 <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
 <c0979d98-7236-b7c8-bd40-173ee2e87385@gmail.com>
 <CAHk-=wi3WXpKJkcpgHkUMgLiX9UdXnXhSFzBd8vTWkKgFpz0+Q@mail.gmail.com>
From: Vineet Gupta <vineetg76@gmail.com>
Message-ID: <8bfd023b-5c00-8355-fd0f-3b4377951e6c@gmail.com>
Date: Mon, 14 Oct 2019 12:08:03 -0700
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi3WXpKJkcpgHkUMgLiX9UdXnXhSFzBd8vTWkKgFpz0+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20191014190803.LOnhv2PkBiD8uCY5Hcnbag09p9RkgCEN6Ebyc96-Fcg@z>

On 10/14/19 11:25 AM, Linus Torvalds wrote:
> On Mon, Oct 14, 2019 at 11:02 AM Vineet Gupta <vineetg76@gmail.com> wrote:
>>
>> I suppose we could but
>>
>> (a) It would be asymmetric with the __p{u,4}d_free_tlb() changes in [1] and [2].
> 
> Your patch is already assymmetric wrt those anyway - you had to add that
> 
>   +#else
>   +#define pmd_free_tlb(tlb, pmdp, address)        do { } while (0)
>   +#endif
> 
> that the other cases don't currently have, so then you point to
> another patch that makes the code uglier instead.
> 
>> Do you  prefer [1] and [2] be repun along the same lines as you propose above ?
> 
> In general, I absolutely detest how we have random
> 
>    #ifndef ARCH_HAS_ONE_DEFINE
>    #define another_define_entirely()
>    ...
> 
> which makes no sense and is ugly, and also wreaks havoc on simple
> things like "git grep another_define_entirely"
> 
> I've long tried to convince people to just do
> 
>   #ifndef special_define
>   #define special_define(xyz) ..
>   #endif
> 
> instead, which doesn't mix up two completely unrelated names, and when
> you grep for that function name, you _see_ all the context.

Ok fair enough, I'd just add extra comments to non stubbed p?d_free_tlb that they
are stubbed out for corresponding case.

> 
>> Also would you care to shed light on my other question about not being able to
>> fold away pmd_clear_bad() despite PMD_FOLDED given the pmd macros actually
>> checking for pgd. Of all the people you are likely to have most insight on how the
>> pmd folding actually evolved and works :-)
> 
> I think some of it is just ugly and historical, and confused.
> 
> In general, it should always be the "higher" level that folds away. So
> I think the best example of this is
> 
>   include/asm-generic/pgtable-nop4d.h
> 
> where basically all the "pgd" functions become no-ops, and can never
> not exist or be bad, because they are always just containers for the
> lower level and don't have any data in them themselves:
> 
>   static inline int pgd_none(pgd_t pgd)           { return 0; }
>   static inline int pgd_bad(pgd_t pgd)            { return 0; }
>   static inline int pgd_present(pgd_t pgd)        { return 1; }
>   static inline void pgd_clear(pgd_t *pgd)        { }
> 
> and walking from pgd to p4d is that nice folded op:
> 
>   static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
>   { return (p4d_t *)pgd; }
> 
> and this is how it should always work.See "nopud" and "nopmd"(which
> are 3rd/2nd level respectively) doing the same thing exactly.

Right, my naive mental model was assuming nopmd would somehow stub out pmd_*
macros (or call into upper level function somehow etc), wheres here
(1) we stub out the prior level and
(2) the function of stubbed level operate on the data type of higher level.


> And yes, pmd_clear_bad() should just go away. We have
> 
>   static inline int pmd_none_or_clear_bad(pmd_t *pmd)
>   {
>         if (pmd_none(*pmd))
>                 return 1;
>         if (unlikely(pmd_bad(*pmd))) {
>                 pmd_clear_bad(pmd);
>                 return 1;
>         }
>         return 0;
>   }
> 
> and if the pmd doesn't exist, then both pmd_none() and pmd_bad()
> should just be zero (see above), and the pmd_none_or_clear_bad()
> should just become "return 0";
> 
> Exactly what part isn't working for you?

I haven't tested that patch but I suspect even if it was broken, it would not
necessarily show right away with a trivial test.

Anyhow my worry/confusions starts at free_pgd_range() where
pgd_none_or_clear_bad(pgd) is no-op given pgd_none()/pgd_bad() are stubs for nopmd
case.

  free_pgd_range
	pgd = pgd_offset(tlb->mm, addr);
	do {
		next = pgd_addr_end(addr, end);
		if (pgd_none_or_clear_bad(pgd))
			continue;
		free_p4e_range(tlb, pgd, addr);
	} while (pgd++, addr = next, addr != end);
   ...

And the validation of pgd entry actually happens in pmd_none_or_clear_bad(pmd)
since there pmd actually ends up referencing pgd entry. Hence the ensuing
pmd_clear_bad() doesn't seem like if it could be stubbed out.

  free_pmd_range
	pmd = pmd_offset(pud, addr);
	do {
		next = pmd_addr_end(addr, end);
		if (pmd_none_or_clear_bad(pmd)) <--- pmd_bad()/pmd_clear_bad()
			continue;
		free_pte_range(tlb, pmd, addr);
	} while (pmd++, addr = next, addr != end);

I'm sure I'm missing something, but don't understand what !
