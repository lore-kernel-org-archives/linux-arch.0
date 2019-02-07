From: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 6/7] powerpc/powernv: Add opal details to dump stack arch description
Date: Thu,  7 Feb 2019 23:46:34 +1100
Message-ID: <20190207124635.3885-6-mpe@ellerman.id.au>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
List-Id: linux-arch.vger.kernel.org

Once we have unflattened the device tree we can easily grab these opal
version details and add them to dump stack arch description, which is
printed in case of an oops.

eg: Hardware name: ... opal:v6.2

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/setup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 14befee4b3f1..1bfb422436fb 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -156,8 +156,33 @@ static void __init pnv_setup_arch(void)
 	/* XXX PMCS */
 }
 
+static void __init pnv_add_dump_stack_arch_desc(void)
+{
+	struct device_node *dn;
+	const char *version;
+
+	dn = of_find_node_by_path("/ibm,opal/firmware");
+	if (!dn)
+		return;
+
+	version = of_get_property(dn, "version", NULL);
+	if (!version)
+		version = of_get_property(dn, "git-id", NULL);
+
+	if (version)
+		dump_stack_add_arch_desc("opal:%s", version);
+
+	version = of_get_property(dn, "mi-version", NULL);
+	if (version)
+		dump_stack_add_arch_desc("mi:%s", version);
+
+	of_node_put(dn);
+}
+
 static void __init pnv_init(void)
 {
+	pnv_add_dump_stack_arch_desc();
+
 	/*
 	 * Initialize the LPC bus now so that legacy serial
 	 * ports can be found on it
-- 
2.20.1
