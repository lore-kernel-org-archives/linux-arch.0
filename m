From: akpm@linux-foundation.org
Subject: [patch 045/183] mm: use debug_kmap_atomic
Date: Tue, 31 Mar 2009 15:23:25 -0700
Message-ID: <200903312223.n2VMNQgC022219@imap1.linux-foundation.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52649 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764408AbZCaXXb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Mar 2009 19:23:31 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, akinobu.mita@gmail.com, hpa@zytor.com, linux-arch@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

From: Akinobu Mita <akinobu.mita@gmail.com>

Use debug_kmap_atomic in kmap_atomic, kmap_atomic_pfn, and
iomap_atomic_prot_pfn.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/mips/mm/highmem.c             |    2 ++
 arch/powerpc/include/asm/highmem.h |    2 ++
 arch/sparc/mm/highmem.c            |    1 +
 arch/x86/mm/highmem_32.c           |    1 +
 arch/x86/mm/iomap_32.c             |    2 ++
 include/asm-frv/highmem.h          |    2 ++
 include/asm-mn10300/highmem.h      |    2 ++
 7 files changed, 12 insertions(+)

diff -puN arch/mips/mm/highmem.c~use-debug_kmap_atomic arch/mips/mm/highmem.c
--- a/arch/mips/mm/highmem.c~use-debug_kmap_atomic
+++ a/arch/mips/mm/highmem.c
@@ -42,6 +42,7 @@ void *__kmap_atomic(struct page *page, e
 	if (!PageHighMem(page))
 		return page_address(page);
 
+	debug_kmap_atomic(type);
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 #ifdef CONFIG_DEBUG_HIGHMEM
@@ -88,6 +89,7 @@ void *kmap_atomic_pfn(unsigned long pfn,
 
 	pagefault_disable();
 
+	debug_kmap_atomic(type);
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	set_pte(kmap_pte-idx, pfn_pte(pfn, kmap_prot));
diff -puN arch/powerpc/include/asm/highmem.h~use-debug_kmap_atomic arch/powerpc/include/asm/highmem.h
--- a/arch/powerpc/include/asm/highmem.h~use-debug_kmap_atomic
+++ a/arch/powerpc/include/asm/highmem.h
@@ -24,6 +24,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/highmem.h>
 #include <asm/kmap_types.h>
 #include <asm/tlbflush.h>
 #include <asm/page.h>
@@ -94,6 +95,7 @@ static inline void *kmap_atomic_prot(str
 	if (!PageHighMem(page))
 		return page_address(page);
 
+	debug_kmap_atomic(type);
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 #ifdef CONFIG_DEBUG_HIGHMEM
diff -puN arch/sparc/mm/highmem.c~use-debug_kmap_atomic arch/sparc/mm/highmem.c
--- a/arch/sparc/mm/highmem.c~use-debug_kmap_atomic
+++ a/arch/sparc/mm/highmem.c
@@ -39,6 +39,7 @@ void *kmap_atomic(struct page *page, enu
 	if (!PageHighMem(page))
 		return page_address(page);
 
+	debug_kmap_atomic(type);
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 
diff -puN arch/x86/mm/highmem_32.c~use-debug_kmap_atomic arch/x86/mm/highmem_32.c
--- a/arch/x86/mm/highmem_32.c~use-debug_kmap_atomic
+++ a/arch/x86/mm/highmem_32.c
@@ -40,6 +40,7 @@ void *kmap_atomic_prot(struct page *page
 
 	debug_kmap_atomic(type);
 
+	debug_kmap_atomic(type);
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	BUG_ON(!pte_none(*(kmap_pte-idx)));
diff -puN arch/x86/mm/iomap_32.c~use-debug_kmap_atomic arch/x86/mm/iomap_32.c
--- a/arch/x86/mm/iomap_32.c~use-debug_kmap_atomic
+++ a/arch/x86/mm/iomap_32.c
@@ -19,6 +19,7 @@
 #include <asm/iomap.h>
 #include <asm/pat.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 
 int is_io_mapping_possible(resource_size_t base, unsigned long size)
 {
@@ -71,6 +72,7 @@ iounmap_atomic(void *kvaddr, enum km_typ
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
+	debug_kmap_atomic(type);
 	/*
 	 * Force other mappings to Oops if they'll try to access this pte
 	 * without first remap it.  Keeping stale mappings around is a bad idea
diff -puN include/asm-frv/highmem.h~use-debug_kmap_atomic include/asm-frv/highmem.h
--- a/include/asm-frv/highmem.h~use-debug_kmap_atomic
+++ a/include/asm-frv/highmem.h
@@ -18,6 +18,7 @@
 #ifdef __KERNEL__
 
 #include <linux/init.h>
+#include <linux/highmem.h>
 #include <asm/mem-layout.h>
 #include <asm/spr-regs.h>
 #include <asm/mb-regs.h>
@@ -116,6 +117,7 @@ static inline void *kmap_atomic(struct p
 	unsigned long paddr;
 
 	pagefault_disable();
+	debug_kmap_atomic(type);
 	paddr = page_to_phys(page);
 
 	switch (type) {
diff -puN include/asm-mn10300/highmem.h~use-debug_kmap_atomic include/asm-mn10300/highmem.h
--- a/include/asm-mn10300/highmem.h~use-debug_kmap_atomic
+++ a/include/asm-mn10300/highmem.h
@@ -16,6 +16,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/highmem.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable.h>
 
@@ -77,6 +78,7 @@ static inline unsigned long kmap_atomic(
 	if (page < highmem_start_page)
 		return page_address(page);
 
+	debug_kmap_atomic(type);
 	idx = type + KM_TYPE_NR * smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 #if HIGHMEM_DEBUG
_
