From: tip-bot for Frederic Weisbecker <fweisbec@gmail.com>
Subject: [tip:perf/urgent] perf: Introduce new perf_fetch_caller_regs() for hot regs snapshot
Date: Wed, 10 Mar 2010 15:37:16 GMT
Message-ID: <tip-5331d7b84613b8325362dde53dc2bff2fb87d351@git.kernel.org>
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
	  paulus@samba.org, acme@redhat.com, peterz@infradead.org,
	  fweisbec@gmail.com, rostedt@goodmis.org, jbaron@redhat.com,
	  tglx@linutronix.de, mhiramat@redhat.com,
	  linux-arch@vger.kernel.org, mingo@elte.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48130 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756725Ab0CJPhk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Mar 2010 10:37:40 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: acme@redhat.com, paulus@samba.org, hpa@zytor.com, mingo@redhat.com, peterz@infradead.org, fweisbec@gmail.com, rostedt@goodmis.org, jbaron@redhat.com, tglx@linutronix.de, linux-arch@vger.kernel.org, mhiramat@redhat.com, mingo@elte.hu

Commit-ID:  5331d7b84613b8325362dde53dc2bff2fb87d351
Gitweb:     http://git.kernel.org/tip/5331d7b84613b8325362dde53dc2bff2fb87d351
Author:     Frederic Weisbecker <fweisbec@gmail.com>
AuthorDate: Thu, 4 Mar 2010 21:15:56 +0100
Committer:  Frederic Weisbecker <fweisbec@gmail.com>
CommitDate: Wed, 10 Mar 2010 14:39:35 +0100

perf: Introduce new perf_fetch_caller_regs() for hot regs snapshot

Events that trigger overflows by interrupting a context can
use get_irq_regs() or task_pt_regs() to retrieve the state
when the event triggered. But this is not the case for some
other class of events like trace events as tracepoints are
executed in the same context than the code that triggered
the event.

It means we need a different api to capture the regs there,
namely we need a hot snapshot to get the most important
informations for perf: the instruction pointer to get the
event origin, the frame pointer for the callchain, the code
segment for user_mode() tests (we always use __KERNEL_CS as
trace events always occur from the kernel) and the eflags
for further purposes.

v2: rename perf_save_regs to perf_fetch_caller_regs as per
Masami's suggestion.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Masami Hiramatsu <mhiramat@redhat.com>
Cc: Jason Baron <jbaron@redhat.com>
Cc: Archs <linux-arch@vger.kernel.org>
---
 arch/x86/kernel/cpu/perf_event.c |   12 ++++++++++
 arch/x86/kernel/dumpstack.h      |   15 +++++++++++++
 include/linux/perf_event.h       |   42 +++++++++++++++++++++++++++++++++++++-
 kernel/perf_event.c              |    5 ++++
 4 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index 1d665a0..c6bde7d 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -1707,3 +1707,15 @@ struct perf_callchain_entry *perf_callchain(struct pt_regs *regs)
 
 	return entry;
 }
+
+void perf_arch_fetch_caller_regs(struct pt_regs *regs, unsigned long ip, int skip)
+{
+	regs->ip = ip;
+	/*
+	 * perf_arch_fetch_caller_regs adds another call, we need to increment
+	 * the skip level
+	 */
+	regs->bp = rewind_frame_pointer(skip + 1);
+	regs->cs = __KERNEL_CS;
+	local_save_flags(regs->flags);
+}
diff --git a/arch/x86/kernel/dumpstack.h b/arch/x86/kernel/dumpstack.h
index 4fd1420..29e5f7c 100644
--- a/arch/x86/kernel/dumpstack.h
+++ b/arch/x86/kernel/dumpstack.h
@@ -29,4 +29,19 @@ struct stack_frame {
 	struct stack_frame *next_frame;
 	unsigned long return_address;
 };
+
+static inline unsigned long rewind_frame_pointer(int n)
+{
+	struct stack_frame *frame;
+
+	get_bp(frame);
+
+#ifdef CONFIG_FRAME_POINTER
+	while (n--)
+		frame = frame->next_frame;
 #endif
+
+	return (unsigned long)frame;
+}
+
+#endif /* DUMPSTACK_H */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 80acbf3..70cffd0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -452,6 +452,7 @@ enum perf_callchain_context {
 #include <linux/fs.h>
 #include <linux/pid_namespace.h>
 #include <linux/workqueue.h>
+#include <linux/ftrace.h>
 #include <asm/atomic.h>
 
 #define PERF_MAX_STACK_DEPTH		255
@@ -847,6 +848,44 @@ perf_sw_event(u32 event_id, u64 nr, int nmi, struct pt_regs *regs, u64 addr)
 		__perf_sw_event(event_id, nr, nmi, regs, addr);
 }
 
+extern void
+perf_arch_fetch_caller_regs(struct pt_regs *regs, unsigned long ip, int skip);
+
+/*
+ * Take a snapshot of the regs. Skip ip and frame pointer to
+ * the nth caller. We only need a few of the regs:
+ * - ip for PERF_SAMPLE_IP
+ * - cs for user_mode() tests
+ * - bp for callchains
+ * - eflags, for future purposes, just in case
+ */
+static inline void perf_fetch_caller_regs(struct pt_regs *regs, int skip)
+{
+	unsigned long ip;
+
+	memset(regs, 0, sizeof(*regs));
+
+	switch (skip) {
+	case 1 :
+		ip = CALLER_ADDR0;
+		break;
+	case 2 :
+		ip = CALLER_ADDR1;
+		break;
+	case 3 :
+		ip = CALLER_ADDR2;
+		break;
+	case 4:
+		ip = CALLER_ADDR3;
+		break;
+	/* No need to support further for now */
+	default:
+		ip = 0;
+	}
+
+	return perf_arch_fetch_caller_regs(regs, ip, skip);
+}
+
 extern void __perf_event_mmap(struct vm_area_struct *vma);
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)
@@ -880,7 +919,8 @@ static inline bool perf_paranoid_kernel(void)
 }
 
 extern void perf_event_init(void);
-extern void perf_tp_event(int event_id, u64 addr, u64 count, void *record, int entry_size);
+extern void perf_tp_event(int event_id, u64 addr, u64 count, void *record,
+			  int entry_size, struct pt_regs *regs);
 extern void perf_bp_event(struct perf_event *event, void *data);
 
 #ifndef perf_misc_flags
diff --git a/kernel/perf_event.c b/kernel/perf_event.c
index 52c69a3..359d7f6 100644
--- a/kernel/perf_event.c
+++ b/kernel/perf_event.c
@@ -2786,6 +2786,11 @@ __weak struct perf_callchain_entry *perf_callchain(struct pt_regs *regs)
 	return NULL;
 }
 
+__weak
+void perf_arch_fetch_caller_regs(struct pt_regs *regs, unsigned long ip, int skip)
+{
+}
+
 /*
  * Output
  */
