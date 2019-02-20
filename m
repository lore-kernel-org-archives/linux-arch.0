Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTBeP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 20:34:15 -0500
Date: Tue, 19 Feb 2019 17:34:07 -0800
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190220013407.GD12668@bombadil.infradead.org>
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
Cc: Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20190220013407.iZrJeluxSZwSKeMo7KUqRNKzFze1QCx1GimF_0dNsXw@z>

On Tue, Feb 19, 2019 at 11:47:12AM +0530, Anshuman Khandual wrote:
> + Matthew Wilcox
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

Where did you get that commit ID from?  In Linus' tree, it's
1d40a5ea01d53251c23c7be541d3f4a656cfc537

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

I think they should all be accounted towards NR_PAGETABLE and marked
as being PageTable.  Somebody needs to make the case for that and
send the patches.  That patch even says that there should be follow-up
patches to do that.  I've been a little busy and haven't got back to it.
I thought you said you were going to do it.

> pgtable_page_ctor/dtor() use across arch is not consistent and there is a need
> for generalization which has been already acknowledged earlier. But for now we
> can atleast fix this on arm64.
> 
> https://lore.kernel.org/lkml/1547619692-7946-1-git-send-email-anshuman.khandual@arm.com/

... were you not listening when you were told that was completely
inadequate?
