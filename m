Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57398 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfDASnc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Apr 2019 14:43:32 -0400
From: Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH] ARC: fix memory nodes topology in case of highmem enabled
Date: Mon,  1 Apr 2019 21:42:42 +0300
Message-ID: <20190401184242.7636-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-snps-arc@lists.infradead.org, Vineet Gupta <vineet.gupta1@synopsys.com>
Cc: linux-kernel@vger.kernel.org, Alexey Brodkin <alexey.brodkin@synopsys.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Message-ID: <20190401184242.27ys9u7samFwCjlYrrWpUou8zbcOJN6OXjhTga2a6xA@z>

Tweak generic node topology in case of CONFIG_HIGHMEM enabled to
prioritize allocations from ZONE_HIGHMEM to avoid ZONE_NORMAL
pressure.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Tested on both NSIM and HSDK (require memory apertures remmaping and
device tree patching)

 arch/arc/include/asm/Kbuild     |  1 -
 arch/arc/include/asm/topology.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 arch/arc/include/asm/topology.h

diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index caa270261521..e64e0439baff 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -18,7 +18,6 @@ generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
-generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += user.h
 generic-y += vga.h
diff --git a/arch/arc/include/asm/topology.h b/arch/arc/include/asm/topology.h
new file mode 100644
index 000000000000..c273506931c9
--- /dev/null
+++ b/arch/arc/include/asm/topology.h
@@ -0,0 +1,30 @@
+#ifndef _ASM_ARC_TOPOLOGY_H
+#define _ASM_ARC_TOPOLOGY_H
+
+/*
+ * On ARC (w/o PAE) HIGHMEM addresses are smaller (0x0 based) than addresses in
+ * NORMAL aka low memory (0x8000_0000 based).
+ * Thus HIGHMEM on ARC is imlemented with DISCONTIGMEM which requires multiple
+ * nodes. So here is memory node map depending on the CONFIG_HIGHMEM
+ * enabled/disabled:
+ *
+ * CONFIG_HIGHMEM disabled:
+ *  - node 0: ZONE_NORMAL memory only.
+ *
+ * CONFIG_HIGHMEM enabled:
+ *  - node 0: ZONE_NORMAL memory only.
+ *  - node 1: ZONE_HIGHMEM memory only.
+ *
+ * In case of CONFIG_HIGHMEM enabled we tweak generic node topology and mark
+ * node 1 as the closest to all CPUs to prioritize allocations from ZONE_HIGHMEM
+ * where it is possible to avoid ZONE_NORMAL pressure.
+ */
+#ifdef CONFIG_HIGHMEM
+#define cpu_to_node(cpu)	((void)(cpu), 1)
+#define cpu_to_mem(cpu)		((void)(cpu), 1)
+#define cpumask_of_node(node)	((node) == 1 ? cpu_online_mask : cpu_none_mask)
+#endif /* CONFIG_HIGHMEM */
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_ARC_TOPOLOGY_H */
-- 
2.14.5
