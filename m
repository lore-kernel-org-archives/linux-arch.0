From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 16/29] mm: remove map_vm_range
Date: Tue, 14 Apr 2020 15:13:35 +0200
Message-ID: <20200414131348.444715-17-hch@lst.de>
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

Switch all callers to map_kernel_range, which symmetric to the unmap
side (as well as the _noflush versions).

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Acked-by: Peter Zijlstra (Intel) <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
---
 Documentation/core-api/cachetlb.rst |  2 +-
 include/linux/vmalloc.h             | 10 ++++------
 mm/vmalloc.c                        | 21 +++++++--------------
 mm/zsmalloc.c                       |  4 +++-
 net/ceph/ceph_common.c              |  3 +--
 5 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index 93cb65d52720..a1582cc79f0f 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -213,7 +213,7 @@ Here are the routines, one by one:
 	there will be no entries in the cache for the kernel address
 	space for virtual addresses in the range 'start' to 'end-1'.
 
-	The first of these two routines is invoked after map_vm_area()
+	The first of these two routines is invoked after map_kernel_range()
 	has installed the page table entries.  The second is invoked
 	before unmap_kernel_range() deletes the page table entries.
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 3070b4dbc2d9..15ffbd8e8e65 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -168,11 +168,11 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
 
-extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
-			struct page **pages);
 #ifdef CONFIG_MMU
 extern int map_kernel_range_noflush(unsigned long start, unsigned long size,
 				    pgprot_t prot, struct page **pages);
+int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
+		struct page **pages);
 extern void unmap_kernel_range_noflush(unsigned long addr, unsigned long size);
 extern void unmap_kernel_range(unsigned long addr, unsigned long size);
 static inline void set_vm_flush_reset_perms(void *addr)
@@ -189,14 +189,12 @@ map_kernel_range_noflush(unsigned long start, unsigned long size,
 {
 	return size >> PAGE_SHIFT;
 }
+#define map_kernel_range map_kernel_range_noflush
 static inline void
 unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
 {
 }
-static inline void
-unmap_kernel_range(unsigned long addr, unsigned long size)
-{
-}
+#define unmap_kernel_range unmap_kernel_range_noflush
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ca8dc5d42580..b0c7cdc8701a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -272,8 +272,8 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 	return 0;
 }
 
-static int map_kernel_range(unsigned long start, unsigned long size,
-			   pgprot_t prot, struct page **pages)
+int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
+		struct page **pages)
 {
 	int ret;
 
@@ -2027,16 +2027,6 @@ void unmap_kernel_range(unsigned long addr, unsigned long size)
 	flush_tlb_kernel_range(addr, end);
 }
 
-int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
-{
-	unsigned long addr = (unsigned long)area->addr;
-	int err;
-
-	err = map_kernel_range(addr, get_vm_area_size(area), prot, pages);
-
-	return err > 0 ? 0 : err;
-}
-
 static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
 {
@@ -2408,7 +2398,8 @@ void *vmap(struct page **pages, unsigned int count,
 	if (!area)
 		return NULL;
 
-	if (map_vm_area(area, prot, pages)) {
+	if (map_kernel_range((unsigned long)area->addr, size, prot,
+			pages) < 0) {
 		vunmap(area->addr);
 		return NULL;
 	}
@@ -2471,8 +2462,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
-	if (map_vm_area(area, prot, pages))
+	if (map_kernel_range((unsigned long)area->addr, get_vm_area_size(area),
+			prot, pages) < 0)
 		goto fail;
+
 	return area->addr;
 
 fail:
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index ac0524330b9b..f6dc0673e62c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1138,7 +1138,9 @@ static inline void __zs_cpu_down(struct mapping_area *area)
 static inline void *__zs_map_object(struct mapping_area *area,
 				struct page *pages[2], int off, int size)
 {
-	BUG_ON(map_vm_area(area->vm, PAGE_KERNEL, pages));
+	unsigned long addr = (unsigned long)area->vm->addr;
+
+	BUG_ON(map_kernel_range(addr, PAGE_SIZE * 2, PAGE_KERNEL, pages) < 0);
 	area->vm_addr = area->vm->addr;
 	return area->vm_addr + off;
 }
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index a0e97f6c1072..66f22e8aa529 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -190,8 +190,7 @@ EXPORT_SYMBOL(ceph_compare_options);
  * kvmalloc() doesn't fall back to the vmalloc allocator unless flags are
  * compatible with (a superset of) GFP_KERNEL.  This is because while the
  * actual pages are allocated with the specified flags, the page table pages
- * are always allocated with GFP_KERNEL.  map_vm_area() doesn't even take
- * flags because GFP_KERNEL is hard-coded in {p4d,pud,pmd,pte}_alloc().
+ * are always allocated with GFP_KERNEL.
  *
  * ceph_kvmalloc() may be called with GFP_KERNEL, GFP_NOFS or GFP_NOIO.
  */
-- 
2.25.1
