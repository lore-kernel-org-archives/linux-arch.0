From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm: pmd dirty emulation in page fault handler
Date: Thu, 22 Dec 2016 23:52:03 +0900
Message-ID: <20161222145203.GA18970@bbox>
References: <1482364101-16204-1-git-send-email-minchan@kernel.org>
 <20161222081713.GA32480@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161222081713.GA32480@node.shutemov.name>
Sender: stable-owner@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Jason Evans <je@fb.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "[4.5+]" <stable@vger.kernel.org>, Andreas Schwab <schwab@suse.de>
List-Id: linux-arch.vger.kernel.org

Hello,

On Thu, Dec 22, 2016 at 11:17:13AM +0300, Kirill A. Shutemov wrote:

< snip >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 36c774f..7408ddc 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3637,18 +3637,20 @@ static int __handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> >  			if (pmd_protnone(orig_pmd) && vma_is_accessible(vma))
> >  				return do_huge_pmd_numa_page(&vmf, orig_pmd);
> >  
> > -			if ((vmf.flags & FAULT_FLAG_WRITE) &&
> > -					!pmd_write(orig_pmd)) {
> > -				ret = wp_huge_pmd(&vmf, orig_pmd);
> > -				if (!(ret & VM_FAULT_FALLBACK))
> > +			if (vmf.flags & FAULT_FLAG_WRITE) {
> > +				if (!pmd_write(orig_pmd)) {
> > +					ret = wp_huge_pmd(&vmf, orig_pmd);
> > +					if (ret == VM_FAULT_FALLBACK)
> 
> In theory, more than one flag can be set and it would lead to
> false-negative. Bit check was the right thing.
> 
> And I don't understand why do you need to change code in
> __handle_mm_fault() at all.
> From what I see change to huge_pmd_set_accessed() should be enough.

Yeb. Thanks for the review. Here v2 goes.

From b3ec95c0df91ad113525968a4a6b53030fd0b48d Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Thu, 22 Dec 2016 23:43:49 +0900
Subject: [PATCH v2] mm: pmd dirty emulation in page fault handler

Andreas reported [1] made a test in jemalloc hang in THP mode in arm64.
http://lkml.kernel.org/r/mvmmvfy37g1.fsf@hawking.suse.de

The problem is page fault handler supports only accessed flag emulation
for THP page of SW-dirty/accessed architecture.

This patch enables dirty-bit emulation for those architectures.
Without it, MADV_FREE makes application hang by repeated fault forever.

[1] b8d3c4c3009d, mm/huge_memory.c: don't split THP page when MADV_FREE syscall is called

Cc: Jason Evans <je@fb.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: <stable@vger.kernel.org> [4.5+]
Fixes: b8d3c4c3009d ("mm/huge_memory.c: don't split THP page when MADV_FREE syscall is called")
Reported-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v1
  * Remove __handle_mm_fault part - Kirill

 mm/huge_memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 10eedbf..29ec8a4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -883,15 +883,17 @@ void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
 {
 	pmd_t entry;
 	unsigned long haddr;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
 
 	vmf->ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
 		goto unlock;
 
 	entry = pmd_mkyoung(orig_pmd);
+	if (write)
+		entry = pmd_mkdirty(entry);
 	haddr = vmf->address & HPAGE_PMD_MASK;
-	if (pmdp_set_access_flags(vmf->vma, haddr, vmf->pmd, entry,
-				vmf->flags & FAULT_FLAG_WRITE))
+	if (pmdp_set_access_flags(vmf->vma, haddr, vmf->pmd, entry, write))
 		update_mmu_cache_pmd(vmf->vma, vmf->address, vmf->pmd);
 
 unlock:
-- 
2.7.4
