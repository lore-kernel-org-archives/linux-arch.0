From: Nick Hu <nickhu@andestech.com>
Subject: [PATCH v4 3/4] nds32: Add perf call-graph support.
Date: Thu, 25 Oct 2018 10:24:16 +0800
Message-ID: <2e5e0aab98fe54fc96cb2d3c2dd62c3396c1abd9.1540430862.git.nickhu@andestech.com>
References: <cover.1540430861.git.nickhu@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1540430861.git.nickhu@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, robh+dt@kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ebiederm@xmission.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, zong@andestech.com, alankao@andestech.com, deanbo422@gmail.com
Cc: Nickhu <nickhu@andestech.com>, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

From: Nickhu <nickhu@andestech.com>

The perf call-graph option can trace the callchain
between functions. This commit add the perf callchain
for nds32. There are kerenl callchain and user callchain.
The kerenl callchain can trace the function in kernel
space. There are two type for user callchain. One for the
'optimize for size' config is set, and another one for the
config is not set. The difference between two types is that
the index of frame-pointer in user stack is not the same.

For example:
	With optimize for size:
		User Stack:
			---------
			|   lp	|
			---------
			|	gp	|
			---------
			|	fp	|

	Without optimize for size:
		User Stack:
		1. non-leaf function:
			---------
			|	lp	|
			---------
			|	fp	|

		2. leaf	function:
			---------
			|	fp	|

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/kernel/perf_event_cpu.c | 299 +++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)

diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
index a6e723d0fdbc..5e00ce54d0ff 100644
--- a/arch/nds32/kernel/perf_event_cpu.c
+++ b/arch/nds32/kernel/perf_event_cpu.c
@@ -1193,6 +1193,305 @@ static int __init register_pmu_driver(void)
 
 device_initcall(register_pmu_driver);
 
+/*
+ * References: arch/nds32/kernel/traps.c:__dump()
+ * You will need to know the NDS ABI first.
+ */
+static int unwind_frame_kernel(struct stackframe *frame)
+{
+	int graph = 0;
+#ifdef CONFIG_FRAME_POINTER
+	/* 0x3 means misalignment */
+	if (!kstack_end((void *)frame->fp) &&
+	    !((unsigned long)frame->fp & 0x3) &&
+	    ((unsigned long)frame->fp >= TASK_SIZE)) {
+		/*
+		 *	The array index is based on the ABI, the below graph
+		 *	illustrate the reasons.
+		 *	Function call procedure: "smw" and "lmw" will always
+		 *	update SP and FP for you automatically.
+		 *
+		 *	Stack                                 Relative Address
+		 *	|  |                                          0
+		 *	----
+		 *	|LP| <-- SP(before smw)  <-- FP(after smw)   -1
+		 *	----
+		 *	|FP|                                         -2
+		 *	----
+		 *	|  | <-- SP(after smw)                       -3
+		 */
+		frame->lp = ((unsigned long *)frame->fp)[-1];
+		frame->fp = ((unsigned long *)frame->fp)[FP_OFFSET];
+		/* make sure CONFIG_FUNCTION_GRAPH_TRACER is turned on */
+		if (__kernel_text_address(frame->lp))
+			frame->lp = ftrace_graph_ret_addr
+						(NULL, &graph, frame->lp, NULL);
+
+		return 0;
+	} else {
+		return -EPERM;
+	}
+#else
+	/*
+	 * You can refer to arch/nds32/kernel/traps.c:__dump()
+	 * Treat "sp" as "fp", but the "sp" is one frame ahead of "fp".
+	 * And, the "sp" is not always correct.
+	 *
+	 *   Stack                                 Relative Address
+	 *   |  |                                          0
+	 *   ----
+	 *   |LP| <-- SP(before smw)                      -1
+	 *   ----
+	 *   |  | <-- SP(after smw)                       -2
+	 *   ----
+	 */
+	if (!kstack_end((void *)frame->sp)) {
+		frame->lp = ((unsigned long *)frame->sp)[1];
+		/* TODO: How to deal with the value in first
+		 * "sp" is not correct?
+		 */
+		if (__kernel_text_address(frame->lp))
+			frame->lp = ftrace_graph_ret_addr
+						(tsk, &graph, frame->lp, NULL);
+
+		frame->sp = ((unsigned long *)frame->sp) + 1;
+
+		return 0;
+	} else {
+		return -EPERM;
+	}
+#endif
+}
+
+static void notrace
+walk_stackframe(struct stackframe *frame,
+		int (*fn_record)(struct stackframe *, void *),
+		void *data)
+{
+	while (1) {
+		int ret;
+
+		if (fn_record(frame, data))
+			break;
+
+		ret = unwind_frame_kernel(frame);
+		if (ret < 0)
+			break;
+	}
+}
+
+/*
+ * Gets called by walk_stackframe() for every stackframe. This will be called
+ * whist unwinding the stackframe and is like a subroutine return so we use
+ * the PC.
+ */
+static int callchain_trace(struct stackframe *fr, void *data)
+{
+	struct perf_callchain_entry_ctx *entry = data;
+
+	perf_callchain_store(entry, fr->lp);
+	return 0;
+}
+
+/*
+ * Get the return address for a single stackframe and return a pointer to the
+ * next frame tail.
+ */
+static unsigned long
+user_backtrace(struct perf_callchain_entry_ctx *entry, unsigned long fp)
+{
+	struct frame_tail buftail;
+	unsigned long lp = 0;
+	unsigned long *user_frame_tail =
+		(unsigned long *)(fp - (unsigned long)sizeof(buftail));
+
+	/* Check accessibility of one struct frame_tail beyond */
+	if (!access_ok(VERIFY_READ, user_frame_tail, sizeof(buftail)))
+		return 0;
+	if (__copy_from_user_inatomic
+		(&buftail, user_frame_tail, sizeof(buftail)))
+		return 0;
+
+	/*
+	 * Refer to unwind_frame_kernel() for more illurstration
+	 */
+	lp = buftail.stack_lp;  /* ((unsigned long *)fp)[-1] */
+	fp = buftail.stack_fp;  /* ((unsigned long *)fp)[FP_OFFSET] */
+	perf_callchain_store(entry, lp);
+	return fp;
+}
+
+static unsigned long
+user_backtrace_opt_size(struct perf_callchain_entry_ctx *entry,
+			unsigned long fp)
+{
+	struct frame_tail_opt_size buftail;
+	unsigned long lp = 0;
+
+	unsigned long *user_frame_tail =
+		(unsigned long *)(fp - (unsigned long)sizeof(buftail));
+
+	/* Check accessibility of one struct frame_tail beyond */
+	if (!access_ok(VERIFY_READ, user_frame_tail, sizeof(buftail)))
+		return 0;
+	if (__copy_from_user_inatomic
+		(&buftail, user_frame_tail, sizeof(buftail)))
+		return 0;
+
+	/*
+	 * Refer to unwind_frame_kernel() for more illurstration
+	 */
+	lp = buftail.stack_lp;  /* ((unsigned long *)fp)[-1] */
+	fp = buftail.stack_fp;  /* ((unsigned long *)fp)[FP_OFFSET] */
+
+	perf_callchain_store(entry, lp);
+	return fp;
+}
+
+/*
+ * This will be called when the target is in user mode
+ * This function will only be called when we use
+ * "PERF_SAMPLE_CALLCHAIN" in
+ * kernel/events/core.c:perf_prepare_sample()
+ *
+ * How to trigger perf_callchain_[user/kernel] :
+ * $ perf record -e cpu-clock --call-graph fp ./program
+ * $ perf report --call-graph
+ */
+unsigned long leaf_fp;
+void
+perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+		    struct pt_regs *regs)
+{
+	unsigned long fp = 0;
+	unsigned long gp = 0;
+	unsigned long lp = 0;
+	unsigned long sp = 0;
+	unsigned long *user_frame_tail;
+
+	leaf_fp = 0;
+
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		/* We don't support guest os callchain now */
+		return;
+	}
+
+	perf_callchain_store(entry, regs->ipc);
+	fp = regs->fp;
+	gp = regs->gp;
+	lp = regs->lp;
+	sp = regs->sp;
+	if (entry->nr < PERF_MAX_STACK_DEPTH &&
+	    (unsigned long)fp && !((unsigned long)fp & 0x7) && fp > sp) {
+		user_frame_tail =
+			(unsigned long *)(fp - (unsigned long)sizeof(fp));
+
+		if (!access_ok(VERIFY_READ, user_frame_tail, sizeof(fp)))
+			return;
+
+		if (__copy_from_user_inatomic
+			(&leaf_fp, user_frame_tail, sizeof(fp)))
+			return;
+
+		if (leaf_fp == lp) {
+			/*
+			 * Maybe this is non leaf function
+			 * with optimize for size,
+			 * or maybe this is the function
+			 * with optimize for size
+			 */
+			struct frame_tail buftail;
+
+			user_frame_tail =
+				(unsigned long *)(fp -
+					(unsigned long)sizeof(buftail));
+
+			if (!access_ok
+				(VERIFY_READ, user_frame_tail, sizeof(buftail)))
+				return;
+
+			if (__copy_from_user_inatomic
+				(&buftail, user_frame_tail, sizeof(buftail)))
+				return;
+
+			if (buftail.stack_fp == gp) {
+				/* non leaf function with optimize
+				 * for size condition
+				 */
+				struct frame_tail_opt_size buftail_opt_size;
+
+				user_frame_tail =
+					(unsigned long *)(fp - (unsigned long)
+						sizeof(buftail_opt_size));
+
+				if (!access_ok(VERIFY_READ, user_frame_tail,
+					       sizeof(buftail_opt_size)))
+					return;
+
+				if (__copy_from_user_inatomic
+				   (&buftail_opt_size, user_frame_tail,
+				   sizeof(buftail_opt_size)))
+					return;
+
+				perf_callchain_store(entry, lp);
+				fp = buftail_opt_size.stack_fp;
+
+				while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
+				       (unsigned long)fp &&
+						!((unsigned long)fp & 0x7) &&
+						fp > sp) {
+					sp = fp;
+					fp = user_backtrace_opt_size(entry, fp);
+				}
+
+			} else {
+				/* this is the function
+				 * without optimize for size
+				 */
+				fp = buftail.stack_fp;
+				perf_callchain_store(entry, lp);
+				while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
+				       (unsigned long)fp &&
+						!((unsigned long)fp & 0x7) &&
+						fp > sp) {
+					sp = fp;
+					fp = user_backtrace(entry, fp);
+				}
+			}
+		} else {
+			/* this is leaf function */
+			fp = leaf_fp;
+			perf_callchain_store(entry, lp);
+
+			/* previous function callcahin  */
+			while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
+			       (unsigned long)fp &&
+				   !((unsigned long)fp & 0x7) && fp > sp) {
+				sp = fp;
+				fp = user_backtrace(entry, fp);
+			}
+		}
+		return;
+	}
+}
+
+/* This will be called when the target is in kernel mode */
+void
+perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
+		      struct pt_regs *regs)
+{
+	struct stackframe fr;
+
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		/* We don't support guest os callchain now */
+		return;
+	}
+	fr.fp = regs->fp;
+	fr.lp = regs->lp;
+	fr.sp = regs->sp;
+	walk_stackframe(&fr, callchain_trace, entry);
+}
+
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
 	/* However, NDS32 does not support virtualization */
-- 
2.17.0
