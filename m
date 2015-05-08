From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v11 18/19] h8300: clocksource
Date: Sat,  9 May 2015 00:04:38 +0900
Message-ID: <1431097479-21101-19-git-send-email-ysato@users.sourceforge.jp>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:14409 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbbEHPE4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2015 11:04:56 -0400
In-Reply-To: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

h8300_timer8: 8bit clockevent device
h8300_timer16 / h8300_tpu: 16bit clocksource

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/timer/renesas,16bit-timer.txt         |  25 ++
 .../bindings/timer/renesas,8bit-timer.txt          |  25 ++
 .../devicetree/bindings/timer/renesas,tpu.txt      |  21 ++
 drivers/clocksource/Kconfig                        |   7 +
 drivers/clocksource/Makefile                       |   3 +
 drivers/clocksource/h8300_timer16.c                | 254 +++++++++++++++++
 drivers/clocksource/h8300_timer8.c                 | 313 +++++++++++++++++++++
 drivers/clocksource/h8300_tpu.c                    | 207 ++++++++++++++
 8 files changed, 855 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,16bit-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,8bit-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.txt
 create mode 100644 drivers/clocksource/h8300_timer16.c
 create mode 100644 drivers/clocksource/h8300_timer8.c
 create mode 100644 drivers/clocksource/h8300_tpu.c

diff --git a/Documentation/devicetree/bindings/timer/renesas,16bit-timer.txt b/Documentation/devicetree/bindings/timer/renesas,16bit-timer.txt
new file mode 100644
index 0000000..e879244
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,16bit-timer.txt
@@ -0,0 +1,25 @@
+* Renesas H8/300 16bit timer
+
+The 16bit timer is a 16bit timer/counter with configurable clock inputs and
+programmable compare match.
+
+Required Properties:
+
+  - compatible: must contain "renesas,16bit-timer"
+  - reg: base address and length of the registers block for the timer module.
+  - interrupts: interrupt-specifier for the timer, IMIA
+  - clocks: a list of phandle, one for each entry in clock-names.
+  - clock-names: must contain "peripheral_clk" for the functional clock.
+  - renesas,channel: timer channel number.
+
+Example:
+
+	timer16: timer@ffff68 {
+		compatible = "reneas,16bit-timer";
+		reg = <0xffff68 8>, <0xffff60 8>;
+		interrupts = <24>;
+		renesas,channel = <0>;
+		clocks = <&pclk>;
+		clock-names = "peripheral_clk";
+	};
+
diff --git a/Documentation/devicetree/bindings/timer/renesas,8bit-timer.txt b/Documentation/devicetree/bindings/timer/renesas,8bit-timer.txt
new file mode 100644
index 0000000..9dca375
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,8bit-timer.txt
@@ -0,0 +1,25 @@
+* Renesas H8/300 8bit timer
+
+The 8bit timer is a 8bit timer/counter with configurable clock inputs and
+programmable compare match.
+
+This implement only supported cascade mode.
+
+Required Properties:
+
+  - compatible: must contain "renesas,8bit-timer"
+  - reg: base address and length of the registers block for the timer module.
+  - interrupts: interrupt-specifier for the timer, CMIA and TOVI
+  - clocks: a list of phandle, one for each entry in clock-names.
+  - clock-names: must contain "fck" for the functional clock.
+
+Example:
+
+	timer8_0: timer@ffff80 {
+		compatible = "renesas,8bit-timer";
+		reg = <0xffff80 10>;
+		interrupts = <36>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+
diff --git a/Documentation/devicetree/bindings/timer/renesas,tpu.txt b/Documentation/devicetree/bindings/timer/renesas,tpu.txt
new file mode 100644
index 0000000..f8b2589
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,tpu.txt
@@ -0,0 +1,21 @@
+* Renesas H8/300 Timer Pluse Unit
+
+The TPU is a 16bit timer/counter with configurable clock inputs and
+programmable compare match.
+This implementation support only cascade mode.
+
+Required Properties:
+
+  - compatible: must contain "renesas,tpu"
+  - reg: base address and length of the registers block in 2 channel.
+  - clocks: a list of phandle, one for each entry in clock-names.
+  - clock-names: must contain "peripheral_clk" for the functional clock.
+
+
+Example:
+	tpu: tpu@ffffe0 {
+		compatible = "renesas,tpu";
+		reg = <0xffffe0 16>, <0xfffff0 12>;
+		clocks = <&pclk>;
+		clock-names = "peripheral_clk";
+	};
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 51d7865f..acce7cf 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -258,4 +258,11 @@ config CLKSRC_PXA
 	help
 	  This enables OST0 support available on PXA and SA-11x0
 	  platforms.
+
+config H8300_TMR16
+        bool
+
+config H8300_TPU
+        bool
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5b85f6a..8288c4e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -52,3 +52,6 @@ obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
+obj-$(CONFIG_H8300)			+= h8300_timer8.o
+obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
+obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
new file mode 100644
index 0000000..82941c1
--- /dev/null
+++ b/drivers/clocksource/h8300_timer16.c
@@ -0,0 +1,254 @@
+/*
+ *  H8/300 16bit Timer driver
+ *
+ *  Copyright 2015 Yoshinori Sato <ysato@users.sourcefoge.jp>
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
+#include <linux/clocksource.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#include <asm/segment.h>
+#include <asm/irq.h>
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
+	struct clocksource cs;
+	struct irqaction irqaction;
+	unsigned long total_cycles;
+	unsigned long mapbase;
+	unsigned long mapcommon;
+	unsigned long flags;
+	unsigned short gra;
+	unsigned short cs_enabled;
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
+	p->total_cycles += 0x10000;
+
+	return IRQ_HANDLED;
+}
+
+static inline struct timer16_priv *cs_to_priv(struct clocksource *cs)
+{
+	return container_of(cs, struct timer16_priv, cs);
+}
+
+static cycle_t timer16_clocksource_read(struct clocksource *cs)
+{
+	struct timer16_priv *p = cs_to_priv(cs);
+	unsigned long flags, raw;
+	unsigned long value;
+
+	raw_spin_lock_irqsave(&p->lock, flags);
+	value = p->total_cycles;
+	raw = timer16_get_counter(p);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
+
+	return value + raw;
+}
+
+static int timer16_enable(struct clocksource *cs)
+{
+	struct timer16_priv *p = cs_to_priv(cs);
+
+	WARN_ON(p->cs_enabled);
+
+	p->total_cycles = 0;
+	ctrl_outw(0x0000, p->mapbase + TCNT);
+	ctrl_outb(0x83, p->mapbase + TCR);
+	ctrl_outb(ctrl_inb(p->mapcommon + TSTR) | p->enb,
+		  p->mapcommon + TSTR);
+
+	p->cs_enabled = true;
+	return 0;
+}
+
+static void timer16_disable(struct clocksource *cs)
+{
+	struct timer16_priv *p = cs_to_priv(cs);
+
+	WARN_ON(!p->cs_enabled);
+
+	ctrl_outb(ctrl_inb(p->mapcommon + TSTR) & ~p->enb,
+		  p->mapcommon + TSTR);
+
+	p->cs_enabled = false;
+}
+
+#define REG_CH   0
+#define REG_COMM 1
+
+static int timer16_setup(struct timer16_priv *p, struct platform_device *pdev)
+{
+	struct resource *res[2];
+	int ret, irq;
+	unsigned int ch;
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
+	p->clk = clk_get(&p->pdev->dev, "fck");
+	if (IS_ERR(p->clk)) {
+		dev_err(&p->pdev->dev, "can't get clk\n");
+		return PTR_ERR(p->clk);
+	}
+	of_property_read_u32(p->pdev->dev.of_node, "renesas,channel", &ch);
+
+	p->pdev = pdev;
+	p->mapbase = res[REG_CH]->start;
+	p->mapcommon = res[REG_COMM]->start;
+	p->enb = 1 << ch;
+	p->imfa = 1 << ch;
+	p->imiea = 1 << (4 + ch);
+	p->cs.name = pdev->name;
+	p->cs.rating = 200;
+	p->cs.read = timer16_clocksource_read;
+	p->cs.enable = timer16_enable;
+	p->cs.disable = timer16_disable;
+	p->cs.mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
+	p->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	ret = request_irq(irq, timer16_interrupt,
+			  IRQF_TIMER, pdev->name, p);
+	if (ret < 0) {
+		dev_err(&p->pdev->dev, "failed to request irq %d\n", irq);
+		return ret;
+	}
+
+	clocksource_register_hz(&p->cs, clk_get_rate(p->clk) / 8);
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
+static const struct of_device_id timer16_of_table[] = {
+	{ .compatible = "renesas,16bit-timer" },
+	{ }
+};
+static struct platform_driver timer16_driver = {
+	.probe		= timer16_probe,
+	.remove		= timer16_remove,
+	.driver		= {
+		.name	= "h8300h-16timer",
+		.of_match_table = of_match_ptr(timer16_of_table),
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
index 0000000..1c6f8b9
--- /dev/null
+++ b/drivers/clocksource/h8300_timer8.c
@@ -0,0 +1,313 @@
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
+#include <linux/clockchips.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#include <asm/irq.h>
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
+	struct clock_event_device ced;
+	struct irqaction irqaction;
+	unsigned long mapbase;
+	raw_spinlock_t lock;
+	unsigned long flags;
+	unsigned int rate;
+	unsigned int tcora;
+	struct clk *pclk;
+};
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
+	ctrl_outb(ctrl_inb(p->mapbase + _8TCSR) & ~0x40,
+		  p->mapbase + _8TCSR);
+	p->flags |= FLAG_IRQCONTEXT;
+	ctrl_outw(p->tcora, p->mapbase + TCORA);
+	if (!(p->flags & FLAG_SKIPEVENT)) {
+		if (p->ced.mode == CLOCK_EVT_MODE_ONESHOT)
+			ctrl_outw(0x0000, p->mapbase + _8TCR);
+		p->ced.event_handler(&p->ced);
+	}
+	p->flags &= ~(FLAG_SKIPEVENT | FLAG_IRQCONTEXT);
+
+	return IRQ_HANDLED;
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
+	p->rate = clk_get_rate(p->pclk) / 64;
+	ctrl_outw(0xffff, p->mapbase + TCORA);
+	ctrl_outw(0x0000, p->mapbase + _8TCNT);
+	ctrl_outw(0x0c02, p->mapbase + _8TCR);
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
+	return container_of(ced, struct timer8_priv, ced);
+}
+
+static void timer8_clock_event_start(struct timer8_priv *p, int periodic)
+{
+	struct clock_event_device *ced = &p->ced;
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
+static int timer8_setup(struct timer8_priv *p,
+			struct platform_device *pdev)
+{
+	struct resource *res;
+	int irq;
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
+	irq = platform_get_irq(p->pdev, 0);
+	if (irq < 0) {
+		dev_err(&p->pdev->dev, "failed to get irq\n");
+		return -ENXIO;
+	}
+
+	p->mapbase = res->start;
+
+	p->irqaction.name = dev_name(&p->pdev->dev);
+	p->irqaction.handler = timer8_interrupt;
+	p->irqaction.dev_id = p;
+	p->irqaction.flags = IRQF_TIMER;
+
+	p->pclk = clk_get(&p->pdev->dev, "fck");
+	if (IS_ERR(p->pclk)) {
+		dev_err(&p->pdev->dev, "can't get clk\n");
+		return PTR_ERR(p->pclk);
+	}
+
+	p->ced.name = pdev->name;
+	p->ced.features = CLOCK_EVT_FEAT_PERIODIC |
+		CLOCK_EVT_FEAT_ONESHOT;
+	p->ced.rating = 200;
+	p->ced.cpumask = cpumask_of(0);
+	p->ced.set_next_event = timer8_clock_event_next;
+	p->ced.set_mode = timer8_clock_event_mode;
+
+	ret = setup_irq(irq, &p->irqaction);
+	if (ret < 0) {
+		dev_err(&p->pdev->dev,
+			"failed to request irq %d\n", irq);
+		return ret;
+	}
+	clockevents_register_device(&p->ced);
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
+static const struct of_device_id timer8_of_table[] __maybe_unused = {
+	{ .compatible = "renesas,8bit-timer" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
+static struct platform_driver timer8_driver = {
+	.probe		= timer8_probe,
+	.remove		= timer8_remove,
+	.driver		= {
+		.name	= "h8300-8timer",
+		.of_match_table = of_match_ptr(timer8_of_table),
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
+subsys_initcall(timer8_init);
+module_exit(timer8_exit);
+MODULE_AUTHOR("Yoshinori Sato");
+MODULE_DESCRIPTION("H8/300 8bit Timer Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/h8300_tpu.c b/drivers/clocksource/h8300_tpu.c
new file mode 100644
index 0000000..64195fd
--- /dev/null
+++ b/drivers/clocksource/h8300_tpu.c
@@ -0,0 +1,207 @@
+/*
+ *  H8/300 TPU Driver
+ *
+ *  Copyright 2015 Yoshinori Sato <ysato@users.sourcefoge.jp>
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
+#include <linux/of.h>
+
+#include <asm/irq.h>
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
+	p->clk = clk_get(&p->pdev->dev, "fck");
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
+static const struct of_device_id tpu_of_table[] = {
+	{ .compatible = "renesas,tpu" },
+	{ }
+};
+
+static struct platform_driver tpu_driver = {
+	.probe		= tpu_probe,
+	.remove		= tpu_remove,
+	.driver		= {
+		.name	= "h8s-tpu",
+		.of_match_table = of_match_ptr(tpu_of_table),
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
