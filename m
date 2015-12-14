Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:53023 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932646AbbLNXid (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2015 18:38:33 -0500
Received: from g4t3428.houston.hp.com (g4t3428.houston.hp.com [15.201.208.56])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id E5BDF643E7
	for <linux-arch@vger.kernel.org>; Mon, 14 Dec 2015 23:38:05 +0000 (UTC)
From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 07/11] memory-hotplug: Set IORESOURCE_SYSTEM_RAM to System RAM
Date: Mon, 14 Dec 2015 16:37:22 -0700
Message-ID: <1450136246-17053-7-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Tang Chen <tangchen@cn.fujitsu.com>, Toshi Kani <toshi.kani@hpe.com>
Message-ID: <20151214233722.UaIABVpkNHLtJis74VmmVbYxqrw64wxkMXCrS4FZBTw@z>

Set IORESOURCE_SYSTEM_RAM to the flags of memory hotplug resource
ranges with "System RAM".

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
---
 mm/memory_hotplug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
