Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28627 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbaLXMXI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Dec 2014 07:23:08 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 16/38] cris: drop _PAGE_FILE and pte_file()-related helpers
Date: Wed, 24 Dec 2014 14:22:24 +0200
Message-ID: <1419423766-114457-17-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, mingo@kernel.org, davej@redhat.com, sasha.levin@oracle.com, hughd@google.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>
Message-ID: <20141224122224.vNb3e2SjUR2PtNEOPu4Y3F71xZkoEbro6OorU_xVN-s@z>

We've replaced remap_file_pages(2) implementation with emulation.
Nobody creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
---
 arch/cris/include/arch-v10/arch/mmu.h | 3 ---
 arch/cris/include/arch-v32/arch/mmu.h | 3 ---
 arch/cris/include/asm/pgtable.h       | 4 ----
 3 files changed, 10 deletions(-)

diff --git a/arch/cris/include/arch-v10/arch/mmu.h b/arch/cris/include/arch-v10/arch/mmu.h
index e829e5a37bbe..47a5dd21749d 100644
--- a/arch/cris/include/arch-v10/arch/mmu.h
+++ b/arch/cris/include/arch-v10/arch/mmu.h
@@ -58,7 +58,6 @@ typedef struct
 /* Bits the HW doesn't care about but the kernel uses them in SW */
 
 #define _PAGE_PRESENT   (1<<4)  /* page present in memory */
-#define _PAGE_FILE      (1<<5)  /* set: pagecache, unset: swap (when !PRESENT) */
 #define _PAGE_ACCESSED	(1<<5)  /* simulated in software using valid bit */
 #define _PAGE_MODIFIED	(1<<6)  /* simulated in software using we bit */
 #define _PAGE_READ      (1<<7)  /* read-enabled */
@@ -105,6 +104,4 @@ typedef struct
 #define __S110	PAGE_SHARED
 #define __S111	PAGE_SHARED
 
-#define PTE_FILE_MAX_BITS	26
-
 #endif
diff --git a/arch/cris/include/arch-v32/arch/mmu.h b/arch/cris/include/arch-v32/arch/mmu.h
index c1a13e05e963..e6db1616dee5 100644
--- a/arch/cris/include/arch-v32/arch/mmu.h
+++ b/arch/cris/include/arch-v32/arch/mmu.h
@@ -53,7 +53,6 @@ typedef struct
  * software.
  */
 #define _PAGE_PRESENT   (1 << 5)   /* Page is present in memory. */
-#define _PAGE_FILE      (1 << 6)   /* 1=pagecache, 0=swap (when !present) */
 #define _PAGE_ACCESSED  (1 << 6)   /* Simulated in software using valid bit. */
 #define _PAGE_MODIFIED  (1 << 7)   /* Simulated in software using we bit. */
 #define _PAGE_READ      (1 << 8)   /* Read enabled. */
@@ -108,6 +107,4 @@ typedef struct
 #define __S110  PAGE_SHARED_EXEC
 #define __S111  PAGE_SHARED_EXEC
 
-#define PTE_FILE_MAX_BITS	25
-
 #endif /* _ASM_CRIS_ARCH_MMU_H */
diff --git a/arch/cris/include/asm/pgtable.h b/arch/cris/include/asm/pgtable.h
index 8b8c86793225..e824257971c4 100644
--- a/arch/cris/include/asm/pgtable.h
+++ b/arch/cris/include/asm/pgtable.h
@@ -114,7 +114,6 @@ extern unsigned long empty_zero_page;
 static inline int pte_write(pte_t pte)          { return pte_val(pte) & _PAGE_WRITE; }
 static inline int pte_dirty(pte_t pte)          { return pte_val(pte) & _PAGE_MODIFIED; }
 static inline int pte_young(pte_t pte)          { return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)           { return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -290,9 +289,6 @@ static inline void update_mmu_cache(struct vm_area_struct * vma,
  */
 #define pgtable_cache_init()   do { } while (0)
 
-#define pte_to_pgoff(x)	(pte_val(x) >> 6)
-#define pgoff_to_pte(x)	__pte(((x) << 6) | _PAGE_FILE)
-
 typedef pte_t *pte_addr_t;
 
 #endif /* __ASSEMBLY__ */
-- 
2.1.3

