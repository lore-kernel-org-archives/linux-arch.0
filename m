From: Cho KyongHo <pullip.cho@samsung.com>
Subject: arm: mm: fix faulty calculation of area to perform cache operation
Date: Thu, 29 Mar 2012 18:55:32 +0900
Message-ID: <002c01cd0d92$14acd5f0$3e0681d0$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:30936 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758860Ab2C2Jze (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2012 05:55:34 -0400
Content-language: ko
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, kgene.kim@samsung.com, 'Younglak Kim' <younglak1004.kim@samsung.com>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, wooki.min@samsung.com

In dma_cache_maint_page(), if offset is larger than PAGE_SIZE,
len becomes PAGE_SIZE - offset. If size is smaller than
PAGE_SIZE - offset, next calcuation of left cause overflow.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1aa664a..14f53b6 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -517,7 +517,7 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 					page += offset / PAGE_SIZE;
 					offset %= PAGE_SIZE;
 				}
-				len = PAGE_SIZE - offset;
+				len = min_t(size_t, PAGE_SIZE - offset, len);
 			}
 			vaddr = kmap_high_get(page);
 			if (vaddr) {
-- 
1.7.1
