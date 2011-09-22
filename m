From: Yong Zhang <yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 32/55] i2c: irq: Remove IRQF_DISABLED
Date: Thu, 22 Sep 2011 16:58:59 +0800
Message-ID: <1316681962-8217-33-git-send-email-yong.zhang0@gmail.com>
References: <1316681962-8217-1-git-send-email-yong.zhang0@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316681962-8217-1-git-send-email-yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, STEricsson <STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lucas De Marchi <lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>, Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWOunwaRDDq4rA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
We run all interrupt handlers with interrupts disabled
and we even check and yell when an interrupt handler
returns with interrupts enabled (see commit [b738a50a:
genirq: Warn when handler enables interrupts]).

So now this flag is a NOOP and can be removed.

Signed-off-by: Yong Zhang <yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c   |    4 ++--
 drivers/i2c/busses/i2c-designware.c |    2 +-
 drivers/i2c/busses/i2c-highlander.c |    2 +-
 drivers/i2c/busses/i2c-nomadik.c    |    2 +-
 drivers/i2c/busses/i2c-nuc900.c     |    2 +-
 drivers/i2c/busses/i2c-pmcmsp.c     |    2 +-
 drivers/i2c/busses/i2c-s3c2410.c    |    2 +-
 drivers/i2c/busses/i2c-sh7760.c     |    2 +-
 drivers/i2c/busses/i2c-sh_mobile.c  |    2 +-
 drivers/i2c/busses/i2c-stu300.c     |    2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index cbc98ae..cdb59e5 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -631,7 +631,7 @@ static int i2c_bfin_twi_resume(struct platform_device *pdev)
 	struct bfin_twi_iface *iface = platform_get_drvdata(pdev);
 
 	int rc = request_irq(iface->irq, bfin_twi_interrupt_entry,
-		IRQF_DISABLED, pdev->name, iface);
+		0, pdev->name, iface);
 	if (rc) {
 		dev_err(&pdev->dev, "Can't get IRQ %d !\n", iface->irq);
 		return -ENODEV;
@@ -702,7 +702,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	}
 
 	rc = request_irq(iface->irq, bfin_twi_interrupt_entry,
-		IRQF_DISABLED, pdev->name, iface);
+		0, pdev->name, iface);
 	if (rc) {
 		dev_err(&pdev->dev, "Can't get IRQ %d !\n", iface->irq);
 		rc = -ENODEV;
diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 1b42b50..2ac1903 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -755,7 +755,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	i2c_dw_init(dev);
 
 	writel(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
-	r = request_irq(dev->irq, i2c_dw_isr, IRQF_DISABLED, pdev->name, dev);
+	r = request_irq(dev->irq, i2c_dw_isr, 0, pdev->name, dev);
 	if (r) {
 		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
 		goto err_iounmap;
diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index 3876a24..63bb1cc 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -387,7 +387,7 @@ static int __devinit highlander_i2c_probe(struct platform_device *pdev)
 		dev->irq = 0;
 
 	if (dev->irq) {
-		ret = request_irq(dev->irq, highlander_i2c_irq, IRQF_DISABLED,
+		ret = request_irq(dev->irq, highlander_i2c_irq, 0,
 				  pdev->name, dev);
 		if (unlikely(ret))
 			goto err_unmap;
diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index b228e09..40702e8 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -935,7 +935,7 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 	}
 
 	dev->irq = platform_get_irq(pdev, 0);
-	ret = request_irq(dev->irq, i2c_irq_handler, IRQF_DISABLED,
+	ret = request_irq(dev->irq, i2c_irq_handler, 0,
 				DRIVER_NAME, dev);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot claim the irq %d\n", dev->irq);
diff --git a/drivers/i2c/busses/i2c-nuc900.c b/drivers/i2c/busses/i2c-nuc900.c
index 7243426..835e47b 100644
--- a/drivers/i2c/busses/i2c-nuc900.c
+++ b/drivers/i2c/busses/i2c-nuc900.c
@@ -610,7 +610,7 @@ static int __devinit nuc900_i2c_probe(struct platform_device *pdev)
 		goto err_iomap;
 	}
 
-	ret = request_irq(i2c->irq, nuc900_i2c_irq, IRQF_DISABLED | IRQF_SHARED,
+	ret = request_irq(i2c->irq, nuc900_i2c_irq, IRQF_SHARED,
 			  dev_name(&pdev->dev), i2c);
 
 	if (ret != 0) {
diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index dfa7ae9..127051b 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -306,7 +306,7 @@ static int __devinit pmcmsptwi_probe(struct platform_device *pldev)
 	pmcmsptwi_data.irq = platform_get_irq(pldev, 0);
 	if (pmcmsptwi_data.irq) {
 		rc = request_irq(pmcmsptwi_data.irq, &pmcmsptwi_interrupt,
-			IRQF_SHARED | IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
+			IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			pldev->name, &pmcmsptwi_data);
 		if (rc == 0) {
 			/*
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 9c00ad1..2754cef 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -980,7 +980,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 		goto err_iomap;
 	}
 
-	ret = request_irq(i2c->irq, s3c24xx_i2c_irq, IRQF_DISABLED,
+	ret = request_irq(i2c->irq, s3c24xx_i2c_irq, 0,
 			  dev_name(&pdev->dev), i2c);
 
 	if (ret != 0) {
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 4cd0a1d..a67132b 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -503,7 +503,7 @@ static int __devinit sh7760_i2c_probe(struct platform_device *pdev)
 	}
 	OUT32(id, I2CCCR, ret);
 
-	if (request_irq(id->irq, sh7760_i2c_irq, IRQF_DISABLED,
+	if (request_irq(id->irq, sh7760_i2c_irq, 0,
 			SH7760_I2C_DEVNAME, id)) {
 		dev_err(&pdev->dev, "cannot get irq %d\n", id->irq);
 		ret = -EBUSY;
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index f633a53..675c969 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -543,7 +543,7 @@ static int sh_mobile_i2c_hook_irqs(struct platform_device *dev, int hook)
 
 	while ((res = platform_get_resource(dev, IORESOURCE_IRQ, k))) {
 		for (n = res->start; hook && n <= res->end; n++) {
-			if (request_irq(n, sh_mobile_i2c_isr, IRQF_DISABLED,
+			if (request_irq(n, sh_mobile_i2c_isr, 0,
 					dev_name(&dev->dev), dev)) {
 				for (n--; n >= res->start; n--)
 					free_irq(n, dev);
diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 9987961..4d44af1 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -916,7 +916,7 @@ stu300_probe(struct platform_device *pdev)
 	}
 
 	dev->irq = platform_get_irq(pdev, 0);
-	if (request_irq(dev->irq, stu300_irh, IRQF_DISABLED,
+	if (request_irq(dev->irq, stu300_irh, 0,
 			NAME, dev)) {
 		ret = -EIO;
 		goto err_no_irq;
-- 
1.7.4.1
