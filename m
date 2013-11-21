From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2] of: unflatten_and_copy: handle NULL initial_boot_params
Date: Thu, 21 Nov 2013 13:44:14 +0000
Message-ID: <1385041454-32385-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
List-Id: linux-arch.vger.kernel.org

Check whether initial_boot_params is NULL before dereferencing it in
unflatten_and_copy_device_tree() for the case where no device tree is
available but the arch can still boot to a minimal usable system without
it. In this case also log a warning for when the kernel log buffer is
obtainable.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
v2:
 * Log a warning for those who can obtain the kernel log buffer (Grant
   Likely).
---
 drivers/of/fdt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 2fa024b97c43..758b4f8b30b7 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -922,8 +922,16 @@ void __init unflatten_device_tree(void)
  */
 void __init unflatten_and_copy_device_tree(void)
 {
-	int size = __be32_to_cpu(initial_boot_params->totalsize);
-	void *dt = early_init_dt_alloc_memory_arch(size,
+	int size;
+	void *dt;
+
+	if (!initial_boot_params) {
+		pr_warn("No valid device tree found, continuing without\n");
+		return;
+	}
+
+	size = __be32_to_cpu(initial_boot_params->totalsize);
+	dt = early_init_dt_alloc_memory_arch(size,
 		__alignof__(struct boot_param_header));
 
 	if (dt) {
-- 
1.8.1.2
