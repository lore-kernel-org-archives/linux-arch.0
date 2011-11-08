From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH 01/10] Hexagon: Use resource_size function
Date: Tue, 8 Nov 2011 19:49:30 +0100
Message-ID: <6e201a$5e4isk@wolverine01.qualcomm.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

 Use resource_size function on resource object
 instead of explicit computation.

 The semantic patch that makes this change is available
 in scripts/coccinelle/api/resource_size.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/kernel/time.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index 6bee15c..ea9e34f 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -200,12 +200,10 @@ void __init time_init_deferred(void)
 		resource = rtos_timer_device.resource;
 
 	/*  ioremap here means this has to run later, after paging init  */
-	rtos_timer = ioremap(resource->start, resource->end
-		- resource->start + 1);
+	rtos_timer = ioremap(resource->start, resource_size(resource));
 
 	if (!rtos_timer) {
-		release_mem_region(resource->start, resource->end
-			- resource->start + 1);
+		release_mem_region(resource->start, resource_size(resource));
 	}
 	clocksource_register_khz(&hexagon_clocksource, pcycle_freq_mhz * 1000);
 
-- 
1.7.1


--

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
