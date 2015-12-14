Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:53021 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932970AbbLNXiG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2015 18:38:06 -0500
Received: from g4t3427.houston.hp.com (g4t3427.houston.hp.com [15.201.208.55])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 295B5643E9
	for <linux-arch@vger.kernel.org>; Mon, 14 Dec 2015 23:38:01 +0000 (UTC)
From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 05/11] xen: Set IORESOURCE_SYSTEM_RAM to System RAM
Date: Mon, 14 Dec 2015 16:37:20 -0700
Message-ID: <1450136246-17053-5-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Toshi Kani <toshi.kani@hpe.com>
Message-ID: <20151214233720.V4q2xcHaJV7tbagD3rMxd2iCIy6runmujROeElQ6oCk@z>

Set IORESOURCE_SYSTEM_RAM to the flags of memory hotplug resource
ranges with "System RAM".

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
---
 drivers/xen/balloon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
