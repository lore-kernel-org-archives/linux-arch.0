From: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 7/7] powerpc/pseries: Add firmware details to dump stack arch description
Date: Thu,  7 Feb 2019 23:46:35 +1100
Message-ID: <20190207124635.3885-7-mpe@ellerman.id.au>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
List-Id: linux-arch.vger.kernel.org

Once we have unflattened the device tree we can easily grab these
firmware version details and add them to dump stack arch description,
which is printed in case of an oops.

Currently /hypervisor only exists on KVM, so if we don't find that look
for something that suggests we're on phyp and if so that's probably a
good guess. The actual content of the ibm,fw-net-version seems to be
a full path so is too long to add to the description.

Hardware name: ... of:'IBM,FW860.42 (SV860_138)' hv:phyp

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 41f62ca27c63..dfb084f5a573 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -923,6 +923,39 @@ static void pSeries_cmo_feature_init(void)
 	pr_debug(" <- fw_cmo_feature_init()\n");
 }
 
+static void __init pseries_add_dump_stack_arch_desc(void)
+{
+	struct device_node *dn;
+	const char *prop;
+
+	dn = of_find_node_by_path("/openprom");
+	if (dn) {
+		prop = of_get_property(dn, "model", NULL);
+		if (prop)
+			dump_stack_add_arch_desc("of:'%s'", prop);
+
+		of_node_put(dn);
+	}
+
+	dn = of_find_node_by_path("/hypervisor");
+	if (dn) {
+		prop = of_get_property(dn, "compatible", NULL);
+		if (prop)
+			dump_stack_add_arch_desc("hv:%s", prop);
+
+		of_node_put(dn);
+	} else {
+		dn = of_find_node_by_path("/");
+		if (dn) {
+			prop = of_get_property(dn, "ibm,fw-net-version", NULL);
+			if (prop)
+				dump_stack_add_arch_desc("hv:phyp");
+
+			of_node_put(dn);
+		}
+	}
+}
+
 /*
  * Early initialization.  Relocation is on but do not reference unbolted pages
  */
@@ -930,6 +963,8 @@ static void __init pseries_init(void)
 {
 	pr_debug(" -> pseries_init()\n");
 
+	pseries_add_dump_stack_arch_desc();
+
 #ifdef CONFIG_HVC_CONSOLE
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hvc_vio_init_early();
-- 
2.20.1
