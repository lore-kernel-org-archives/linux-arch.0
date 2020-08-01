From: guoren@kernel.org
Subject: [PATCH 13/13] csky: Add context tracking support
Date: Sat,  1 Aug 2020 01:14:13 +0000
Message-ID: <1596244453-98575-14-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>, Greentime Hu <greentime.hu@sifive.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch support context tracking with no hz full.

Here is the test result with dynticks-testing (see tick_stop):

 cat /sys/kernel/debug/tracing/per_cpu/cpu0/trace
 tracer: nop

 entries-in-buffer/entries-written: 356/356   #P:1

                              _-----=> irqs-off
                             / _----=> need-resched
                            | / _---=> hardirq/softirq
                            || / _--=> preempt-depth
                            ||| /     delay
           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
              | |       |   ||||       |         |
...
          sleep-192   [000] d.h.   167.088270: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=166436355700
          sleep-192   [000] d.h.   167.092279: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=166440365700
         <idle>-0     [000] d.h2   167.096492: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=166444578400
         <idle>-0     [000] d..1   167.097876: tick_stop: success=1 dependency=NONE
                                               ^^^^^^^^^
         <idle>-0     [000] d.h1   168.818206: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=168166280900
   kworker/u2:0-7     [000] ....   168.821760: workqueue_execute_start: work struct (ptrval): function wb_workfn
   kworker/u2:0-7     [000] d.h1   168.824464: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=168172547100
    kworker/0:1-18    [000] ....   168.825053: workqueue_execute_start: work struct (ptrval): function vmstat_update
    kworker/0:1-18    [000] ....   168.825238: workqueue_execute_start: work struct (ptrval): function vmstat_shepherd
    kworker/0:1-18    [000] ....   168.825516: workqueue_execute_start: work struct (ptrval): function neigh_periodic_work
         <idle>-0     [000] d..1   168.826121: tick_stop: success=1 dependency=NONE
   kworker/u2:0-7     [000] ....   169.377327: workqueue_execute_start: work struct (ptrval): function flush_to_ldisc
         <idle>-0     [000] d..1   169.379832: tick_stop: success=1 dependency=NONE
   kworker/u2:0-7     [000] ....   169.607935: workqueue_execute_start: work struct (ptrval): function flush_to_ldisc
   kworker/u2:0-7     [000] d.h1   169.608148: hrtimer_expire_entry: hrtimer=(ptrval) function=tick_sched_timer now=168956235500
         <idle>-0     [000] d..1   169.608654: tick_stop: success=1 dependency=NONE

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Greentime Hu <greentime.hu@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig        |  2 ++
 arch/csky/kernel/entry.S | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index ad98b93..af23873 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -42,6 +42,8 @@ config CSKY
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_COPY_THREAD_TLS
+	select HAVE_CONTEXT_TRACKING
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index efd2e69..5936391 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -23,6 +23,22 @@
 #endif
 .endm
 
+.macro	context_tracking
+	mfcr	a0, epsr
+	btsti	a0, 31
+	bt	1f
+	jbsr	context_tracking_user_exit
+	ldw	a0, (sp, LSAVE_A0)
+	ldw	a1, (sp, LSAVE_A1)
+	ldw	a2, (sp, LSAVE_A2)
+	ldw	a3, (sp, LSAVE_A3)
+#if defined(__CSKYABIV1__)
+	ldw	r6, (sp, LSAVE_A4)
+	ldw	r7, (sp, LSAVE_A5)
+#endif
+1:
+.endm
+
 .macro tlbop_begin name, val0, val1, val2
 ENTRY(csky_\name)
 	mtcr    a3, ss2
@@ -103,6 +119,7 @@ ENTRY(csky_\name)
 .endm
 .macro tlbop_end is_write
 	zero_fp
+	context_tracking
 	RD_MEH	a2
 	psrset  ee, ie
 	mov     a0, sp
@@ -128,6 +145,7 @@ tlbop_end 1
 ENTRY(csky_systemcall)
 	SAVE_ALL TRAP0_SIZE
 	zero_fp
+	context_tracking
 	psrset  ee, ie
 
 	lrw     r9, __NR_syscalls
@@ -237,6 +255,9 @@ ret_from_exception:
 	and	r10, r9
 	cmpnei	r10, 0
 	bt	exit_work
+#ifdef CONFIG_CONTEXT_TRACKING
+	jbsr	context_tracking_user_enter
+#endif
 1:
 #ifdef CONFIG_PREEMPTION
 	mov	r9, sp
@@ -277,6 +298,7 @@ work_resched:
 ENTRY(csky_trap)
 	SAVE_ALL 0
 	zero_fp
+	context_tracking
 	psrset	ee
 	mov	a0, sp                 /* Push Stack pointer arg */
 	jbsr	trap_c                 /* Call C-level trap handler */
@@ -311,6 +333,7 @@ ENTRY(csky_get_tls)
 ENTRY(csky_irq)
 	SAVE_ALL 0
 	zero_fp
+	context_tracking
 	psrset	ee
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
2.7.4
