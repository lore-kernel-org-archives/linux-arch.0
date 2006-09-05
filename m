Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:52899 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932194AbWIEQdH
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 12:33:07 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.7/8.13.7) with ESMTP id k85GX6nc123436
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 16:33:06 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k85GbTkm2650220
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:37:29 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k85GX5Zi004956
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:33:05 +0200
Received: from localhost (dyn-9-152-216-78.boeblingen.de.ibm.com [9.152.216.78])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k85GX5TS004953
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:33:05 +0200
Date: Tue, 5 Sep 2006 18:33:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/5] Kconfig: refine some depend statements.
Message-ID: <20060905163305.GB6510@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 1/5] Kconfig: refine some depend statements.

Refine the depend statements of four menus (ftape, fusion,
ieee1394 and I2O) and two config options (DTLK and TELCLOCK).

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/char/Kconfig           |    3 +++
 drivers/ieee1394/Kconfig       |    1 +
 drivers/message/fusion/Kconfig |    1 +
 drivers/message/i2o/Kconfig    |    1 +
 4 files changed, 6 insertions(+)

diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-patched/drivers/char/Kconfig
--- linux-2.6/drivers/char/Kconfig	2006-09-05 16:57:02.000000000 +0200
+++ linux-2.6-patched/drivers/char/Kconfig	2006-09-05 16:57:17.000000000 +0200
@@ -842,6 +842,7 @@ config COBALT_LCD
 
 config DTLK
 	tristate "Double Talk PC internal speech card support"
+	depends on ISA
 	help
 	  This driver is for the DoubleTalk PC, a speech synthesizer
 	  manufactured by RC Systems (<http://www.rcsys.com/>).  It is also
@@ -896,6 +897,7 @@ config TANBAC_TB0219
 	select GPIO_VR41XX
 
 menu "Ftape, the floppy tape device driver"
+	depends on BROKEN_ON_SMP && (ALPHA || X86)
 
 config FTAPE
 	tristate "Ftape (QIC-80/Travan) support"
@@ -1079,6 +1081,7 @@ source "drivers/char/tpm/Kconfig"
 config TELCLOCK
 	tristate "Telecom clock driver for MPBL0010 ATCA SBC"
 	depends on EXPERIMENTAL
+	depends on X86
 	default n
 	help
 	  The telecom clock device is specific to the MPBL0010 ATCA computer and
diff -urpN linux-2.6/drivers/ieee1394/Kconfig linux-2.6-patched/drivers/ieee1394/Kconfig
--- linux-2.6/drivers/ieee1394/Kconfig	2006-09-05 16:57:02.000000000 +0200
+++ linux-2.6-patched/drivers/ieee1394/Kconfig	2006-09-05 16:57:17.000000000 +0200
@@ -1,6 +1,7 @@
 # -*- shell-script -*-
 
 menu "IEEE 1394 (FireWire) support"
+	depends on PCI || BROKEN
 
 config IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
diff -urpN linux-2.6/drivers/message/fusion/Kconfig linux-2.6-patched/drivers/message/fusion/Kconfig
--- linux-2.6/drivers/message/fusion/Kconfig	2006-09-05 16:56:23.000000000 +0200
+++ linux-2.6-patched/drivers/message/fusion/Kconfig	2006-09-05 16:57:17.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "Fusion MPT device support"
+	depends on PCI
 
 config FUSION
 	bool
diff -urpN linux-2.6/drivers/message/i2o/Kconfig linux-2.6-patched/drivers/message/i2o/Kconfig
--- linux-2.6/drivers/message/i2o/Kconfig	2006-09-05 16:57:03.000000000 +0200
+++ linux-2.6-patched/drivers/message/i2o/Kconfig	2006-09-05 16:57:17.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "I2O device support"
+	depends on PCI
 
 config I2O
 	tristate "I2O support"
