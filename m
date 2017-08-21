From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] mm/hugetlb.c: make huge_pte_offset() consistent and
 document behaviour
Date: Mon, 21 Aug 2017 19:07:42 +0100
Message-ID: <20170821180741.4ns2s4wp3t2r6mpi@armageddon.cambridge.arm.com>
References: <20170725154114.24131-2-punit.agrawal@arm.com>
 <20170818145415.7588-1-punit.agrawal@arm.com>
 <3de49294-f6f8-2623-1778-56a3b092f2a5@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753333AbdHUSHq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Aug 2017 14:07:46 -0400
Content-Disposition: inline
In-Reply-To: <3de49294-f6f8-2623-1778-56a3b092f2a5@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Steve Capper <steve.capper@arm.com>, Will Deacon <will.deacon@arm.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>

On Fri, Aug 18, 2017 at 02:29:18PM -0700, Mike Kravetz wrote:
> On 08/18/2017 07:54 AM, Punit Agrawal wrote:
> > When walking the page tables to resolve an address that points to
> > !p*d_present() entry, huge_pte_offset() returns inconsistent values
> > depending on the level of page table (PUD or PMD).
> > 
> > It returns NULL in the case of a PUD entry while in the case of a PMD
> > entry, it returns a pointer to the page table entry.
> > 
> > A similar inconsitency exists when handling swap entries - returns NULL
> > for a PUD entry while a pointer to the pte_t is retured for the PMD entry.
> > 
> > Update huge_pte_offset() to make the behaviour consistent - return a
> > pointer to the pte_t for hugepage or swap entries. Only return NULL in
> > instances where we have a p*d_none() entry and the size parameter
> > doesn't match the hugepage size at this level of the page table.
> > 
> > Document the behaviour to clarify the expected behaviour of this function.
> > This is to set clear semantics for architecture specific implementations
> > of huge_pte_offset().
> > 
> > Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Cc: Steve Capper <steve.capper@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> > 
> > Hi Andrew,
> > 
> > From discussions on the arm64 implementation of huge_pte_offset()[0]
> > we realised that there is benefit from returning a pte_t* in the case
> > of p*d_none().
> > 
> > The fault handling code in hugetlb_fault() can handle p*d_none()
> > entries and saves an extra round trip to huge_pte_alloc(). Other
> > callers of huge_pte_offset() should be ok as well.
> 
> Yes, this change would eliminate that call to huge_pte_alloc() in
> hugetlb_fault().  However, huge_pte_offset() is now returning a pointer
> to a p*d_none() pte in some instances where it would have previously
> returned NULL.  Correct?

Yes (whether it was previously the right thing to return is a different
matter; that's what we are trying to clarify in the generic code so that
we can have similar semantics on arm64).

> I went through the callers, and like you am fairly confident that they
> can handle this situation.  But, returning  p*d_none() instead of NULL
> does change the execution path in several routines such as
> copy_hugetlb_page_range, __unmap_hugepage_range hugetlb_change_protection,
> and follow_hugetlb_page.  If huge_pte_alloc() returns NULL to these
> routines, they do a quick continue, exit, etc.  If they are returned
> a pointer, they typically lock the page table(s) and then check for
> p*d_none() before continuing, exiting, etc.  So, it appears that these
> routines could potentially slow down a bit with this change (in the specific
> case of p*d_none).

Arguably (well, my interpretation), it should return a NULL only if the
entry is a table entry, potentially pointing to a next level (pmd). In
the pud case, this means that sz < PUD_SIZE.

If the pud is a last level huge page entry (either present or !present),
huge_pte_offset() should return the pointer to it and never NULL. If the
entry is a swap or migration one (pte_present() == false) with the
current code we don't even enter the corresponding checks in
copy_hugetlb_page_range().

I also assume that the ptl __unmap_hugepage_range() is taken to avoid
some race when the entry is a huge page (present or not). If such race
doesn't exist, we could as well check the huge_pte_none() outside the
locked region (which is what the current huge_pte_offset() does with
!pud_present()).

IMHO, while the current generic huge_pte_offset() avoids some code paths
in the functions you mentioned, the results are not always correct
(missing swap/migration entries or potentially racy).

-- 
Catalin
