From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 09/26] um lkl: timers, time and delay support
Date: Wed,  5 Feb 2020 16:30:18 +0900
Message-ID: <4b9ac9193575112b3f921e5f6087f114569e44d5.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35053 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBEHbI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:31:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id y73so753992pfg.2
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:31:06 -0800 (PST)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Michael Zimmermann <sigmaepsilon92@gmail.com>, Hajime Tazaki <thehajime@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

Clockevent driver based on host timer operations and clocksource
driver and udelay support based on host time operations.

Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/uapi/asm/host_ops.h |  13 +++
 arch/um/lkl/kernel/time.c               | 145 ++++++++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 arch/um/lkl/kernel/time.c

diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index 1c839d7139f8..c9f77dd7fbe7 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -48,6 +48,13 @@ struct lkl_jmp_buf {
  * @mem_alloc - allocate memory
  * @mem_free - free memory
  *
+ * @timer_create - allocate a host timer that runs fn(arg) when the timer
+ * fires.
+ * @timer_free - disarms and free the timer
+ * @timer_set_oneshot - arm the timer to fire once, after delta ns.
+ * @timer_set_periodic - arm the timer to fire periodically, with a period of
+ * delta ns.
+ *
  * @gettid - returns the host thread id of the caller, which need not
  * be the same as the handle returned by thread_create
  *
@@ -88,6 +95,12 @@ struct lkl_host_operations {
 	void *(*mem_alloc)(unsigned long mem);
 	void (*mem_free)(void *mem);
 
+	unsigned long long (*time)(void);
+
+	void *(*timer_alloc)(void (*fn)(void *), void *arg);
+	int (*timer_set_oneshot)(void *timer, unsigned long delta);
+	void (*timer_free)(void *timer);
+
 	long (*gettid)(void);
 
 	void (*jmp_buf_set)(struct lkl_jmp_buf *jmpb, void (*f)(void));
diff --git a/arch/um/lkl/kernel/time.c b/arch/um/lkl/kernel/time.c
new file mode 100644
index 000000000000..b8320e1bfa53
--- /dev/null
+++ b/arch/um/lkl/kernel/time.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <asm/host_ops.h>
+
+static unsigned long long boot_time;
+
+void __ndelay(unsigned long nsecs)
+{
+	unsigned long long start = lkl_ops->time();
+
+	while (lkl_ops->time() < start + nsecs)
+		;
+}
+
+void __udelay(unsigned long usecs)
+{
+	__ndelay(usecs * NSEC_PER_USEC);
+}
+
+void __const_udelay(unsigned long xloops)
+{
+	__udelay(xloops / 0x10c7ul);
+}
+
+void calibrate_delay(void)
+{
+}
+
+void read_persistent_clock(struct timespec *ts)
+{
+	*ts = ns_to_timespec(lkl_ops->time());
+}
+
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ *
+ */
+unsigned long long sched_clock(void)
+{
+	if (!boot_time)
+		return 0;
+
+	return lkl_ops->time() - boot_time;
+}
+
+static u64 clock_read(struct clocksource *cs)
+{
+	return lkl_ops->time();
+}
+
+static struct clocksource clocksource = {
+	.name	= "lkl",
+	.rating = 499,
+	.read	= clock_read,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.mask	= CLOCKSOURCE_MASK(64),
+};
+
+static void *timer;
+
+static int timer_irq;
+
+static void timer_fn(void *arg)
+{
+	lkl_trigger_irq(timer_irq);
+}
+
+static int clockevent_set_state_shutdown(struct clock_event_device *evt)
+{
+	if (timer) {
+		lkl_ops->timer_free(timer);
+		timer = NULL;
+	}
+
+	return 0;
+}
+
+static int clockevent_set_state_oneshot(struct clock_event_device *evt)
+{
+	timer = lkl_ops->timer_alloc(timer_fn, NULL);
+	if (!timer)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static irqreturn_t timer_irq_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *dev = (struct clock_event_device *)dev_id;
+
+	dev->event_handler(dev);
+
+	return IRQ_HANDLED;
+}
+
+static int clockevent_next_event(unsigned long ns,
+				 struct clock_event_device *evt)
+{
+	return lkl_ops->timer_set_oneshot(timer, ns);
+}
+
+static struct clock_event_device clockevent = {
+	.name			= "lkl",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_oneshot	= clockevent_set_state_oneshot,
+	.set_next_event		= clockevent_next_event,
+	.set_state_shutdown	= clockevent_set_state_shutdown,
+};
+
+static struct irqaction irq0  = {
+	.handler	= timer_irq_handler,
+	.flags		= IRQF_NOBALANCING | IRQF_TIMER,
+	.dev_id		= &clockevent,
+	.name		= "timer"
+};
+
+void __init time_init(void)
+{
+	int ret;
+
+	if (!lkl_ops->timer_alloc || !lkl_ops->timer_free ||
+	    !lkl_ops->timer_set_oneshot || !lkl_ops->time) {
+		pr_err("lkl: no time or timer support provided by host\n");
+		return;
+	}
+
+	timer_irq = lkl_get_free_irq("timer");
+	setup_irq(timer_irq, &irq0);
+
+	ret = clocksource_register_khz(&clocksource, 1000000);
+	if (ret)
+		pr_err("lkl: unable to register clocksource\n");
+
+	clockevents_config_and_register(&clockevent, NSEC_PER_SEC, 1,
+					ULONG_MAX);
+
+	boot_time = lkl_ops->time();
+	pr_info("lkl: time and timers initialized (irq%d)\n", timer_irq);
+}
-- 
2.21.0 (Apple Git-122.2)
