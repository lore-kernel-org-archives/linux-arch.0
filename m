From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] of/fdt: Allow memory node and root to have different size/address cells
Date: Thu, 1 Oct 2015 16:59:42 +0530
Message-ID: <1443698982-27227-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:39847 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbbJALaM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2015 07:30:12 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Currently memory node parsing uses root "#size-cells", "#address-cells"
This doesn't work correctly when memory address/size is different or
greater than root's.

e.g. ARC 32-bit systems implementing physical adressing extension and
say 4GB of memory. All peripherals mappings stay within the 4GB (so root
address/size cells remain 1 each), only the memory node address/size
cells needs to specify greater than 32-bits as below

	memory {
		device_type = "memory";
		reg = <0x0 0x80000000 0x1 0x00000000>;	/* 4 GB */
		#address-cells = <2>;
		#size-cells = <2>;
	};

This patch lets me boot a ARC system with PAE40 + 4GB of memory specified
as above and fails to boot otherwise as memory parsing doesn't populate
right base, size.

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 drivers/of/fdt.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 07496560e5b9..3af808f45965 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -888,8 +888,8 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 				     int depth, void *data)
 {
 	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	const __be32 *reg, *endp;
-	int l;
+	const __be32 *reg, *endp, *prop;
+	int l, dt_mem_addr_cells, dt_mem_size_cells;
 
 	/* We are scanning "memory" nodes only */
 	if (type == NULL) {
@@ -912,11 +912,22 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 
 	pr_debug("memory scan node %s, reg size %d,\n", uname, l);
 
-	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+
+	dt_mem_size_cells = dt_root_size_cells,;
+	prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
+	if (prop)
+		dt_mem_size_cells = be32_to_cpup(prop);
+
+	dt_mem_addr_cells = dt_root_addr_cells;
+	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
+	if (prop)
+		dt_mem_addr_cells = be32_to_cpup(prop);
+
+	while ((endp - reg) >= (dt_mem_addr_cells + dt_mem_size_cells)) {
 		u64 base, size;
 
-		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-		size = dt_mem_next_cell(dt_root_size_cells, &reg);
+		base = dt_mem_next_cell(dt_mem_addr_cells, &reg);
+		size = dt_mem_next_cell(dt_mem_size_cells, &reg);
 
 		if (size == 0)
 			continue;
-- 
1.9.1
