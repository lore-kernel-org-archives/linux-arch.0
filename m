Return-Path: <SRS0=05z6=56=kvack.org=owner-linux-mm@kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/29] mm: rename vmap_page_range to map_kernel_range
Date: Tue, 14 Apr 2020 15:13:33 +0200
Message-ID: <20200414131348.444715-15-hch@lst.de>
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200414131333.DLMk3glCEeuu_f5-gr931suXqqwIG8hdWH3Z_HGP32U@z>

This matches the map_kernel_range_noflush API.  Also change to pass
a size instead of the end, similar to the noflush version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/vmalloc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 55df5dc6a9fc..a3d810def567 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -272,13 +272,13 @@ int map_kernel_range_noflush(unsigned long addr, un=
signed long size,
 	return nr;
 }
=20
-static int vmap_page_range(unsigned long start, unsigned long end,
+static int map_kernel_range(unsigned long start, unsigned long size,
 			   pgprot_t prot, struct page **pages)
 {
 	int ret;
=20
-	ret =3D map_kernel_range_noflush(start, end - start, prot, pages);
-	flush_cache_vmap(start, end);
+	ret =3D map_kernel_range_noflush(start, size, prot, pages);
+	flush_cache_vmap(start, start + size);
 	return ret;
 }
=20
@@ -1866,7 +1866,7 @@ void *vm_map_ram(struct page **pages, unsigned int =
count, int node, pgprot_t pro
=20
 	kasan_unpoison_vmalloc(mem, size);
=20
-	if (vmap_page_range(addr, addr + size, prot, pages) < 0) {
+	if (map_kernel_range(addr, size, prot, pages) < 0) {
 		vm_unmap_ram(mem, count);
 		return NULL;
 	}
@@ -2030,10 +2030,9 @@ void unmap_kernel_range(unsigned long addr, unsign=
ed long size)
 int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pag=
es)
 {
 	unsigned long addr =3D (unsigned long)area->addr;
-	unsigned long end =3D addr + get_vm_area_size(area);
 	int err;
=20
-	err =3D vmap_page_range(addr, end, prot, pages);
+	err =3D map_kernel_range(addr, get_vm_area_size(area), prot, pages);
=20
 	return err > 0 ? 0 : err;
 }
--=20
2.25.1
