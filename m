From: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 2/7] powerpc: Add PVR & CPU name to dump stack arch description
Date: Thu,  7 Feb 2019 23:46:30 +1100
Message-ID: <20190207124635.3885-2-mpe@ellerman.id.au>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
List-Id: linux-arch.vger.kernel.org

As soon as we've done some basic setup, add the PVR and CPU name to
the dump stack arch description, which is printed in case of an oops.

eg: Hardware name: ... POWER8E (raw) pvr:0x4b0201

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/cputable.c | 1 +
 arch/powerpc/kernel/prom.c     | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 1eab54bc6ee9..8b4520a84612 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/jump_label.h>
+#include <linux/printk.h>
 
 #include <asm/oprofile_impl.h>
 #include <asm/cputable.h>
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4181ec715f88..ea2c3498067d 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -761,6 +761,10 @@ void __init early_init_devtree(void *params)
 
 	dt_cpu_ftrs_scan();
 
+	/* We can now set the CPU name & PVR for the oops output */
+	dump_stack_add_arch_desc("%s pvr:0x%04lx", cur_cpu_spec->cpu_name,
+				 mfspr(SPRN_PVR));
+
 	/* Retrieve CPU related informations from the flat tree
 	 * (altivec support, boot CPU ID, ...)
 	 */
-- 
2.20.1
