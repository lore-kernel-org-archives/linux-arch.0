Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31171 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932961AbbJIWWe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Oct 2015 18:22:34 -0400
Subject: [PATCH 14/20] pxa2xx-flash: switch from ioremap_cache to memremap
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 09 Oct 2015 18:16:51 -0400
Message-ID: <20151009221651.32203.63446.stgit@dwillia2-desk3.jf.intel.com>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Message-ID: <20151009221651.1AIxiOxjE0uJJI-aab6KhmhOpICiU6SNear5vHoBp58@z>

In preparation for deprecating ioremap_cache() convert its usage in
pxa2xx-flash to memremap.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
[brian: also convert iounmap to memunmap]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/mtd/maps/pxa2xx-flash.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index 12fa75df5008..5ff6cc5b4844 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -71,8 +71,8 @@ static int pxa2xx_flash_probe(struct platform_device *pdev)
 		       info->map.name);
 		return -ENOMEM;
 	}
-	info->map.cached =
-		ioremap_cache(info->map.phys, info->map.size);
+	info->map.cached = memremap(info->map.phys, info->map.size,
+			MEMREMAP_WB);
 	if (!info->map.cached)
 		printk(KERN_WARNING "Failed to ioremap cached %s\n",
 		       info->map.name);
@@ -111,7 +111,7 @@ static int pxa2xx_flash_remove(struct platform_device *dev)
 	map_destroy(info->mtd);
 	iounmap(info->map.virt);
 	if (info->map.cached)
-		iounmap(info->map.cached);
+		memunmap(info->map.cached);
 	kfree(info);
 	return 0;
 }

