Return-Path: <SRS0=ZIJQ=7T=kvack.org=owner-linux-mm@kernel.org>
From: Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH v2 1/2] MIPS: Set page access bit with pgprot on platforms with RIXI
Date: Sat,  6 Jun 2020 12:02:48 +0800
Message-ID: <1591416169-26666-1-git-send-email-maobibo@loongson.cn>
Sender: owner-linux-mm@kvack.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Andrew Morton <akpm@linux-foundation.org>, Paul Burton <paulburton@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200606040248.OKxiKuPYfb0078FRRlOvMJsxm4Ejx_heMKvh-uA0_f4@z>

On MIPS system which has rixi hardware bit, page access bit is not
set in pgrot. For memory reading, there will be one page fault to
allocate physical page; however valid bit is not set, there will
be the second fast tlb-miss fault handling to set valid/access bit.

This patch set page access/valid bit with pgrot if there is reading
access privilege. It will reduce one tlb-miss handling for memory
reading access.

The valid/access bit will be cleared in order to track memory
accessing activity. If the page is accessed, tlb-miss fast handling
will set valid/access bit, pte_sw_mkyoung is not necessary in slow
page fault path. This patch removes pte_sw_mkyoung function which
is defined as empty function except MIPS system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
v2:
- refine commit log title
---
 arch/mips/include/asm/pgtable.h | 10 ++++++++--
 arch/mips/mm/cache.c            | 34 +++++++++++++++++-----------------
 include/asm-generic/pgtable.h   | 16 ----------------
 mm/memory.c                     |  3 ---
 4 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 85b39c9..d066469 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -25,6 +25,14 @@
 struct mm_struct;
 struct vm_area_struct;
 
+#define __PP	_PAGE_PRESENT
+#define __NX	_PAGE_NO_EXEC
+#define __NR	_PAGE_NO_READ
+#define ___W	_PAGE_WRITE
+#define ___A	_PAGE_ACCESSED
+#define ___R	(_PAGE_SILENT_READ | _PAGE_ACCESSED)
+#define __PC	_page_cachable_default
+
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
 				 _page_cachable_default)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
@@ -414,8 +422,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte;
 }
 
-#define pte_sw_mkyoung	pte_mkyoung
-
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 static inline int pte_huge(pte_t pte)	{ return pte_val(pte) & _PAGE_HUGE; }
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index ad6df1c..f814e43 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -158,23 +158,23 @@ void __update_cache(unsigned long address, pte_t pte)
 static inline void setup_protection_map(void)
 {
 	if (cpu_has_rixi) {
-		protection_map[0]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
-		protection_map[2]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-		protection_map[3]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
-		protection_map[4]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[5]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[6]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[7]  = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-
-		protection_map[8]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-		protection_map[9]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
-		protection_map[10] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
-		protection_map[11] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
-		protection_map[12] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[13] = __pgprot(_page_cachable_default | _PAGE_PRESENT);
-		protection_map[14] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
-		protection_map[15] = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_WRITE);
+		protection_map[0]  = __pgprot(__PC | __PP | __NX | __NR);
+		protection_map[1]  = __pgprot(__PC | __PP | __NX | ___R);
+		protection_map[2]  = __pgprot(__PC | __PP | __NX | __NR);
+		protection_map[3]  = __pgprot(__PC | __PP | __NX | ___R);
+		protection_map[4]  = __pgprot(__PC | __PP | ___R);
+		protection_map[5]  = __pgprot(__PC | __PP | ___R);
+		protection_map[6]  = __pgprot(__PC | __PP | ___R);
+		protection_map[7]  = __pgprot(__PC | __PP | ___R);
+
+		protection_map[8]  = __pgprot(__PC | __PP | __NX | __NR);
+		protection_map[9]  = __pgprot(__PC | __PP | __NX | ___R);
+		protection_map[10] = __pgprot(__PC | __PP | __NX | ___W | __NR);
+		protection_map[11] = __pgprot(__PC | __PP | __NX | ___W | ___R);
+		protection_map[12] = __pgprot(__PC | __PP | ___R);
+		protection_map[13] = __pgprot(__PC | __PP | ___R);
+		protection_map[14] = __pgprot(__PC | __PP | ___W | ___R);
+		protection_map[15] = __pgprot(__PC | __PP | ___W | ___R);
 
 	} else {
 		protection_map[0] = PAGE_NONE;
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index b5278ec..fa5c73f 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -244,22 +244,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 }
 #endif
 
-/*
- * On some architectures hardware does not set page access bit when accessing
- * memory page, it is responsibilty of software setting this bit. It brings
- * out extra page fault penalty to track page access bit. For optimization page
- * access bit can be set during all page fault flow on these arches.
- * To be differentiate with macro pte_mkyoung, this macro is used on platforms
- * where software maintains page access bit.
- */
-#ifndef pte_sw_mkyoung
-static inline pte_t pte_sw_mkyoung(pte_t pte)
-{
-	return pte;
-}
-#define pte_sw_mkyoung	pte_sw_mkyoung
-#endif
-
 #ifndef pte_savedwrite
 #define pte_savedwrite pte_write
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index c7c8960..8bb31c4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2704,7 +2704,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
-		entry = pte_sw_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
@@ -3379,7 +3378,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	__SetPageUptodate(page);
 
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
@@ -3662,7 +3660,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	/* copy-on-write page */
-- 
1.8.3.1
