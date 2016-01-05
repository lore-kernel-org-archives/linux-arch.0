From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v3 08/17] xen, mm: Set IORESOURCE_SYSTEM_RAM to System RAM
Date: Tue,  5 Jan 2016 11:54:32 -0700
Message-ID: <1452020081-26534-8-git-send-email-toshi.kani@hpe.com>
References: <1452020081-26534-1-git-send-email-toshi.kani@hpe.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1452020081-26534-1-git-send-email-toshi.kani@hpe.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, Toshi Kani <toshi.kani@hpe.com>
List-Id: linux-arch.vger.kernel.org

Set IORESOURCE_SYSTEM_RAM to 'flags' of struct resource entries
with "System RAM".

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: xen-devel@lists.xenproject.org
Acked-by: David Vrabel <david.vrabel@citrix.com> # xen
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
index a042a9d..0712585 100644
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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
