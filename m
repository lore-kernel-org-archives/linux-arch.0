Return-Path: <SRS0=F7pE=5Y=kvack.org=owner-linux-mm@kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 17/28] mm: remove the prot argument from vm_map_ram
Date: Wed,  8 Apr 2020 13:59:15 +0200
Message-ID: <20200408115926.1467567-18-hch@lst.de>
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200408115915.N4pB0tGuaoWNPz6_dy2hv5XJ84-bukkJmsv29e2ektE@z>

This is always GFP_KERNEL - for long term mappings with other properties
vmap should be used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c   | 2 +-
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 3 +--
 drivers/media/common/videobuf2/videobuf2-vmalloc.c | 3 +--
 fs/erofs/decompressor.c                            | 2 +-
 fs/xfs/xfs_buf.c                                   | 2 +-
 include/linux/vmalloc.h                            | 3 +--
 mm/nommu.c                                         | 2 +-
 mm/vmalloc.c                                       | 4 ++--
 8 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c b/drivers/g=
pu/drm/i915/gem/selftests/mock_dmabuf.c
index 9272bef57092..debaf7b18ab5 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
@@ -66,7 +66,7 @@ static void *mock_dmabuf_vmap(struct dma_buf *dma_buf)
 {
 	struct mock_dmabuf *mock =3D to_mock(dma_buf);
=20
-	return vm_map_ram(mock->pages, mock->npages, 0, PAGE_KERNEL);
+	return vm_map_ram(mock->pages, mock->npages, 0);
 }
=20
 static void mock_dmabuf_vunmap(struct dma_buf *dma_buf, void *vaddr)
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/=
media/common/videobuf2/videobuf2-dma-sg.c
index 6db60e9d5183..92072a08af25 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -309,8 +309,7 @@ static void *vb2_dma_sg_vaddr(void *buf_priv)
 		if (buf->db_attach)
 			buf->vaddr =3D dma_buf_vmap(buf->db_attach->dmabuf);
 		else
-			buf->vaddr =3D vm_map_ram(buf->pages,
-					buf->num_pages, -1, PAGE_KERNEL);
+			buf->vaddr =3D vm_map_ram(buf->pages, buf->num_pages, -1);
 	}
=20
 	/* add offset in case userptr is not page-aligned */
diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers=
/media/common/videobuf2/videobuf2-vmalloc.c
index 1a4f0ca87c7c..c66fda4a65e4 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -107,8 +107,7 @@ static void *vb2_vmalloc_get_userptr(struct device *d=
ev, unsigned long vaddr,
 		buf->vaddr =3D (__force void *)
 			ioremap(__pfn_to_phys(nums[0]), size + offset);
 	} else {
-		buf->vaddr =3D vm_map_ram(frame_vector_pages(vec), n_pages, -1,
-					PAGE_KERNEL);
+		buf->vaddr =3D vm_map_ram(frame_vector_pages(vec), n_pages, -1);
 	}
=20
 	if (!buf->vaddr)
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 5d2d81940679..7628816f2453 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -274,7 +274,7 @@ static int z_erofs_decompress_generic(struct z_erofs_=
decompress_req *rq,
=20
 	i =3D 0;
 	while (1) {
-		dst =3D vm_map_ram(rq->out, nrpages_out, -1, PAGE_KERNEL);
+		dst =3D vm_map_ram(rq->out, nrpages_out, -1);
=20
 		/* retry two more times (totally 3 times) */
 		if (dst || ++i >=3D 3)
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index f880141a2268..940af9da6db1 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -474,7 +474,7 @@ _xfs_buf_map_pages(
 		nofs_flag =3D memalloc_nofs_save();
 		do {
 			bp->b_addr =3D vm_map_ram(bp->b_pages, bp->b_page_count,
-						-1, PAGE_KERNEL);
+						-1);
 			if (bp->b_addr)
 				break;
 			vm_unmap_aliases();
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 15ffbd8e8e65..9273b1a91ca5 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -88,8 +88,7 @@ struct vmap_area {
  *	Highlevel APIs for driver use
  */
 extern void vm_unmap_ram(const void *mem, unsigned int count);
-extern void *vm_map_ram(struct page **pages, unsigned int count,
-				int node, pgprot_t prot);
+extern void *vm_map_ram(struct page **pages, unsigned int count, int nod=
e);
 extern void vm_unmap_aliases(void);
=20
 #ifdef CONFIG_MMU
diff --git a/mm/nommu.c b/mm/nommu.c
index 318df4e236c9..4f07b7ef0297 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -351,7 +351,7 @@ void vunmap(const void *addr)
 }
 EXPORT_SYMBOL(vunmap);
=20
-void *vm_map_ram(struct page **pages, unsigned int count, int node, pgpr=
ot_t prot)
+void *vm_map_ram(struct page **pages, unsigned int count, int node)
 {
 	BUG();
 	return NULL;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 258220b203f1..7356b3f07bd8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1834,7 +1834,7 @@ EXPORT_SYMBOL(vm_unmap_ram);
  *
  * Returns: a pointer to the address that has been mapped, or %NULL on f=
ailure
  */
-void *vm_map_ram(struct page **pages, unsigned int count, int node, pgpr=
ot_t prot)
+void *vm_map_ram(struct page **pages, unsigned int count, int node)
 {
 	unsigned long size =3D (unsigned long)count << PAGE_SHIFT;
 	unsigned long addr;
@@ -1858,7 +1858,7 @@ void *vm_map_ram(struct page **pages, unsigned int =
count, int node, pgprot_t pro
=20
 	kasan_unpoison_vmalloc(mem, size);
=20
-	if (map_kernel_range(addr, size, prot, pages) < 0) {
+	if (map_kernel_range(addr, size, PAGE_KERNEL, pages) < 0) {
 		vm_unmap_ram(mem, count);
 		return NULL;
 	}
--=20
2.25.1
