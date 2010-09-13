From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 1/6] perf: Add helper function to return number of counters
Date: Mon, 13 Sep 2010 07:07:32 +0100
Message-ID: <2c5f545e9dafada4780d48ee778b4424ee093839.1284357372.git.matt@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:39287 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751886Ab0IMGHk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Sep 2010 02:07:40 -0400
In-Reply-To: <cover.1284357372.git.matt@console-pimps.org>
In-Reply-To: <cover.1284357372.git.matt@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robert Richter <robert.richter@amd.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-arch@vger.kernel.org

The number of counters for the registered pmu is needed in a few places
so provide a helper function that returns this number.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/arm/kernel/perf_event.c |    6 ++++++
 arch/arm/oprofile/common.c   |   25 +++++++++++--------------
 arch/sh/kernel/perf_event.c  |    9 +++++++++
 include/linux/perf_event.h   |    1 +
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 417c392..3b0aedf 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -123,6 +123,12 @@ armpmu_get_max_events(void)
 }
 EXPORT_SYMBOL_GPL(armpmu_get_max_events);
 
+int perf_num_counters(void)
+{
+	return armpmu_get_max_events();
+}
+EXPORT_SYMBOL_GPL(perf_num_counters);
+
 #define HW_OP_UNSUPPORTED		0xFFFF
 
 #define C(_x) \
diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index d660cb8..6498e58 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -43,7 +43,6 @@ static DEFINE_MUTEX(op_arm_mutex);
 
 static struct op_counter_config *counter_config;
 static struct perf_event **perf_events[nr_cpumask_bits];
-static int perf_num_counters;
 
 /*
  * Overflow callback for oprofile.
@@ -54,11 +53,11 @@ static void op_overflow_handler(struct perf_event *event, int unused,
 	int id;
 	u32 cpu = smp_processor_id();
 
-	for (id = 0; id < perf_num_counters; ++id)
+	for (id = 0; id < perf_num_counters(); ++id)
 		if (perf_events[cpu][id] == event)
 			break;
 
-	if (id != perf_num_counters)
+	if (id != perf_num_counters())
 		oprofile_add_sample(regs, id);
 	else
 		pr_warning("oprofile: ignoring spurious overflow "
@@ -76,7 +75,7 @@ static void op_perf_setup(void)
 	u32 size = sizeof(struct perf_event_attr);
 	struct perf_event_attr *attr;
 
-	for (i = 0; i < perf_num_counters; ++i) {
+	for (i = 0; i < perf_num_counters(); ++i) {
 		attr = &counter_config[i].attr;
 		memset(attr, 0, size);
 		attr->type		= PERF_TYPE_RAW;
@@ -131,7 +130,7 @@ static int op_perf_start(void)
 	int cpu, event, ret = 0;
 
 	for_each_online_cpu(cpu) {
-		for (event = 0; event < perf_num_counters; ++event) {
+		for (event = 0; event < perf_num_counters(); ++event) {
 			ret = op_create_counter(cpu, event);
 			if (ret)
 				goto out;
@@ -150,7 +149,7 @@ static void op_perf_stop(void)
 	int cpu, event;
 
 	for_each_online_cpu(cpu)
-		for (event = 0; event < perf_num_counters; ++event)
+		for (event = 0; event < perf_num_counters(); ++event)
 			op_destroy_counter(cpu, event);
 }
 
@@ -179,7 +178,7 @@ static int op_arm_create_files(struct super_block *sb, struct dentry *root)
 {
 	unsigned int i;
 
-	for (i = 0; i < perf_num_counters; i++) {
+	for (i = 0; i < perf_num_counters(); i++) {
 		struct dentry *dir;
 		char buf[4];
 
@@ -353,14 +352,12 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 
 	memset(&perf_events, 0, sizeof(perf_events));
 
-	perf_num_counters = armpmu_get_max_events();
-
-	counter_config = kcalloc(perf_num_counters,
+	counter_config = kcalloc(perf_num_counters(),
 			sizeof(struct op_counter_config), GFP_KERNEL);
 
 	if (!counter_config) {
 		pr_info("oprofile: failed to allocate %d "
-				"counters\n", perf_num_counters);
+				"counters\n", perf_num_counters());
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -370,11 +367,11 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 		goto out;
 
 	for_each_possible_cpu(cpu) {
-		perf_events[cpu] = kcalloc(perf_num_counters,
+		perf_events[cpu] = kcalloc(perf_num_counters(),
 				sizeof(struct perf_event *), GFP_KERNEL);
 		if (!perf_events[cpu]) {
 			pr_info("oprofile: failed to allocate %d perf events "
-					"for cpu %d\n", perf_num_counters, cpu);
+					"for cpu %d\n", perf_num_counters(), cpu);
 			ret = -ENOMEM;
 			goto out;
 		}
@@ -409,7 +406,7 @@ void __exit oprofile_arch_exit(void)
 	struct perf_event *event;
 
 	for_each_possible_cpu(cpu) {
-		for (id = 0; id < perf_num_counters; ++id) {
+		for (id = 0; id < perf_num_counters(); ++id) {
 			event = perf_events[cpu][id];
 			if (event)
 				perf_event_release_kernel(event);
diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
index 7a3dc35..2cb9ad5 100644
--- a/arch/sh/kernel/perf_event.c
+++ b/arch/sh/kernel/perf_event.c
@@ -59,6 +59,15 @@ static inline int sh_pmu_initialized(void)
 	return !!sh_pmu;
 }
 
+int perf_num_counters(void)
+{
+	if (!sh_pmu)
+		return 0;
+
+	return sh_pmu->num_events;
+}
+EXPORT_SYMBOL_GPL(perf_num_counters);
+
 /*
  * Release the PMU if this is the last perf_event.
  */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 716f99b..1a02192 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -849,6 +849,7 @@ extern int perf_max_events;
 
 extern const struct pmu *hw_perf_event_init(struct perf_event *event);
 
+extern int perf_num_counters(void);
 extern void perf_event_task_sched_in(struct task_struct *task);
 extern void perf_event_task_sched_out(struct task_struct *task, struct task_struct *next);
 extern void perf_event_task_tick(struct task_struct *task);
-- 
1.7.1
