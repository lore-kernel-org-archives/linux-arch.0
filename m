From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v2 3/8] ARCv2: perf: implement "event_set_period" for future use with interrupts
Date: Wed,  5 Aug 2015 18:13:29 +0300
Message-ID: <1438787614-14074-4-git-send-email-abrodkin@synopsys.com>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, peterz@infradead.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-arch.vger.kernel.org

This generalization prepares for support of overflow interrupts.

Hardware event counters on ARC work that way:
Each counter counts from programmed start value (set in
ARC_REG_PCT_COUNT) to a limit value (set in ARC_REG_PCT_INT_CNT) and
once limit value is reached this timer generates an interrupt.

Even though this hardware implementation allows for more flexibility,
in Linux kernel we decided to mimic behavior of other architectures this
way:

 [1] Set limit value as half of counter's max value (to allow counter to
     run after reaching it limit, see below for more explanation):
 ---------->8-----------
 arc_pmu->max_period = (1ULL << counter_size) / 2 - 1ULL;
 ---------->8-----------

 [2] Set start value as "arc_pmu->max_period - sample_period" and then
count up to the limit

Our event counters don't stop on reaching max value (the one we set in
ARC_REG_PCT_INT_CNT) but continue to count until kernel explicitly
stops each of them.

And setting a limit as half of counter capacity is done to allow
capturing of additional events in between moment when interrupt was
triggered until we're actually processing PMU interrupts. That way
we're trying to be more precise.

For example if we count CPU cycles we keep track of cycles while
running through generic IRQ handling code:

 [1] We set counter period as say 100_000 events of type "crun"
 [2] Counter reaches that limit and raises its interrupt
 [3] Once we get in PMU IRQ handler we read current counter value from
ARC_REG_PCT_SNAP ans see there something like 105_000.

If counters stop on reaching a limit value then we would miss
additional 5000 cycles.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---

Compared to v1:
 [1] Added verbose commit message with explanation of how PCT HW works on ARC
 [2] Simplified arc_perf_event_update()
 [3] Removed check for is_sampling_event() because we already set
     PERF_PMU_CAP_NO_INTERRUPT in probe()
 [4] Minor cosmetics

 arch/arc/kernel/perf_event.c | 81 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 461fccf..2d95440 100644
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
@@ -90,18 +90,15 @@ static uint64_t arc_pmu_read_counter(int idx)
 static void arc_perf_event_update(struct perf_event *event,
 				  struct hw_perf_event *hwc, int idx)
 {
-	uint64_t prev_raw_count, new_raw_count;
-	int64_t delta;
-
-	do {
-		prev_raw_count = local64_read(&hwc->prev_count);
-		new_raw_count = arc_pmu_read_counter(idx);
-	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-				 new_raw_count) != prev_raw_count);
-
-	delta = (new_raw_count - prev_raw_count) &
-		((1ULL << arc_pmu->counter_size) - 1ULL);
+	uint64_t prev_raw_count = local64_read(&hwc->prev_count);
+	uint64_t new_raw_count = arc_pmu_read_counter(idx);
+	int64_t delta = new_raw_count - prev_raw_count;
 
+	/*
+	 * We don't afaraid of hwc->prev_count changing beneath our feet
+	 * because there's no way for us to re-enter this function anytime.
+	 */
+	local64_set(&hwc->prev_count, new_raw_count);
 	local64_add(delta, &event->count);
 	local64_sub(delta, &hwc->period_left);
 }
@@ -156,6 +153,10 @@ static int arc_pmu_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int ret;
 
+	hwc->sample_period  = arc_pmu->max_period;
+	hwc->last_period = hwc->sample_period;
+	local64_set(&hwc->period_left, hwc->sample_period);
+
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
 		if (event->attr.config >= PERF_COUNT_HW_MAX)
@@ -167,6 +168,7 @@ static int arc_pmu_event_init(struct perf_event *event)
 			 (int) event->attr.config, (int) hwc->config,
 			 arc_pmu_ev_hw_map[event->attr.config]);
 		return 0;
+
 	case PERF_TYPE_HW_CACHE:
 		ret = arc_pmu_cache_event(event->attr.config);
 		if (ret < 0)
@@ -202,6 +204,49 @@ static void arc_pmu_disable(struct pmu *pmu)
 	write_aux_reg(ARC_REG_PCT_CONTROL, (tmp & 0xffff0000) | 0x0);
 }
 
+static int arc_pmu_event_set_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left = local64_read(&hwc->period_left);
+	s64 period = hwc->sample_period;
+	int idx = hwc->idx;
+	int overflow = 0;
+	u64 value;
+
+	if (unlikely(left <= -period)) {
+		/* left underflowed by more than period. */
+		left = period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		overflow = 1;
+	} else	if (unlikely(left <= 0)) {
+		/* left underflowed by less than period. */
+		left += period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		overflow = 1;
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
+	write_aux_reg(ARC_REG_PCT_COUNTL, (u32)value);
+	write_aux_reg(ARC_REG_PCT_COUNTH, (value >> 32));
+
+	perf_event_update_userpage(event);
+
+	return overflow;
+}
+
 /*
  * Assigns hardware counter to hardware condition.
  * Note that there is no separate start/stop mechanism;
@@ -216,9 +261,11 @@ static void arc_pmu_start(struct perf_event *event, int flags)
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
@@ -291,6 +338,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	struct arc_reg_pct_build pct_bcr;
 	struct arc_reg_cc_build cc_bcr;
 	int i, j;
+	int counter_size;	/* in bits */
 
 	struct cc_name {
 		union {
@@ -317,10 +365,11 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
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
2.4.3
