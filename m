Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21933
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S964949AbWFAVED (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Jun 2006 17:04:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.sfo1.dsl.speakeasy.net (Postfix) with ESMTP id 192D5AE406B
	for <linux-arch@vger.kernel.org>; Thu,  1 Jun 2006 14:04:33 -0700 (PDT)
Date: Thu, 01 Jun 2006 14:04:33 -0700 (PDT)
Message-Id: <20060601.140433.40742272.davem@davemloft.net>
Subject: mremap() BUG on virtually indexed caches
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


I just discovered a serious problem with mremap() on platforms that
use virtually indexed caches.  It results in illegal cache aliases and
corrupt data, even for anonymous mmap()'s.  The bug has essentially
been around forever.

The problem occurs when MREMAP_MAYMOVE is passed into mremap(), the
area is moved instead of simply expanded/shrunk, and the virtual
address choosen for the new area has a different "virtual color" from
the previous location.

To be honest, the "ZERO_PAGE() mips" stuff for move_pte() should have
been a big red flag.

I'm actually surprised this bug didn't get spotted earlier.  For
example, glibc uses mmap() regions for malloc() buffers if they are
>128K in size, or something like that.  If you realloc() on such a
buffer then mremap() with MREMAP_MAYMOVE is used by glibc to expand
the area.

Guess what uses realloc() a _lot_ with >128K buffers?  dpkg.  When
it's parsing and building package database files, it uses this
expanding buffer thing called varbuf, every time a varbuf needs to
expand it uses realloc().

So the bug reports I saw on sparc64 were cases of the Debian package
database 'status' and 'available' files getting corrupted on Debian
and Debian derived systems such as Ubuntu.  It was always some
multiple of the cacheline size, the corruption pieces, and once I
strace'd dpkg and saw the voluminous mremap() calls it became clear
what might cause this.

There are several ways to deal with this bug, one example is attached
below which involved overriding move_pte() on the relevant platforms
in order to do the cache flush if necessary.  Another possible
solution is to make get_unmapped_area() smarter about this case, such
that it will choose the same virtual color as the existing mapping.
That would be desirable because it would eliminate all of the cache
flushing.

I'm working on a reproducable test case for this bug so that 1) I can
validate the bug and 2) other architecture maintainers can try the
test case on their platform.  This test case isn't easy to write
because you have to use carefully choosen guard mmap() pages in order
to both force a mremap() move during expansion, and also to force
get_unmapped_area() into choosing an area with a different virtual
color.  :-)

Anyways, I'll post that test case here once I have it working.

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 358e4d3..c2059a3 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -159,17 +159,8 @@ static inline void ptep_set_wrprotect(st
 #define lazy_mmu_prot_update(pte)	do { } while (0)
 #endif
 
-#ifndef __HAVE_ARCH_MULTIPLE_ZERO_PAGE
+#ifndef __HAVE_ARCH_MOVE_PTE
 #define move_pte(pte, prot, old_addr, new_addr)	(pte)
-#else
-#define move_pte(pte, prot, old_addr, new_addr)				\
-({									\
- 	pte_t newpte = (pte);						\
-	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
-			pte_page(pte) == ZERO_PAGE(old_addr))		\
-		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
-	newpte;								\
-})
 #endif
 
 /*
diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index 702a28f..69cebbd 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -70,7 +70,15 @@ extern unsigned long zero_page_mask;
 #define ZERO_PAGE(vaddr) \
 	(virt_to_page(empty_zero_page + (((unsigned long)(vaddr)) & zero_page_mask)))
 
-#define __HAVE_ARCH_MULTIPLE_ZERO_PAGE
+#define __HAVE_ARCH_MOVE_PTE
+#define move_pte(pte, prot, old_addr, new_addr)				\
+({									\
+ 	pte_t newpte = (pte);						\
+	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
+			pte_page(pte) == ZERO_PAGE(old_addr))		\
+		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
+	newpte;								\
+})
 
 extern void paging_init(void);
 
diff --git a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
index c44e746..afe6b97 100644
--- a/include/asm-sparc64/pgtable.h
+++ b/include/asm-sparc64/pgtable.h
@@ -689,6 +689,23 @@ static inline void set_pte_at(struct mm_
 #define pte_clear(mm,addr,ptep)		\
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
 
+#ifdef DCACHE_ALIASING_POSSIBLE
+#define __HAVE_ARCH_MOVE_PTE
+#define move_pte(pte, prot, old_addr, new_addr)				\
+({									\
+ 	pte_t newpte = (pte);						\
+	if (tlb_type != hypervisor && pte_present(pte)) {		\
+		unsigned long __pfn = pte_pfn(pte);			\
+									\
+		if (pfn_valid(__pfn) &&					\
+		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
+			flush_dcache_page_all(current->mm,		\
+					      pfn_to_page(__pfn));	\
+	}								\
+	newpte;								\
+})
+#endif
+
 extern pgd_t swapper_pg_dir[2048];
 extern pmd_t swapper_low_pmd_dir[2048];
 
