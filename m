From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 28/40] metag: Perf
Date: Wed, 31 Oct 2012 16:14:09 +0000
Message-ID: <1351700061-7203-29-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55171 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423205Ab2JaQPE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:15:04 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>

Add Perf support to Meta.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/Kconfig                  |    1 +
 arch/metag/include/asm/perf_event.h |    4 ++
 arch/metag/kernel/perf_callchain.c  |   96 +++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 arch/metag/include/asm/perf_event.h
 create mode 100644 arch/metag/kernel/perf_callchain.c

diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index 5141108..c7c84d1 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -9,6 +9,7 @@ config METAG
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_PERF_EVENTS
 	select HAVE_IRQ_WORK
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_BZIP2
diff --git a/arch/metag/include/asm/perf_event.h b/arch/metag/include/asm/perf_event.h
new file mode 100644
index 0000000..105bbff
--- /dev/null
+++ b/arch/metag/include/asm/perf_event.h
@@ -0,0 +1,4 @@
+#ifndef __ASM_METAG_PERF_EVENT_H
+#define __ASM_METAG_PERF_EVENT_H
+
+#endif /* __ASM_METAG_PERF_EVENT_H */
diff --git a/arch/metag/kernel/perf_callchain.c b/arch/metag/kernel/perf_callchain.c
new file mode 100644
index 0000000..3156334
--- /dev/null
+++ b/arch/metag/kernel/perf_callchain.c
@@ -0,0 +1,96 @@
+/*
+ * Perf callchain handling code.
+ *
+ *   Based on the ARM perf implementation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/perf_event.h>
+#include <linux/uaccess.h>
+#include <asm/ptrace.h>
+#include <asm/stacktrace.h>
+
+static bool is_valid_call(unsigned long calladdr)
+{
+	unsigned int callinsn;
+
+	/* Check the possible return address is aligned. */
+	if (!(calladdr & 0x3)) {
+		if (!get_user(callinsn, (unsigned int *)calladdr)) {
+			/* Check for CALLR or SWAP PC,D1RtP. */
+			if ((callinsn & 0xff000000) == 0xab000000 ||
+			    callinsn == 0xa3200aa0)
+				return true;
+		}
+	}
+	return false;
+}
+
+static struct metag_frame __user *
+user_backtrace(struct metag_frame __user *user_frame,
+	       struct perf_callchain_entry *entry)
+{
+	struct metag_frame frame;
+	unsigned long calladdr;
+
+	/* We cannot rely on having frame pointers in user code. */
+	while (1) {
+		/* Also check accessibility of one struct frame beyond */
+		if (!access_ok(VERIFY_READ, user_frame, sizeof(frame)))
+			return 0;
+		if (__copy_from_user_inatomic(&frame, user_frame,
+					      sizeof(frame)))
+			return 0;
+
+		--user_frame;
+
+		calladdr = frame.lr - 4;
+		if (is_valid_call(calladdr)) {
+			perf_callchain_store(entry, calladdr);
+			return user_frame;
+		}
+	}
+
+	return 0;
+}
+
+void
+perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
+{
+	unsigned long sp = regs->ctx.AX[0].U0;
+	struct metag_frame __user *frame;
+
+	frame = (struct metag_frame __user *)sp;
+
+	--frame;
+
+	while ((entry->nr < PERF_MAX_STACK_DEPTH) && frame)
+		frame = user_backtrace(frame, entry);
+}
+
+/*
+ * Gets called by walk_stackframe() for every stackframe. This will be called
+ * whist unwinding the stackframe and is like a subroutine return so we use
+ * the PC.
+ */
+static int
+callchain_trace(struct stackframe *fr,
+		void *data)
+{
+	struct perf_callchain_entry *entry = data;
+	perf_callchain_store(entry, fr->pc);
+	return 0;
+}
+
+void
+perf_callchain_kernel(struct perf_callchain_entry *entry, struct pt_regs *regs)
+{
+	struct stackframe fr;
+
+	fr.fp = regs->ctx.AX[1].U0;
+	fr.sp = regs->ctx.AX[0].U0;
+	fr.lr = regs->ctx.DX[4].U1;
+	fr.pc = regs->ctx.CurrPC;
+	walk_stackframe(&fr, callchain_trace, entry);
+}
-- 
1.7.7.6
