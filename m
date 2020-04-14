From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 13/29] mm: remove vmap_page_range_noflush and vunmap_page_range
Date: Tue, 14 Apr 2020 15:13:32 +0200
Message-ID: <20200414131348.444715-14-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20200414131348.444715-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "K. Y. Srinivasan" <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Wei Liu <wei.liu-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Laura Abbott <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Minchan Kim <minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nitin Gupta <ngupta-KNmc09w0p+Ednm+yROfE0A@public.gmane.org>
Cc: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hyperv-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

These have non-static aliases called map_kernel_range_noflush and
unmap_kernel_range_noflush that just differ slightly in the calling
conventions that pass addr + size instead of an end.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Acked-by: Peter Zijlstra (Intel) <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
---
 mm/vmalloc.c | 98 +++++++++++++++++++++-------------------------------
 1 file changed, 40 insertions(+), 58 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index aada9e9144bd..55df5dc6a9fc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -127,10 +127,24 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end)
 	} while (p4d++, addr = next, addr != end);
 }
 
-static void vunmap_page_range(unsigned long addr, unsigned long end)
+/**
+ * unmap_kernel_range_noflush - unmap kernel VM area
+ * @addr: start of the VM area to unmap
+ * @size: size of the VM area to unmap
+ *
+ * Unmap PFN_UP(@size) pages at @addr.  The VM area @addr and @size specify
+ * should have been allocated using get_vm_area() and its friends.
+ *
+ * NOTE:
+ * This function does NOT do any cache flushing.  The caller is responsible
+ * for calling flush_cache_vunmap() on to-be-mapped areas before calling this
+ * function and flush_tlb_kernel_range() after.
+ */
+void unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
 {
-	pgd_t *pgd;
+	unsigned long end = addr + size;
 	unsigned long next;
+	pgd_t *pgd;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset_k(addr);
@@ -219,18 +233,30 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
 	return 0;
 }
 
-/*
- * Set up page tables in kva (addr, end). The ptes shall have prot "prot", and
- * will have pfns corresponding to the "pages" array.
+/**
+ * map_kernel_range_noflush - map kernel VM area with the specified pages
+ * @addr: start of the VM area to map
+ * @size: size of the VM area to map
+ * @prot: page protection flags to use
+ * @pages: pages to map
  *
- * Ie. pte at addr+N*PAGE_SIZE shall point to pfn corresponding to pages[N]
+ * Map PFN_UP(@size) pages at @addr.  The VM area @addr and @size specify should
+ * have been allocated using get_vm_area() and its friends.
+ *
+ * NOTE:
+ * This function does NOT do any cache flushing.  The caller is responsible for
+ * calling flush_cache_vmap() on to-be-mapped areas before calling this
+ * function.
+ *
+ * RETURNS:
+ * The number of pages mapped on success, -errno on failure.
  */
-static int vmap_page_range_noflush(unsigned long start, unsigned long end,
-				   pgprot_t prot, struct page **pages)
+int map_kernel_range_noflush(unsigned long addr, unsigned long size,
+			     pgprot_t prot, struct page **pages)
 {
-	pgd_t *pgd;
+	unsigned long end = addr + size;
 	unsigned long next;
-	unsigned long addr = start;
+	pgd_t *pgd;
 	int err = 0;
 	int nr = 0;
 
@@ -251,7 +277,7 @@ static int vmap_page_range(unsigned long start, unsigned long end,
 {
 	int ret;
 
-	ret = vmap_page_range_noflush(start, end, prot, pages);
+	ret = map_kernel_range_noflush(start, end - start, prot, pages);
 	flush_cache_vmap(start, end);
 	return ret;
 }
@@ -1226,7 +1252,7 @@ EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
  */
 static void unmap_vmap_area(struct vmap_area *va)
 {
-	vunmap_page_range(va->va_start, va->va_end);
+	unmap_kernel_range_noflush(va->va_start, va->va_end - va->va_start);
 }
 
 /*
@@ -1686,7 +1712,7 @@ static void vb_free(unsigned long addr, unsigned long size)
 	rcu_read_unlock();
 	BUG_ON(!vb);
 
-	vunmap_page_range(addr, addr + size);
+	unmap_kernel_range_noflush(addr, size);
 
 	if (debug_pagealloc_enabled_static())
 		flush_tlb_kernel_range(addr, addr + size);
@@ -1984,50 +2010,6 @@ void __init vmalloc_init(void)
 	vmap_initialized = true;
 }
 
-/**
- * map_kernel_range_noflush - map kernel VM area with the specified pages
- * @addr: start of the VM area to map
- * @size: size of the VM area to map
- * @prot: page protection flags to use
- * @pages: pages to map
- *
- * Map PFN_UP(@size) pages at @addr.  The VM area @addr and @size
- * specify should have been allocated using get_vm_area() and its
- * friends.
- *
- * NOTE:
- * This function does NOT do any cache flushing.  The caller is
- * responsible for calling flush_cache_vmap() on to-be-mapped areas
- * before calling this function.
- *
- * RETURNS:
- * The number of pages mapped on success, -errno on failure.
- */
-int map_kernel_range_noflush(unsigned long addr, unsigned long size,
-			     pgprot_t prot, struct page **pages)
-{
-	return vmap_page_range_noflush(addr, addr + size, prot, pages);
-}
-
-/**
- * unmap_kernel_range_noflush - unmap kernel VM area
- * @addr: start of the VM area to unmap
- * @size: size of the VM area to unmap
- *
- * Unmap PFN_UP(@size) pages at @addr.  The VM area @addr and @size
- * specify should have been allocated using get_vm_area() and its
- * friends.
- *
- * NOTE:
- * This function does NOT do any cache flushing.  The caller is
- * responsible for calling flush_cache_vunmap() on to-be-mapped areas
- * before calling this function and flush_tlb_kernel_range() after.
- */
-void unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
-{
-	vunmap_page_range(addr, addr + size);
-}
-
 /**
  * unmap_kernel_range - unmap kernel VM area and flush cache and TLB
  * @addr: start of the VM area to unmap
@@ -2041,7 +2023,7 @@ void unmap_kernel_range(unsigned long addr, unsigned long size)
 	unsigned long end = addr + size;
 
 	flush_cache_vunmap(addr, end);
-	vunmap_page_range(addr, end);
+	unmap_kernel_range_noflush(addr, size);
 	flush_tlb_kernel_range(addr, end);
 }
 
-- 
2.25.1
