From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 8/8] ARCv2: perf: Finally introduce HS perf unit
Date: Tue, 9 Jun 2015 17:49:32 +0530
Message-ID: <1433852372-29494-9-git-send-email-vgupta@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:52312 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbFIMVf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:21:35 -0400
In-Reply-To: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>

With all features in place, the ARC HS pct block can now be effectively
allowed to be probed/used

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 Documentation/devicetree/bindings/arc/archs-pct.txt | 17 +++++++++++++++++
 arch/arc/include/asm/perf_event.h                   |  5 ++++-
 arch/arc/kernel/perf_event.c                        |  3 ++-
 3 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arc/archs-pct.txt

diff --git a/Documentation/devicetree/bindings/arc/archs-pct.txt b/Documentation/devicetree/bindings/arc/archs-pct.txt
new file mode 100644
index 000000000000..1ae98b87c640
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
diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index e915c0d4b630..e4d758718bb5 100644
--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -108,8 +108,11 @@ static const char * const arc_pmu_ev_hw_map[] = {
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
index a40772b37b77..e2ce9e03ea3d 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -611,6 +611,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id arc_pmu_match[] = {
 	{ .compatible = "snps,arc700-pct" },
+	{ .compatible = "snps,archs-pct" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, arc_pmu_match);
@@ -618,7 +619,7 @@ MODULE_DEVICE_TABLE(of, arc_pmu_match);
 
 static struct platform_driver arc_pmu_driver = {
 	.driver	= {
-		.name		= "arc700-pct",
+		.name		= "arc-pct",
 		.of_match_table = of_match_ptr(arc_pmu_match),
 	},
 	.probe		= arc_pmu_device_probe,
-- 
1.9.1
