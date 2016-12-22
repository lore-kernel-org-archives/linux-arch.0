From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm: pmd dirty emulation in page fault handler
Date: Thu, 22 Dec 2016 21:35:33 +0300
Message-ID: <20161222183533.GA29876@node.shutemov.name>
References: <1482364101-16204-1-git-send-email-minchan@kernel.org>
 <20161222081713.GA32480@node.shutemov.name>
 <20161222145203.GA18970@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20161222145203.GA18970@bbox>
Sender: owner-linux-mm@kvack.org
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Jason Evans <je@fb.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "[4.5+]" <stable@vger.kernel.org>, Andreas Schwab <schwab@suse.de>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 22, 2016 at 11:52:03PM +0900, Minchan Kim wrote:
> Hello,
> 
> On Thu, Dec 22, 2016 at 11:17:13AM +0300, Kirill A. Shutemov wrote:
> 
> < snip >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 36c774f..7408ddc 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3637,18 +3637,20 @@ static int __handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> > >  			if (pmd_protnone(orig_pmd) && vma_is_accessible(vma))
> > >  				return do_huge_pmd_numa_page(&vmf, orig_pmd);
> > >  
> > > -			if ((vmf.flags & FAULT_FLAG_WRITE) &&
> > > -					!pmd_write(orig_pmd)) {
> > > -				ret = wp_huge_pmd(&vmf, orig_pmd);
> > > -				if (!(ret & VM_FAULT_FALLBACK))
> > > +			if (vmf.flags & FAULT_FLAG_WRITE) {
> > > +				if (!pmd_write(orig_pmd)) {
> > > +					ret = wp_huge_pmd(&vmf, orig_pmd);
> > > +					if (ret == VM_FAULT_FALLBACK)
> > 
> > In theory, more than one flag can be set and it would lead to
> > false-negative. Bit check was the right thing.
> > 
> > And I don't understand why do you need to change code in
> > __handle_mm_fault() at all.
> > From what I see change to huge_pmd_set_accessed() should be enough.
> 
> Yeb. Thanks for the review. Here v2 goes.
> 
> From b3ec95c0df91ad113525968a4a6b53030fd0b48d Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Thu, 22 Dec 2016 23:43:49 +0900
> Subject: [PATCH v2] mm: pmd dirty emulation in page fault handler
> 
> Andreas reported [1] made a test in jemalloc hang in THP mode in arm64.
> http://lkml.kernel.org/r/mvmmvfy37g1.fsf@hawking.suse.de
> 
> The problem is page fault handler supports only accessed flag emulation
> for THP page of SW-dirty/accessed architecture.
> 
> This patch enables dirty-bit emulation for those architectures.
> Without it, MADV_FREE makes application hang by repeated fault forever.
> 
> [1] b8d3c4c3009d, mm/huge_memory.c: don't split THP page when MADV_FREE syscall is called
> 
> Cc: Jason Evans <je@fb.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: <stable@vger.kernel.org> [4.5+]
> Fixes: b8d3c4c3009d ("mm/huge_memory.c: don't split THP page when MADV_FREE syscall is called")
> Reported-by: Andreas Schwab <schwab@suse.de>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
