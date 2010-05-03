Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:46125 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590Ab0ECPGK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2010 11:06:10 -0400
From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Date: Mon, 03 May 2010 11:05:18 -0400
Message-ID: <20100503150518.15039.3576.sendpatchset@localhost.localdomain>
In-Reply-To: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
References: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
Subject: [PATCH 3/7] numa-x86_64-use-generic-percpu-var-numa_node_id-implementation-fix1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Valdis.Kletnieks@vt.edu, Randy Dunlap <randy.dunlap@oracle.com>, Christoph Lameter <cl@linux-foundation.org>, eric.whitney@hp.com, Andrew Morton <akpm@linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <20100503150518.1yS3_MJ9Xv9J5W8NFLLYQg2vsRt_WE8GX_9fJkEJX9E@z>

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
