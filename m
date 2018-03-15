Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:14784
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751928AbeCOLCM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 07:02:12 -0400
From: Aaron Wu <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 25/28] staging: Remove Blackfin iio trigger timer support
Date: Thu, 15 Mar 2018 18:50:25 +0800
Message-ID: <1521111028-19856-25-git-send-email-aaron.wu@analog.com>
In-Reply-To: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, f.fainelli@gmail.com, linux-arch@vger.kernel.org, kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, liqin.linux@gmail.com, lennox.wu@gmail.com, gxt@mprc.pku.edu.cn, linux@roeck-us.net
Cc: viro@zeniv.linux.org.uk, jhogan@kernel.org, linux-metag@vger.kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, openrisc@lists.librecores.org, dhowells@redhat.com, peterz@infradead.org, aaron.wu@analog.com

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin iio trigger timer support
---
 drivers/staging/iio/Kconfig                       |   1 -
 drivers/staging/iio/Makefile                      |   1 -
 drivers/staging/iio/trigger/Kconfig               |  19 --
 drivers/staging/iio/trigger/Makefile              |   5 -
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 292 ----------------------
 drivers/staging/iio/trigger/iio-trig-bfin-timer.h |  25 --
 6 files changed, 343 deletions(-)
 delete mode 100644 drivers/staging/iio/trigger/Kconfig
 delete mode 100644 drivers/staging/iio/trigger/Makefile
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.h

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 8abc1ab..bd94459 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -14,6 +14,5 @@ source "drivers/staging/iio/impedance-analyzer/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
 source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/resolver/Kconfig"
-source "drivers/staging/iio/trigger/Kconfig"
 
 endmenu
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 455bffc..e99a375 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -13,4 +13,3 @@ obj-y += impedance-analyzer/
 obj-y += light/
 obj-y += meter/
 obj-y += resolver/
-obj-y += trigger/
diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
deleted file mode 100644
index 0b01d24..0000000
--- a/drivers/staging/iio/trigger/Kconfig
+++ /dev/null
@@ -1,19 +0,0 @@
-  #
-# Industrial I/O standalone triggers
-#
-comment "Triggers - standalone"
-
-if IIO_TRIGGER
-
-config IIO_BFIN_TMR_TRIGGER
-	tristate "Blackfin TIMER trigger"
-	depends on BLACKFIN
-	select BFIN_GPTIMERS
-	help
-	  Provides support for using a Blackfin timer as IIO triggers.
-	  If unsure, say N (but it's safe to say "Y").
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called iio-trig-bfin-timer.
-
-endif # IIO_TRIGGER
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
deleted file mode 100644
index 1300a21..0000000
--- a/drivers/staging/iio/trigger/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Makefile for triggers not associated with iio-devices
-#
-
-obj-$(CONFIG_IIO_BFIN_TMR_TRIGGER) += iio-trig-bfin-timer.o
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
deleted file mode 100644
index 71f11d7..0000000
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ /dev/null
@@ -1,292 +0,0 @@
-/*
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
-
-#include <asm/gptimers.h>
-#include <asm/portmux.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/trigger.h>
-
-#include "iio-trig-bfin-timer.h"
-
-struct bfin_timer {
-	unsigned short id, bit;
-	unsigned long irqbit;
-	int irq;
-	int pin;
-};
-
-/*
- * this covers all hardware timer configurations on
- * all Blackfin derivatives out there today
- */
-
-static struct bfin_timer iio_bfin_timer_code[MAX_BLACKFIN_GPTIMERS] = {
-	{TIMER0_id,  TIMER0bit,  TIMER_STATUS_TIMIL0,  IRQ_TIMER0, P_TMR0},
-	{TIMER1_id,  TIMER1bit,  TIMER_STATUS_TIMIL1,  IRQ_TIMER1, P_TMR1},
-	{TIMER2_id,  TIMER2bit,  TIMER_STATUS_TIMIL2,  IRQ_TIMER2, P_TMR2},
-#if (MAX_BLACKFIN_GPTIMERS > 3)
-	{TIMER3_id,  TIMER3bit,  TIMER_STATUS_TIMIL3,  IRQ_TIMER3, P_TMR3},
-	{TIMER4_id,  TIMER4bit,  TIMER_STATUS_TIMIL4,  IRQ_TIMER4, P_TMR4},
-	{TIMER5_id,  TIMER5bit,  TIMER_STATUS_TIMIL5,  IRQ_TIMER5, P_TMR5},
-	{TIMER6_id,  TIMER6bit,  TIMER_STATUS_TIMIL6,  IRQ_TIMER6, P_TMR6},
-	{TIMER7_id,  TIMER7bit,  TIMER_STATUS_TIMIL7,  IRQ_TIMER7, P_TMR7},
-#endif
-#if (MAX_BLACKFIN_GPTIMERS > 8)
-	{TIMER8_id,  TIMER8bit,  TIMER_STATUS_TIMIL8,  IRQ_TIMER8, P_TMR8},
-	{TIMER9_id,  TIMER9bit,  TIMER_STATUS_TIMIL9,  IRQ_TIMER9, P_TMR9},
-	{TIMER10_id, TIMER10bit, TIMER_STATUS_TIMIL10, IRQ_TIMER10, P_TMR10},
-#if (MAX_BLACKFIN_GPTIMERS > 11)
-	{TIMER11_id, TIMER11bit, TIMER_STATUS_TIMIL11, IRQ_TIMER11, P_TMR11},
-#endif
-#endif
-};
-
-struct bfin_tmr_state {
-	struct iio_trigger	*trig;
-	struct bfin_timer	*t;
-	unsigned int		timer_num;
-	bool			output_enable;
-	unsigned int		duty;
-	int			irq;
-};
-
-static int iio_bfin_tmr_set_state(struct iio_trigger *trig, bool state)
-{
-	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
-
-	if (get_gptimer_period(st->t->id) == 0)
-		return -EINVAL;
-
-	if (state)
-		enable_gptimers(st->t->bit);
-	else
-		disable_gptimers(st->t->bit);
-
-	return 0;
-}
-
-static ssize_t frequency_store(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
-{
-	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
-	unsigned int val;
-	bool enabled;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	if (val > 100000)
-		return -EINVAL;
-
-	enabled = get_enabled_gptimers() & st->t->bit;
-
-	if (enabled)
-		disable_gptimers(st->t->bit);
-
-	if (!val)
-		return count;
-
-	val = get_sclk() / val;
-	if (val <= 4 || val <= st->duty)
-		return -EINVAL;
-
-	set_gptimer_period(st->t->id, val);
-	set_gptimer_pwidth(st->t->id, val - st->duty);
-
-	if (enabled)
-		enable_gptimers(st->t->bit);
-
-	return count;
-}
-
-static ssize_t frequency_show(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
-	unsigned int period = get_gptimer_period(st->t->id);
-	unsigned long val;
-
-	if (!period)
-		val = 0;
-	else
-		val = get_sclk() / get_gptimer_period(st->t->id);
-
-	return sprintf(buf, "%lu\n", val);
-}
-
-static DEVICE_ATTR_RW(frequency);
-
-static struct attribute *iio_bfin_tmr_trigger_attrs[] = {
-	&dev_attr_frequency.attr,
-	NULL,
-};
-
-static const struct attribute_group iio_bfin_tmr_trigger_attr_group = {
-	.attrs = iio_bfin_tmr_trigger_attrs,
-};
-
-static const struct attribute_group *iio_bfin_tmr_trigger_attr_groups[] = {
-	&iio_bfin_tmr_trigger_attr_group,
-	NULL
-};
-
-static irqreturn_t iio_bfin_tmr_trigger_isr(int irq, void *devid)
-{
-	struct bfin_tmr_state *st = devid;
-
-	clear_gptimer_intr(st->t->id);
-	iio_trigger_poll(st->trig);
-
-	return IRQ_HANDLED;
-}
-
-static int iio_bfin_tmr_get_number(int irq)
-{
-	int i;
-
-	for (i = 0; i < MAX_BLACKFIN_GPTIMERS; i++)
-		if (iio_bfin_timer_code[i].irq == irq)
-			return i;
-
-	return -ENODEV;
-}
-
-static const struct iio_trigger_ops iio_bfin_tmr_trigger_ops = {
-	.set_trigger_state = iio_bfin_tmr_set_state,
-};
-
-static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
-{
-	struct iio_bfin_timer_trigger_pdata *pdata;
-	struct bfin_tmr_state *st;
-	unsigned int config;
-	int ret;
-
-	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
-	if (!st)
-		return -ENOMEM;
-
-	st->irq = platform_get_irq(pdev, 0);
-	if (st->irq < 0) {
-		dev_err(&pdev->dev, "No IRQs specified");
-		return st->irq;
-	}
-
-	ret = iio_bfin_tmr_get_number(st->irq);
-	if (ret < 0)
-		return ret;
-
-	st->timer_num = ret;
-	st->t = &iio_bfin_timer_code[st->timer_num];
-
-	st->trig = iio_trigger_alloc("bfintmr%d", st->timer_num);
-	if (!st->trig)
-		return -ENOMEM;
-
-	st->trig->ops = &iio_bfin_tmr_trigger_ops;
-	st->trig->dev.groups = iio_bfin_tmr_trigger_attr_groups;
-	iio_trigger_set_drvdata(st->trig, st);
-	ret = iio_trigger_register(st->trig);
-	if (ret)
-		goto out;
-
-	ret = request_irq(st->irq, iio_bfin_tmr_trigger_isr,
-			  0, st->trig->name, st);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"request IRQ-%d failed", st->irq);
-		goto out1;
-	}
-
-	config = PWM_OUT | PERIOD_CNT | IRQ_ENA;
-
-	pdata =	dev_get_platdata(&pdev->dev);
-	if (pdata && pdata->output_enable) {
-		unsigned long long val;
-
-		st->output_enable = true;
-
-		ret = peripheral_request(st->t->pin, st->trig->name);
-		if (ret)
-			goto out_free_irq;
-
-		val = (unsigned long long)get_sclk() * pdata->duty_ns;
-		do_div(val, NSEC_PER_SEC);
-		st->duty = val;
-
-		/**
-		 * The interrupt will be generated at the end of the period,
-		 * since we want the interrupt to be generated at end of the
-		 * pulse we invert both polarity and duty cycle, so that the
-		 * pulse will be generated directly before the interrupt.
-		 */
-		if (pdata->active_low)
-			config |= PULSE_HI;
-	} else {
-		st->duty = 1;
-		config |= OUT_DIS;
-	}
-
-	set_gptimer_config(st->t->id, config);
-
-	dev_info(&pdev->dev, "iio trigger Blackfin TMR%d, IRQ-%d",
-		 st->timer_num, st->irq);
-	platform_set_drvdata(pdev, st);
-
-	return 0;
-out_free_irq:
-	free_irq(st->irq, st);
-out1:
-	iio_trigger_unregister(st->trig);
-out:
-	iio_trigger_free(st->trig);
-	return ret;
-}
-
-static int iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
-{
-	struct bfin_tmr_state *st = platform_get_drvdata(pdev);
-
-	disable_gptimers(st->t->bit);
-	if (st->output_enable)
-		peripheral_free(st->t->pin);
-	free_irq(st->irq, st);
-	iio_trigger_unregister(st->trig);
-	iio_trigger_free(st->trig);
-
-	return 0;
-}
-
-static struct platform_driver iio_bfin_tmr_trigger_driver = {
-	.driver = {
-		.name = "iio_bfin_tmr_trigger",
-	},
-	.probe = iio_bfin_tmr_trigger_probe,
-	.remove = iio_bfin_tmr_trigger_remove,
-};
-
-module_platform_driver(iio_bfin_tmr_trigger_driver);
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Blackfin system timer based trigger for the iio subsystem");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:iio-trig-bfin-timer");
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.h b/drivers/staging/iio/trigger/iio-trig-bfin-timer.h
deleted file mode 100644
index fb05a2a..0000000
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __IIO_BFIN_TIMER_TRIGGER_H__
-#define __IIO_BFIN_TIMER_TRIGGER_H__
-
-/**
- * struct iio_bfin_timer_trigger_pdata - timer trigger platform data
- * @output_enable: Enable external trigger pulse generation.
- * @active_low: Whether the trigger pulse is active low.
- * @duty_ns: Length of the trigger pulse in nanoseconds.
- *
- * This struct is used to configure the output pulse generation of the blackfin
- * timer trigger. If output_enable is set to true an external trigger signal
- * will generated on the pin corresponding to the timer. This is useful for
- * converters which needs an external signal to start conversion. active_low and
- * duty_ns are used to configure the type of the trigger pulse. If output_enable
- * is set to false no external trigger pulse will be generated and active_low
- * and duty_ns are ignored.
- **/
-struct iio_bfin_timer_trigger_pdata {
-	bool output_enable;
-	bool active_low;
-	unsigned int duty_ns;
-};
-
-#endif
-- 
2.7.4
