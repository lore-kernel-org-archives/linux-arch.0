From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 7/8] ARCv2: perf: SMP support
Date: Tue, 9 Jun 2015 17:49:31 +0530
Message-ID: <1433852372-29494-8-git-send-email-vgupta@synopsys.com>
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

* split off pmu info into singleton and per-cpu bits
* setup PMU on all cores

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/perf_event.c | 73 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 01aa0ea16bae..a40772b37b77 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -21,16 +21,27 @@
 
 struct arc_pmu {
 	struct pmu	pmu;
-	int		has_interrupts;
+	unsigned int	irq:31, has_interrupts:1;
 	int		n_counters;
 	int		n_events;
-	unsigned long	used_mask[BITS_TO_LONGS(ARC_PERF_MAX_COUNTERS)];
 	u64		max_period;
 	int		ev_hw_idx[PERF_COUNT_ARC_HW_MAX];
-	struct perf_event *act_counter[ARC_PERF_MAX_COUNTERS];
 	u64             raw_events[ARC_PERF_MAX_EVENTS];
 };
 
+struct arc_pmu_cpu {
+	/*
+	 * A 1 bit for an index indicates that the counter is being used for
+	 * an event. A 0 means that the counter can be used.
+	 */
+	unsigned long	used_mask[BITS_TO_LONGS(ARC_PERF_MAX_COUNTERS)];
+
+	/*
+	 * The events that are active on the PMU for the given index.
+	 */
+	struct perf_event *act_counter[ARC_PERF_MAX_COUNTERS];
+};
+
 struct arc_callchain_trace {
 	int depth;
 	void *perf_stuff;
@@ -70,6 +81,7 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 }
 
 static struct arc_pmu *arc_pmu;
+static DEFINE_PER_CPU(struct arc_pmu_cpu, arc_pmu_cpu);
 
 /* read counter #idx; note that counter# != event# on ARC! */
 static uint64_t arc_pmu_read_counter(int idx)
@@ -353,10 +365,12 @@ static void arc_pmu_stop(struct perf_event *event, int flags)
 
 static void arc_pmu_del(struct perf_event *event, int flags)
 {
+	struct arc_pmu_cpu *pmu_cpu = this_cpu_ptr(&arc_pmu_cpu);
+
 	arc_pmu_stop(event, PERF_EF_UPDATE);
-	__clear_bit(event->hw.idx, arc_pmu->used_mask);
+	__clear_bit(event->hw.idx, pmu_cpu->used_mask);
 
-	arc_pmu->act_counter[event->hw.idx] = 0;
+	pmu_cpu->act_counter[event->hw.idx] = 0;
 
 	perf_event_update_userpage(event);
 }
@@ -364,22 +378,23 @@ static void arc_pmu_del(struct perf_event *event, int flags)
 /* allocate hardware counter and optionally start counting */
 static int arc_pmu_add(struct perf_event *event, int flags)
 {
+	struct arc_pmu_cpu *pmu_cpu = this_cpu_ptr(&arc_pmu_cpu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
-	if (__test_and_set_bit(idx, arc_pmu->used_mask)) {
-		idx = find_first_zero_bit(arc_pmu->used_mask,
+	if (__test_and_set_bit(idx, pmu_cpu->used_mask)) {
+		idx = find_first_zero_bit(pmu_cpu->used_mask,
 					  arc_pmu->n_counters);
 		if (idx == arc_pmu->n_counters)
 			return -EAGAIN;
 
-		__set_bit(idx, arc_pmu->used_mask);
+		__set_bit(idx, pmu_cpu->used_mask);
 		hwc->idx = idx;
 	}
 
 	write_aux_reg(ARC_REG_PCT_INDEX, idx);
 
-	arc_pmu->act_counter[idx] = event;
+	pmu_cpu->act_counter[idx] = event;
 
 	if (is_sampling_event(event)) {
 		/* Mimic full counter overflow as other arches do */
@@ -411,7 +426,7 @@ static int arc_pmu_add(struct perf_event *event, int flags)
 static irqreturn_t arc_pmu_intr(int irq, void *dev)
 {
 	struct perf_sample_data data;
-	struct arc_pmu *arc_pmu = (struct arc_pmu *)dev;
+	struct arc_pmu_cpu *pmu_cpu = this_cpu_ptr(&arc_pmu_cpu);
 	struct pt_regs *regs;
 	int active_ints;
 	int idx;
@@ -423,7 +438,7 @@ static irqreturn_t arc_pmu_intr(int irq, void *dev)
 	regs = get_irq_regs();
 
 	for (idx = 0; idx < arc_pmu->n_counters; idx++) {
-		struct perf_event *event = arc_pmu->act_counter[idx];
+		struct perf_event *event = pmu_cpu->act_counter[idx];
 		struct hw_perf_event *hwc;
 
 		if (!(active_ints & (1 << idx)))
@@ -466,9 +481,19 @@ static irqreturn_t arc_pmu_intr(int irq, void *dev)
 
 #endif /* CONFIG_ISA_ARCV2 */
 
+void arc_cpu_pmu_irq_init(void)
+{
+	struct arc_pmu_cpu *pmu_cpu = this_cpu_ptr(&arc_pmu_cpu);
+
+	arc_request_percpu_irq(arc_pmu->irq, smp_processor_id(), arc_pmu_intr,
+			       "ARC perf counters", pmu_cpu);
+
+	/* Clear all pending interrupt flags */
+	write_aux_reg(ARC_REG_PCT_INT_ACT, 0xffffffff);
+}
+
 static int arc_pmu_device_probe(struct platform_device *pdev)
 {
-	struct arc_pmu *arc_pmu;
 	struct arc_reg_pct_build pct_bcr;
 	struct arc_reg_cc_build cc_bcr;
 	int i, j;
@@ -549,18 +574,30 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 
 	if (arc_pmu->has_interrupts) {
 		int irq = platform_get_irq(pdev, 0);
+		unsigned long flags;
 
 		if (irq < 0) {
 			pr_err("Cannot get IRQ number for the platform\n");
 			return -ENODEV;
 		}
 
-		ret = devm_request_irq(&pdev->dev, irq, arc_pmu_intr, 0,
-				       "arc-pmu", arc_pmu);
-		if (ret) {
-			pr_err("could not allocate PMU IRQ\n");
-			return ret;
-		}
+		arc_pmu->irq = irq;
+
+		/*
+		 * arc_cpu_pmu_irq_init() needs to be called on all cores for
+		 * their respective local PMU.
+		 * However we use opencoded on_each_cpu() to ensure it is called
+		 * on core0 first, so that arc_request_percpu_irq() sets up
+		 * AUTOEN etc. Otherwise enable_percpu_irq() fails to enable
+		 * perf IRQ on non master cores.
+		 * see arc_request_percpu_irq()
+		 */
+		preempt_disable();
+		local_irq_save(flags);
+		arc_cpu_pmu_irq_init();
+		local_irq_restore(flags);
+		smp_call_function((smp_call_func_t)arc_cpu_pmu_irq_init, 0, 1);
+		preempt_enable();
 
 		/* Clean all pending interrupt flags */
 		write_aux_reg(ARC_REG_PCT_INT_ACT, 0xffffffff);
-- 
1.9.1
