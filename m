Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44305 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262263AbUC1KWU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 28 Mar 2004 05:22:20 -0500
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B7XQn-0006lR-No
	for linux-arch@vger.kernel.org; Sun, 28 Mar 2004 11:22:17 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.30)
	id 1B7XQm-0001QL-Uo
	for linux-arch@vger.kernel.org; Sun, 28 Mar 2004 11:22:16 +0100
Date: Sun, 28 Mar 2004 11:22:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH: x86] Add dma_mmap_coherent()
Message-ID: <20040328112216.B2825@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King <rmk@arm.linux.org.uk>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This has only been compile tested.  There are two changes here:

1. ensure that we zero the whole page - otherwise we may expose leak
   kernel data to userspace in the remainder of the last page.
2. add dma_mmap_coherent().  I've added checks for the offset and
   size to ensure that we don't do anything silly (like mapping more
   memory than the original coherent allocation covered.)  Maybe this
   is something that remap_page_range() should be doing anyway?

--- orig/arch/i386/kernel/pci-dma.c	Fri Mar 19 11:55:20 2004
+++ linux/arch/i386/kernel/pci-dma.c	Sun Mar 28 10:58:22 2004
@@ -26,7 +26,7 @@ void *dma_alloc_coherent(struct device *
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 
 	if (ret != NULL) {
-		memset(ret, 0, size);
+		memset(ret, 0, PAGE_ALIGN(size));
 		*dma_handle = virt_to_phys(ret);
 	}
 	return ret;
--- orig/include/asm-i386/dma-mapping.h	Sat Mar 20 09:22:49 2004
+++ linux/include/asm-i386/dma-mapping.h	Sun Mar 28 10:57:56 2004
@@ -12,6 +12,23 @@ void *dma_alloc_coherent(struct device *
 void dma_free_coherent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle);
 
+static inline int
+dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+		  void *vaddr, dma_addr_t handle, size_t size)
+{
+	unsigned long offset = vma->vm_pgoff, usize;
+
+	size = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	usize = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+
+	if (offset >= size || usize > (size - offset))
+		return -ENXIO;
+
+	return remap_page_range(vma, vma->vm_start,
+				__pa(vaddr) + (offset << PAGE_SHIFT),
+				usize << PAGE_SHIFT, vma->vm_page_prot);
+}
+
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
 	       enum dma_data_direction direction)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
