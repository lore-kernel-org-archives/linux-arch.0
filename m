Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41584 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835AbcAZU5l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Jan 2016 15:57:41 -0500
From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 08/17] xen, mm: Set IORESOURCE_SYSTEM_RAM to System RAM
Date: Tue, 26 Jan 2016 21:57:24 +0100
Message-ID: <1453841853-11383-9-git-send-email-bp@alien8.de>
In-Reply-To: <1453841853-11383-1-git-send-email-bp@alien8.de>
References: <1453841853-11383-1-git-send-email-bp@alien8.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Banman <abanman@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dan Williams <dan.j.williams@intel.com>, David Rientjes <rientjes@google.com>, David Vrabel <david.vrabel@citrix.com>, Gu Zheng <guz.fnst@cn.fujitsu.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arch@vger.kernel.org, linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@techsingularity.net>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Tang Chen <tangchen@cn.fujitsu.com>, xen-devel@lists.xenproject.org
Message-ID: <20160126205724.PagTmjDe2IxLFAdQHEZDNHcX3Tpu26oJNnAWzGtInog@z>

From: Toshi Kani <toshi.kani@hpe.com>

Set IORESOURCE_SYSTEM_RAM in struct resource.flags of "System RAM"
entries.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Acked-by: David Vrabel <david.vrabel@citrix.com> # xen
Cc: Andrew Banman <abanman@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm <linux-mm@kvack.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Cc: xen-devel@lists.xenproject.org
Link: http://lkml.kernel.org/r/1452020081-26534-8-git-send-email-toshi.kani@hpe.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/xen/balloon.c | 2 +-
 mm/memory_hotplug.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 12eab503efd1..dc4305b407bf 100644
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
index 4af58a3a8ffa..979b18cbd343 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -138,7 +138,7 @@ static struct resource *register_memory_resource(u64 start, u64 size)
 	res->name = "System RAM";
 	res->start = start;
 	res->end = start + size - 1;
-	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 	if (request_resource(&iomem_resource, res) < 0) {
 		pr_debug("System RAM resource %pR cannot be added\n", res);
 		kfree(res);
-- 
2.3.5

