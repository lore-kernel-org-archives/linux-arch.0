Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfBSGRV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 01:17:21 -0500
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
Date: Tue, 19 Feb 2019 11:47:12 +0530
MIME-Version: 1.0
In-Reply-To: <20190219053205.GA124985@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Message-ID: <20190219061712.4u_iXsKGbzFDH5UJIgOdbIu_jZYJV529-MT2LetUgxE@z>

+ Matthew Wilcox

On 02/19/2019 11:02 AM, Yu Zhao wrote:
> On Tue, Feb 19, 2019 at 09:51:01AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 02/19/2019 04:43 AM, Yu Zhao wrote:
>>> For pte page, use pgtable_page_ctor(); for pmd page, use
>>> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
>>> p4d and pgd), don't use any.
>> pgtable_page_ctor()/dtor() is not optional for any level page table page
>> as it determines the struct page state and zone statistics.
> 
> This is not true. pgtable_page_ctor() is only meant for user pte
> page. The name isn't perfect (we named it this way before we had
> split pmd page table lock, and never bothered to change it).
> 
> The commit cccd843f54be ("mm: mark pages in use for page tables")
> clearly states so:
>   Note that only pages currently accounted as NR_PAGETABLES are
>   tracked as PageTable; this does not include pgd/p4d/pud/pmd pages.

I think the commit is the following one and it does say so. But what is
the rationale of tagging only PTE page as PageTable and updating the zone
stat but not doing so for higher level page table pages ? Are not they
used as page table pages ? Should not they count towards NR_PAGETABLE ?

1d40a5ea01d53251c ("mm: mark pages in use for page tables")
> 
> I'm sure if we go back further, we can find similar stories: we
> don't set PageTable on page tables other than pte; and we don't
> account page tables other than pte. I don't have any objection if
> you want change these two. But please make sure they are consistent
> across all archs.

pgtable_page_ctor/dtor() use across arch is not consistent and there is a need
for generalization which has been already acknowledged earlier. But for now we
can atleast fix this on arm64.

https://lore.kernel.org/lkml/1547619692-7946-1-git-send-email-anshuman.khandual@arm.com/

> 
>> We should not skip it for any page table page.
> 
> In fact, calling it on pmd/pud/p4d is peculiar, and may even be
> considered wrong. AFAIK, no other arch does so.

Why would it be considered wrong ? IIUC archs have their own understanding
of this and there are different implementations. But doing something for
PTE page and skipping for others is plain inconsistent.

> 
>> As stated before pgtable_pmd_page_ctor() is not a replacement for
>> pgtable_page_ctor().
> 
> pgtable_pmd_page_ctor() must be used on user pmd. For kernel pmd,
> it's okay to use pgtable_page_ctor() instead only because kernel
> doesn't have thp.

The only extra thing to be done for THP is initializing page->pmd_huge_pte
apart from calling pgtable_page_ctor(). Right not it just works on arm64
may be because page->pmd_huge_pte never gets accessed before it's init and
no path checks for it when not THP. Its better to init/reset pmd_huge_pte.
