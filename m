From: Joerg Roedel <joro@8bytes.org>
Subject: [RFC PATCH 4/7] x86/mm/64: Implement arch_sync_kernel_mappings()
Date: Fri,  8 May 2020 16:40:40 +0200
Message-ID: <20200508144043.13893-5-joro@8bytes.org>
References: <20200508144043.13893-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200508144043.13893-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Joerg Roedel <jroedel@suse.de>, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Implement the function to sync changes in vmalloc and ioremap ranges
to all page-tables.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_64_types.h | 2 ++
 arch/x86/mm/init_64.c                   | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 52e5f5f2240d..8f63efb2a2cc 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -159,4 +159,6 @@ extern unsigned int ptrs_per_p4d;
 
 #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
 
+#define ARCH_PAGE_TABLE_SYNC_MASK	(pgtable_l5_enabled() ?	PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
+
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3b289c2f75cd..541af8e5bcd4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -217,6 +217,11 @@ void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
-- 
2.17.1
