Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48576 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfBUNls (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Feb 2019 08:41:48 -0500
From: Mao Han <han_mao@c-sky.com>
Subject: [PATCH] csky: Add perf callchin support
Date: Thu, 21 Feb 2019 21:41:26 +0800
Message-ID: <20190221134126.930-1-han_mao@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: guoren@kernel.org, Mao Han <han_mao@c-sky.com>
Message-ID: <20190221134126.ruCTp9yGzRRdtZnF2QUm9AnI3Ka5iZAm5dPmyQa4lPI@z>

This patch add support for perf callchain sampling on csky platform.
As fp is used to unwind the stack, the program being sampled and the
C library need to be compiled with -mbacktrace for user callchains,
kernel callchains require CONFIG_STACKTRACE = y.

Signed-off-by: Mao Han <han_mao@c-sky.com>
---
 arch/csky/kernel/Makefile         |   1 +
 arch/csky/kernel/perf_callchain.c | 133 ++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 arch/csky/kernel/perf_callchain.c

diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 484e6d3a3..4c462f584 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SMP)			+= smp.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o
 obj-$(CONFIG_STACKTRACE)		+= stacktrace.o
 obj-$(CONFIG_CSKY_PMU_V1)		+= perf_event.o
+obj-$(CONFIG_PERF_EVENTS)		+= perf_callchain.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/csky/kernel/perf_callchain.c b/arch/csky/kernel/perf_callchain.c
new file mode 100644
index 000000000..0a7a546e9
--- /dev/null
+++ b/arch/csky/kernel/perf_callchain.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/perf_event.h>
+#include <linux/uaccess.h>
+
+/* Kernel callchain */
+struct stackframe {
+	unsigned long fp;
+	unsigned long lr;
+};
+
+static int
+unwind_frame_kernel(struct stackframe *frame)
+{
+	int graph = 0;
+
+	/* 0x3 means misalignment */
+	if (!kstack_end((void *)frame->fp) &&
+	    !((unsigned long)frame->fp & 0x3) &&
+	    ((unsigned long)frame->fp >= TASK_SIZE)) {
+		frame->lr = ((struct stackframe *)frame->fp)->lr;
+		frame->fp = ((struct stackframe *)frame->fp)->fp;
+		/* make sure CONFIG_FUNCTION_GRAPH_TRACER is turned on */
+		if (__kernel_text_address(frame->lr))
+			frame->lr = ftrace_graph_ret_addr
+						(NULL, &graph, frame->lr, NULL);
+		return 0;
+	} else {
+		return -EPERM;
+	}
+}
+
+static void notrace
+walk_stackframe(struct stackframe *fr,
+		struct perf_callchain_entry_ctx *entry)
+{
+	while (1) {
+		int ret;
+
+		perf_callchain_store(entry, fr->lr);
+
+		ret = unwind_frame_kernel(fr);
+		if (ret < 0)
+			break;
+	}
+}
+
+/*
+ * Get the return address for a single stackframe and return a pointer to the
+ * next frame tail.
+ */
+static unsigned long
+user_backtrace(struct perf_callchain_entry_ctx *entry, unsigned long fp,
+	       unsigned long reg_lr)
+{
+	struct stackframe buftail;
+	unsigned long lr = 0;
+	unsigned long *user_frame_tail = (unsigned long *)fp;
+
+	/* Check accessibility of one struct frame_tail beyond */
+	if (!access_ok(user_frame_tail, sizeof(buftail)))
+		return 0;
+	if (__copy_from_user_inatomic
+		(&buftail, user_frame_tail, sizeof(buftail)))
+		return 0;
+
+	if (reg_lr != 0) {
+		lr = reg_lr;
+	} else {
+		lr = buftail.lr;
+	}
+	fp = buftail.fp;
+	perf_callchain_store(entry, lr);
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
+ *
+ * On C-SKY platform, the program being sampled and the C library
+ * need to be compiled with * -mbacktrace, otherwise the user
+ * stack will not contain function frame.
+ */
+void
+perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+		    struct pt_regs *regs)
+{
+	unsigned long fp = 0;
+
+	/* C-SKY does not support virtualization. */
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		return;
+	}
+
+	fp = regs->regs[2];
+	perf_callchain_store(entry, regs->pc);
+	/*
+	 * While backtrace from leaf function, lr is normally
+	 * not saved inside frame on C-SKY, so get lr from pt_regs
+	 * at the sample point. However, lr value can be incorrect if
+	 * lr is used as temp register
+	 */
+	fp = user_backtrace(entry, fp, regs->lr);
+
+	while ((entry->nr < entry->max_stack) &&
+		fp && !((unsigned long)fp & 0x3))
+		fp = user_backtrace(entry, fp, 0);
+}
+
+void
+perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
+		      struct pt_regs *regs)
+{
+	struct stackframe fr;
+
+	/* C-SKY does not support virtualization. */
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		pr_warn("C-SKY does not support perf in guest mode!");
+		return;
+	}
+
+	fr.fp = regs->regs[4];
+	fr.lr = regs->lr;
+	walk_stackframe(&fr, entry);
+}
-- 
2.21.0.rc2
