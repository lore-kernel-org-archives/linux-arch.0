Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11489 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbaLXMXL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Dec 2014 07:23:11 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 22/38] metag: drop _PAGE_FILE and pte_file()-related helpers
Date: Wed, 24 Dec 2014 14:22:30 +0200
Message-ID: <1419423766-114457-23-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, mingo@kernel.org, davej@redhat.com, sasha.levin@oracle.com, hughd@google.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, James Hogan <james.hogan@imgtec.com>
Message-ID: <20141224122230.gKexlZma6R9Ru8KVllVdp79rtIdWoK-TYAiKr9yCN6s@z>

We've replaced remap_file_pages(2) implementation with emulation.
Nobody creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/include/asm/pgtable.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/metag/include/asm/pgtable.h b/arch/metag/include/asm/pgtable.h
index 0d9dc5487296..d0604c0a8702 100644
--- a/arch/metag/include/asm/pgtable.h
+++ b/arch/metag/include/asm/pgtable.h
@@ -47,7 +47,6 @@
  */
 #define _PAGE_ACCESSED		_PAGE_ALWAYS_ZERO_1
 #define _PAGE_DIRTY		_PAGE_ALWAYS_ZERO_2
-#define _PAGE_FILE		_PAGE_ALWAYS_ZERO_3
 
 /* Pages owned, and protected by, the kernel. */
 #define _PAGE_KERNEL		_PAGE_PRIV
@@ -219,7 +218,6 @@ extern unsigned long empty_zero_page;
 static inline int pte_write(pte_t pte)   { return pte_val(pte) & _PAGE_WRITE; }
 static inline int pte_dirty(pte_t pte)   { return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)   { return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)    { return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_special(pte_t pte) { return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte) { pte_val(pte) &= (~_PAGE_WRITE); return pte; }
@@ -327,10 +325,6 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#define PTE_FILE_MAX_BITS	22
-#define pte_to_pgoff(x)		(pte_val(x) >> 10)
-#define pgoff_to_pte(x)		__pte(((x) << 10) | _PAGE_FILE)
-
 #define kern_addr_valid(addr)	(1)
 
 /*
-- 
2.1.3

