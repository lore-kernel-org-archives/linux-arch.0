From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 3/8] ARCv2: perf: implement "event_set_period" for future use with interrupts
Date: Tue, 9 Jun 2015 17:49:27 +0530
Message-ID: <1433852372-29494-4-git-send-email-vgupta@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

From: Alexey Brodkin <abrodkin@synopsys.com>

This generalization prepares for support of overflow interrupts.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
[vgupta: Fixed up so @counter need not be in struct arc_pmu

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/perf_event.c | 67 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 18b074f63cb6..065daed8ad5f 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -20,10 +20,10 @@
 
 struct arc_pmu {
 	struct pmu	pmu;
-	int		counter_size;	/* in bits */
 	int		n_counters;
 	int		n_events;
 	unsigned long	used_mask[BITS_TO_LONGS(ARC_PERF_MAX_COUNTERS)];
+	u64		max_period;
 	int		ev_hw_idx[PERF_COUNT_ARC_HW_MAX];
 	u64             raw_events[ARC_PERF_MAX_EVENTS];
 };
@@ -99,8 +99,7 @@ static void arc_perf_event_update(struct perf_event *event,
 	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
 				 new_raw_count) != prev_raw_count);
 
-	delta = (new_raw_count - prev_raw_count) &
-		((1ULL << arc_pmu->counter_size) - 1ULL);
+	delta = (new_raw_count - prev_raw_count) & arc_pmu->max_period;
 
 	local64_add(delta, &event->count);
 	local64_sub(delta, &hwc->period_left);
@@ -182,6 +181,13 @@ static int arc_pmu_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int ret;
 
+	if (!is_sampling_event(event)) {
+		hwc->sample_period  = arc_pmu->max_period;
+		hwc->last_period = hwc->sample_period;
+		local64_set(&hwc->period_left, hwc->sample_period);
+	} else
+		return -ENOENT;
+
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
 		if (event->attr.config >= PERF_COUNT_HW_MAX)
@@ -228,6 +234,49 @@ static void arc_pmu_disable(struct pmu *pmu)
 	write_aux_reg(ARC_REG_PCT_CONTROL, (tmp & 0xffff0000) | 0x0);
 }
 
+static int arc_pmu_event_set_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 left = local64_read(&hwc->period_left);
+	u64 period = hwc->sample_period;
+	int idx = hwc->idx;
+	int ret = 0;
+	u64 value;
+
+	if (unlikely(left <= -period)) {
+		/* left underflowed by more than period. */
+		left = period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	} else	if (unlikely((left + period) <= period)) {
+		/* left underflowed by less than period. */
+		left += period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (left > arc_pmu->max_period) {
+		left = arc_pmu->max_period;
+		local64_set(&hwc->period_left, left);
+	}
+
+	value = arc_pmu->max_period - left;
+	local64_set(&hwc->prev_count, value);
+
+	/* Select counter */
+	write_aux_reg(ARC_REG_PCT_INDEX, idx);
+
+	/* Write value */
+	write_aux_reg(ARC_REG_PCT_COUNTL, value & 0xffffffff);
+	write_aux_reg(ARC_REG_PCT_COUNTH, (value >> 32));
+
+	perf_event_update_userpage(event);
+
+	return ret;
+}
+
 /*
  * Assigns hardware counter to hardware condition.
  * Note that there is no separate start/stop mechanism;
@@ -242,9 +291,11 @@ static void arc_pmu_start(struct perf_event *event, int flags)
 		return;
 
 	if (flags & PERF_EF_RELOAD)
-		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
+		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
 
-	event->hw.state = 0;
+	arc_pmu_event_set_period(event);
 
 	/* enable ARC pmu here */
 	write_aux_reg(ARC_REG_PCT_INDEX, idx);
@@ -318,6 +369,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	struct arc_reg_pct_build pct_bcr;
 	struct arc_reg_cc_build cc_bcr;
 	int i, j;
+	int counter_size;	/* in bits */
 
 	union cc_name {
 		struct {
@@ -344,10 +396,11 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	arc_pmu->n_counters = pct_bcr.c;
-	arc_pmu->counter_size = 32 + (pct_bcr.s << 4);
+	counter_size = 32 + (pct_bcr.s << 4);
+	arc_pmu->max_period = (1ULL << counter_size) - 1ULL;
 
 	pr_info("ARC perf\t: %d counters (%d bits), %d countable conditions\n",
-		arc_pmu->n_counters, arc_pmu->counter_size, cc_bcr.c);
+		arc_pmu->n_counters, counter_size, cc_bcr.c);
 
 	arc_pmu->n_events = cc_bcr.c;
 
-- 
1.9.1
