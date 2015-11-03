From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 07/28] lkl: interrupt support
Date: Tue,  3 Nov 2015 22:20:38 +0200
Message-ID: <1446582059-17355-8-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Add APIs that allows the host to reserve and free and interrupt number
and also to trigger an interrupt.

The trigger operation will simply store the interrupt data in
queue. The interrupt handler is run later, at the first opportunity it
has to avoid races with any kernel threads.

Currently, interrupts are run on the first interrupt enable operation
if interrupts are disabled and if we are not already in interrupt
context.

When triggering an interrupt the host can also send a void pointer
that is going to be available to the handler routine via
get_irq_regs()->irq_data. This allows to easly create host <-> kernel
synchronous communication channels and is currently used by the system
call interface.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 arch/lkl/include/asm/irq.h             |  10 +++
 arch/lkl/include/uapi/asm/irq.h        |  37 ++++++++++
 arch/lkl/include/uapi/asm/sigcontext.h |   1 +
 arch/lkl/kernel/irq.c                  | 131 +++++++++++++++++++++++++++++++++
 4 files changed, 179 insertions(+)
 create mode 100644 arch/lkl/include/asm/irq.h
 create mode 100644 arch/lkl/include/uapi/asm/irq.h
 create mode 100644 arch/lkl/kernel/irq.c

diff --git a/arch/lkl/include/asm/irq.h b/arch/lkl/include/asm/irq.h
new file mode 100644
index 0000000..f4ceb5a
--- /dev/null
+++ b/arch/lkl/include/asm/irq.h
@@ -0,0 +1,10 @@
+#ifndef _ASM_LKL_IRQ_H
+#define _ASM_LKL_IRQ_H
+
+#define NR_IRQS		32
+
+void free_IRQ(void);
+
+#include <uapi/asm/irq.h>
+
+#endif
diff --git a/arch/lkl/include/uapi/asm/irq.h b/arch/lkl/include/uapi/asm/irq.h
new file mode 100644
index 0000000..a33f5c5
--- /dev/null
+++ b/arch/lkl/include/uapi/asm/irq.h
@@ -0,0 +1,37 @@
+#ifndef _ASM_UAPI_LKL_IRQ_H
+#define _ASM_UAPI_LKL_IRQ_H
+
+/**
+ * lkl_trigger_irq - generate an interrupt
+ *
+ * This function is used by the device host side to signal its Linux counterpart
+ * that some event happened.
+ *
+ * @irq - the irq number to signal
+ * @data - data to be passed to the irq handler; available via
+ * get_irq_regs()->irq_data
+ */
+int lkl_trigger_irq(int irq, void *data);
+
+/**
+ * lkl_get_free_irq - find and reserve a free IRQ number
+ *
+ * This function is called by the host device code to find an unused IRQ number
+ * and reserved it for its own use.
+ *
+ * @user - a string to identify the user
+ * @returns - and irq number that can be used by request_irq or an negative
+ * value in case of an error
+ */
+int lkl_get_free_irq(const char *user);
+
+/**
+ * lkl_put_irq - release an IRQ number previously obtained with lkl_get_free_irq
+ *
+ * @irq - irq number to release
+ * @user - string identifying the user; should be the same as the one passed to
+ * lkl_get_free_irq when the irq number was obtained
+ */
+void lkl_put_irq(int irq, const char *name);
+
+#endif
diff --git a/arch/lkl/include/uapi/asm/sigcontext.h b/arch/lkl/include/uapi/asm/sigcontext.h
index 99b2d53..77aba40 100644
--- a/arch/lkl/include/uapi/asm/sigcontext.h
+++ b/arch/lkl/include/uapi/asm/sigcontext.h
@@ -4,6 +4,7 @@
 #include <asm/ptrace.h>
 
 struct pt_regs {
+	void *irq_data;
 };
 
 struct sigcontext {
diff --git a/arch/lkl/kernel/irq.c b/arch/lkl/kernel/irq.c
new file mode 100644
index 0000000..9ff0e12
--- /dev/null
+++ b/arch/lkl/kernel/irq.c
@@ -0,0 +1,131 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/hardirq.h>
+#include <asm/irq_regs.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/tick.h>
+#include <asm/irqflags.h>
+#include <asm/host_ops.h>
+
+static bool irqs_enabled;
+
+#define MAX_IRQS	16
+static struct irq_info {
+	struct pt_regs regs[MAX_IRQS];
+	const char *user;
+	int count;
+} irqs[NR_IRQS];
+static void *irqs_lock;
+
+static void do_IRQ(int irq, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
+	generic_handle_irq(irq);
+	irq_exit();
+
+	set_irq_regs(old_regs);
+}
+
+int lkl_trigger_irq(int irq, void *data)
+{
+	struct pt_regs regs = {
+		.irq_data = data,
+	};
+	int ret = 0;
+
+	if (irq >= NR_IRQS)
+		return -EINVAL;
+
+	lkl_ops->sem_down(irqs_lock);
+	if (irqs[irq].count < MAX_IRQS) {
+		irqs[irq].regs[irqs[irq].count] = regs;
+		irqs[irq].count++;
+	} else {
+		ret = -EOVERFLOW;
+	}
+	lkl_ops->sem_up(irqs_lock);
+
+	wakeup_cpu();
+
+	return ret;
+}
+
+static void run_irqs(void)
+{
+	int i, j;
+
+	lkl_ops->sem_down(irqs_lock);
+	for (i = 0; i < NR_IRQS; i++) {
+		for (j = 0; j < irqs[i].count; j++)
+			do_IRQ(i, &irqs[i].regs[j]);
+		irqs[i].count = 0;
+	}
+	lkl_ops->sem_up(irqs_lock);
+}
+
+int show_interrupts(struct seq_file *p, void *v)
+{
+	return 0;
+}
+
+int lkl_get_free_irq(const char *user)
+{
+	int i;
+	int ret = -EBUSY;
+
+	/* 0 is not a valid IRQ */
+	for (i = 1; i < NR_IRQS; i++) {
+		if (!irqs[i].user) {
+			irqs[i].user = user;
+			ret = i;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+void lkl_put_irq(int i, const char *user)
+{
+	if (!irqs[i].user || strcmp(irqs[i].user, user) != 0) {
+		WARN("%s tried to release %s's irq %d", user, irqs[i].user, i);
+		return;
+	}
+
+	irqs[i].user = NULL;
+}
+
+unsigned long arch_local_save_flags(void)
+{
+	return irqs_enabled;
+}
+
+void arch_local_irq_restore(unsigned long flags)
+{
+	if (flags == ARCH_IRQ_ENABLED && irqs_enabled == ARCH_IRQ_DISABLED &&
+	    !in_interrupt())
+		run_irqs();
+	irqs_enabled = flags;
+}
+
+void free_IRQ(void)
+{
+	lkl_ops->sem_free(irqs_lock);
+}
+
+void init_IRQ(void)
+{
+	int i;
+
+	irqs_lock = lkl_ops->sem_alloc(1);
+	BUG_ON(!irqs_lock);
+
+	for (i = 0; i < NR_IRQS; i++)
+		irq_set_chip_and_handler(i, &dummy_irq_chip, handle_simple_irq);
+
+	pr_info("lkl: irqs initialized\n");
+}
-- 
2.1.0
