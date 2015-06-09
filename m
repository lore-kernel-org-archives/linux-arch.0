From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 4/8] ARCv2: perf: Support sampling events using overflow interrupts
Date: Tue, 9 Jun 2015 17:49:28 +0530
Message-ID: <1433852372-29494-5-git-send-email-vgupta@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:52277 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbbFIMUV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:20:21 -0400
In-Reply-To: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

From: Alexey Brodkin <abrodkin@synopsys.com>

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/perf_event.h |   8 ++-
 arch/arc/kernel/perf_event.c      | 123 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 124 insertions(+), 7 deletions(-)

diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index ca8c414738de..33a6eb2998ac 100644
--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -32,15 +32,19 @@
 #define ARC_REG_PCT_CONFIG	0x254
 #define ARC_REG_PCT_CONTROL	0x255
 #define ARC_REG_PCT_INDEX	0x256
+#define ARC_REG_PCT_INT_CNTL	0x25C
+#define ARC_REG_PCT_INT_CNTH	0x25D
+#define ARC_REG_PCT_INT_CTRL	0x25E
+#define ARC_REG_PCT_INT_ACT	0x25F
 
 #define ARC_REG_PCT_CONTROL_CC	(1 << 16)	/* clear counts */
 #define ARC_REG_PCT_CONTROL_SN	(1 << 17)	/* snapshot */
 
 struct arc_reg_pct_build {
 #ifdef CONFIG_CPU_BIG_ENDIAN
-	unsigned int m:8, c:8, r:6, s:2, v:8;
+	unsigned int m:8, c:8, r:5, i:1, s:2, v:8;
 #else
-	unsigned int v:8, s:2, r:6, c:8, m:8;
+	unsigned int v:8, s:2, i:1, r:5, c:8, m:8;
 #endif
 };
 
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 065daed8ad5f..4e3211948467 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -11,6 +11,7 @@
  *
  */
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/perf_event.h>
@@ -20,11 +21,13 @@
 
 struct arc_pmu {
 	struct pmu	pmu;
+	int		has_interrupts;
 	int		n_counters;
 	int		n_events;
 	unsigned long	used_mask[BITS_TO_LONGS(ARC_PERF_MAX_COUNTERS)];
 	u64		max_period;
 	int		ev_hw_idx[PERF_COUNT_ARC_HW_MAX];
+	struct perf_event *act_counter[ARC_PERF_MAX_COUNTERS];
 	u64             raw_events[ARC_PERF_MAX_EVENTS];
 };
 
@@ -186,7 +189,8 @@ static int arc_pmu_event_init(struct perf_event *event)
 		hwc->last_period = hwc->sample_period;
 		local64_set(&hwc->period_left, hwc->sample_period);
 	} else
-		return -ENOENT;
+		if (!arc_pmu->has_interrupts)
+			return -ENOENT;
 
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
@@ -307,6 +311,17 @@ static void arc_pmu_stop(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
+	/* Disable interrupt for this counter */
+	if (is_sampling_event(event)) {
+		/*
+		 * Reset interrupt flag by writing of 1. This is required
+		 * to make sure pending interrupt was not left.
+		 */
+		write_aux_reg(ARC_REG_PCT_INT_ACT, 1 << idx);
+		write_aux_reg(ARC_REG_PCT_INT_CTRL,
+			      read_aux_reg(ARC_REG_PCT_INT_CTRL) & ~(1 << idx));
+	}
+
 	if (!(event->hw.state & PERF_HES_STOPPED)) {
 		/* stop ARC pmu here */
 		write_aux_reg(ARC_REG_PCT_INDEX, idx);
@@ -329,6 +344,8 @@ static void arc_pmu_del(struct perf_event *event, int flags)
 	arc_pmu_stop(event, PERF_EF_UPDATE);
 	__clear_bit(event->hw.idx, arc_pmu->used_mask);
 
+	arc_pmu->act_counter[event->hw.idx] = 0;
+
 	perf_event_update_userpage(event);
 }
 
@@ -349,6 +366,21 @@ static int arc_pmu_add(struct perf_event *event, int flags)
 	}
 
 	write_aux_reg(ARC_REG_PCT_INDEX, idx);
+
+	arc_pmu->act_counter[idx] = event;
+
+	if (is_sampling_event(event)) {
+		/* Mimic full counter overflow as other arches do */
+		write_aux_reg(ARC_REG_PCT_INT_CNTL, arc_pmu->max_period &
+						    0xffffffff);
+		write_aux_reg(ARC_REG_PCT_INT_CNTH,
+			      (arc_pmu->max_period >> 32));
+
+		/* Enable interrupt for this counter */
+		write_aux_reg(ARC_REG_PCT_INT_CTRL,
+			      read_aux_reg(ARC_REG_PCT_INT_CTRL) | (1 << idx));
+	}
+
 	write_aux_reg(ARC_REG_PCT_CONFIG, 0);
 	write_aux_reg(ARC_REG_PCT_COUNTL, 0);
 	write_aux_reg(ARC_REG_PCT_COUNTH, 0);
@@ -363,6 +395,65 @@ static int arc_pmu_add(struct perf_event *event, int flags)
 	return 0;
 }
 
+#ifdef CONFIG_ISA_ARCV2
+static irqreturn_t arc_pmu_intr(int irq, void *dev)
+{
+	struct perf_sample_data data;
+	struct arc_pmu *arc_pmu = (struct arc_pmu *)dev;
+	struct pt_regs *regs;
+	int active_ints;
+	int idx;
+
+	arc_pmu_disable(&arc_pmu->pmu);
+
+	active_ints = read_aux_reg(ARC_REG_PCT_INT_ACT);
+
+	regs = get_irq_regs();
+
+	for (idx = 0; idx < arc_pmu->n_counters; idx++) {
+		struct perf_event *event = arc_pmu->act_counter[idx];
+		struct hw_perf_event *hwc;
+
+		if (!(active_ints & (1 << idx)))
+			continue;
+
+		/* Reset interrupt flag by writing of 1 */
+		write_aux_reg(ARC_REG_PCT_INT_ACT, 1 << idx);
+
+		/*
+		 * On reset of "interrupt active" bit corresponding
+		 * "interrupt enable" bit gets automatically reset as well.
+		 * Now we need to re-enable interrupt for the counter.
+		 */
+		write_aux_reg(ARC_REG_PCT_INT_CTRL,
+			read_aux_reg(ARC_REG_PCT_INT_CTRL) | (1 << idx));
+
+		hwc = &event->hw;
+
+		WARN_ON_ONCE(hwc->idx != idx);
+
+		arc_perf_event_update(event, &event->hw, event->hw.idx);
+		perf_sample_data_init(&data, 0, hwc->last_period);
+		if (!arc_pmu_event_set_period(event))
+			continue;
+
+		if (perf_event_overflow(event, &data, regs))
+			arc_pmu_stop(event, 0);
+	}
+
+	arc_pmu_enable(&arc_pmu->pmu);
+
+	return IRQ_HANDLED;
+}
+#else
+
+static irqreturn_t arc_pmu_intr(int irq, void *dev)
+{
+	return IRQ_NONE;
+}
+
+#endif /* CONFIG_ISA_ARCV2 */
+
 static int arc_pmu_device_probe(struct platform_device *pdev)
 {
 	struct arc_pmu *arc_pmu;
@@ -395,12 +486,16 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	if (!arc_pmu)
 		return -ENOMEM;
 
+	arc_pmu->has_interrupts = is_isa_arcv2() ? pct_bcr.i : 0;
+
 	arc_pmu->n_counters = pct_bcr.c;
 	counter_size = 32 + (pct_bcr.s << 4);
+
 	arc_pmu->max_period = (1ULL << counter_size) - 1ULL;
 
-	pr_info("ARC perf\t: %d counters (%d bits), %d countable conditions\n",
-		arc_pmu->n_counters, counter_size, cc_bcr.c);
+	pr_info("ARC perf\t: %d counters (%d bits), %d conditions%s\n",
+		arc_pmu->n_counters, counter_size, cc_bcr.c,
+		arc_pmu->has_interrupts ? ", [overflow IRQ support]":"");
 
 	arc_pmu->n_events = cc_bcr.c;
 
@@ -440,8 +535,26 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 		.read		= arc_pmu_read,
 	};
 
-	/* ARC 700 PMU does not support sampling events */
-	arc_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	if (arc_pmu->has_interrupts) {
+		int irq = platform_get_irq(pdev, 0);
+
+		if (irq < 0) {
+			pr_err("Cannot get IRQ number for the platform\n");
+			return -ENODEV;
+		}
+
+		ret = devm_request_irq(&pdev->dev, irq, arc_pmu_intr, 0,
+				       "arc-pmu", arc_pmu);
+		if (ret) {
+			pr_err("could not allocate PMU IRQ\n");
+			return ret;
+		}
+
+		/* Clean all pending interrupt flags */
+		write_aux_reg(ARC_REG_PCT_INT_ACT, 0xffffffff);
+	} else {
+		arc_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	}
 
 	return perf_pmu_register(&arc_pmu->pmu, pdev->name, PERF_TYPE_RAW);
 }
-- 
1.9.1
