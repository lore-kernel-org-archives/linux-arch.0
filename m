From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Subject: [PATCH 3/7] numa-x86_64-use-generic-percpu-var-numa_node_id-implementation-fix1
Date: Mon, 03 May 2010 11:05:18 -0400
Message-ID: <20100503150518.15039.3576.sendpatchset@localhost.localdomain>
References: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
Return-path: <linux-numa-owner@vger.kernel.org>
In-Reply-To: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
Sender: linux-numa-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Valdis.Kletnieks@vt.edu, Randy Dunlap <randy.dunlap@oracle.com>, Christoph Lameter <cl@linux-foundation.org>, eric.whitney@hp.com, Andrew Morton <akpm@linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-arch.vger.kernel.org

Incremental patch 1 to
numa-x86_64-use-generic-percpu-var-numa_node_id-implementation.patch
in 28apr10 mmotm.

Use generic percpu numa_node variable only for x86_64.

x86_32 will require separate support.  Not sure it's worth it.

Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>

 arch/x86/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.34-rc5-mmotm-100428-1653/arch/x86/Kconfig
===================================================================
--- linux-2.6.34-rc5-mmotm-100428-1653.orig/arch/x86/Kconfig
+++ linux-2.6.34-rc5-mmotm-100428-1653/arch/x86/Kconfig
@@ -1720,7 +1720,7 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
 	depends on NUMA
 
 config USE_PERCPU_NUMA_NODE_ID
-	def_bool y
+	def_bool X86_64
 	depends on NUMA
 
 menu "Power management and ACPI options"
