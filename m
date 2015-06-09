From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 1/8] ARC: perf: support RAW events
Date: Tue, 9 Jun 2015 17:49:25 +0530
Message-ID: <1433852372-29494-2-git-send-email-vgupta@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33606 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753921AbbFIMV6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:21:58 -0400
In-Reply-To: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

From: Alexey Brodkin <abrodkin@synopsys.com>

To run perf against raw event user may issue following command:
--->---
Initializing raw event: crun

 Performance counter stats for 'sleep 0':

            583202 r6372756e

       0.020000000 seconds time elapsed
--->---

"-e rXXX" is indication of raw event to count.
XXX is 64-bit ASCII value.
0x6372756e = crun (in ASCII)

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/perf_event.h |  3 +++
 arch/arc/kernel/perf_event.c      | 54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index 2b8880e953a2..ea43477f8a59 100644
--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -15,6 +15,9 @@
 /* real maximum varies per CPU, this is the maximum supported by the driver */
 #define ARC_PMU_MAX_HWEVENTS	64
 
+/* Max number of countable events that CPU may have */
+#define ARC_PERF_MAX_EVENTS	256
+
 #define ARC_REG_CC_BUILD	0xF6
 #define ARC_REG_CC_INDEX	0x240
 #define ARC_REG_CC_NAME0	0x241
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index eea8a7b42e87..400965973bb0 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -22,8 +22,10 @@ struct arc_pmu {
 	struct pmu	pmu;
 	int		counter_size;	/* in bits */
 	int		n_counters;
+	int		n_events;
 	unsigned long	used_mask[BITS_TO_LONGS(ARC_PMU_MAX_HWEVENTS)];
 	int		ev_hw_idx[PERF_COUNT_ARC_HW_MAX];
+	u64             raw_events[ARC_PERF_MAX_EVENTS];
 };
 
 struct arc_callchain_trace {
@@ -136,6 +138,44 @@ static int arc_pmu_cache_event(u64 config)
 	return ret;
 }
 
+/*
+ * Raw events are specified in hex value of ASCII chars:
+ *
+ * In PCT register CC_NAME{0,1} event name string[] is saved from LSB side:
+ * e.g. cycles corresponds to ARC "crun" and is saved as 0x6e757263
+ *							    n u r c
+ * However in perf cmdline they are specified in human order as r6372756e
+ *
+ * Thus event from cmdline requires an word swap
+ */
+static int arc_pmu_raw_event(u64 config)
+{
+	int i;
+	char name[sizeof(u64) + 1] = {0};
+	u64 swapped = __swab64(config);
+
+	/* Trim leading zeroes */
+	for (i = 0; i < sizeof(u64); i++)
+		if (!(swapped & 0xFF))
+			swapped = swapped >> 8;
+		else
+			break;
+
+	for (i = 0; i < arc_pmu->n_events; i++) {
+		if (swapped == arc_pmu->raw_events[i])
+			break;
+	}
+
+	if (i == arc_pmu->n_events)
+		return -ENOENT;
+
+	memcpy(name, &swapped, sizeof(u64));
+
+	pr_debug("Initializing raw event: %s\n", name);
+
+	return i;
+}
+
 /* initializes hw_perf_event structure if event is supported */
 static int arc_pmu_event_init(struct perf_event *event)
 {
@@ -159,6 +199,14 @@ static int arc_pmu_event_init(struct perf_event *event)
 			return ret;
 		hwc->config = arc_pmu->ev_hw_idx[ret];
 		return 0;
+
+	case PERF_TYPE_RAW:
+		ret = arc_pmu_raw_event(event->attr.config);
+		if (ret < 0)
+			return ret;
+		hwc->config |= ret;
+		return 0;
+
 	default:
 		return -ENOENT;
 	}
@@ -289,6 +337,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 
 	READ_BCR(ARC_REG_CC_BUILD, cc_bcr);
 	BUG_ON(!cc_bcr.v); /* Counters exist but No countable conditions ? */
+	BUG_ON(cc_bcr.c > ARC_PERF_MAX_EVENTS);
 
 	arc_pmu = devm_kzalloc(&pdev->dev, sizeof(struct arc_pmu), GFP_KERNEL);
 	if (!arc_pmu)
@@ -300,6 +349,8 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	pr_info("ARC perf\t: %d counters (%d bits), %d countable conditions\n",
 		arc_pmu->n_counters, arc_pmu->counter_size, cc_bcr.c);
 
+	arc_pmu->n_events = cc_bcr.c;
+
 	cc_name.str[8] = 0;
 	for (i = 0; i < PERF_COUNT_ARC_HW_MAX; i++)
 		arc_pmu->ev_hw_idx[i] = -1;
@@ -310,6 +361,9 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 		cc_name.indiv.word0 = read_aux_reg(ARC_REG_CC_NAME0);
 		cc_name.indiv.word1 = read_aux_reg(ARC_REG_CC_NAME1);
 
+		arc_pmu->raw_events[j] = ((u64)cc_name.indiv.word1 << 32) |
+						cc_name.indiv.word0;
+
 		/* See if it has been mapped to a perf event_id */
 		for (i = 0; i < ARRAY_SIZE(arc_pmu_ev_hw_map); i++) {
 			if (arc_pmu_ev_hw_map[i] &&
-- 
1.9.1
