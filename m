From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 1/6] dma-mapping: fix dma_sync_single_range_*
Date: Tue, 27 Apr 2010 21:25:35 +0900
Message-ID: <1272371140-6085-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1272371140-6085-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:41136 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab0D0Maj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 Apr 2010 08:30:39 -0400
In-Reply-To: <1272371140-6085-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

dma_sync_single_range_for_cpu and dma_sync_single_range_for_device
use a wrong address with a partial synchronization.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: stable@kernel.org
---
 include/asm-generic/dma-mapping-common.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index e694263..6920695 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -131,7 +131,7 @@ static inline void dma_sync_single_range_for_cpu(struct device *dev,
 		debug_dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
 
 	} else
-		dma_sync_single_for_cpu(dev, addr, size, dir);
+		dma_sync_single_for_cpu(dev, addr + offset, size, dir);
 }
 
 static inline void dma_sync_single_range_for_device(struct device *dev,
@@ -148,7 +148,7 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 		debug_dma_sync_single_range_for_device(dev, addr, offset, size, dir);
 
 	} else
-		dma_sync_single_for_device(dev, addr, size, dir);
+		dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
 static inline void
-- 
1.6.5
