From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 05/10] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
Date: Sat, 25 Jan 2020 09:27:47 +0100
Message-ID: <20200125082746.GT11457@worktop.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-6-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAYI2O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 03:28:14 -0500
Content-Disposition: inline
In-Reply-To: <20200123153341.19947-6-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, ying.huang@intel.com, kirill.shutemov@linux.intel.com

On Thu, Jan 23, 2020 at 03:33:36PM +0000, Will Deacon wrote:
> {READ,WRITE}_ONCE() cannot guarantee atomicity for arbitrary data sizes.
> This can be surprising to callers that might incorrectly be expecting
> atomicity for accesses to aggregate structures, although there are other
> callers where tearing is actually permissable (e.g. if they are using
> something akin to sequence locking to protect the access).
> 
> Linus sayeth:
> 
>   | We could also look at being stricter for the normal READ/WRITE_ONCE(),
>   | and require that they are
>   |
>   | (a) regular integer types
>   |
>   | (b) fit in an atomic word
>   |
>   | We actually did (b) for a while, until we noticed that we do it on
>   | loff_t's etc and relaxed the rules. But maybe we could have a
>   | "non-atomic" version of READ/WRITE_ONCE() that is used for the
>   | questionable cases?
> 
> The slight snag is that we also have to support 64-bit accesses on 32-bit
> architectures, as these appear to be widespread and tend to work out ok
> if either the architecture supports atomic 64-bit accesses (x86, armv7)
> or if the variable being accesses represents a virtual address and
> therefore only requires 32-bit atomicity in practice.
> 
> Take a step in that direction by introducing a variant of
> 'compiletime_assert_atomic_type()' and use it to check the pointer
> argument to {READ,WRITE}_ONCE(). Expose __{READ,WRITE_ONCE}() variants
> which are allowed to tear and convert the two broken callers over to the
> new macros.

The build robot is telling me we also need this for m68k; they have:

  arch/m68k/include/asm/page.h:typedef struct { unsigned long pmd[16]; } pmd_t;

Commit 688272809fcce seems to suggest the below is actually wrong tho.

---
diff --git a/mm/gup.c b/mm/gup.c
index 7646bf993b25..62885dad5444 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -320,7 +320,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	 * The READ_ONCE() will stabilize the pmdval in a register or
 	 * on the stack so that it will stop changing under the code.
 	 */
-	pmdval = READ_ONCE(*pmd);
+	pmdval = __READ_ONCE(*pmd);
 	if (pmd_none(pmdval))
 		return no_page_table(vma, flags);
 	if (pmd_huge(pmdval) && vma->vm_flags & VM_HUGETLB) {
@@ -345,7 +345,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 				  !is_pmd_migration_entry(pmdval));
 		if (is_pmd_migration_entry(pmdval))
 			pmd_migration_entry_wait(mm, pmd);
-		pmdval = READ_ONCE(*pmd);
+		pmdval = __READ_ONCE(*pmd);
 		/*
 		 * MADV_DONTNEED may convert the pmd to null because
 		 * mmap_sem is held in read mode
