From: Krishna Reddy <vdumpa@nvidia.com>
Subject: RE: [Linaro-mm-sig] [PATCH 1/2] ARM: initial proof-of-concept IOMMU
 mapper for DMA-mapping
Date: Wed, 12 Oct 2011 17:18:00 -0700
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E3722519EAE@HQMAIL04.nvidia.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
	<1314971786-15140-2-git-send-email-m.szyprowski@samsung.com>
	<594816116217195c28de13accaf1f9f2.squirrel@www.codeaurora.org>
	<001f01cc786d$d55222c0$7ff66840$%szyprowski@samsung.com>
	<401E54CE964CD94BAE1EB4A729C7087E37225197F8@HQMAIL04.nvidia.com>
	<00b101cc87ee$8976c410$9c644c30$%szyprowski@samsung.com>
	<401E54CE964CD94BAE1EB4A729C7087E3722519A1F@HQMAIL04.nvidia.com>
	<401E54CE964CD94BAE1EB4A729C7087E3722519BF4@HQMAIL04.nvidia.com>
	<00e501cc88a2$b82fc680$288f5380$%szyprowski@samsung.com>
 <401E54CE964CD94BAE1EB4A729C7087E3722519C65@HQMAIL04.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:14093 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab1JMASf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2011 20:18:35 -0400
In-Reply-To: <401E54CE964CD94BAE1EB4A729C7087E3722519C65@HQMAIL04.nvidia.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Arnd Bergmann' <arnd@arndb.de>, 'Joerg Roedel' <joro@8bytes.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Here a patch v2 that has updates/fixes to DMA IOMMU code. With these changes, the nvidia device is able to boot with all its platform drivers as DMA IOMMU clients.

Here is the overview of changes.

1. Converted the mutex to spinlock to handle atomic context calls and used spinlock in necessary places.
2. Implemented arm_iommu_map_page and arm_iommu_unmap_page, which are used by MMC host stack.
3. Separated creation of dma_iommu_mapping from arm_iommu_attach_device in order to share mapping.
4. Fixed various bugs identified in DMA IOMMU code during testing.




[PATCH] ARM: dma-mapping: Add iommu map_page/unmap_page and fix issues.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm/include/asm/dma-iommu.h |   14 ++-
 arch/arm/mm/dma-mapping.c        |  229 +++++++++++++++++++++++++-------------
 2 files changed, 161 insertions(+), 82 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 0b2677e..5f4e37f 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -7,6 +7,8 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
 #include <linux/kmemcheck.h>
+#include <linux/spinlock_types.h>
+#include <linux/kref.h>

 #include <asm/memory.h>

@@ -19,11 +21,17 @@ struct dma_iommu_mapping {
        unsigned int            order;
        dma_addr_t              base;

-       struct mutex            lock;
+       spinlock_t              lock;
+       struct kref             kref;
 };

-int arm_iommu_attach_device(struct device *dev, dma_addr_t base,
-                           dma_addr_t size, int order);
+struct dma_iommu_mapping *arm_iommu_create_mapping(dma_addr_t base,
+                                                   size_t size, int order);
+
+void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
+
+int arm_iommu_attach_device(struct device *dev,
+                           struct dma_iommu_mapping *mapping);

 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 020bde1..721b7c0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -739,32 +739,42 @@ fs_initcall(dma_debug_do_init);

 /* IOMMU */

-static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping, size_t size)
+static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
+                                       size_t size)
 {
-       unsigned int order = get_order(size);
        unsigned int align = 0;
        unsigned int count, start;
+       unsigned long flags;

-       if (order > mapping->order)
-               align = (1 << (order - mapping->order)) - 1;
+       count = ((PAGE_ALIGN(size) >> PAGE_SHIFT) +
+                (1 << mapping->order) - 1) >> mapping->order;

-       count = ((size >> PAGE_SHIFT) + (1 << mapping->order) - 1) >> mapping->order;
-
-       start = bitmap_find_next_zero_area(mapping->bitmap, mapping->bits, 0, count, align);
-       if (start > mapping->bits)
+       spin_lock_irqsave(&mapping->lock, flags);
+       start = bitmap_find_next_zero_area(mapping->bitmap, mapping->bits,
+                                           0, count, align);
+       if (start > mapping->bits) {
+               spin_unlock_irqrestore(&mapping->lock, flags);
                return ~0;
+       }

        bitmap_set(mapping->bitmap, start, count);
+       spin_unlock_irqrestore(&mapping->lock, flags);

        return mapping->base + (start << (mapping->order + PAGE_SHIFT));
 }

-static inline void __free_iova(struct dma_iommu_mapping *mapping, dma_addr_t addr, size_t size)
+static inline void __free_iova(struct dma_iommu_mapping *mapping,
+                               dma_addr_t addr, size_t size)
 {
-       unsigned int start = (addr - mapping->base) >> (mapping->order + PAGE_SHIFT);
-       unsigned int count = ((size >> PAGE_SHIFT) + (1 << mapping->order) - 1) >> mapping->order;
+       unsigned int start = (addr - mapping->base) >>
+                            (mapping->order + PAGE_SHIFT);
+       unsigned int count = ((PAGE_ALIGN(size) >> PAGE_SHIFT) +
+                             (1 << mapping->order) - 1) >> mapping->order;
+       unsigned long flags;

+       spin_lock_irqsave(&mapping->lock, flags);
        bitmap_clear(mapping->bitmap, start, count);
+       spin_unlock_irqrestore(&mapping->lock, flags);
 }

 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size, gfp_t gfp)
@@ -867,7 +877,7 @@ __iommu_alloc_remap(struct page **pages, size_t size, gfp_t gfp, pgprot_t prot)
 static dma_addr_t __iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
 {
        struct dma_iommu_mapping *mapping = dev->archdata.mapping;
-       unsigned int count = size >> PAGE_SHIFT;
+       unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
        dma_addr_t dma_addr, iova;
        int i, ret = ~0;

@@ -892,13 +902,12 @@ fail:
 static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t size)
 {
        struct dma_iommu_mapping *mapping = dev->archdata.mapping;
-       unsigned int count = size >> PAGE_SHIFT;
+       unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
        int i;

-       for (i=0; i<count; i++) {
-               iommu_unmap(mapping->domain, iova, 0);
-               iova += PAGE_SIZE;
-       }
+       iova = iova & PAGE_MASK;
+       for (i = 0; i < count; i++)
+               iommu_unmap(mapping->domain, iova + (i << PAGE_SHIFT), 0);
        __free_iova(mapping, iova, size);
        return 0;
 }
@@ -906,7 +915,6 @@ static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t si
 static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
            dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-       struct dma_iommu_mapping *mapping = dev->archdata.mapping;
        pgprot_t prot = __get_dma_pgprot(attrs, pgprot_kernel);
        struct page **pages;
        void *addr = NULL;
@@ -914,11 +922,9 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
        *handle = ~0;
        size = PAGE_ALIGN(size);

-       mutex_lock(&mapping->lock);
-
        pages = __iommu_alloc_buffer(dev, size, gfp);
        if (!pages)
-               goto err_unlock;
+               goto exit;

        *handle = __iommu_create_mapping(dev, pages, size);
        if (*handle == ~0)
@@ -928,15 +934,13 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
        if (!addr)
                goto err_mapping;

-       mutex_unlock(&mapping->lock);
        return addr;

 err_mapping:
        __iommu_remove_mapping(dev, *handle, size);
 err_buffer:
        __iommu_free_buffer(dev, pages, size);
-err_unlock:
-       mutex_unlock(&mapping->lock);
+exit:
        return NULL;
 }

@@ -944,11 +948,9 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
                    void *cpu_addr, dma_addr_t dma_addr, size_t size,
                    struct dma_attrs *attrs)
 {
-       unsigned long user_size;
        struct arm_vmregion *c;

        vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
-       user_size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;

        c = arm_vmregion_find(&consistent_head, (unsigned long)cpu_addr);
        if (c) {
@@ -981,11 +983,9 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
                          dma_addr_t handle, struct dma_attrs *attrs)
 {
-       struct dma_iommu_mapping *mapping = dev->archdata.mapping;
        struct arm_vmregion *c;
        size = PAGE_ALIGN(size);

-       mutex_lock(&mapping->lock);
        c = arm_vmregion_find(&consistent_head, (unsigned long)cpu_addr);
        if (c) {
                struct page **pages = c->priv;
@@ -993,7 +993,6 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
                __iommu_remove_mapping(dev, handle, size);
                __iommu_free_buffer(dev, pages, size);
        }
-       mutex_unlock(&mapping->lock);
 }

 static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
@@ -1001,80 +1000,118 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
                          enum dma_data_direction dir)
 {
        struct dma_iommu_mapping *mapping = dev->archdata.mapping;
-       dma_addr_t dma_addr, iova;
+       dma_addr_t iova;
        int ret = 0;
+       unsigned int count, i;
+       struct scatterlist *s;

+       size = PAGE_ALIGN(size);
        *handle = ~0;
-       mutex_lock(&mapping->lock);

-       iova = dma_addr = __alloc_iova(mapping, size);
-       if (dma_addr == 0)
-               goto fail;
+       iova = __alloc_iova(mapping, size);
+       if (iova == 0)
+               return -ENOMEM;

-       while (size) {
-               unsigned int phys = page_to_phys(sg_page(sg));
-               unsigned int len = sg->offset + sg->length;
+       for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
+               phys_addr_t phys = page_to_phys(sg_page(s));
+               unsigned int len = PAGE_ALIGN(s->offset + s->length);

                if (!arch_is_coherent())
-                       __dma_page_cpu_to_dev(sg_page(sg), sg->offset, sg->length, dir);
+                       __dma_page_cpu_to_dev(sg_page(s), s->offset,
+                                               s->length, dir);

-               while (len) {
-                       ret = iommu_map(mapping->domain, iova, phys, 0, 0);
+               for (i = 0; i < (len >> PAGE_SHIFT); i++) {
+                       ret = iommu_map(mapping->domain,
+                               iova + (count << PAGE_SHIFT),
+                               phys + (i << PAGE_SHIFT), 0, 0);
                        if (ret < 0)
                                goto fail;
-                       iova += PAGE_SIZE;
-                       len -= PAGE_SIZE;
-                       size -= PAGE_SIZE;
+                       count++;
                }
-               sg = sg_next(sg);
        }
-
-       *handle = dma_addr;
-       mutex_unlock(&mapping->lock);
+       *handle = iova;

        return 0;
 fail:
+       while (count--)
+               iommu_unmap(mapping->domain, iova + count * PAGE_SIZE, 0);
        __iommu_remove_mapping(dev, iova, size);
-       mutex_unlock(&mapping->lock);
        return ret;
 }

+static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
+            unsigned long offset, size_t size, enum dma_data_direction dir,
+            struct dma_attrs *attrs)
+{
+       dma_addr_t dma_addr;
+
+       if (!arch_is_coherent())
+               __dma_page_cpu_to_dev(page, offset, size, dir);
+
+       BUG_ON((offset+size) > PAGE_SIZE);
+       dma_addr = __iommu_create_mapping(dev, &page, PAGE_SIZE);
+       return dma_addr + offset;
+}
+
+static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
+               size_t size, enum dma_data_direction dir,
+               struct dma_attrs *attrs)
+{
+       struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+       phys_addr_t phys;
+
+       phys = iommu_iova_to_phys(mapping->domain, handle);
+       __iommu_remove_mapping(dev, handle, size);
+       if (!arch_is_coherent())
+               __dma_page_dev_to_cpu(pfn_to_page(__phys_to_pfn(phys)),
+                                     phys & ~PAGE_MASK, size, dir);
+}
+
 int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
                     enum dma_data_direction dir, struct dma_attrs *attrs)
 {
        struct scatterlist *s = sg, *dma = sg, *start = sg;
-       int i, count = 1;
+       int i, count = 0;
        unsigned int offset = s->offset;
        unsigned int size = s->offset + s->length;

+       s->dma_address = ~0;
+       s->dma_length = 0;
+
        for (i = 1; i < nents; i++) {
+               s = sg_next(s);
                s->dma_address = ~0;
                s->dma_length = 0;

-               s = sg_next(s);
-
-               if (s->offset || (size & (PAGE_SIZE - 1))) {
-                       if (__map_sg_chunk(dev, start, size, &dma->dma_address, dir) < 0)
+               if (s->offset || size & ~PAGE_MASK ||
+                   size + s->length > dma_get_max_seg_size(dev)) {
+                       if (__map_sg_chunk(dev, start, size,
+                                           &dma->dma_address, dir) < 0)
                                goto bad_mapping;

                        dma->dma_address += offset;
-                       dma->dma_length = size;
+                       dma->dma_length = size - offset;

                        size = offset = s->offset;
                        start = s;
                        dma = sg_next(dma);
-                       count += 1;
+                       count++;
                }
-               size += sg->length;
+               size += s->length;
        }
-       __map_sg_chunk(dev, start, size, &dma->dma_address, dir);
-       d->dma_address += offset;

-       return count;
+       if (__map_sg_chunk(dev, start, size, &dma->dma_address, dir) < 0)
+               goto bad_mapping;
+       dma->dma_address += offset;
+       dma->dma_length = size - offset;
+
+       return ++count;

 bad_mapping:
-       for_each_sg(sg, s, count-1, i)
-               __iommu_remove_mapping(dev, sg_dma_address(s), sg_dma_len(s));
+       for_each_sg(sg, s, count, i) {
+               __iommu_remove_mapping(dev, sg_dma_address(s),
+                                       PAGE_ALIGN(sg_dma_len(s)));
+       }
        return 0;
 }

@@ -1086,9 +1123,11 @@ void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,

        for_each_sg(sg, s, nents, i) {
                if (sg_dma_len(s))
-                       __iommu_remove_mapping(dev, sg_dma_address(s), sg_dma_len(s));
+                       __iommu_remove_mapping(dev, sg_dma_address(s),
+                                               sg_dma_len(s));
                if (!arch_is_coherent())
-                       __dma_page_dev_to_cpu(sg_page(sg), sg->offset, sg->length, dir);
+                       __dma_page_dev_to_cpu(sg_page(s), s->offset,
+                                               s->length, dir);
        }
 }

@@ -1108,7 +1147,8 @@ void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,

        for_each_sg(sg, s, nents, i)
                if (!arch_is_coherent())
-                       __dma_page_dev_to_cpu(sg_page(sg), sg->offset, sg->length, dir);
+                       __dma_page_dev_to_cpu(sg_page(s), s->offset,
+                                               s->length, dir);
 }

 /**
@@ -1126,20 +1166,24 @@ void arm_iommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,

        for_each_sg(sg, s, nents, i)
                if (!arch_is_coherent())
-                       __dma_page_cpu_to_dev(sg_page(sg), sg->offset, sg->length, dir);
+                       __dma_page_cpu_to_dev(sg_page(s), s->offset,
+                                               s->length, dir);
 }

 struct dma_map_ops iommu_ops = {
        .alloc          = arm_iommu_alloc_attrs,
        .free           = arm_iommu_free_attrs,
        .mmap           = arm_iommu_mmap_attrs,
+       .map_page       = arm_iommu_map_page,
+       .unmap_page     = arm_iommu_unmap_page,
        .map_sg                 = arm_iommu_map_sg,
        .unmap_sg               = arm_iommu_unmap_sg,
        .sync_sg_for_cpu        = arm_iommu_sync_sg_for_cpu,
        .sync_sg_for_device     = arm_iommu_sync_sg_for_device,
 };

-int arm_iommu_attach_device(struct device *dev, dma_addr_t base, size_t size, int order)
+struct dma_iommu_mapping *arm_iommu_create_mapping(dma_addr_t base,
+                                                   size_t size, int order)
 {
        unsigned int count = (size >> PAGE_SHIFT) - order;
        unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
@@ -1157,30 +1201,57 @@ int arm_iommu_attach_device(struct device *dev, dma_addr_t base, size_t size, in
        mapping->base = base;
        mapping->bits = bitmap_size;
        mapping->order = order;
-       mutex_init(&mapping->lock);
+       spin_lock_init(&mapping->lock);

        mapping->domain = iommu_domain_alloc();
        if (!mapping->domain)
                goto err3;

-       err = iommu_attach_device(mapping->domain, dev);
-       if (err != 0)
-               goto err4;
-
-       dev->archdata.mapping = mapping;
-       set_dma_ops(dev, &iommu_ops);
-
-       printk(KERN_INFO "Attached IOMMU controller to %s device.\n", dev_name(dev));
-       return 0;
+       kref_init(&mapping->kref);
+       return mapping;

-err4:
-       iommu_domain_free(mapping->domain);
 err3:
        kfree(mapping->bitmap);
 err2:
        kfree(mapping);
 err:
-       return -ENOMEM;
+       return ERR_PTR(err);
+}
+EXPORT_SYMBOL(arm_iommu_create_mapping);
+
+static void release_iommu_mapping(struct kref *kref)
+{
+       struct dma_iommu_mapping *mapping =
+               container_of(kref, struct dma_iommu_mapping, kref);
+
+       iommu_domain_free(mapping->domain);
+       kfree(mapping->bitmap);
+       kfree(mapping);
+}
+
+void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
+{
+       if (mapping)
+               kref_put(&mapping->kref, release_iommu_mapping);
+}
+EXPORT_SYMBOL(arm_iommu_release_mapping);
+
+int arm_iommu_attach_device(struct device *dev,
+                           struct dma_iommu_mapping *mapping)
+{
+       int err;
+
+       err = iommu_attach_device(mapping->domain, dev);
+       if (err)
+               return err;
+
+       kref_get(&mapping->kref);
+       dev->archdata.mapping = mapping;
+       set_dma_ops(dev, &iommu_ops);
+
+       printk(KERN_INFO "*****Attached IOMMU controller to %s device.\n",
+               dev_name(dev));
+       return 0;
 }
 EXPORT_SYMBOL(arm_iommu_attach_device);

--
1.7.0.4

--
nvpublic
