Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:29399 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261988AbUCLG2K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Mar 2004 01:28:10 -0500
Subject: [PATCH] ppc64 version of DMA boundary iommu stuff
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1079072606.24362.333.camel@gaston>
Mime-Version: 1.0
Date: Fri, 12 Mar 2004 17:23:26 +1100
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Andi Kleen <ak@suse.de>
List-ID: <linux-arch.vger.kernel.org>

Hi James !

This patch adds to your previous one, it implements support for the
dma boundary stuff at the iommu level.

We should push to get those things to Andrew for 2.6.5n don't you think?

Ben

diff -urN linux-2.5/arch/ppc64/kernel/iommu.c linux-iommu/arch/ppc64/kernel/iommu.c
--- linux-2.5/arch/ppc64/kernel/iommu.c	2004-03-04 12:49:00.000000000 +1100
+++ linux-iommu/arch/ppc64/kernel/iommu.c	2004-03-12 15:45:40.000000000 +1100
@@ -60,7 +60,7 @@
 __setup("iommu=", setup_iommu);
 
 static unsigned long iommu_range_alloc(struct iommu_table *tbl, unsigned long npages,
-				       unsigned long *handle)
+				       unsigned long boundary, unsigned long *handle)
 { 
 	unsigned long n, end, i, start;
 	unsigned long limit;
@@ -99,6 +99,17 @@
 	n = find_next_zero_bit(tbl->it_map, limit, start);
 	end = n + npages;
 
+	/* Bump to the next boundary region if current allocation crosses it.
+	 * This assumes we didn't get passed a segment that doesn't fit in the 
+	 * first place.
+	 */
+	if (boundary != (0xffffffffull >> PAGE_SHIFT))
+		if (((n + tbl->it_offset) ^ (end + tbl->it_offset - 1))
+		    & ~boundary) {
+			n = (n | boundary) + 1;
+			end = n + npages;
+		}
+
 	if (unlikely(end >= limit)) {
 		if (likely(pass++ < 2)) {
 			/* First failure, just rescan the half of the table.
@@ -139,7 +150,7 @@
 	return n;
 }
 
-dma_addr_t iommu_alloc(struct iommu_table *tbl, void *page,
+dma_addr_t iommu_alloc(struct iommu_table *tbl, struct device *dev, void *page,
 		       unsigned int npages, int direction)
 {
 	unsigned long entry, flags;
@@ -147,8 +158,7 @@
 	
 	spin_lock_irqsave(&(tbl->it_lock), flags);
 
-	entry = iommu_range_alloc(tbl, npages, NULL);
-
+	entry = iommu_range_alloc(tbl, npages, dev->dma_boundary >> PAGE_SHIFT, NULL);
 	if (unlikely(entry == NO_TCE)) {
 		spin_unlock_irqrestore(&(tbl->it_lock), flags);
 		return NO_TCE;
@@ -230,6 +240,7 @@
 	dma_addr_t dma_next, dma_addr;
 	unsigned long flags;
 	struct scatterlist *s, *outs, *segstart;
+	unsigned long boundary = dev->dma_boundary;
 	int outcount;
 	unsigned long handle;
 
@@ -257,7 +268,7 @@
 		vaddr = (unsigned long)page_address(s->page) + s->offset;
 		npages = PAGE_ALIGN(vaddr + slen) - (vaddr & PAGE_MASK);
 		npages >>= PAGE_SHIFT;
-		entry = iommu_range_alloc(tbl, npages, &handle);
+		entry = iommu_range_alloc(tbl, npages, boundary >> PAGE_SHIFT, &handle);
 
 		DBG("  - vaddr: %lx, size: %lx\n", vaddr, slen);
 
@@ -285,8 +296,11 @@
 			DBG("  - trying merge...\n");
 			/* We cannot merge if:
 			 * - allocated dma_addr isn't contiguous to previous allocation
+			 * - we are crossing the device boundary limits
 			 */
-			if (novmerge || (dma_addr != dma_next)) {
+			if (novmerge || (dma_addr != dma_next) ||
+			    (boundary != 0xfffffffful &&
+			     ((outs->dma_address ^ (dma_addr + slen - 1)) & ~boundary))) {
 				/* Can't merge: create a new segment */
 				segstart = s;
 				outcount++; outs++;
diff -urN linux-2.5/arch/ppc64/kernel/pci_iommu.c linux-iommu/arch/ppc64/kernel/pci_iommu.c
--- linux-2.5/arch/ppc64/kernel/pci_iommu.c	2004-03-04 12:49:00.000000000 +1100
+++ linux-iommu/arch/ppc64/kernel/pci_iommu.c	2004-03-12 15:46:11.000000000 +1100
@@ -99,7 +99,7 @@
 	memset(ret, 0, size);
 
 	/* Set up tces to cover the allocated range */
-	mapping = iommu_alloc(tbl, ret, npages, PCI_DMA_BIDIRECTIONAL);
+	mapping = iommu_alloc(tbl, &hwdev->dev, ret, npages, PCI_DMA_BIDIRECTIONAL);
 
 	if (mapping == NO_TCE) {
 		free_pages((unsigned long)ret, order);
@@ -152,7 +152,7 @@
 	tbl = devnode_table(hwdev); 
 
 	if (tbl) {
-		dma_handle = iommu_alloc(tbl, vaddr, npages, direction);
+		dma_handle = iommu_alloc(tbl, &hwdev->dev, vaddr, npages, direction);
 		if (dma_handle == NO_TCE) {
 			if (printk_ratelimit())  {
 				printk(KERN_INFO "iommu_alloc failed, tbl %p vaddr %p npages %d\n",
diff -urN linux-2.5/arch/ppc64/kernel/vio.c linux-iommu/arch/ppc64/kernel/vio.c
--- linux-2.5/arch/ppc64/kernel/vio.c	2004-03-04 12:49:00.000000000 +1100
+++ linux-iommu/arch/ppc64/kernel/vio.c	2004-03-12 15:47:47.000000000 +1100
@@ -432,7 +432,7 @@
 	tbl = dev->iommu_table;
 
 	if (tbl) {
-		dma_handle = iommu_alloc(tbl, vaddr, npages, direction);
+		dma_handle = iommu_alloc(tbl, &dev->dev, vaddr, npages, direction);
 		dma_handle |= (uaddr & ~PAGE_MASK);
 	}
 
@@ -516,7 +516,8 @@
 			/* Page allocation succeeded */
 			memset(ret, 0, npages << PAGE_SHIFT);
 			/* Set up tces to cover the allocated range */
-			tce = iommu_alloc(tbl, ret, npages, PCI_DMA_BIDIRECTIONAL);
+			tce = iommu_alloc(tbl, &dev->dev, ret, npages,
+					  PCI_DMA_BIDIRECTIONAL);
 			if (tce == NO_TCE) {
 				PPCDBG(PPCDBG_TCE, "vio_alloc_consistent: iommu_alloc failed\n" );
 				free_pages((unsigned long)ret, order);
diff -urN linux-2.5/include/asm-ppc64/iommu.h linux-iommu/include/asm-ppc64/iommu.h
--- linux-2.5/include/asm-ppc64/iommu.h	2004-03-04 12:49:00.000000000 +1100
+++ linux-iommu/include/asm-ppc64/iommu.h	2004-03-12 10:34:20.000000000 +1100
@@ -19,8 +19,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#ifndef _PCI_DMA_H
-#define _PCI_DMA_H
+#ifndef _IOMMU_H
+#define _IOMMU_H
 
 #include <asm/types.h>
 #include <linux/spinlock.h>
@@ -133,8 +133,9 @@
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl);
 
 /* allocates a range of tces and sets them to the pages  */
-extern dma_addr_t iommu_alloc(struct iommu_table *, void *page, 
-			      unsigned int numPages, int direction);
+extern dma_addr_t iommu_alloc(struct iommu_table *, struct device *dev,
+			      void *page, unsigned int numPages,
+			      int direction);
 extern void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr, 
 		       unsigned int npages);
 
@@ -152,4 +153,4 @@
 extern void pci_iommu_init(void);
 extern void pci_dma_init_direct(void);
 
-#endif
+#endif /* _IOMMU_H */
