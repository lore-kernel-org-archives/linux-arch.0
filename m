From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 1/9] dt: Handle passed/built-in DT selection in early_init_dt_scan()
Date: Tue, 19 Nov 2013 12:12:26 +0100
Message-ID: <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
References: <5283A000.8090007@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5283A000.8090007-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Let early_init_dt_scan() fall-back to the built-in DT if no DT was passed,
or if it's invalid, so architectures don't have to duplicate this logic.

Suggested-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/of/fdt.c       |   24 +++++++++++++++++-------
 include/linux/of_fdt.h |    1 +
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 2fa024b97c43..a797cd43bc8b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -868,18 +868,28 @@ void * __init __weak early_init_dt_alloc_memory_arch(u64 size, u64 align)
 
 bool __init early_init_dt_scan(void *params)
 {
-	if (!params)
-		return false;
-
 	/* Setup flat device-tree pointer */
 	initial_boot_params = params;
 
-	/* check device tree validity */
-	if (be32_to_cpu(initial_boot_params->magic) != OF_DT_HEADER) {
-		initial_boot_params = NULL;
-		return false;
+	/* check passed device tree validity */
+	if (initial_boot_params &&
+	    be32_to_cpu(initial_boot_params->magic) == OF_DT_HEADER) {
+		pr_info("FDT at %p\n", initial_boot_params);
+		goto found;
+	}
+
+	/* check built-in device tree validity */
+	initial_boot_params = &__dtb_start;
+	if (__dtb_end != (void *)&__dtb_start &&
+	    be32_to_cpu(initial_boot_params->magic) == OF_DT_HEADER) {
+		pr_info("Compiled-in FDT at %p\n", initial_boot_params);
+		goto found;
 	}
 
+	initial_boot_params = NULL;
+	return false;
+
+found:
 	/* Retrieve various information from the /chosen node */
 	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
 
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index aabc49f3e403..6c4a60454854 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -59,6 +59,7 @@ struct boot_param_header {
 
 /* For kernels with a built-in device tree */
 extern struct boot_param_header __dtb_start;
+extern char __dtb_end[];
 
 #if defined(CONFIG_OF_FLATTREE)
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
