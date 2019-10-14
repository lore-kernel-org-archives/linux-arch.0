Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36927 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731877AbfJNSCn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2019 14:02:43 -0400
Subject: Re: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if
 __PAGETABLE_PMD_FOLDED
References: <20191011121951.nxna6hruuskvdxod@box>
 <20191011223818.7238-1-vgupta@synopsys.com>
 <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
From: Vineet Gupta <vineetg76@gmail.com>
Message-ID: <c0979d98-7236-b7c8-bd40-173ee2e87385@gmail.com>
Date: Mon, 14 Oct 2019 11:02:38 -0700
MIME-Version: 1.0
In-Reply-To: <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20191014180238.kXPsm2UVWMLrVKnQjwIk-PlDCQul8N4fV7GqhypkQKQ@z>

On 10/14/19 10:41 AM, Linus Torvalds wrote:
> On Fri, Oct 11, 2019 at 3:38 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>>
>> This is inine with similar patches for nopud [1] and nop4d [2] cases.
> 
> I don't think your patch is wrong, but wouldn't it be easier and
> cleaner to just do this instead
> 
>     --- a/include/asm-generic/pgtable-nopmd.h
>     +++ b/include/asm-generic/pgtable-nopmd.h
>     @@ -60,7 +60,7 @@ static inline pmd_t * pmd_offset(pud_t * pud,
> unsigned long address)
>      static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>      {
>      }
>     -#define __pmd_free_tlb(tlb, x, a)          do { } while (0)
>     +#define pmd_free_tlb(tlb, x, a)            do { } while (0)
> 
>      #undef  pmd_addr_end
>      #define pmd_addr_end(addr, end)                    (end)

I suppose we could but

(a) It would be asymmetric with the __p{u,4}d_free_tlb() changes in [1] and [2].
Do you  prefer [1] and [2] be repun along the same lines as you propose above ?

(b) IMHO p?d_free_tlb() under corresponding #ifndef *P?D_FOLDED is much clearer to
read as being stubbed out. But this is minor point.

Also would you care to shed light on my other question about not being able to
fold away pmd_clear_bad() despite PMD_FOLDED given the pmd macros actually
checking for pgd. Of all the people you are likely to have most insight on how the
pmd folding actually evolved and works :-)

Thx,
-Vineet

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006266.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006265.html
