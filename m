Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54545 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262263AbUC1Kkc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 28 Mar 2004 05:40:32 -0500
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B7XiP-0006mn-Aw
	for linux-arch@vger.kernel.org; Sun, 28 Mar 2004 11:40:29 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.30)
	id 1B7XiO-0001aj-1H
	for linux-arch@vger.kernel.org; Sun, 28 Mar 2004 11:40:28 +0100
Date: Sun, 28 Mar 2004 11:40:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH: ARM] Add dma_mmap_coherent()
Message-ID: <20040328114027.C2825@flint.arm.linux.org.uk>
References: <20040328112216.B2825@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328112216.B2825@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Mar 28, 2004 at 11:22:16AM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a little more involved than the x86 patch, mainly because it
presently contains three changes in one:

1a. We take note of the DMA mask, and attempt a normal (non-GFP_DMA)
    allocation.  If this satisfies the DMA mask, we use it.  If not,
    we retry the allocation, but this time with GFP_DMA to ensure
    we get a page matching our requirements.  If this fails, we fail.
1b. We check that the size of the coherent allocation is possible given
    the mask.

2.  Eliminate consistent_alloc / consistent_free.  These are supposed
    to be internal functions to the coherent memory allocator, but it
    seems that some third party drivers decided that they could use
    them rather than the DMA API / PCI DMA APIs.  Since these drivers
    need updating anyway, these functions have been eliminated.

3.  Provide dma_mmap_coherent().  We do this using a vm_operations_struct
    for two reasons: we have the struct page to hand, and it allows us
    to check for drivers freeing their coherent memory buffer while the
    userspace mapping remains.

[ARM also has dma_FOO_writecombine() as well for video drivers now, but I
haven't included it in this patch.]

--- orig/arch/arm/mm/consistent.c	Fri Mar 19 11:55:17 2004
+++ linux/arch/arm/mm/consistent.c	Sun Mar 28 11:34:55 2004
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/arm/mm/consistent.c
  *
- *  Copyright (C) 2000-2002 Russell King
+ *  Copyright (C) 2000-2004 Russell King
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -33,7 +33,6 @@
  * This is the page table (2MB) covering uncached, DMA consistent allocations
  */
 static pte_t *consistent_pte;
-static spinlock_t consistent_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * VM region handling support.
@@ -68,16 +67,26 @@ struct vm_region {
 	struct list_head	vm_list;
 	unsigned long		vm_start;
 	unsigned long		vm_end;
+	struct page		*vm_pages;
+	int			vm_user_use;
 };
 
-static struct vm_region consistent_head = {
+struct vm_region_head {
+	spinlock_t		vm_lock;
+	struct list_head	vm_list;
+	unsigned long		vm_start;
+	unsigned long		vm_end;
+};
+
+static struct vm_region_head consistent_head = {
+	.vm_lock	= SPIN_LOCK_UNLOCKED,
 	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
 	.vm_start	= CONSISTENT_BASE,
 	.vm_end		= CONSISTENT_END,
 };
 
 #if 0
-static void vm_region_dump(struct vm_region *head, char *fn)
+static void vm_region_dump(struct vm_region_head *head, char *fn)
 {
 	struct vm_region *c;
 
@@ -91,19 +100,28 @@ static void vm_region_dump(struct vm_reg
 #define vm_region_dump(head,fn)	do { } while(0)
 #endif
 
-static int vm_region_alloc(struct vm_region *head, struct vm_region *new, size_t size)
+static struct vm_region *
+vm_region_alloc(struct vm_region_head *head, size_t size, int gfp)
 {
 	unsigned long addr = head->vm_start, end = head->vm_end - size;
-	struct vm_region *c;
+	unsigned long flags;
+	struct vm_region *c, *new;
+
+	new = kmalloc(sizeof(struct vm_region), gfp);
+	if (!new)
+		goto out;
+
+	spin_lock_irqsave(&head->vm_lock, flags);
+	vm_region_dump(head, "before alloc");
 
 	list_for_each_entry(c, &head->vm_list, vm_list) {
 		if ((addr + size) < addr)
-			goto out;
+			goto nospc;
 		if ((addr + size) <= c->vm_start)
 			goto found;
 		addr = c->vm_end;
 		if (addr > end)
-			goto out;
+			goto nospc;
 	}
 
  found:
@@ -113,14 +131,22 @@ static int vm_region_alloc(struct vm_reg
 	list_add_tail(&new->vm_list, &c->vm_list);
 	new->vm_start = addr;
 	new->vm_end = addr + size;
+	new->vm_user_use = 0;
 
-	return 0;
-
+	vm_region_dump(head, "after alloc");
+	spin_unlock_irqrestore(&head->vm_lock, flags);
+	return new;
+
+ nospc:
+	vm_region_dump(head, "after alloc");
+	spin_unlock_irqrestore(&head->vm_lock, flags);
+	kfree(new);
  out:
-	return -ENOMEM;
+	return NULL;
 }
 
-static struct vm_region *vm_region_find(struct vm_region *head, unsigned long addr)
+static struct vm_region *
+vm_region_find(struct vm_region_head *head, unsigned long addr)
 {
 	struct vm_region *c;
 	
@@ -133,18 +159,15 @@ static struct vm_region *vm_region_find(
 	return c;
 }
 
-/*
- * This allocates one page of cache-coherent memory space and returns
- * both the virtual and a "dma" address to that space.
- */
-void *consistent_alloc(int gfp, size_t size, dma_addr_t *handle,
-		       unsigned long cache_flags)
+static struct vm_region *
+__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, int gfp,
+	    pgprot_t prot)
 {
 	struct page *page;
 	struct vm_region *c;
-	unsigned long order, flags;
-	void *ret = NULL;
-	int res;
+	unsigned long order;
+	u64 mask = 0xffffff, limit; /* ISA default */
+	int i;
 
 	if (!consistent_pte) {
 		printk(KERN_ERR "consistent_alloc: not initialised\n");
@@ -152,10 +175,40 @@ void *consistent_alloc(int gfp, size_t s
 		return NULL;
 	}
 
+	if (dev) {
+		mask = dev->coherent_dma_mask;
+		if (mask == 0) {
+			dev_warn(dev, "coherent DMA mask is unset\n");
+			return NULL;
+		}
+	}
+
+	limit = (mask + 1) & ~mask;
+	if ((limit && size >= limit) || size >= (CONSISTENT_END - CONSISTENT_BASE)) {
+		dev_warn(dev, "coherent allocation too big (requested %#x mask %#Lx)\n",
+			 size, mask);
+		return NULL;
+	}
+
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	page = alloc_pages(gfp, order);
+	for (i = 0; i < 2; i++) {
+		u32 dma_addr;
+
+		page = alloc_pages(gfp, order);
+		if (!page)
+			break;
+
+		dma_addr = page_to_bus(page);
+		if (!(dma_addr & ~mask))
+			break;
+
+		__free_pages(page, order);
+		page = NULL;
+		gfp |= GFP_DMA;
+	}
+
 	if (!page)
 		goto no_page;
 
@@ -169,32 +222,15 @@ void *consistent_alloc(int gfp, size_t s
 	}
 
 	/*
-	 * Our housekeeping doesn't need to come from DMA,
-	 * but it must not come from highmem.
-	 */
-	c = kmalloc(sizeof(struct vm_region),
-		    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
-	if (!c)
-		goto no_remap;
-
-	/*
-	 * Attempt to allocate a virtual address in the
-	 * consistent mapping region.
+	 * Allocate a virtual address in the consistent mapping region.
 	 */
-	spin_lock_irqsave(&consistent_lock, flags);
-	vm_region_dump(&consistent_head, "before alloc");
-
-	res = vm_region_alloc(&consistent_head, c, size);
-
-	vm_region_dump(&consistent_head, "after alloc");
-	spin_unlock_irqrestore(&consistent_lock, flags);
-
-	if (!res) {
+	c = vm_region_alloc(&consistent_head, size,
+			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
+	if (c) {
 		pte_t *pte = consistent_pte + CONSISTENT_OFFSET(c->vm_start);
 		struct page *end = page + (1 << order);
-		pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG |
-					 L_PTE_DIRTY | L_PTE_WRITE |
-					 cache_flags);
+
+		c->vm_pages = page;
 
 		/*
 		 * Set the "dma handle"
@@ -220,38 +256,108 @@ void *consistent_alloc(int gfp, size_t s
 			page++;
 		}
 
-		ret = (void *)c->vm_start;
+		return (void *)c->vm_start;
 	}
 
- no_remap:
-	if (ret == NULL) {
-		kfree(c);
+	if (page)
 		__free_pages(page, order);
-	}
  no_page:
-	return ret;
+	return NULL;
 }
-EXPORT_SYMBOL(consistent_alloc);
 
 /*
- * Since we have the DMA mask available to us here, we could try to do
- * a normal allocation, and only fall back to a "DMA" allocation if the
- * resulting bus address does not satisfy the dma_mask requirements.
+ * We try to do a normal allocation, and fall back to a "DMA" allocation
+ * if the resulting bus address does not satisfy the dma_mask requirements.
  */
 void *
 dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, int gfp)
 {
-	if (dev == NULL || *dev->dma_mask != 0xffffffff)
-		gfp |= GFP_DMA;
-
-	return consistent_alloc(gfp, size, handle, 0);
+	return __dma_alloc(dev, size, handle, gfp,
+			   pgprot_dmacoherent(pgprot_kernel));
 }
 EXPORT_SYMBOL(dma_alloc_coherent);
 
+#define dma_coherent_get(c)	do { (c)->vm_user_use++; } while (0)
+#define dma_coherent_put(c)	do { (c)->vm_user_use--; } while (0)
+
+static void dma_mmap_open(struct vm_area_struct *vma)
+{
+	struct vm_region *c = vma->vm_private_data;
+	dma_coherent_get(c);
+}
+
+static void dma_mmap_close(struct vm_area_struct *vma)
+{
+	struct vm_region *c = vma->vm_private_data;
+	dma_coherent_put(c);
+}
+
+static struct page *
+dma_mmap_nopage(struct vm_area_struct *vma, unsigned long address, int *type)
+{
+	struct vm_region *c = vma->vm_private_data;
+	struct page *page = NOPAGE_OOM;
+	unsigned long off;
+
+	off = (address - vma->vm_start) >> PAGE_SHIFT;
+	off += vma->vm_pgoff;
+
+	if (off < (c->vm_end - c->vm_start) >> PAGE_SHIFT) {
+		page = c->vm_pages + off;
+		if (type)
+			*type = VM_FAULT_MINOR;
+	}
+
+	return page;
+}
+
+static struct vm_operations_struct dma_vm_ops = {
+	.open	= dma_mmap_open,
+	.close	= dma_mmap_close,
+	.nopage	= dma_mmap_nopage,
+};
+
+static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
+{
+	struct vm_region *c;
+	unsigned long flags, user_size, kern_size;
+
+	spin_lock_irqsave(&consistent_head.vm_lock, flags);
+	c = vm_region_find(&consistent_head, (unsigned long)cpu_addr);
+	if (c)
+		dma_coherent_get(c);
+	spin_unlock_irqrestore(&consistent_head.vm_lock, flags);
+
+	if (!c)
+		return -ENXIO;
+
+	user_size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	kern_size = (c->vm_end - c->vm_start) >> PAGE_SHIFT;
+	if (vma->vm_pgoff >= kern_size ||
+	    user_size >= (kern_size - vma->vm_pgoff)) {
+		dma_coherent_put(c);
+		return -ENXIO;
+	}
+
+	vma->vm_ops = &dma_vm_ops;
+	vma->vm_private_data = c;
+	vma->vm_flags |= VM_RESERVED;
+	return 0;
+}
+
+int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+		      void *cpu_addr, dma_addr_t dma_addr, size_t size)
+{
+	vma->vm_page_prot = pgprot_dmacoherent(vma->vm_page_prot);
+	return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
+}
+EXPORT_SYMBOL(dma_mmap_coherent);
+
 /*
  * free a page as defined by the above mapping.
  */
-void consistent_free(void *vaddr, size_t size, dma_addr_t handle)
+void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr_t handle)
 {
 	struct vm_region *c;
 	unsigned long flags;
@@ -259,20 +365,25 @@ void consistent_free(void *vaddr, size_t
 
 	size = PAGE_ALIGN(size);
 
-	spin_lock_irqsave(&consistent_lock, flags);
+	spin_lock_irqsave(&consistent_head.vm_lock, flags);
 	vm_region_dump(&consistent_head, "before free");
 
-	c = vm_region_find(&consistent_head, (unsigned long)vaddr);
+	c = vm_region_find(&consistent_head, (unsigned long)cpu_addr);
 	if (!c)
 		goto no_area;
 
 	if ((c->vm_end - c->vm_start) != size) {
-		printk(KERN_ERR "consistent_free: wrong size (%ld != %d)\n",
-		       c->vm_end - c->vm_start, size);
+		dev_err(dev, "freeing wrong coherent size (%ld != %d)\n",
+		        c->vm_end - c->vm_start, size);
 		dump_stack();
 		size = c->vm_end - c->vm_start;
 	}
 
+	if (c->vm_user_use) {
+		dev_err(dev, "freeing coherent buffer with user mappings\n");
+		dump_stack();
+	}
+
 	ptep = consistent_pte + CONSISTENT_OFFSET(c->vm_start);
 	do {
 		pte_t pte = ptep_get_and_clear(ptep);
@@ -292,8 +403,8 @@ void consistent_free(void *vaddr, size_t
 			}
 		}
 
-		printk(KERN_CRIT "consistent_free: bad page in kernel page "
-		       "table\n");
+		printk(KERN_CRIT "%s: bad page in kernel page table\n",
+		       __func__);
 	} while (size -= PAGE_SIZE);
 
 	flush_tlb_kernel_range(c->vm_start, c->vm_end);
@@ -301,18 +412,18 @@ void consistent_free(void *vaddr, size_t
 	list_del(&c->vm_list);
 
 	vm_region_dump(&consistent_head, "after free");
-	spin_unlock_irqrestore(&consistent_lock, flags);
+	spin_unlock_irqrestore(&consistent_head.vm_lock, flags);
 
 	kfree(c);
 	return;
 
  no_area:
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	printk(KERN_ERR "consistent_free: trying to free "
-	       "invalid area: %p\n", vaddr);
+	spin_unlock_irqrestore(&consistent_head.vm_lock, flags);
+	dev_err(dev, "trying to free invalid coherent area: %p\n",
+	        cpu_addr);
 	dump_stack();
 }
-EXPORT_SYMBOL(consistent_free);
+EXPORT_SYMBOL(dma_free_coherent);
 
 /*
  * Initialise the consistent memory allocation.
--- orig/include/asm-arm/dma-mapping.h	Fri Mar 19 11:56:26 2004
+++ linux/include/asm-arm/dma-mapping.h	Sun Mar 28 10:28:57 2004
@@ -14,8 +14,6 @@
  * devices.  This is the "generic" version.  The PCI specific version
  * is in pci.h
  */
-extern void *consistent_alloc(int gfp, size_t size, dma_addr_t *handle, unsigned long flags);
-extern void consistent_free(void *vaddr, size_t size, dma_addr_t handle);
 extern void consistent_sync(void *kaddr, size_t size, int rw);
 
 /*
@@ -46,6 +44,9 @@ extern struct bus_type sa1111_bus_type;
  * properly.  For example, if your device can only drive the low 24-bits
  * during bus mastering, then you would pass 0x00ffffff as the mask
  * to this function.
+ *
+ * This should really be a platform specific issue - we should return
+ * false if GFP_DMA allocations may not satisfy the supplied 'mask'.
  */
 static inline int dma_supported(struct device *dev, u64 mask)
 {
@@ -99,12 +100,24 @@ dma_alloc_coherent(struct device *dev, s
  * References to memory and mappings associated with cpu_addr/handle
  * during and after this call executing are illegal.
  */
-static inline void
+extern void
 dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
-		  dma_addr_t handle)
-{
-	consistent_free(cpu_addr, size, handle);
-}
+		  dma_addr_t handle);
+
+/**
+ * dma_mmap_coherent - map a coherent DMA allocation into user space
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @vma: vm_area_struct describing requested user mapping
+ * @cpu_addr: kernel CPU-view address returned from dma_alloc_coherent
+ * @handle: device-view address returned from dma_alloc_coherent
+ * @size: size of memory originally requested in dma_alloc_coherent
+ *
+ * Map a coherent DMA buffer previously allocated by dma_alloc_coherent
+ * into user space.  The coherent DMA buffer must not be freed by the
+ * driver until the user space mapping has been released.
+ */
+int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+		      void *cpu_addr, dma_addr_t handle, size_t size);
 
 /**
  * dma_map_single - map a single buffer for streaming DMA

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
