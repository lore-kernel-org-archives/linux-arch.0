Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:60125 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbbLYWKU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Dec 2015 17:10:20 -0500
From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v2 08/16] xen, mm: Set IORESOURCE_SYSTEM_RAM to System RAM
Date: Fri, 25 Dec 2015 15:09:17 -0700
Message-ID: <1451081365-15190-8-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Toshi Kani <toshi.kani@hpe.com>
Message-ID: <20151225220917.QDCatSSJp2d9eQwJPsVHbgeFVQRojnrbsIgTKaLhLHY@z>

Set IORESOURCE_SYSTEM_RAM to 'flags' of struct resource entries
with "System RAM".

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
---
 drivers/xen/balloon.c |    2 +-
 mm/memory_hotplug.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 12eab50..dc4305b 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -257,7 +257,7 @@ static struct resource *additional_memory_resource(phys_addr_t size)
 		return NULL;
 
 	res->name = "System RAM";
-	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
 	ret = allocate_resource(&iomem_resource, res,
 				size, 0, -1,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 67d488a..9458423 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -136,7 +136,7 @@ static struct resource *register_memory_resource(u64 start, u64 size)
 	res->name = "System RAM";
 	res->start = start;
 	res->end = start + size - 1;
-	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 	if (request_resource(&iomem_resource, res) < 0) {
 		pr_debug("System RAM resource %pR cannot be added\n", res);
 		kfree(res);
