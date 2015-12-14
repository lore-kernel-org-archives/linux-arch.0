From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 05/11] xen: Set IORESOURCE_SYSTEM_RAM to System RAM
Date: Mon, 14 Dec 2015 16:37:20 -0700
Message-ID: <1450136246-17053-5-git-send-email-toshi.kani@hpe.com>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Toshi Kani <toshi.kani@hpe.com>
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
