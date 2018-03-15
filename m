Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:52981
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751774AbeCOLBk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 07:01:40 -0400
From: Aaron Wu <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 20/28] pwm: Remove Blackfin PWM support
Date: Thu, 15 Mar 2018 18:50:20 +0800
Message-ID: <1521111028-19856-20-git-send-email-aaron.wu@analog.com>
In-Reply-To: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, f.fainelli@gmail.com, linux-arch@vger.kernel.org, kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, liqin.linux@gmail.com, lennox.wu@gmail.com, gxt@mprc.pku.edu.cn, linux@roeck-us.net
Cc: viro@zeniv.linux.org.uk, jhogan@kernel.org, linux-metag@vger.kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, openrisc@lists.librecores.org, dhowells@redhat.com, peterz@infradead.org, aaron.wu@analog.com

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin PWM support
---
 drivers/pwm/Kconfig    |   9 ---
 drivers/pwm/Makefile   |   1 -
 drivers/pwm/pwm-bfin.c | 157 -------------------------------------------------
 3 files changed, 167 deletions(-)
 delete mode 100644 drivers/pwm/pwm-bfin.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50..5d9868d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -113,15 +113,6 @@ config PWM_BERLIN
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-berlin.
 
-config PWM_BFIN
-	tristate "Blackfin PWM support"
-	depends on BFIN_GPTIMERS
-	help
-	  Generic PWM framework driver for Blackfin.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-bfin.
-
 config PWM_BRCMSTB
 	tristate "Broadcom STB PWM support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0258a74..9c676a0 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
-obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
diff --git a/drivers/pwm/pwm-bfin.c b/drivers/pwm/pwm-bfin.c
deleted file mode 100644
index a9a8813..0000000
--- a/drivers/pwm/pwm-bfin.c
+++ /dev/null
@@ -1,157 +0,0 @@
-/*
- * Blackfin Pulse Width Modulation (PWM) core
- *
- * Copyright (c) 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/pwm.h>
-#include <linux/slab.h>
-
-#include <asm/gptimers.h>
-#include <asm/portmux.h>
-
-struct bfin_pwm_chip {
-	struct pwm_chip chip;
-};
-
-struct bfin_pwm {
-	unsigned short pin;
-};
-
-static const unsigned short pwm_to_gptimer_per[] = {
-	P_TMR0, P_TMR1, P_TMR2, P_TMR3, P_TMR4, P_TMR5,
-	P_TMR6, P_TMR7, P_TMR8, P_TMR9, P_TMR10, P_TMR11,
-};
-
-static int bfin_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bfin_pwm *priv;
-	int ret;
-
-	if (pwm->hwpwm >= ARRAY_SIZE(pwm_to_gptimer_per))
-		return -EINVAL;
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->pin = pwm_to_gptimer_per[pwm->hwpwm];
-
-	ret = peripheral_request(priv->pin, NULL);
-	if (ret) {
-		kfree(priv);
-		return ret;
-	}
-
-	pwm_set_chip_data(pwm, priv);
-
-	return 0;
-}
-
-static void bfin_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
-
-	if (priv) {
-		peripheral_free(priv->pin);
-		kfree(priv);
-	}
-}
-
-static int bfin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-		int duty_ns, int period_ns)
-{
-	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
-	unsigned long period, duty;
-	unsigned long long val;
-
-	val = (unsigned long long)get_sclk() * period_ns;
-	do_div(val, NSEC_PER_SEC);
-	period = val;
-
-	val = (unsigned long long)period * duty_ns;
-	do_div(val, period_ns);
-	duty = period - val;
-
-	if (duty >= period)
-		duty = period - 1;
-
-	set_gptimer_config(priv->pin, TIMER_MODE_PWM | TIMER_PERIOD_CNT);
-	set_gptimer_pwidth(priv->pin, duty);
-	set_gptimer_period(priv->pin, period);
-
-	return 0;
-}
-
-static int bfin_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
-
-	enable_gptimer(priv->pin);
-
-	return 0;
-}
-
-static void bfin_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
-
-	disable_gptimer(priv->pin);
-}
-
-static const struct pwm_ops bfin_pwm_ops = {
-	.request = bfin_pwm_request,
-	.free = bfin_pwm_free,
-	.config = bfin_pwm_config,
-	.enable = bfin_pwm_enable,
-	.disable = bfin_pwm_disable,
-	.owner = THIS_MODULE,
-};
-
-static int bfin_pwm_probe(struct platform_device *pdev)
-{
-	struct bfin_pwm_chip *pwm;
-	int ret;
-
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, pwm);
-
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &bfin_pwm_ops;
-	pwm->chip.base = -1;
-	pwm->chip.npwm = 12;
-
-	ret = pwmchip_add(&pwm->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int bfin_pwm_remove(struct platform_device *pdev)
-{
-	struct bfin_pwm_chip *pwm = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&pwm->chip);
-}
-
-static struct platform_driver bfin_pwm_driver = {
-	.driver = {
-		.name = "bfin-pwm",
-	},
-	.probe = bfin_pwm_probe,
-	.remove = bfin_pwm_remove,
-};
-
-module_platform_driver(bfin_pwm_driver);
-
-MODULE_LICENSE("GPL");
-- 
2.7.4
