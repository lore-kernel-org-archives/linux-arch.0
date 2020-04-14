From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 22/29] mm: remove the prot argument to __vmalloc_node
Date: Tue, 14 Apr 2020 15:13:41 +0200
Message-ID: <20200414131348.444715-23-hch@lst.de>
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

This is always PAGE_KERNEL now.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Acked-by: Peter Zijlstra (Intel) <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
---
 mm/vmalloc.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 466a449b3a15..de7952959e82 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2401,8 +2401,7 @@ void *vmap(struct page **pages, unsigned int count,
 EXPORT_SYMBOL(vmap);
 
 static void *__vmalloc_node(unsigned long size, unsigned long align,
-			    gfp_t gfp_mask, pgprot_t prot,
-			    int node, const void *caller);
+			    gfp_t gfp_mask, int node, const void *caller);
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				 pgprot_t prot, int node)
 {
@@ -2420,7 +2419,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
 		pages = __vmalloc_node(array_size, 1, nested_gfp|highmem_mask,
-				PAGE_KERNEL, node, area->caller);
+				node, area->caller);
 	} else {
 		pages = kmalloc_node(array_size, nested_gfp, node);
 	}
@@ -2539,13 +2538,11 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_range);
  * @size:	    allocation size
  * @align:	    desired alignment
  * @gfp_mask:	    flags for the page level allocator
- * @prot:	    protection mask for the allocated pages
  * @node:	    node to use for allocation or NUMA_NO_NODE
  * @caller:	    caller's return address
  *
- * Allocate enough pages to cover @size from the page level
- * allocator with @gfp_mask flags.  Map them into contiguous
- * kernel virtual space, using a pagetable protection of @prot.
+ * Allocate enough pages to cover @size from the page level allocator with
+ * @gfp_mask flags.  Map them into contiguous kernel virtual space.
  *
  * Reclaim modifiers in @gfp_mask - __GFP_NORETRY, __GFP_RETRY_MAYFAIL
  * and __GFP_NOFAIL are not supported
@@ -2556,16 +2553,15 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_range);
  * Return: pointer to the allocated memory or %NULL on error
  */
 static void *__vmalloc_node(unsigned long size, unsigned long align,
-			    gfp_t gfp_mask, pgprot_t prot,
-			    int node, const void *caller)
+			    gfp_t gfp_mask, int node, const void *caller)
 {
 	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
-				gfp_mask, prot, 0, node, caller);
+				gfp_mask, PAGE_KERNEL, 0, node, caller);
 }
 
 void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 {
-	return __vmalloc_node(size, 1, gfp_mask, PAGE_KERNEL, NUMA_NO_NODE,
+	return __vmalloc_node(size, 1, gfp_mask, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(__vmalloc);
@@ -2573,15 +2569,15 @@ EXPORT_SYMBOL(__vmalloc);
 static inline void *__vmalloc_node_flags(unsigned long size,
 					int node, gfp_t flags)
 {
-	return __vmalloc_node(size, 1, flags, PAGE_KERNEL,
-					node, __builtin_return_address(0));
+	return __vmalloc_node(size, 1, flags, node,
+				__builtin_return_address(0));
 }
 
 
 void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t flags,
 				  void *caller)
 {
-	return __vmalloc_node(size, 1, flags, PAGE_KERNEL, node, caller);
+	return __vmalloc_node(size, 1, flags, node, caller);
 }
 
 /**
@@ -2656,8 +2652,8 @@ EXPORT_SYMBOL(vmalloc_user);
  */
 void *vmalloc_node(unsigned long size, int node)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL, PAGE_KERNEL,
-					node, __builtin_return_address(0));
+	return __vmalloc_node(size, 1, GFP_KERNEL, node,
+			__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vmalloc_node);
 
@@ -2670,9 +2666,6 @@ EXPORT_SYMBOL(vmalloc_node);
  * allocator and map them into contiguous kernel virtual space.
  * The memory allocated is set to zero.
  *
- * For tight control over page level allocator and protection flags
- * use __vmalloc_node() instead.
- *
  * Return: pointer to the allocated memory or %NULL on error
  */
 void *vzalloc_node(unsigned long size, int node)
@@ -2745,8 +2738,8 @@ void *vmalloc_exec(unsigned long size)
  */
 void *vmalloc_32(unsigned long size)
 {
-	return __vmalloc_node(size, 1, GFP_VMALLOC32, PAGE_KERNEL,
-			      NUMA_NO_NODE, __builtin_return_address(0));
+	return __vmalloc_node(size, 1, GFP_VMALLOC32, NUMA_NO_NODE,
+			__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vmalloc_32);
 
-- 
2.25.1
