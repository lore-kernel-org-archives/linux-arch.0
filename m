Return-Path: <SRS0=05z6=56=kvack.org=owner-linux-mm@kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/29] mm: pass addr as unsigned long to vb_free
Date: Tue, 14 Apr 2020 15:13:31 +0200
Message-ID: <20200414131348.444715-13-hch@lst.de>
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200414131331.52nv-OTQXP2XY8xgzzwF5xPczkc2WXIxP7bYhS_hFT4@z>

Ever use of addr in vb_free casts to unsigned long first, and the caller
has an unsigned long version of the address available anyway.  Just pass
that and avoid all the casts.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/vmalloc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9183fc0d365a..aada9e9144bd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1664,7 +1664,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp=
_mask)
 	return vaddr;
 }
=20
-static void vb_free(const void *addr, unsigned long size)
+static void vb_free(unsigned long addr, unsigned long size)
 {
 	unsigned long offset;
 	unsigned long vb_idx;
@@ -1674,24 +1674,22 @@ static void vb_free(const void *addr, unsigned lo=
ng size)
 	BUG_ON(offset_in_page(size));
 	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
=20
-	flush_cache_vunmap((unsigned long)addr, (unsigned long)addr + size);
+	flush_cache_vunmap(addr, addr + size);
=20
 	order =3D get_order(size);
=20
-	offset =3D (unsigned long)addr & (VMAP_BLOCK_SIZE - 1);
-	offset >>=3D PAGE_SHIFT;
+	offset =3D (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
=20
-	vb_idx =3D addr_to_vb_idx((unsigned long)addr);
+	vb_idx =3D addr_to_vb_idx(addr);
 	rcu_read_lock();
 	vb =3D radix_tree_lookup(&vmap_block_tree, vb_idx);
 	rcu_read_unlock();
 	BUG_ON(!vb);
=20
-	vunmap_page_range((unsigned long)addr, (unsigned long)addr + size);
+	vunmap_page_range(addr, addr + size);
=20
 	if (debug_pagealloc_enabled_static())
-		flush_tlb_kernel_range((unsigned long)addr,
-					(unsigned long)addr + size);
+		flush_tlb_kernel_range(addr, addr + size);
=20
 	spin_lock(&vb->lock);
=20
@@ -1791,7 +1789,7 @@ void vm_unmap_ram(const void *mem, unsigned int cou=
nt)
=20
 	if (likely(count <=3D VMAP_MAX_ALLOC)) {
 		debug_check_no_locks_freed(mem, size);
-		vb_free(mem, size);
+		vb_free(addr, size);
 		return;
 	}
=20
--=20
2.25.1
