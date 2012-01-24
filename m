From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 04/10] arch/hexagon/kernel/dma.c: make function static
Date: Tue, 24 Jan 2012 14:31:36 +0100
Message-ID: <8675ae$5bugro@wolverine02.qualcomm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This function is only used in the same file, and the other similar
functions in this file are also static.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
[rkuo@codeaurora.org: adjusted patch to apply to latest]
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/kernel/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 3730221..e8d52cc 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -53,7 +53,7 @@ static struct gen_pool *coherent_pool;
 
 /* Allocates from a pool of uncached memory that was reserved at boot time */
 
-void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
+static void *hexagon_dma_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t flag,
 				 struct dma_attrs *attrs)
 {
-- 
1.7.1


--

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
