From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 08/29] mm: remove __get_vm_area
Date: Tue, 14 Apr 2020 15:13:27 +0200
Message-ID: <20200414131348.444715-9-hch@lst.de>
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

Switch the two remaining callers to use __get_vm_area_caller instead.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Acked-by: Peter Zijlstra (Intel) <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
---
 arch/powerpc/kernel/pci_64.c | 3 ++-
 arch/sh/kernel/cpu/sh4/sq.c  | 3 ++-
 include/linux/vmalloc.h      | 2 --
 mm/vmalloc.c                 | 8 --------
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 2a976314f169..d9ac980c398c 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -132,7 +132,8 @@ void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size)
 	 * address decoding but I'd rather not deal with those outside of the
 	 * reserved 64K legacy region.
 	 */
-	area = __get_vm_area(size, 0, PHB_IO_BASE, PHB_IO_END);
+	area = __get_vm_area_caller(size, 0, PHB_IO_BASE, PHB_IO_END,
+				    __builtin_return_address(0));
 	if (!area)
 		return NULL;
 
diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 934ff84844fa..d432164b23b7 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -103,7 +103,8 @@ static int __sq_remap(struct sq_mapping *map, pgprot_t prot)
 #if defined(CONFIG_MMU)
 	struct vm_struct *vma;
 
-	vma = __get_vm_area(map->size, VM_ALLOC, map->sq_addr, SQ_ADDRMAX);
+	vma = __get_vm_area_caller(map->size, VM_ALLOC, map->sq_addr,
+			SQ_ADDRMAX, __builtin_return_address(0));
 	if (!vma)
 		return -ENOMEM;
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 0507a162ccd0..3070b4dbc2d9 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -161,8 +161,6 @@ static inline size_t get_vm_area_size(const struct vm_struct *area)
 extern struct vm_struct *get_vm_area(unsigned long size, unsigned long flags);
 extern struct vm_struct *get_vm_area_caller(unsigned long size,
 					unsigned long flags, const void *caller);
-extern struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
-					unsigned long start, unsigned long end);
 extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 					unsigned long flags,
 					unsigned long start, unsigned long end,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 399f219544f7..d1534d610b48 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2127,14 +2127,6 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 	return area;
 }
 
-struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
-				unsigned long start, unsigned long end)
-{
-	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
-				  GFP_KERNEL, __builtin_return_address(0));
-}
-EXPORT_SYMBOL_GPL(__get_vm_area);
-
 struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
 				       unsigned long start, unsigned long end,
 				       const void *caller)
-- 
2.25.1
