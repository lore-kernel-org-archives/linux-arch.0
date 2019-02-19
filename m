Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:53877 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfBSW2c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 17:28:32 -0500
Received: by mail-it1-f195.google.com with SMTP id x131so10213044itc.3
        for <linux-arch@vger.kernel.org>; Tue, 19 Feb 2019 14:28:31 -0800 (PST)
Date: Tue, 19 Feb 2019 15:28:28 -0700
From: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190219222828.GA68281@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
 <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Message-ID: <20190219222828.PQwn4858C156zRL_BktEgXSSmhHNIZzgpoemcfWbQRw@z>

On Tue, Feb 19, 2019 at 11:47:12AM +0530, Anshuman Khandual wrote:
> + Matthew Wilcox
> 
> On 02/19/2019 11:02 AM, Yu Zhao wrote:
> > On Tue, Feb 19, 2019 at 09:51:01AM +0530, Anshuman Khandual wrote:
> >>
> >>
> >> On 02/19/2019 04:43 AM, Yu Zhao wrote:
> >>> For pte page, use pgtable_page_ctor(); for pmd page, use
> >>> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> >>> p4d and pgd), don't use any.
> >> pgtable_page_ctor()/dtor() is not optional for any level page table page
> >> as it determines the struct page state and zone statistics.
> > 
> > This is not true. pgtable_page_ctor() is only meant for user pte
> > page. The name isn't perfect (we named it this way before we had
> > split pmd page table lock, and never bothered to change it).
> > 
> > The commit cccd843f54be ("mm: mark pages in use for page tables")
> > clearly states so:
> >   Note that only pages currently accounted as NR_PAGETABLES are
> >   tracked as PageTable; this does not include pgd/p4d/pud/pmd pages.
> 
> I think the commit is the following one and it does say so. But what is
> the rationale of tagging only PTE page as PageTable and updating the zone
> stat but not doing so for higher level page table pages ? Are not they
> used as page table pages ? Should not they count towards NR_PAGETABLE ?
> 
> 1d40a5ea01d53251c ("mm: mark pages in use for page tables")

Well, I was just trying to clarify how the ctor is meant to be used.
The rational behind it is probably another topic.

For starters, the number of pmd/pud/p4d/pgd is at least two orders
of magnitude less than the number of pte, which makes them almost
negligible. And some archs use kmem for them, so it's infeasible to
SetPageTable on or account them in the way the ctor does on those
archs.

But, as I said, it's not something can't be changed. It's just not
the concern of this patch.

> > 
> > I'm sure if we go back further, we can find similar stories: we
> > don't set PageTable on page tables other than pte; and we don't
> > account page tables other than pte. I don't have any objection if
> > you want change these two. But please make sure they are consistent
> > across all archs.
> 
> pgtable_page_ctor/dtor() use across arch is not consistent and there is a need
> for generalization which has been already acknowledged earlier. But for now we
> can atleast fix this on arm64.
> 
> https://lore.kernel.org/lkml/1547619692-7946-1-git-send-email-anshuman.khandual@arm.com/

This is again not true. Please stop making claims not backed up by
facts. And the link is completely irrelevant to the ctor.

I just checked *all* arches. Only four arches call the ctor outside
pte_alloc_one(). They are arm, arm64, ppc and s390. The last two do
so not because they want to SetPageTable on or account pmd/pud/p4d/
pgd, but because they have to work around something, as arm/arm64
do.

> 
> > 
> >> We should not skip it for any page table page.
> > 
> > In fact, calling it on pmd/pud/p4d is peculiar, and may even be
> > considered wrong. AFAIK, no other arch does so.
> 
> Why would it be considered wrong ? IIUC archs have their own understanding
> of this and there are different implementations. But doing something for
> PTE page and skipping for others is plain inconsistent.

Allocating memory that will never be used is wrong. Please look into
the ctor and find out what exactly it does under different configs.

And why I said "may"? Because we know there is only negligible number
of pmd/pud/p4d, so the memory allocated may be considered negligible
as well.

> 
> > 
> >> As stated before pgtable_pmd_page_ctor() is not a replacement for
> >> pgtable_page_ctor().
> > 
> > pgtable_pmd_page_ctor() must be used on user pmd. For kernel pmd,
> > it's okay to use pgtable_page_ctor() instead only because kernel
> > doesn't have thp.
> 
> The only extra thing to be done for THP is initializing page->pmd_huge_pte
> apart from calling pgtable_page_ctor(). Right not it just works on arm64
> may be because page->pmd_huge_pte never gets accessed before it's init and
> no path checks for it when not THP. Its better to init/reset pmd_huge_pte.

This is not the reason. Arm64 gets by with calling
pgtable_page_ctor() on pmd because it only does so on efi_mm. efi_mm
is not user mm, therefore doesn't involve thp.
