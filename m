From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 3/6] ARM: oprofile: Move non-ARM code into separate init/exit functions
Date: Mon, 13 Sep 2010 07:07:34 +0100
Message-ID: <7f520b235254cdbf6444ed9f4839fb5c12ff1199.1284357372.git.matt@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:39309 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751672Ab0IMGHl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Sep 2010 02:07:41 -0400
In-Reply-To: <cover.1284357372.git.matt@console-pimps.org>
In-Reply-To: <cover.1284357372.git.matt@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robert Richter <robert.richter@amd.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-arch@vger.kernel.org

In preparation for moving the majority of this oprofile code into an
architecture-neutral place separate the architecture-independent code
into oprofile_perf_init() and oprofile_perf_exit().

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/arm/oprofile/common.c |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index ed8291a..4d814c3 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -346,7 +346,7 @@ static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
 		tail = user_backtrace(tail);
 }
 
-int __init oprofile_arch_init(struct oprofile_operations *ops)
+int __init oprofile_perf_init(struct oprofile_operations *ops)
 {
 	int cpu, ret = 0;
 
@@ -377,13 +377,16 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 		}
 	}
 
-	ops->backtrace		= arm_backtrace;
-	ops->create_files	= oprofile_perf_create_files;
-	ops->setup		= oprofile_perf_setup;
-	ops->start		= oprofile_perf_start;
-	ops->stop		= oprofile_perf_stop;
-	ops->shutdown		= oprofile_perf_stop;
-	ops->cpu_type		= op_name_from_perf_id(armpmu_get_pmu_id());
+	if (!ops->create_files)
+		ops->create_files = oprofile_perf_create_files;
+	if (!ops->setup)
+		ops->setup = oprofile_perf_setup;
+	if (!ops->start)
+		ops->start = oprofile_perf_start;
+	if (!ops->stop)
+		ops->stop = oprofile_perf_stop;
+	if (!ops->shutdown)
+		ops->shutdown = oprofile_perf_stop;
 
 	if (!ops->cpu_type)
 		ret = -ENODEV;
@@ -400,7 +403,15 @@ out:
 	return ret;
 }
 
-void __exit oprofile_arch_exit(void)
+int __init oprofile_arch_init(struct oprofile_operations *ops)
+{
+	ops->backtrace		= arm_backtrace;
+	ops->cpu_type		= op_name_from_perf_id(armpmu_get_pmu_id());
+
+	return oprofile_perf_init(ops);
+}
+
+void __exit oprofile_perf_exit(void)
 {
 	int cpu, id;
 	struct perf_event *event;
@@ -418,6 +429,11 @@ void __exit oprofile_arch_exit(void)
 	kfree(counter_config);
 	exit_driverfs();
 }
+
+void __exit oprofile_arch_exit(void)
+{
+	oprofile_perf_exit();
+}
 #else
 int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
-- 
1.7.1
