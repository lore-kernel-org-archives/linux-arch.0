From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] asm-generic: add pgtable-nommu.h
Date: Wed, 15 Jul 2009 11:25:48 +0200
Message-ID: <200907151125.49327.arnd@arndb.de>
References: <4A5D8797.10004@petalogix.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60764 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbZGOJZ5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2009 05:25:57 -0400
In-Reply-To: <4A5D8797.10004@petalogix.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: michal.simek@petalogix.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, lkml <linux-arch@vger.kernel.org>

All nommu architectures have almost identical pgtable.h implementations,
so we should have a common file for them.

I must have missed this in the earlier asm-generic submission.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
On Wednesday 15 July 2009, Michal Simek wrote:

> I found that we should simplify pgtable.h. There are a lot of generic
> functions which use all archs. Have you look at it or not?

I have missed this one for some reason, maybe because it looked too
complicated at some point, or because it is already very complex with
a lot of different helper header files.

For the nommu case, it should be trivial to add something. Can you
try if the patch below gives you something useful?

diff --git a/include/asm-generic/pgtable-nommu.h b/include/asm-generic/pgtable-nommu.h
new file mode 100644
index 0000000..c194f85
--- /dev/null
+++ b/include/asm-generic/pgtable-nommu.h
@@ -0,0 +1,74 @@
+#ifndef __ASM_GENERIC_PGTABLE_H
+#define __ASM_GENERIC_PGTABLE_H
+
+#include <asm-generic/4level-fixup.h>
+
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/io.h>
+
+/*
+ * Trivial page table functions.
+ */
+#define pgd_present(pgd)	(1)
+#define pgd_none(pgd)		(0)
+#define pgd_bad(pgd)		(0)
+#define pgd_clear(pgdp)
+#define kern_addr_valid(addr)	(1)
+#define	pmd_offset(a, b)	((void *)0)
+
+#define PAGE_NONE	__pgprot(0)
+#define PAGE_SHARED	__pgprot(0)
+#define PAGE_COPY	__pgprot(0)
+#define PAGE_READONLY	__pgprot(0)
+#define PAGE_KERNEL	__pgprot(0)
+
+extern void paging_init(void);
+#define swapper_pg_dir ((pgd_t *) 0)
+
+#define __swp_type(x)		(0)
+#define __swp_offset(x)		(0)
+#define __swp_entry(typ,off)	((swp_entry_t) { ((typ) | ((off) << 7)) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+
+static inline int pte_file(pte_t pte)
+{
+	return 0;
+}
+
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+#define ZERO_PAGE(vaddr)	(virt_to_page(0))
+
+/*
+ * Mark the prot value as uncacheable and unbufferable.
+ */
+#define pgprot_noncached(prot)	__pgprot(0)
+#define pgprot_writecombine(prot) __pgprot(0)
+
+/*
+ * These would be in other places but having them here reduces the diffs.
+ */
+extern unsigned int kobjsize(const void *objp);
+
+/*
+ * No page table caches to initialise.
+ */
+#define pgtable_cache_init()	do { } while (0)
+
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+/*
+ * All 32bit addresses are effectively valid for vmalloc...
+ * Sort of meaningless for non-VM targets.
+ */
+#define	VMALLOC_START	0
+#define	VMALLOC_END	0xffffffff
+
+#include <asm-generic/pgtable.h>
+
+#endif /* __ASM_GENERIC_PGTABLE_H */
