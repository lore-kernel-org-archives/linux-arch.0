From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 6/6] sh: oprofile: Use perf-events oprofile backend
Date: Mon, 13 Sep 2010 07:07:37 +0100
Message-ID: <e75f8fa563b4bfb2b4cf62fe64ae398ea5e1831a.1284357372.git.matt@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <cover.1284357372.git.matt@console-pimps.org>
In-Reply-To: <cover.1284357372.git.matt@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
Sender: linux-sh-owner@vger.kernel.org
To: Robert Richter <robert.richter@amd.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Now that we've got a generic perf-events based oprofile backend we might
as well make use of it seeing as SH doesn't do anything special with its
oprofile backend.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/Kconfig             |    2 +-
 arch/sh/kernel/perf_event.c |    8 +++
 arch/sh/oprofile/Makefile   |    2 +-
 arch/sh/oprofile/common.c   |  104 ++++--------------------------------------
 arch/sh/oprofile/op_impl.h  |   33 --------------
 5 files changed, 20 insertions(+), 129 deletions(-)
 delete mode 100644 arch/sh/oprofile/op_impl.h

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 33990fa..dc4a017 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -11,7 +11,7 @@ config SUPERH
 	select HAVE_CLK
 	select HAVE_IDE if HAS_IOPORT
 	select HAVE_MEMBLOCK
-	select HAVE_OPROFILE
+	select HAVE_OPROFILE if PERF_EVENTS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DMA_API_DEBUG
diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
index 2cb9ad5..3c3fc9a 100644
--- a/arch/sh/kernel/perf_event.c
+++ b/arch/sh/kernel/perf_event.c
@@ -59,6 +59,14 @@ static inline int sh_pmu_initialized(void)
 	return !!sh_pmu;
 }
 
+const char *sh_pmu_name(void)
+{
+	if (!sh_pmu)
+		return NULL;
+
+	return sh_pmu->name;
+}
+
 int perf_num_counters(void)
 {
 	if (!sh_pmu)
diff --git a/arch/sh/oprofile/Makefile b/arch/sh/oprofile/Makefile
index 4886c5c..e1015ae 100644
--- a/arch/sh/oprofile/Makefile
+++ b/arch/sh/oprofile/Makefile
@@ -4,6 +4,6 @@ DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
 		oprof.o cpu_buffer.o buffer_sync.o \
 		event_buffer.o oprofile_files.o \
 		oprofilefs.o oprofile_stats.o \
-		timer_int.o )
+		timer_int.o oprofile_perf.o )
 
 oprofile-y	:= $(DRIVER_OBJS) common.o backtrace.o
diff --git a/arch/sh/oprofile/common.c b/arch/sh/oprofile/common.c
index ac60493..87ce88e 100644
--- a/arch/sh/oprofile/common.c
+++ b/arch/sh/oprofile/common.c
@@ -18,113 +18,29 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 #include <asm/processor.h>
-#include "op_impl.h"
-
-static struct op_sh_model *model;
-
-static struct op_counter_config ctr[20];
 
 extern void sh_backtrace(struct pt_regs * const regs, unsigned int depth);
+extern const char *sh_pmu_name(void);
 
-static int op_sh_setup(void)
-{
-	/* Pre-compute the values to stuff in the hardware registers.  */
-	model->reg_setup(ctr);
-
-	/* Configure the registers on all cpus.  */
-	on_each_cpu(model->cpu_setup, NULL, 1);
-
-        return 0;
-}
-
-static int op_sh_create_files(struct super_block *sb, struct dentry *root)
-{
-	int i, ret = 0;
-
-	for (i = 0; i < model->num_counters; i++) {
-		struct dentry *dir;
-		char buf[4];
-
-		snprintf(buf, sizeof(buf), "%d", i);
-		dir = oprofilefs_mkdir(sb, root, buf);
-
-		ret |= oprofilefs_create_ulong(sb, dir, "enabled", &ctr[i].enabled);
-		ret |= oprofilefs_create_ulong(sb, dir, "event", &ctr[i].event);
-		ret |= oprofilefs_create_ulong(sb, dir, "kernel", &ctr[i].kernel);
-		ret |= oprofilefs_create_ulong(sb, dir, "user", &ctr[i].user);
-
-		if (model->create_files)
-			ret |= model->create_files(sb, dir);
-		else
-			ret |= oprofilefs_create_ulong(sb, dir, "count", &ctr[i].count);
-
-		/* Dummy entries */
-		ret |= oprofilefs_create_ulong(sb, dir, "unit_mask", &ctr[i].unit_mask);
-	}
-
-	return ret;
-}
-
-static int op_sh_start(void)
+static char *op_name_from_perf_name(const char *name)
 {
-	/* Enable performance monitoring for all counters.  */
-	on_each_cpu(model->cpu_start, NULL, 1);
+	if (!strcmp(name, "SH7750"))
+		return "sh/sh7750";
+	if (!strcmp(name, "SH-4A"))
+		return "sh/sh4a";
 
-	return 0;
-}
-
-static void op_sh_stop(void)
-{
-	/* Disable performance monitoring for all counters.  */
-	on_each_cpu(model->cpu_stop, NULL, 1);
+	return NULL;
 }
 
 int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
-	struct op_sh_model *lmodel = NULL;
-	int ret;
-
-	/*
-	 * Always assign the backtrace op. If the counter initialization
-	 * fails, we fall back to the timer which will still make use of
-	 * this.
-	 */
 	ops->backtrace = sh_backtrace;
+	ops->cpu_type  = op_name_from_perf_name(sh_pmu_name());
 
-	/*
-	 * XXX
-	 *
-	 * All of the SH7750/SH-4A counters have been converted to perf,
-	 * this infrastructure hook is left for other users until they've
-	 * had a chance to convert over, at which point all of this
-	 * will be deleted.
-	 */
-
-	if (!lmodel)
-		return -ENODEV;
-	if (!(current_cpu_data.flags & CPU_HAS_PERF_COUNTER))
-		return -ENODEV;
-
-	ret = lmodel->init();
-	if (unlikely(ret != 0))
-		return ret;
-
-	model = lmodel;
-
-	ops->setup		= op_sh_setup;
-	ops->create_files	= op_sh_create_files;
-	ops->start		= op_sh_start;
-	ops->stop		= op_sh_stop;
-	ops->cpu_type		= lmodel->cpu_type;
-
-	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
-	       lmodel->cpu_type);
-
-	return 0;
+	return oprofile_perf_init(ops);
 }
 
 void oprofile_arch_exit(void)
 {
-	if (model && model->exit)
-		model->exit();
+	oprofile_perf_exit();
 }
diff --git a/arch/sh/oprofile/op_impl.h b/arch/sh/oprofile/op_impl.h
deleted file mode 100644
index 1244479..0000000
--- a/arch/sh/oprofile/op_impl.h
+++ /dev/null
@@ -1,33 +0,0 @@
-#ifndef __OP_IMPL_H
-#define __OP_IMPL_H
-
-/* Per-counter configuration as set via oprofilefs.  */
-struct op_counter_config {
-	unsigned long enabled;
-	unsigned long event;
-
-	unsigned long count;
-
-	/* Dummy values for userspace tool compliance */
-	unsigned long kernel;
-	unsigned long user;
-	unsigned long unit_mask;
-};
-
-/* Per-architecture configury and hooks.  */
-struct op_sh_model {
-	void (*reg_setup)(struct op_counter_config *);
-	int (*create_files)(struct super_block *sb, struct dentry *dir);
-	void (*cpu_setup)(void *dummy);
-	int (*init)(void);
-	void (*exit)(void);
-	void (*cpu_start)(void *args);
-	void (*cpu_stop)(void *args);
-	char *cpu_type;
-	unsigned char num_counters;
-};
-
-/* arch/sh/oprofile/common.c */
-extern void sh_backtrace(struct pt_regs * const regs, unsigned int depth);
-
-#endif /* __OP_IMPL_H */
-- 
1.7.1

