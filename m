Return-Path: <SRS0=W/Kb=6W=kvack.org=owner-linux-mm@kernel.org>
From: Joerg Roedel <joro@8bytes.org>
Subject: [RFC PATCH 5/7] x86/mm/32: Implement arch_sync_kernel_mappings()
Date: Fri,  8 May 2020 16:40:41 +0200
Message-ID: <20200508144043.13893-6-joro@8bytes.org>
In-Reply-To: <20200508144043.13893-1-joro@8bytes.org>
References: <20200508144043.13893-1-joro@8bytes.org>
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org
Cc: hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Joerg Roedel <jroedel@suse.de>, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200508144041.7n7oGuO31bfYdCviqZE1creBMQuAGy3Y0Sn99BpHyP8@z>

From: Joerg Roedel <jroedel@suse.de>

Implement the function to sync changes in vmalloc and ioremap ranges
to all page-tables.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable-2level_types.h |  2 ++
 arch/x86/include/asm/pgtable-3level_types.h |  2 ++
 arch/x86/mm/fault.c                         | 25 +++++++++++++--------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index 6deb6cd236e3..7f6ccff0ba72 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -20,6 +20,8 @@ typedef union {
 
 #define SHARED_KERNEL_PMD	0
 
+#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
+
 /*
  * traditional i386 two-level paging structure:
  */
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 33845d36897c..80fbb4a9ed87 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -27,6 +27,8 @@ typedef union {
 #define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
 #endif
 
+#define ARCH_PAGE_TABLE_SYNC_MASK	(SHARED_KERNEL_PMD ? 0 : PGTBL_PMD_MODIFIED)
+
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a51df516b87b..edeb2adaf31f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -190,16 +190,13 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 	return pmd_k;
 }
 
-static void vmalloc_sync(void)
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 {
-	unsigned long address;
-
-	if (SHARED_KERNEL_PMD)
-		return;
+	unsigned long addr;
 
-	for (address = VMALLOC_START & PMD_MASK;
-	     address >= TASK_SIZE_MAX && address < VMALLOC_END;
-	     address += PMD_SIZE) {
+	for (addr = start & PMD_MASK;
+	     addr >= TASK_SIZE_MAX && addr < VMALLOC_END;
+	     addr += PMD_SIZE) {
 		struct page *page;
 
 		spin_lock(&pgd_lock);
@@ -210,13 +207,23 @@ static void vmalloc_sync(void)
 			pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
 
 			spin_lock(pgt_lock);
-			vmalloc_sync_one(page_address(page), address);
+			vmalloc_sync_one(page_address(page), addr);
 			spin_unlock(pgt_lock);
 		}
 		spin_unlock(&pgd_lock);
 	}
 }
 
+static void vmalloc_sync(void)
+{
+	unsigned long address;
+
+	if (SHARED_KERNEL_PMD)
+		return;
+
+	arch_sync_kernel_mappings(VMALLOC_START, VMALLOC_END);
+}
+
 void vmalloc_sync_mappings(void)
 {
 	vmalloc_sync();
-- 
2.17.1
