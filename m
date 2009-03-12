From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 2/2] use debug_kmap_atomic
Date: Fri, 13 Mar 2009 00:19:33 +0900
Message-ID: <20090312151932.GB3904@localhost.localdomain>
References: <20090312151617.GA3904@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757319AbZCLPU1@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090312151617.GA3904@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Use debug_kmap_atomic in kmap_atomic, kmap_atomic_pfn,
and iomap_atomic_prot_pfn.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <linux-arch@vger.kernel.org>
---
 arch/mips/mm/highmem.c             |    2 ++
 arch/powerpc/include/asm/highmem.h |    2 ++
 arch/sparc/mm/highmem.c            |    1 +
 arch/x86/mm/highmem_32.c           |    1 +
 arch/x86/mm/iomap_32.c             |    2 ++
 include/asm-frv/highmem.h          |    2 ++
 include/asm-mn10300/highmem.h      |    2 ++
 7 files changed, 12 insertions(+)

Index: 2.6-mmotm/arch/x86/mm/highmem_32.c
===================================================================
--- 2.6-mmotm.orig/arch/x86/mm/highmem_32.c
+++ 2.6-mmotm/arch/x86/mm/highmem_32.c
@@ -88,6 +88,7 @@ void *kmap_atomic_pfn(unsigned long pfn,
 
 	pagefault_disable();
 
+	debug_kmap_atomic(type);
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	set_pte(kmap_pte-idx, pfn_pte(pfn, kmap_prot));
Index: 2.6-mmotm/arch/x86/mm/iomap_32.c
===================================================================
--- 2.6-mmotm.orig/arch/x86/mm/iomap_32.c
+++ 2.6-mmotm/arch/x86/mm/iomap_32.c
@@ -19,6 +19,7 @@
 #include <asm/iomap.h>
 #include <asm/pat.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 
 int is_io_mapping_possible(resource_size_t base, unsigned long size)
 {
@@ -41,6 +42,7 @@ iomap_atomic_prot_pfn(unsigned long pfn,
 
 	pagefault_disable();
 
+	debug_kmap_atomic(type);
 	/*
 	 * For non-PAT systems, promote PAGE_KERNEL_WC to PAGE_KERNEL_UC_MINUS.
 	 * PAGE_KERNEL_WC maps to PWT, which translates to uncached if the
Index: 2.6-mmotm/arch/mips/mm/highmem.c
===================================================================
--- 2.6-mmotm.orig/arch/mips/mm/highmem.c
+++ 2.6-mmotm/arch/mips/mm/highmem.c
@@ -43,6 +43,7 @@ void *__kmap_atomic(struct page *page, e
 	if (!PageHighMem(page))
 		return page_address(page);
 
+	debug_kmap_atomic(type);
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 #ifdef CONFIG_DEBUG_HIGHMEM
@@ -91,6 +92,7 @@ void *kmap_atomic_pfn(unsigned long pfn,
 
 	pagefault_disable();
 
+	debug_kmap_atomic(type);
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	set_pte(kmap_pte-idx, pfn_pte(pfn, kmap_prot));
Index: 2.6-mmotm/arch/powerpc/include/asm/highmem.h
===================================================================
--- 2.6-mmotm.orig/arch/powerpc/include/asm/highmem.h
+++ 2.6-mmotm/arch/powerpc/include/asm/highmem.h
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
Index: 2.6-mmotm/arch/sparc/mm/highmem.c
===================================================================
--- 2.6-mmotm.orig/arch/sparc/mm/highmem.c
+++ 2.6-mmotm/arch/sparc/mm/highmem.c
@@ -39,6 +39,7 @@ void *kmap_atomic(struct page *page, enu
 	if (!PageHighMem(page))
 		return page_address(page);
 
+	debug_kmap_atomic(type);
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 
Index: 2.6-mmotm/include/asm-frv/highmem.h
===================================================================
--- 2.6-mmotm.orig/include/asm-frv/highmem.h
+++ 2.6-mmotm/include/asm-frv/highmem.h
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
Index: 2.6-mmotm/include/asm-mn10300/highmem.h
===================================================================
--- 2.6-mmotm.orig/include/asm-mn10300/highmem.h
+++ 2.6-mmotm/include/asm-mn10300/highmem.h
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
