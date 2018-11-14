Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbeKNSZ5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2018 13:25:57 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/34] powerpc/dma: remove the unused ISA_DMA_THRESHOLD export
Date: Wed, 14 Nov 2018 09:22:44 +0100
Message-ID: <20181114082314.8965-5-hch@lst.de>
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181114082244.a33YjYVAuxmMdnB8-WXWM4HV9tvNRfiU-XMCZR0sjjk@z>

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 81909600013a..07f7e6aaf104 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -59,7 +59,6 @@ unsigned long ISA_DMA_THRESHOLD;
 unsigned int DMA_MODE_READ;
 unsigned int DMA_MODE_WRITE;
 
-EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
 
-- 
2.19.1
