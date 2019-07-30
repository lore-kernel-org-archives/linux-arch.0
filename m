Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbfG3MQC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jul 2019 08:16:02 -0400
From: guoren@kernel.org
Subject: [PATCH 4/4] csky: Add dma_inv_range for DMA_FROM_DEVICE
Date: Tue, 30 Jul 2019 20:15:45 +0800
Message-ID: <1564488945-20149-4-git-send-email-guoren@kernel.org>
In-Reply-To: <1564488945-20149-1-git-send-email-guoren@kernel.org>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190730121545.GbWmEI8vIF76vuGHn4yELq2ymED8bq9Bb8YUtOTOFno@z>

From: Guo Ren <ren_guo@c-sky.com>

DMA_FROM_DEVICE only need to read dma data of memory into CPU cache,
so there is no need to clear cache before. Also clear + inv for
DMA_FROM_DEVICE won't cause problem, because the memory range for dma
won't be touched by software during dma working.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/cache.h |  1 +
 arch/csky/mm/cachev1.c        |  7 ++++++-
 arch/csky/mm/cachev2.c        | 11 ++++++++++-
 arch/csky/mm/dma-mapping.c    |  4 ++++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/cache.h b/arch/csky/include/asm/cache.h
index d683734..1d5fc2f 100644
--- a/arch/csky/include/asm/cache.h
+++ b/arch/csky/include/asm/cache.h
@@ -24,6 +24,7 @@ void cache_wbinv_range(unsigned long start, unsigned long end);
 void cache_wbinv_all(void);
 
 void dma_wbinv_range(unsigned long start, unsigned long end);
+void dma_inv_range(unsigned long start, unsigned long end);
 void dma_wb_range(unsigned long start, unsigned long end);
 
 #endif
diff --git a/arch/csky/mm/cachev1.c b/arch/csky/mm/cachev1.c
index b8a75cc..494ec91 100644
--- a/arch/csky/mm/cachev1.c
+++ b/arch/csky/mm/cachev1.c
@@ -120,7 +120,12 @@ void dma_wbinv_range(unsigned long start, unsigned long end)
 	cache_op_range(start, end, DATA_CACHE|CACHE_CLR|CACHE_INV, 1);
 }
 
+void dma_inv_range(unsigned long start, unsigned long end)
+{
+	cache_op_range(start, end, DATA_CACHE|CACHE_CLR|CACHE_INV, 1);
+}
+
 void dma_wb_range(unsigned long start, unsigned long end)
 {
-	cache_op_range(start, end, DATA_CACHE|CACHE_INV, 1);
+	cache_op_range(start, end, DATA_CACHE|CACHE_CLR|CACHE_INV, 1);
 }
diff --git a/arch/csky/mm/cachev2.c b/arch/csky/mm/cachev2.c
index baaf05d..b61be65 100644
--- a/arch/csky/mm/cachev2.c
+++ b/arch/csky/mm/cachev2.c
@@ -69,11 +69,20 @@ void dma_wbinv_range(unsigned long start, unsigned long end)
 	sync_is();
 }
 
+void dma_inv_range(unsigned long start, unsigned long end)
+{
+	unsigned long i = start & ~(L1_CACHE_BYTES - 1);
+
+	for (; i < end; i += L1_CACHE_BYTES)
+		asm volatile("dcache.iva %0\n"::"r"(i):"memory");
+	sync_is();
+}
+
 void dma_wb_range(unsigned long start, unsigned long end)
 {
 	unsigned long i = start & ~(L1_CACHE_BYTES - 1);
 
 	for (; i < end; i += L1_CACHE_BYTES)
-		asm volatile("dcache.civa %0\n"::"r"(i):"memory");
+		asm volatile("dcache.cva %0\n"::"r"(i):"memory");
 	sync_is();
 }
diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 3f1ff9d..d8f0f81 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -72,6 +72,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 		cache_op(paddr, size, dma_wb_range);
 		break;
 	case DMA_FROM_DEVICE:
+		cache_op(paddr, size, dma_inv_range);
+		break;
 	case DMA_BIDIRECTIONAL:
 		cache_op(paddr, size, dma_wbinv_range);
 		break;
@@ -88,6 +90,8 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		cache_op(paddr, size, dma_wb_range);
 		break;
 	case DMA_FROM_DEVICE:
+		cache_op(paddr, size, dma_inv_range);
+		break;
 	case DMA_BIDIRECTIONAL:
 		cache_op(paddr, size, dma_wbinv_range);
 		break;
-- 
2.7.4
