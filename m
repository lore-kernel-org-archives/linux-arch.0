Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:46745 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbBVGZ2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2015 01:25:28 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v5 12/15] h8300: clocksource
Date: Sun, 22 Feb 2015 15:25:17 +0900
Message-ID: <1424586320-3144-13-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1424586320-3144-1-git-send-email-ysato@users.sourceforge.jp>
References: <1424586320-3144-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150222062517.TAFoeRDBYhVRVlwSdoq_qJv43cE8DGuI1C5fQv0q4AQ@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/clocksource/Kconfig         |   6 +
 drivers/clocksource/Makefile        |   3 +
 drivers/clocksource/h8300_timer16.c | 332 ++++++++++++++++++++++++++++++
 drivers/clocksource/h8300_timer8.c  | 398 ++++++++++++++++++++++++++++++++++++
 drivers/clocksource/h8300_tpu.c     | 203 ++++++++++++++++++
 5 files changed, 942 insertions(+)
 create mode 100644 drivers/clocksource/h8300_timer16.c
 create mode 100644 drivers/clocksource/h8300_timer8.c
 create mode 100644 drivers/clocksource/h8300_tpu.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index fc01ec2..4116409 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -229,4 +229,10 @@ config CLKSRC_MIPS_GIC
 	depends on MIPS_GIC
 	select CLKSRC_OF
 
+config H8300_TMR16
+        bool
+
+config H8300_TPU
+        bool
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 94d90b2..18824ed 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -48,3 +48,6 @@ obj-$(CONFIG_ARCH_KEYSTONE)		+= timer-keystone.o
 obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
+obj-$(CONFIG_H8300)			+= h8300_timer8.o
+obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
+obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
new file mode 100644
index 0000000..bf6a74c
--- /dev/null
+++ b/drivers/clocksource/h8300_timer16.c
@@ -0,0 +1,332 @@
+/*
+ *  linux/arch/h8300/kernel/timer/timer16.c
+ *
+ *  Yoshinori Sato <ysato@users.sourcefoge.jp>
+ *
+ *  16bit Timer clockevent device
+ *
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/clockchips.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/segment.h>
+#include <asm/irq.h>
+#include <asm/timer.h>
+
+#define TSTR	0
+#define TSNC	1
+#define TMDR	2
+#define TOLR	3
+#define TISRA	4
+#define TISRB	5
+#define TISRC	6
+
+#define TCR	0
+#define TIOR	1
+#define TCNT	2
+#define GRA	4
+#define GRB	6
+
+#define FLAG_REPROGRAM (1 << 0)
+#define FLAG_SKIPEVENT (1 << 1)
+#define FLAG_IRQCONTEXT (1 << 2)
+#define FLAG_STARTED (1 << 3)
+
+#define ONESHOT  0
+#define PERIODIC 1
+
+#define RELATIVE 0
+#define ABSOLUTE 1
+
+struct timer16_priv {
+	struct platform_device *pdev;
+	struct clock_event_device ced;
+	struct irqaction irqaction;
+	unsigned long mapbase;
+	unsigned long mapcommon;
+	unsigned long flags;
+	unsigned int rate;
+	unsigned short gra;
+	unsigned char enb;
+	unsigned char imfa;
+	unsigned char imiea;
+	unsigned char ovf;
+	raw_spinlock_t lock;
+	struct clk *clk;
+};
+
+static unsigned long timer16_get_counter(struct timer16_priv *p)
+{
+	unsigned long v1, v2, v3;
+	int o1, o2;
+
+	o1 = ctrl_inb(p->mapcommon + TISRC) & p->ovf;
+
+	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
+	do {
+		o2 = o1;
+		v1 = ctrl_inw(p->mapbase + TCNT);
+		v2 = ctrl_inw(p->mapbase + TCNT);
+		v3 = ctrl_inw(p->mapbase + TCNT);
+		o1 = ctrl_inb(p->mapcommon + TISRC) & p->ovf;
+	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
+			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
+
+	v2 |= 0x10000;
+	return v2;
+}
+
+
+static irqreturn_t timer16_interrupt(int irq, void *dev_id)
+{
+	struct timer16_priv *p = (struct timer16_priv *)dev_id;
+
+	ctrl_outb(ctrl_inb(p->mapcommon + TISRA) & ~p->imfa,
+		  p->mapcommon + TISRA);
+
+	p->flags |= FLAG_IRQCONTEXT;
+	ctrl_outw(p->gra, p->mapbase + GRA);
+	if (!(p->flags & FLAG_SKIPEVENT)) {
+		if (p->ced.mode == CLOCK_EVT_MODE_ONESHOT) {
+			ctrl_outb(ctrl_inb(p->mapcommon + TSTR) & ~p->enb,
+				  p->mapcommon + TISRA);
+		}
+		p->ced.event_handler(&p->ced);
+	}
+
+	p->flags &= ~(FLAG_SKIPEVENT | FLAG_IRQCONTEXT);
+
+	return IRQ_HANDLED;
+}
+
+static void timer16_set_next(struct timer16_priv *p, unsigned long delta)
+{
+	unsigned long flags;
+	unsigned long now;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+	if (delta >= 0x10000)
+		dev_warn(&p->pdev->dev, "delta out of range\n");
+	now = timer16_get_counter(p);
+	p->gra = delta;
+	ctrl_outb(ctrl_inb(p->mapcommon + TISRA) | p->imiea,
+		  p->mapcommon + TISRA);
+	if (delta > now)
+		ctrl_outw(delta, p->mapbase + GRA);
+	else
+		ctrl_outw(now + 1, p->mapbase + GRA);
+
+	raw_spin_unlock_irqrestore(&p->lock, flags);
+}
+
+static int timer16_enable(struct timer16_priv *p)
+{
+	p->rate = clk_get_rate(p->clk) / 8;
+	ctrl_outw(0xffff, p->mapbase + GRA);
+	ctrl_outw(0x0000, p->mapbase + TCNT);
+	ctrl_outb(0xa3, p->mapbase + TCR);
+	ctrl_outb(ctrl_inb(p->mapcommon + TSTR) | p->enb,
+		  p->mapcommon + TSTR);
+
+	return 0;
+}
+
+static int timer16_start(struct timer16_priv *p)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+
+	if (!(p->flags & FLAG_STARTED))
+		ret = timer16_enable(p);
+
+	if (ret)
+		goto out;
+	p->flags |= FLAG_STARTED;
+
+ out:
+	raw_spin_unlock_irqrestore(&p->lock, flags);
+
+	return ret;
+}
+
+static void timer16_stop(struct timer16_priv *p)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+
+	ctrl_outb(ctrl_inb(p->mapcommon + TSTR) & ~p->enb,
+		  p->mapcommon + TSTR);
+
+	raw_spin_unlock_irqrestore(&p->lock, flags);
+}
+
+static inline struct timer16_priv *ced_to_priv(struct clock_event_device *ced)
+{
+	return container_of(ced, struct timer16_priv, ced);
+}
+
+static void timer16_clock_event_start(struct timer16_priv *p, int periodic)
+{
+	struct clock_event_device *ced = &p->ced;
+
+	timer16_start(p);
+
+	ced->shift = 32;
+	ced->mult = div_sc(p->rate, NSEC_PER_SEC, ced->shift);
+	ced->max_delta_ns = clockevent_delta2ns(0xffff, ced);
+	ced->min_delta_ns = clockevent_delta2ns(0x0001, ced);
+
+	timer16_set_next(p, periodic?(p->rate + HZ/2) / HZ:0x10000);
+}
+
+static void timer16_clock_event_mode(enum clock_event_mode mode,
+				    struct clock_event_device *ced)
+{
+	struct timer16_priv *p = ced_to_priv(ced);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		dev_info(&p->pdev->dev, "used for periodic clock events\n");
+		timer16_stop(p);
+		timer16_clock_event_start(p, PERIODIC);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		dev_info(&p->pdev->dev, "used for oneshot clock events\n");
+		timer16_stop(p);
+		timer16_clock_event_start(p, ONESHOT);
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		timer16_stop(p);
+		break;
+	default:
+		break;
+	}
+}
+
+static int timer16_clock_event_next(unsigned long delta,
+				   struct clock_event_device *ced)
+{
+	struct timer16_priv *p = ced_to_priv(ced);
+
+	BUG_ON(ced->mode != CLOCK_EVT_MODE_ONESHOT);
+	timer16_set_next(p, delta - 1);
+
+	return 0;
+}
+
+#define REG_CH   0
+#define REG_COMM 1
+
+static int timer16_setup(struct timer16_priv *p, struct platform_device *pdev)
+{
+	struct h8300_timer16_config *cfg = dev_get_platdata(&pdev->dev);
+	struct resource *res[2];
+	int ret, irq;
+
+	memset(p, 0, sizeof(*p));
+	p->pdev = pdev;
+
+	res[REG_CH] = platform_get_resource(p->pdev,
+					    IORESOURCE_MEM, REG_CH);
+	res[REG_COMM] = platform_get_resource(p->pdev,
+					      IORESOURCE_MEM, REG_COMM);
+	if (!res[REG_CH] || !res[REG_COMM]) {
+		dev_err(&p->pdev->dev, "failed to get I/O memory\n");
+		return -ENXIO;
+	}
+	irq = platform_get_irq(p->pdev, 0);
+	if (irq < 0) {
+		dev_err(&p->pdev->dev, "failed to get irq\n");
+		return irq;
+	}
+
+	p->clk = clk_get(&p->pdev->dev, "peripheral_clk");
+	if (IS_ERR(p->clk)) {
+		dev_err(&p->pdev->dev, "can't get clk\n");
+		return PTR_ERR(p->clk);
+	}
+
+	p->pdev = pdev;
+	p->mapbase = res[REG_CH]->start;
+	p->mapcommon = res[REG_COMM]->start;
+	p->enb = 1 << cfg->enb;
+	p->imfa = 1 << cfg->imfa;
+	p->imiea = 1 << cfg->imiea;
+	p->ced.name = pdev->name;
+	p->ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	p->ced.rating = 200;
+	p->ced.cpumask = cpumask_of(0);
+	p->ced.set_next_event = timer16_clock_event_next;
+	p->ced.set_mode = timer16_clock_event_mode;
+
+	ret = request_irq(irq, timer16_interrupt,
+			  IRQF_DISABLED | IRQF_TIMER, pdev->name, p);
+	if (ret < 0) {
+		dev_err(&p->pdev->dev, "failed to request irq %d\n", irq);
+		return ret;
+	}
+
+	clockevents_register_device(&p->ced);
+
+	return 0;
+}
+
+static int timer16_probe(struct platform_device *pdev)
+{
+	struct timer16_priv *p = platform_get_drvdata(pdev);
+
+	if (p) {
+		dev_info(&pdev->dev, "kept as earlytimer\n");
+		return 0;
+	}
+
+	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	return timer16_setup(p, pdev);
+}
+
+static int timer16_remove(struct platform_device *pdev)
+{
+	return -EBUSY;
+}
+
+static struct platform_driver timer16_driver = {
+	.probe		= timer16_probe,
+	.remove		= timer16_remove,
+	.driver		= {
+		.name	= "h8300h-16timer",
+	}
+};
+
+static int __init timer16_init(void)
+{
+	return platform_driver_register(&timer16_driver);
+}
+
+static void __exit timer16_exit(void)
+{
+	platform_driver_unregister(&timer16_driver);
+}
+
+subsys_initcall(timer16_init);
+module_exit(timer16_exit);
+MODULE_AUTHOR("Yoshinori Sato");
+MODULE_DESCRIPTION("H8/300H 16bit Timer Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
new file mode 100644
index 0000000..3d84b6c
--- /dev/null
+++ b/drivers/clocksource/h8300_timer8.c
@@ -0,0 +1,398 @@
+/*
+ *  linux/arch/h8300/kernel/cpu/timer/timer8.c
+ *
+ *  Yoshinori Sato <ysato@users.sourcefoge.jp>
+ *
+ *  8bit Timer driver
+ *
+ */
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/irq.h>
+#include <asm/timer.h>
+
+#define _8TCR	0
+#define _8TCSR	2
+#define TCORA	4
+#define TCORB	6
+#define _8TCNT	8
+
+#define FLAG_REPROGRAM (1 << 0)
+#define FLAG_SKIPEVENT (1 << 1)
+#define FLAG_IRQCONTEXT (1 << 2)
+#define FLAG_STARTED (1 << 3)
+
+#define ONESHOT  0
+#define PERIODIC 1
+
+#define RELATIVE 0
+#define ABSOLUTE 1
+
+struct timer8_priv {
+	struct platform_device *pdev;
+	int mode;
+	union {
+		struct clocksource cs;
+		struct clock_event_device ced;
+	} clk;
+	struct irqaction irqaction;
+	unsigned long mapbase;
+	raw_spinlock_t lock;
+	unsigned long total_cycles;
+	unsigned int cs_enabled;
+	unsigned long flags;
+	unsigned int rate;
+	unsigned short tcora;
+	unsigned short div;
+	struct clk *pclk;
+};
+
+static const int div_rate[] = {8, 64, 8192};
+
+static unsigned long timer8_get_counter(struct timer8_priv *p)
+{
+	unsigned long v1, v2, v3;
+	int o1, o2;
+
+	o1 = ctrl_inb(p->mapbase + _8TCSR) & 0x20;
+
+	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
+	do {
+		o2 = o1;
+		v1 = ctrl_inw(p->mapbase + _8TCNT);
+		v2 = ctrl_inw(p->mapbase + _8TCNT);
+		v3 = ctrl_inw(p->mapbase + _8TCNT);
+		o1 = ctrl_inb(p->mapbase + _8TCSR) & 0x20;
+	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
+			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
+
+	v2 |= o1 << 10;
+	return v2;
+}
+
+static irqreturn_t timer8_interrupt(int irq, void *dev_id)
+{
+	struct timer8_priv *p = dev_id;
+
+	switch (p->mode) {
+	case H8300_TMR8_CLKSRC:
+		ctrl_outb(ctrl_inb(p->mapbase + _8TCSR) & ~0x20,
+			  p->mapbase + _8TCSR);
+		p->total_cycles += 0x10000;
+		break;
+	case H8300_TMR8_CLKEVTDEV:
+		ctrl_outb(ctrl_inb(p->mapbase + _8TCSR) & ~0x40,
+			  p->mapbase + _8TCSR);
+		p->flags |= FLAG_IRQCONTEXT;
+		ctrl_outw(p->tcora, p->mapbase + TCORA);
+		if (!(p->flags & FLAG_SKIPEVENT)) {
+			if (p->clk.ced.mode == CLOCK_EVT_MODE_ONESHOT)
+				ctrl_outw(0x0000, p->mapbase + _8TCR);
+			p->clk.ced.event_handler(&p->clk.ced);
+		}
+		p->flags &= ~(FLAG_SKIPEVENT | FLAG_IRQCONTEXT);
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static inline struct timer8_priv *cs_to_priv(struct clocksource *cs)
+{
+	return container_of(cs, struct timer8_priv, clk.cs);
+}
+
+static cycle_t timer8_clocksource_read(struct clocksource *cs)
+{
+	struct timer8_priv *p = cs_to_priv(cs);
+	unsigned long flags, raw;
+	unsigned long value;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+	value = p->total_cycles;
+	raw = timer8_get_counter(p);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
+
+	return value + raw;
+}
+
+static int timer8_clocksource_enable(struct clocksource *cs)
+{
+	struct timer8_priv *p = cs_to_priv(cs);
+
+	WARN_ON(p->cs_enabled);
+
+	p->total_cycles = 0;
+	ctrl_outw(0, p->mapbase + _8TCNT);
+	ctrl_outw(0x2400 | p->div, p->mapbase + _8TCR);
+
+	p->cs_enabled = true;
+	return 0;
+}
+
+static void timer8_clocksource_disable(struct clocksource *cs)
+{
+	struct timer8_priv *p = cs_to_priv(cs);
+
+	WARN_ON(!p->cs_enabled);
+
+	ctrl_outb(0, p->mapbase + _8TCR);
+	p->cs_enabled = false;
+}
+
+static void timer8_set_next(struct timer8_priv *p, unsigned long delta)
+{
+	unsigned long flags;
+	unsigned long now;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+	if (delta >= 0x10000)
+		dev_warn(&p->pdev->dev, "delta out of range\n");
+	now = timer8_get_counter(p);
+	p->tcora = delta;
+	ctrl_outb(ctrl_inb(p->mapbase + _8TCR) | 0x40, p->mapbase + _8TCR);
+	if (delta > now)
+		ctrl_outw(delta, p->mapbase + TCORA);
+	else
+		ctrl_outw(now + 1, p->mapbase + TCORA);
+
+	raw_spin_unlock_irqrestore(&p->lock, flags);
+}
+
+static int timer8_enable(struct timer8_priv *p)
+{
+	p->rate = clk_get_rate(p->pclk) / div_rate[p->div];
+	ctrl_outw(0xffff, p->mapbase + TCORA);
+	ctrl_outw(0x0000, p->mapbase + _8TCNT);
+	ctrl_outw(0x0c01, p->mapbase + _8TCR);
+
+	return 0;
+}
+
+static int timer8_start(struct timer8_priv *p)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+
+	if (!(p->flags & FLAG_STARTED))
+		ret = timer8_enable(p);
+
+	if (ret)
+		goto out;
+	p->flags |= FLAG_STARTED;
+
+ out:
+	raw_spin_unlock_irqrestore(&p->lock, flags);
+
+	return ret;
+}
+
+static void timer8_stop(struct timer8_priv *p)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+
+	ctrl_outw(0x0000, p->mapbase + _8TCR);
+
+	raw_spin_unlock_irqrestore(&p->lock, flags);
+}
+
+static inline struct timer8_priv *ced_to_priv(struct clock_event_device *ced)
+{
+	return container_of(ced, struct timer8_priv, clk.ced);
+}
+
+static void timer8_clock_event_start(struct timer8_priv *p, int periodic)
+{
+	struct clock_event_device *ced = &p->clk.ced;
+
+	timer8_start(p);
+
+	ced->shift = 32;
+	ced->mult = div_sc(p->rate, NSEC_PER_SEC, ced->shift);
+	ced->max_delta_ns = clockevent_delta2ns(0xffff, ced);
+	ced->min_delta_ns = clockevent_delta2ns(0x0001, ced);
+
+	timer8_set_next(p, periodic?(p->rate + HZ/2) / HZ:0x10000);
+}
+
+static void timer8_clock_event_mode(enum clock_event_mode mode,
+				    struct clock_event_device *ced)
+{
+	struct timer8_priv *p = ced_to_priv(ced);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		dev_info(&p->pdev->dev, "used for periodic clock events\n");
+		timer8_stop(p);
+		timer8_clock_event_start(p, PERIODIC);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		dev_info(&p->pdev->dev, "used for oneshot clock events\n");
+		timer8_stop(p);
+		timer8_clock_event_start(p, ONESHOT);
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		timer8_stop(p);
+		break;
+	default:
+		break;
+	}
+}
+
+static int timer8_clock_event_next(unsigned long delta,
+				   struct clock_event_device *ced)
+{
+	struct timer8_priv *p = ced_to_priv(ced);
+
+	BUG_ON(ced->mode != CLOCK_EVT_MODE_ONESHOT);
+	timer8_set_next(p, delta - 1);
+
+	return 0;
+}
+
+#define CMI 0
+#define OVI 1
+static int __init timer8_setup(struct timer8_priv *p,
+			       struct platform_device *pdev)
+{
+	struct h8300_timer8_config *cfg = dev_get_platdata(&pdev->dev);
+	struct resource *res;
+	int irq[2];
+	int ret;
+
+	memset(p, 0, sizeof(*p));
+	p->pdev = pdev;
+
+	res = platform_get_resource(p->pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&p->pdev->dev, "failed to get I/O memory\n");
+		return -ENXIO;
+	}
+
+	irq[CMI] = platform_get_irq(p->pdev, CMI);
+	irq[OVI] = platform_get_irq(p->pdev, OVI);
+	if (irq[CMI] < 0 || irq[OVI] < 0) {
+		dev_err(&p->pdev->dev, "failed to get irq\n");
+		return -ENXIO;
+	}
+
+	p->mapbase = res->start;
+
+	p->irqaction.name = dev_name(&p->pdev->dev);
+	p->irqaction.handler = timer8_interrupt;
+	p->irqaction.dev_id = p;
+	p->irqaction.flags = IRQF_DISABLED | IRQF_TIMER;
+
+	p->mode = cfg->mode;
+	p->div = cfg->div;
+
+	p->pclk = clk_get(&p->pdev->dev, "peripheral_clk");
+	if (IS_ERR(p->pclk)) {
+		dev_err(&p->pdev->dev, "can't get clk\n");
+		return PTR_ERR(p->pclk);
+	}
+
+	switch (p->mode) {
+	case H8300_TMR8_CLKSRC:
+		p->clk.cs.name = pdev->name;
+		p->clk.cs.rating = 200;
+		p->clk.cs.read = timer8_clocksource_read;
+		p->clk.cs.enable = timer8_clocksource_enable;
+		p->clk.cs.disable = timer8_clocksource_disable;
+		p->clk.cs.mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
+		p->clk.cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+		ret = setup_irq(irq[OVI], &p->irqaction);
+		if (ret < 0) {
+			dev_err(&p->pdev->dev,
+				"failed to request irq %d\n", irq[OVI]);
+			return ret;
+		}
+		clocksource_register_hz(&p->clk.cs,
+					clk_get_rate(p->pclk) / div_rate[p->div]);
+		break;
+	case H8300_TMR8_CLKEVTDEV:
+		p->clk.ced.name = pdev->name;
+		p->clk.ced.features = CLOCK_EVT_FEAT_PERIODIC |
+					CLOCK_EVT_FEAT_ONESHOT;
+		p->clk.ced.rating = 200;
+		p->clk.ced.cpumask = cpumask_of(0);
+		p->clk.ced.set_next_event = timer8_clock_event_next;
+		p->clk.ced.set_mode = timer8_clock_event_mode;
+
+		ret = setup_irq(irq[CMI], &p->irqaction);
+		if (ret < 0) {
+			dev_err(&p->pdev->dev,
+				"failed to request irq %d\n", irq[CMI]);
+			return ret;
+		}
+		clockevents_register_device(&p->clk.ced);
+		break;
+	}
+	platform_set_drvdata(pdev, p);
+
+	return 0;
+}
+
+static int timer8_probe(struct platform_device *pdev)
+{
+	struct timer8_priv *p = platform_get_drvdata(pdev);
+
+	if (p) {
+		dev_info(&pdev->dev, "kept as earlytimer\n");
+		return 0;
+	}
+
+	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	return timer8_setup(p, pdev);
+}
+
+static int timer8_remove(struct platform_device *pdev)
+{
+	return -EBUSY;
+}
+
+static struct platform_driver timer8_driver = {
+	.probe		= timer8_probe,
+	.remove		= timer8_remove,
+	.driver		= {
+		.name	= "h8300-8timer",
+	}
+};
+
+static int __init timer8_init(void)
+{
+	return platform_driver_register(&timer8_driver);
+}
+
+static void __exit timer8_exit(void)
+{
+	platform_driver_unregister(&timer8_driver);
+}
+
+early_platform_init("earlytimer", &timer8_driver);
+subsys_initcall(timer8_init);
+module_exit(timer8_exit);
+MODULE_AUTHOR("Yoshinori Sato");
+MODULE_DESCRIPTION("H8/300 8bit Timer Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/h8300_tpu.c b/drivers/clocksource/h8300_tpu.c
new file mode 100644
index 0000000..1aae8a7
--- /dev/null
+++ b/drivers/clocksource/h8300_tpu.c
@@ -0,0 +1,203 @@
+/*
+ *  linux/arch/h8300/kernel/cpu/timer/timer_tpu.c
+ *
+ *  Yoshinori Sato <ysato@users.sourcefoge.jp>
+ *
+ *  TPU driver
+ *
+ */
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/clocksource.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/irq.h>
+#include <asm/timer.h>
+
+#define TCR	0
+#define TMDR	1
+#define TIOR	2
+#define TER	4
+#define TSR	5
+#define TCNT	6
+#define TGRA	8
+#define TGRB	10
+#define TGRC	12
+#define TGRD	14
+
+struct tpu_priv {
+	struct platform_device *pdev;
+	struct clocksource cs;
+	struct clk *clk;
+	unsigned long mapbase1;
+	unsigned long mapbase2;
+	raw_spinlock_t lock;
+	unsigned int cs_enabled;
+};
+
+static inline unsigned long read_tcnt32(struct tpu_priv *p)
+{
+	unsigned long tcnt;
+
+	tcnt = ctrl_inw(p->mapbase1 + TCNT) << 16;
+	tcnt |= ctrl_inw(p->mapbase2 + TCNT);
+	return tcnt;
+}
+
+static int tpu_get_counter(struct tpu_priv *p, unsigned long long *val)
+{
+	unsigned long v1, v2, v3;
+	int o1, o2;
+
+	o1 = ctrl_inb(p->mapbase1 + TSR) & 0x10;
+
+	/* Make sure the timer value is stable. Stolen from acpi_pm.c */
+	do {
+		o2 = o1;
+		v1 = read_tcnt32(p);
+		v2 = read_tcnt32(p);
+		v3 = read_tcnt32(p);
+		o1 = ctrl_inb(p->mapbase1 + TSR) & 0x10;
+	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
+			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
+
+	*val = v2;
+	return o1;
+}
+
+static inline struct tpu_priv *cs_to_priv(struct clocksource *cs)
+{
+	return container_of(cs, struct tpu_priv, cs);
+}
+
+static cycle_t tpu_clocksource_read(struct clocksource *cs)
+{
+	struct tpu_priv *p = cs_to_priv(cs);
+	unsigned long flags;
+	unsigned long long value;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+	if (tpu_get_counter(p, &value))
+		value += 0x100000000;
+	raw_spin_unlock_irqrestore(&p->lock, flags);
+
+	return value;
+}
+
+static int tpu_clocksource_enable(struct clocksource *cs)
+{
+	struct tpu_priv *p = cs_to_priv(cs);
+
+	WARN_ON(p->cs_enabled);
+
+	ctrl_outw(0, p->mapbase1 + TCNT);
+	ctrl_outw(0, p->mapbase2 + TCNT);
+	ctrl_outb(0x0f, p->mapbase1 + TCR);
+	ctrl_outb(0x03, p->mapbase2 + TCR);
+
+	p->cs_enabled = true;
+	return 0;
+}
+
+static void tpu_clocksource_disable(struct clocksource *cs)
+{
+	struct tpu_priv *p = cs_to_priv(cs);
+
+	WARN_ON(!p->cs_enabled);
+
+	ctrl_outb(0, p->mapbase1 + TCR);
+	ctrl_outb(0, p->mapbase2 + TCR);
+	p->cs_enabled = false;
+}
+
+#define CH_L 0
+#define CH_H 1
+
+static int __init tpu_setup(struct tpu_priv *p, struct platform_device *pdev)
+{
+	struct resource *res[2];
+
+	memset(p, 0, sizeof(*p));
+	p->pdev = pdev;
+
+	res[CH_L] = platform_get_resource(p->pdev, IORESOURCE_MEM, CH_L);
+	res[CH_H] = platform_get_resource(p->pdev, IORESOURCE_MEM, CH_H);
+	if (!res[CH_L] || !res[CH_H]) {
+		dev_err(&p->pdev->dev, "failed to get I/O memory\n");
+		return -ENXIO;
+	}
+
+	p->clk = clk_get(&p->pdev->dev, "peripheral_clk");
+	if (IS_ERR(p->clk)) {
+		dev_err(&p->pdev->dev, "can't get clk\n");
+		return PTR_ERR(p->clk);
+	}
+
+	p->mapbase1 = res[CH_L]->start;
+	p->mapbase2 = res[CH_H]->start;
+
+	p->cs.name = pdev->name;
+	p->cs.rating = 200;
+	p->cs.read = tpu_clocksource_read;
+	p->cs.enable = tpu_clocksource_enable;
+	p->cs.disable = tpu_clocksource_disable;
+	p->cs.mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
+	p->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	clocksource_register_hz(&p->cs, clk_get_rate(p->clk) / 64);
+	platform_set_drvdata(pdev, p);
+
+	return 0;
+}
+
+static int tpu_probe(struct platform_device *pdev)
+{
+	struct tpu_priv *p = platform_get_drvdata(pdev);
+
+	if (p) {
+		dev_info(&pdev->dev, "kept as earlytimer\n");
+		return 0;
+	}
+
+	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	return tpu_setup(p, pdev);
+}
+
+static int tpu_remove(struct platform_device *pdev)
+{
+	return -EBUSY;
+}
+
+static struct platform_driver tpu_driver = {
+	.probe		= tpu_probe,
+	.remove		= tpu_remove,
+	.driver		= {
+		.name	= "h8s-tpu",
+	}
+};
+
+static int __init tpu_init(void)
+{
+	return platform_driver_register(&tpu_driver);
+}
+
+static void __exit tpu_exit(void)
+{
+	platform_driver_unregister(&tpu_driver);
+}
+
+subsys_initcall(tpu_init);
+module_exit(tpu_exit);
+MODULE_AUTHOR("Yoshinori Sato");
+MODULE_DESCRIPTION("H8S Timer Pulse Unit Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

