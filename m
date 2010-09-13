From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 5/6] ARM: Make oprofile depend on CONFIG_HW_PERF_EVENTS
Date: Mon, 13 Sep 2010 07:07:36 +0100
Message-ID: <831bc9523fe04ce899bc78230990033fbe009431.1284357372.git.matt@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <cover.1284357372.git.matt@console-pimps.org>
In-Reply-To: <cover.1284357372.git.matt@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
Sender: linux-sh-owner@vger.kernel.org
To: Robert Richter <robert.richter@amd.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Currently, oprofile support is only functional if CONFIG_HW_PERF_EVENTS
is set. If this symbol is not set, oprofile initialisation will fail at
runtime. Instead of allowing the oprofile code to build but fail at
runtime it seems less confusing to not allow the code to be built unless
hardware performance counter support is available.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/arm/Kconfig           |    2 +-
 arch/arm/oprofile/common.c |    9 ---------
 2 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7ed21f..d29075c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -14,7 +14,7 @@ config ARM
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
 	select GENERIC_ATOMIC64 if (!CPU_32v6K)
-	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
+	select HAVE_OPROFILE if (HW_PERF_EVENTS)
 	select HAVE_ARCH_KGDB
 	select HAVE_KPROBES if (!XIP_KERNEL)
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 9a3ed26..444ea86 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -24,7 +24,6 @@
 #include <asm/perf_event.h>
 #include <asm/ptrace.h>
 
-#ifdef CONFIG_HW_PERF_EVENTS
 static char *op_name_from_perf_id(enum arm_perf_pmu_ids id)
 {
 	switch (id) {
@@ -119,11 +118,3 @@ void __exit oprofile_arch_exit(void)
 {
 	oprofile_perf_exit();
 }
-#else
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	pr_info("oprofile: hardware counters not available\n");
-	return -ENODEV;
-}
-void __exit oprofile_arch_exit(void) {}
-#endif /* CONFIG_HW_PERF_EVENTS */
-- 
1.7.1

