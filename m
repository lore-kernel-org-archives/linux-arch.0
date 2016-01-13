From: Lada Trimasova <Lada.Trimasova@synopsys.com>
Subject: [PATCH] Fixing io-pgtable-arm build failure
Date: Wed, 13 Jan 2016 17:48:01 +0300
Message-ID: <1452696481-2030-1-git-send-email-ltrimas@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:33747 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbcAMOsS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2016 09:48:18 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Lada Trimasova <Lada.Trimasova@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>

Trying to build kernel for ARC with both options
CONFIG_COMPILE_TEST and CONFIG_IOMMU_IO_PGTABLE_LPAE enabled
(which happened really in "allyesconfig") I'm seeing this:
---------------->8----------------
$ make ARCH=3Darc
=2E..sic...
CC drivers/iommu/io-pgtable-arm.o
linux/drivers/iommu/io-pgtable-arm.c: In
function =E2=80=98__arm_lpae_alloc_pages=E2=80=99:
linux/drivers/iommu/io-pgtable-arm.c:221:3:
error: implicit declaration of function =E2=80=98dma_map_single=E2=80=99
[-Werror=3Dimplicit-function-declaration]
dma =3D dma_map_single(dev, pages, size, DMA_TO_DEVICE);
^
linux/drivers/iommu/io-pgtable-arm.c:221:42:
error: =E2=80=98DMA_TO_DEVICE=E2=80=99 undeclared (first use in this fu=
nction)
dma =3D dma_map_single(dev, pages, size, DMA_TO_DEVICE);
^
---------------->8----------------
and so on.

IOMMU_IO_PGTABLE_LPAE depends on DMA API.
So io-pgtable-arm.c should include linux/dma-mapping.h.

Signed-off-by: Lada Trimasova <ltrimas@synopsys.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/io-pgtable-arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
index 7df9777..0b1aca0 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/dma-mapping.h>
=20
 #include <asm/barrier.h>
=20
--=20
2.5.0
