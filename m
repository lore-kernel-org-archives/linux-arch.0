From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [PATCH 38/55] mtd: irq: Remove IRQF_DISABLED
Date: Thu, 22 Sep 2011 16:59:05 +0800
Message-ID: <1316681962-8217-39-git-send-email-yong.zhang0@gmail.com>
References: <1316681962-8217-1-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1316681962-8217-1-git-send-email-yong.zhang0@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Baruch Siach <baruch@tkos.co.il>, Artem Bityutskiy <artem.bityutskiy@intel.com>, Eric Miao <eric.y.miao@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lei Wen <leiwen@marvell.com>, Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, yong.zhang0@gmail.com, linux-mtd@lists.infradead.org, Andres Salomon <dilinger@queued.net>, tglx@linutronix.de, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-arch.vger.kernel.org

Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
We run all interrupt handlers with interrupts disabled
and we even check and yell when an interrupt handler
returns with interrupts enabled (see commit [b738a50a:
genirq: Warn when handler enables interrupts]).

So now this flag is a NOOP and can be removed.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c    |    2 +-
 drivers/mtd/nand/pxa3xx_nand.c |    3 +--
 drivers/mtd/nand/tmio_nand.c   |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 4d4c677..b03eb16 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1191,7 +1191,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	else
 		host->irq_control(host, 0);
 
-	err = request_irq(host->irq, mxc_nfc_irq, IRQF_DISABLED, DRIVER_NAME, host);
+	err = request_irq(host->irq, mxc_nfc_irq, 0, DRIVER_NAME, host);
 	if (err)
 		goto eirq;
 
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 9eb7f87..fabba5c 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1132,8 +1132,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 	/* initialize all interrupts to be disabled */
 	disable_int(info, NDSR_MASK);
 
-	ret = request_irq(irq, pxa3xx_nand_irq, IRQF_DISABLED,
-			  pdev->name, info);
+	ret = request_irq(irq, pxa3xx_nand_irq, 0, pdev->name, info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
 		goto fail_free_buf;
diff --git a/drivers/mtd/nand/tmio_nand.c b/drivers/mtd/nand/tmio_nand.c
index beebd95..6e5d6ff 100644
--- a/drivers/mtd/nand/tmio_nand.c
+++ b/drivers/mtd/nand/tmio_nand.c
@@ -441,7 +441,7 @@ static int tmio_probe(struct platform_device *dev)
 	nand_chip->chip_delay = 15;
 
 	retval = request_irq(irq, &tmio_irq,
-				IRQF_DISABLED, dev_name(&dev->dev), tmio);
+				0, dev_name(&dev->dev), tmio);
 	if (retval) {
 		dev_err(&dev->dev, "request_irq error %d\n", retval);
 		goto err_irq;
-- 
1.7.4.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
