From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2] of/fdt: Allow memory node and root to have different size/address cells
Date: Thu, 1 Oct 2015 17:48:21 +0530
Message-ID: <1443701901-362-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kbuild-all-JC7UmRfGjtg@public.gmane.org" <kbuild-all-JC7UmRfGjtg@public.gmane.org>, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

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

---
Changes since v2:
   silly typo creeped in due to last minute change to use root props
---
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
 drivers/of/fdt.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 07496560e5b9..48618bb2674a 100644
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
+	dt_mem_size_cells = dt_root_size_cells;
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
