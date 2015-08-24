From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v3 6/6] ARCv2: perf: Finally introduce HS perf unit
Date: Mon, 24 Aug 2015 17:20:23 +0300
Message-ID: <1440426023-2792-7-git-send-email-abrodkin@synopsys.com>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:46208 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbbHXOU5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Aug 2015 10:20:57 -0400
In-Reply-To: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, peterz@infradead.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

From: Vineet Gupta <vgupta@synopsys.com>

With all features in place, the ARC HS pct block can now be effectively
allowed to be probed/used

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---

No changes since v2.

Compared to v1:
 [1] MAINTAINERS file updated to cover new file.

 Documentation/devicetree/bindings/arc/archs-pct.txt | 17 +++++++++++++++++
 MAINTAINERS                                         |  2 +-
 arch/arc/include/asm/perf_event.h                   |  5 ++++-
 arch/arc/kernel/perf_event.c                        |  3 ++-
 4 files changed, 24 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arc/archs-pct.txt

diff --git a/Documentation/devicetree/bindings/arc/archs-pct.txt b/Documentation/devicetree/bindings/arc/archs-pct.txt
new file mode 100644
index 0000000..1ae98b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arc/archs-pct.txt
@@ -0,0 +1,17 @@
+* ARC HS Performance Counters
+
+The ARC HS can be configured with a pipeline performance monitor for counting
+CPU and cache events like cache misses and hits. Like conventional PCT there
+are 100+ hardware conditions dynamically mapped to upto 32 counters.
+It also supports overflow interrupts.
+
+Required properties:
+
+- compatible : should contain
+	"snps,archs-pct"
+
+Example:
+
+pmu {
+        compatible = "snps,archs-pct";
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 569568f..3ab63b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9883,7 +9883,7 @@ SYNOPSYS ARC ARCHITECTURE
 M:	Vineet Gupta <vgupta@synopsys.com>
 S:	Supported
 F:	arch/arc/
-F:	Documentation/devicetree/bindings/arc/
+F:	Documentation/devicetree/bindings/arc/*
 F:	drivers/tty/serial/arc_uart.c
 
 SYNOPSYS ARC SDP platform support
diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index 876e216..848de94 100644
--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -105,8 +105,11 @@ static const char * const arc_pmu_ev_hw_map[] = {
 	[PERF_COUNT_HW_INSTRUCTIONS] = "iall",
 	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = "ijmp",
 	[PERF_COUNT_ARC_BPOK]         = "bpok",	  /* NP-NT, PT-T, PNT-NT */
+#ifdef CONFIG_ISA_ARCV2
+	[PERF_COUNT_HW_BRANCH_MISSES] = "bpmp",
+#else
 	[PERF_COUNT_HW_BRANCH_MISSES] = "bpfail", /* NP-T, PT-NT, PNT-T */
-
+#endif
 	[PERF_COUNT_ARC_LDC] = "imemrdc",	/* Instr: mem read cached */
 	[PERF_COUNT_ARC_STC] = "imemwrc",	/* Instr: mem write cached */
 
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 80f5a85..19d6115 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -551,6 +551,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id arc_pmu_match[] = {
 	{ .compatible = "snps,arc700-pct" },
+	{ .compatible = "snps,archs-pct" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, arc_pmu_match);
@@ -558,7 +559,7 @@ MODULE_DEVICE_TABLE(of, arc_pmu_match);
 
 static struct platform_driver arc_pmu_driver = {
 	.driver	= {
-		.name		= "arc700-pct",
+		.name		= "arc-pct",
 		.of_match_table = of_match_ptr(arc_pmu_match),
 	},
 	.probe		= arc_pmu_device_probe,
-- 
2.4.3
