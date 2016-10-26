From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [RFC] dma-mapping: fix dma_common_mmap() for ARC
Date: Wed, 26 Oct 2016 22:22:44 +0300
Message-ID: <1477509764-18370-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

ARC CPU with enabled MMU sees entire 32-bit address space divided in 2
big parts:
 1) 0 - 0x7fff_ffff (lower 2Gb): translated memory
    I.e. all reads/writes from/to this region go through MMU and after
    translation land somewhere in physical memory.

 2) 0x8000_0000 - 0xffff_ffff: untranslated memory
    ARC CPU in kernel mode accesses this memory directly, i.e. MMU is
    not used at all.
    One important note: data accesses in this region go through data
    cache!

If some peripheral wants to use DMA Linux kernel just allocates data
buffer in upper 2Gb (i.e. above 0x8000_0000).
In that case dma_addr = cpu_addr. Everything is simple.

But if a driver wants to allocate uncached buffer for DMA (very good
example and that's how I actually caught the issue is DRM frame-buffer)
things become a little-bit more complicated.

Now kernel wants to write data in memory bypassing data cache.
For that to happen we have to program MMU so that TLB entry gets
"cached flag" reset for a particular page(s). And keeping in mind
explanation above the only way to utilize MMU is to access data via
lower part of address space. In other words we implement page mapping
similarly to what we do for user-space, see:
------------------------>8-----------------------
arc_dma_alloc()
  ioremap_nocache() AKA ioremap()
    ioremap_prot()
      get_vm_area() + ioremap_page_range() on obtained vaddr
------------------------>8-----------------------

As a result we get TLB entry of the following kind:
------------------------>8-----------------------
    vaddr = 0x7200_0000
    paddr = 0x8200_0000
    flags = _uncached_
------------------------>8-----------------------

Kerenl thinks frame buffer is located @ 0x7200_0000 and uses it
perfectly fine.

But here comes a time for user-space application to request frame buffer
to be mapped for it. That happens easily with the following call path:
------------------------>8-----------------------
fb_mmap()
  drm_fb_cma_mmap()
    dma_mmap_writecombine() AKA dma_mmap_wc()
      dma_mmap_attrs()
        dma_common_mmap() since we don't [yet] have dma_map_ops.mmap()
                          for ARC
------------------------>8-----------------------

And in dma_common_mmap() we first calculate pfn of what we think is
"physical page" and then do remap_pfn_range() to that "physical page".

Here we're getting to the interesting thing - how pfn is calculated.
As of now this is done as simple as:
------------------------>8-----------------------
    pfn = page_to_pfn(virt_to_page(cpu_addr));
------------------------>8-----------------------

Below is a nice set of defines we need to use to evaluate pfn:
------------------------>8-----------------------
 #define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
 #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
 #define page_to_pfn __page_to_pfn
 #define pfn_to_page __pfn_to_page
 #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
 #define __page_to_pfn(page)     ((unsigned long)((page) - mem_map) + \
                                   ARCH_PFN_OFFSET)
------------------------>8-----------------------

If we do some obvious calculations we'll get:
------------------------>8-----------------------
    pfn = cpu_addr >> PAGE_SHIFT;
------------------------>8-----------------------

In our case cpu_addr here is 0x7200_0000 from TLB entry above and this
what is used to create another TLB entry this time for user-space app.
We'll get something like this:
------------------------>8-----------------------
    vaddr = 0x0200_0000
    paddr = 0x7200_0000
    flags = _uncached_
------------------------>8-----------------------

This is obviously wrong! We cannot map vaddr to vaddr with MMU.

Simplest fix for ARC is to use dma_addr instead because it matches
real physical memory address and so mapping for user-space we're
getting then is this:
------------------------>8-----------------------
    vaddr = 0x0200_0000
    paddr = 0x8200_0000
    flags = _uncached_
------------------------>8-----------------------
And it works perfectly fine.

But I'm pretty sure that's not the best approach for other
architectures. Indeed we may create ARC-specific dma_map_ops.mmap()
which only differs from dma_common_mmap() with addr being used
but IMHO it's not the best idea to duplicate that much of code
for such a simple change.

Would be interesting to get more opinions on how to handle that thing in
the most graceful way.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arch@vger.kernel.org
---
 drivers/base/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 8f8b68c80986..16307eed453f 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -252,7 +252,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 #if defined(CONFIG_MMU) && !defined(CONFIG_ARCH_NO_COHERENT_DMA_MMAP)
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
+	unsigned long pfn = page_to_pfn(virt_to_page(dma_addr));
 	unsigned long off = vma->vm_pgoff;
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-- 
2.7.4
