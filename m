From: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 4/7] powerpc: Add device-tree model to dump stack arch description
Date: Thu,  7 Feb 2019 23:46:32 +1100
Message-ID: <20190207124635.3885-4-mpe@ellerman.id.au>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
List-Id: linux-arch.vger.kernel.org

As soon as we know the model of the machine we're on, add it to the
dump stack arch description, which is printed in case of an oops.

eg: Hardware name: model:'IBM,8247-22L'

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 38a90097469a..70af26a1eedd 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -34,6 +34,7 @@
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <linux/cpu.h>
+#include <linux/printk.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -687,6 +688,23 @@ static void __init tm_init(void)
 static void tm_init(void) { }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
+static int __init
+early_init_dt_scan_model(unsigned long node, const char *uname,
+			 int depth, void *data)
+{
+	const char *prop;
+
+	if (depth != 0)
+		return 0;
+
+	prop = of_get_flat_dt_prop(node, "model", NULL);
+	if (prop)
+		dump_stack_add_arch_desc("model:'%s'", prop);
+
+	/* break now */
+	return 1;
+}
+
 void __init early_init_devtree(void *params)
 {
 	phys_addr_t limit;
@@ -697,6 +715,8 @@ void __init early_init_devtree(void *params)
 	if (!early_init_dt_verify(params))
 		panic("BUG: Failed verifying flat device tree, bad version?");
 
+	of_scan_flat_dt(early_init_dt_scan_model, NULL);
+
 #ifdef CONFIG_PPC_RTAS
 	/* Some machines might need RTAS info for debugging, grab it now. */
 	of_scan_flat_dt(early_init_dt_scan_rtas, NULL);
-- 
2.20.1
