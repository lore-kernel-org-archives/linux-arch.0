Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:2793 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161085AbWHDHrg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2006 03:47:36 -0400
Date: Fri, 4 Aug 2006 09:47:00 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [RFC] Generic ioremap_page_range
Message-ID: <20060804094700.40a63a78@cad-250-152.norway.atmel.com>
In-Reply-To: <1152892123.24925.67.camel@localhost.localdomain>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	<1152892123.24925.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 14 Jul 2006 08:48:43 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> It would also be nice to see a _couple_ of patches that perhaps
> abstract a thing or two into generic code.  I know that new
> architectures usually begin with a 'cp -r', but it would be nice to
> see a wee bit of code refactoring as a small price of admission.
> Some of the ioremap and other pagetable code looked pretty generic to
> me.

Ok, here's a first try.

This patch moves the i386 implementation of ioremap_page_range() into
lib/ioremap.c for use by other architectures.

There's one difference between the generic ioremap_page_range and the
i386 version: it takes a pgprot_t argument instead of unsigned long
flags, meaning that the arch-specific ioremap() implementation must
set all pte flags before calling ioremap_page_range() instead of
in the lowest-level page remapping function.

If you think this looks like a good idea, I'll split out the i386
modifications in a separate patch and submit patches for several other
architectures as well.

To get the review started, here are a couple of questions:
  * Wouldn't it make more sense to call flush_cache_vmap() instead of
    flush_cache_all()?
  * Why do we need to call flush_tlb_all()? I thought you only needed
    to do that when changing/removing existing mappings...

Haavard

---
 arch/i386/mm/ioremap.c |   88 ++++--------------------------------------------
 include/linux/io.h     |    3 ++
 lib/Makefile           |    2 +
 lib/ioremap.c          |   87 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 81 deletions(-)

diff --git a/arch/i386/mm/ioremap.c b/arch/i386/mm/ioremap.c
index 247fde7..df8427d 100644
--- a/arch/i386/mm/ioremap.c
+++ b/arch/i386/mm/ioremap.c
@@ -12,7 +12,7 @@ #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/fixmap.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
@@ -21,82 +21,6 @@ #include <asm/pgtable.h>
 #define ISA_START_ADDRESS	0xa0000
 #define ISA_END_ADDRESS		0x100000
 
-static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, unsigned long phys_addr, unsigned long flags)
-{
-	pte_t *pte;
-	unsigned long pfn;
-
-	pfn = phys_addr >> PAGE_SHIFT;
-	pte = pte_alloc_kernel(pmd, addr);
-	if (!pte)
-		return -ENOMEM;
-	do {
-		BUG_ON(!pte_none(*pte));
-		set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
-					_PAGE_DIRTY | _PAGE_ACCESSED | flags)));
-		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
-	return 0;
-}
-
-static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, unsigned long phys_addr, unsigned long flags)
-{
-	pmd_t *pmd;
-	unsigned long next;
-
-	phys_addr -= addr;
-	pmd = pmd_alloc(&init_mm, pud, addr);
-	if (!pmd)
-		return -ENOMEM;
-	do {
-		next = pmd_addr_end(addr, end);
-		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, flags))
-			return -ENOMEM;
-	} while (pmd++, addr = next, addr != end);
-	return 0;
-}
-
-static inline int ioremap_pud_range(pgd_t *pgd, unsigned long addr,
-		unsigned long end, unsigned long phys_addr, unsigned long flags)
-{
-	pud_t *pud;
-	unsigned long next;
-
-	phys_addr -= addr;
-	pud = pud_alloc(&init_mm, pgd, addr);
-	if (!pud)
-		return -ENOMEM;
-	do {
-		next = pud_addr_end(addr, end);
-		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, flags))
-			return -ENOMEM;
-	} while (pud++, addr = next, addr != end);
-	return 0;
-}
-
-static int ioremap_page_range(unsigned long addr,
-		unsigned long end, unsigned long phys_addr, unsigned long flags)
-{
-	pgd_t *pgd;
-	unsigned long next;
-	int err;
-
-	BUG_ON(addr >= end);
-	flush_cache_all();
-	phys_addr -= addr;
-	pgd = pgd_offset_k(addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		err = ioremap_pud_range(pgd, addr, next, phys_addr+addr, flags);
-		if (err)
-			break;
-	} while (pgd++, addr = next, addr != end);
-	flush_tlb_all();
-	return err;
-}
-
 /*
  * Generic mapping function (not visible outside):
  */
@@ -112,9 +36,10 @@ static int ioremap_page_range(unsigned l
  */
 void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
 {
-	void __iomem * addr;
-	struct vm_struct * area;
+	void __iomem *addr;
+	struct vm_struct *area;
 	unsigned long offset, last_addr;
+	pgprot_t prot;
 
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
@@ -142,6 +67,9 @@ void __iomem * __ioremap(unsigned long p
 				return NULL;
 	}
 
+	prot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY
+			| _PAGE_ACCESSED | flags);
+
 	/*
 	 * Mappings have to be page-aligned
 	 */
@@ -158,7 +86,7 @@ void __iomem * __ioremap(unsigned long p
 	area->phys_addr = phys_addr;
 	addr = (void __iomem *) area->addr;
 	if (ioremap_page_range((unsigned long) addr,
-			(unsigned long) addr + size, phys_addr, flags)) {
+			(unsigned long) addr + size, phys_addr, prot)) {
 		vunmap((void __force *) addr);
 		return NULL;
 	}
diff --git a/include/linux/io.h b/include/linux/io.h
index 420e2fd..d9d45be 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -23,4 +23,7 @@ #include <asm/io.h>
 void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 
+int ioremap_page_range(unsigned long addr, unsigned long end,
+		       unsigned long phys_addr, pgprot_t prot);
+
 #endif /* _LINUX_IO_H */
diff --git a/lib/Makefile b/lib/Makefile
index be9719a..a4dcb07 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@ #
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o ioremap.o
 
 lib-$(CONFIG_SMP) += cpumask.o
 
diff --git a/lib/ioremap.c b/lib/ioremap.c
new file mode 100644
index 0000000..d3e1bfd
--- /dev/null
+++ b/lib/ioremap.c
@@ -0,0 +1,87 @@
+/*
+ * Re-map IO memory to kernel address space so that we can access it.
+ * This is needed for high PCI addresses that aren't mapped in the
+ * 640k-1MB IO memory area on PC's
+ *
+ * (C) Copyright 1995 1996 Linus Torvalds
+ */
+#include <linux/io.h>
+#include <linux/vmalloc.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm/pgtable.h>
+
+static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, pgprot_t prot)
+{
+	pte_t *pte;
+	unsigned long pfn;
+
+	pfn = phys_addr >> PAGE_SHIFT;
+	pte = pte_alloc_kernel(pmd, addr);
+	if (!pte)
+		return -ENOMEM;
+	do {
+		BUG_ON(!pte_none(*pte));
+		set_pte(pte, pfn_pte(pfn, prot));
+		pfn++;
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	return 0;
+}
+
+static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, pgprot_t prot)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	phys_addr -= addr;
+	pmd = pmd_alloc(&init_mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
+	do {
+		next = pmd_addr_end(addr, end);
+		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
+			return -ENOMEM;
+	} while (pmd++, addr = next, addr != end);
+	return 0;
+}
+
+static inline int ioremap_pud_range(pgd_t *pgd, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, pgprot_t prot)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	phys_addr -= addr;
+	pud = pud_alloc(&init_mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next = pud_addr_end(addr, end);
+		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, prot))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr != end);
+	return 0;
+}
+
+int ioremap_page_range(unsigned long addr,
+		       unsigned long end, unsigned long phys_addr, pgprot_t prot)
+{
+	pgd_t *pgd;
+	unsigned long next;
+	int err;
+
+	BUG_ON(addr >= end);
+	flush_cache_all();
+	phys_addr -= addr;
+	pgd = pgd_offset_k(addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		err = ioremap_pud_range(pgd, addr, next, phys_addr+addr, prot);
+		if (err)
+			break;
+	} while (pgd++, addr = next, addr != end);
+	flush_tlb_all();
+	return err;
+}
-- 
1.4.0

