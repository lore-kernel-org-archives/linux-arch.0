From: Steve Capper <steve.capper@arm.com>
Subject: [PATCH 2/6] ARM: mm: Add support for flushing HugeTLB pages.
Date: Fri,  8 Feb 2013 15:01:19 +0000
Message-ID: <1360335683-7755-3-git-send-email-steve.capper@arm.com>
References: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44383 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759974Ab3BHPBx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2013 10:01:53 -0500
In-Reply-To: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: c.dall@virtualopensystems.com, akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

On ARM we use the __flush_dcache_page function to flush the dcache
of pages when needed; usually when the PG_dcache_clean bit is unset
and we are setting a PTE.

A HugeTLB page is represented as a compound page consisting of an
array of pages. Thus to flush the dcache of a HugeTLB page, one must
flush more than a single page.

This patch modifies __flush_dcache_page such that all constituent
pages of a HugeTLB page are flushed.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/mm/flush.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 1c8f7f5..7f32f96 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -17,6 +17,7 @@
 #include <asm/highmem.h>
 #include <asm/smp_plat.h>
 #include <asm/tlbflush.h>
+#include <linux/hugetlb.h>
=20
 #include "mm.h"
=20
@@ -168,17 +169,22 @@ void __flush_dcache_page(struct address_space *mappin=
g, struct page *page)
 =09 * coherent with the kernels mapping.
 =09 */
 =09if (!PageHighMem(page)) {
-=09=09__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
+=09=09size_t page_size =3D PAGE_SIZE << compound_order(page);
+=09=09__cpuc_flush_dcache_area(page_address(page), page_size);
 =09} else {
-=09=09void *addr =3D kmap_high_get(page);
-=09=09if (addr) {
-=09=09=09__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-=09=09=09kunmap_high(page);
-=09=09} else if (cache_is_vipt()) {
-=09=09=09/* unmapped pages might still be cached */
-=09=09=09addr =3D kmap_atomic(page);
-=09=09=09__cpuc_flush_dcache_area(addr, PAGE_SIZE);
-=09=09=09kunmap_atomic(addr);
+=09=09unsigned long i;
+=09=09for(i =3D 0; i < (1 << compound_order(page)); i++) {
+=09=09=09struct page *cpage =3D page + i;
+=09=09=09void *addr =3D kmap_high_get(cpage);
+=09=09=09if (addr) {
+=09=09=09=09__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+=09=09=09=09kunmap_high(cpage);
+=09=09=09} else if (cache_is_vipt()) {
+=09=09=09=09/* unmapped pages might still be cached */
+=09=09=09=09addr =3D kmap_atomic(cpage);
+=09=09=09=09__cpuc_flush_dcache_area(addr, PAGE_SIZE);
+=09=09=09=09kunmap_atomic(addr);
+=09=09=09}
 =09=09}
 =09}
=20
--=20
1.7.9.5
