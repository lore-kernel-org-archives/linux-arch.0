Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:46858 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbeBFKPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Feb 2018 05:15:03 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC 1/6] dma-mapping: Convert NO_DMA get_dma_ops() into a real dummy
Date: Tue,  6 Feb 2018 11:14:47 +0100
Message-ID: <1517912092-15470-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>
Cc: Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20180206101447.ZlYu51337x_7Kl0uvgUf1ZWNNZjmSaJB4ZS2H9_MGSE@z>

If NO_DMA=y, get_dma_ops() returns a reference to the
non-existing symbol bad_dma_ops, thus causing a link failure if it is
ever used.

Make get_dma_ops() return NULL instead, to avoid the link failure.
This allows to improve compile-testing, and limits the need to keep on
sprinkling dependencies on HAS_DMA all over the place.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/dma-mapping.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 34fe8463d10ea3be..d78d7541f784875b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -212,14 +212,14 @@ static inline void set_dma_ops(struct device *dev,
 }
 #else
 /*
- * Define the dma api to allow compilation but not linking of
- * dma dependent code.  Code that depends on the dma-mapping
- * API needs to set 'depends on HAS_DMA' in its Kconfig
+ * Define the dma api to allow compilation of dma dependent code.
+ * Code that depends on the dma-mapping API needs to set 'depends on HAS_DMA'
+ * in its Kconfig, unless it already depends on <something> || COMPILE_TEST,
+ * where <something> guarantuees the availability of the dma-mapping API.
  */
-extern const struct dma_map_ops bad_dma_ops;
 static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-	return &bad_dma_ops;
+	return NULL;
 }
 #endif
 
-- 
2.7.4
