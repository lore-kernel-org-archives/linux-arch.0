Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:56159 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab2DRAVP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Apr 2012 20:21:15 -0400
Message-ID: <8675ae$5bugro@wolverine02.qualcomm.com>
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Tue, 24 Jan 2012 14:31:36 +0100
Subject: [PATCH 04/10] arch/hexagon/kernel/dma.c: make function static
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20120124133136.eoahLcfj325NxQ-zLw8EbzbhXfH5vFtfEzftoUJGK-o@z>

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
