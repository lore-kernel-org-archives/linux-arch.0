Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:36672 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932204AbWIEQdq
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 12:33:46 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.7/8.13.7) with ESMTP id k85GXiC4175346
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 16:33:44 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k85Gc8bY3121380
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:38:08 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k85GXiKE005592
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:33:44 +0200
Received: from localhost (dyn-9-152-216-78.boeblingen.de.ibm.com [9.152.216.78])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k85GXiSJ005573
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:33:44 +0200
Date: Tue, 5 Sep 2006 18:33:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/5] Kconfig: unwanted menus for s390.
Message-ID: <20060905163344.GE6510@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 4/5] Kconfig: unwanted menus for s390.

Hide unwanted menus from Kconfig for s390 by adding a lot of
"depends on !S390" statements.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/ata/Kconfig          |    1 +
 drivers/char/ipmi/Kconfig    |    2 ++
 drivers/char/tpm/Kconfig     |    1 +
 drivers/dma/Kconfig          |    1 +
 drivers/edac/Kconfig         |    1 +
 drivers/hwmon/Kconfig        |    1 +
 drivers/i2c/Kconfig          |    1 +
 drivers/ide/Kconfig          |    1 +
 drivers/iio/Kconfig          |    2 ++
 drivers/infiniband/Kconfig   |    1 +
 drivers/input/Kconfig        |    1 +
 drivers/isdn/Kconfig         |    1 +
 drivers/leds/Kconfig         |    1 +
 drivers/media/Kconfig        |    1 +
 drivers/misc/Kconfig         |    1 +
 drivers/mmc/Kconfig          |    1 +
 drivers/mtd/Kconfig          |    1 +
 drivers/net/Kconfig          |    4 ++--
 drivers/net/phy/Kconfig      |    1 +
 drivers/net/wireless/Kconfig |    2 +-
 drivers/parport/Kconfig      |    1 +
 drivers/pnp/Kconfig          |    1 +
 drivers/rtc/Kconfig          |    1 +
 drivers/serial/Kconfig       |    1 +
 drivers/spi/Kconfig          |    1 +
 drivers/telephony/Kconfig    |    1 +
 drivers/usb/Kconfig          |    1 +
 drivers/video/Kconfig        |    1 +
 drivers/w1/Kconfig           |    1 +
 sound/Kconfig                |    1 +
 30 files changed, 33 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/ata/Kconfig linux-2.6-patched/drivers/ata/Kconfig
--- linux-2.6/drivers/ata/Kconfig	2006-09-05 16:57:01.000000000 +0200
+++ linux-2.6-patched/drivers/ata/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Serial ATA (prod) and Parallel ATA (experimental) drivers"
+	depends on !S390
 
 config ATA
 	tristate "ATA device support"
diff -urpN linux-2.6/drivers/char/ipmi/Kconfig linux-2.6-patched/drivers/char/ipmi/Kconfig
--- linux-2.6/drivers/char/ipmi/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/char/ipmi/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,8 @@
 #
 
 menu "IPMI"
+	depends on !S390
+
 config IPMI_HANDLER
        tristate 'IPMI top-level message handler'
        help
diff -urpN linux-2.6/drivers/char/tpm/Kconfig linux-2.6-patched/drivers/char/tpm/Kconfig
--- linux-2.6/drivers/char/tpm/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/char/tpm/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "TPM devices"
+	depends on !S390
 
 config TCG_TPM
 	tristate "TPM Hardware Support"
diff -urpN linux-2.6/drivers/dma/Kconfig linux-2.6-patched/drivers/dma/Kconfig
--- linux-2.6/drivers/dma/Kconfig	2006-09-05 16:56:21.000000000 +0200
+++ linux-2.6-patched/drivers/dma/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "DMA Engine support"
+	depends on !S390
 
 config DMA_ENGINE
 	bool "Support for DMA engines"
diff -urpN linux-2.6/drivers/edac/Kconfig linux-2.6-patched/drivers/edac/Kconfig
--- linux-2.6/drivers/edac/Kconfig	2006-09-05 16:57:02.000000000 +0200
+++ linux-2.6-patched/drivers/edac/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -7,6 +7,7 @@
 #
 
 menu 'EDAC - error detection and reporting (RAS) (EXPERIMENTAL)'
+	depends on !S390
 
 config EDAC
 	tristate "EDAC core system error reporting (EXPERIMENTAL)"
diff -urpN linux-2.6/drivers/hwmon/Kconfig linux-2.6-patched/drivers/hwmon/Kconfig
--- linux-2.6/drivers/hwmon/Kconfig	2006-09-05 16:57:02.000000000 +0200
+++ linux-2.6-patched/drivers/hwmon/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Hardware Monitoring support"
+	depends on !S390
 
 config HWMON
 	tristate "Hardware Monitoring support"
diff -urpN linux-2.6/drivers/i2c/Kconfig linux-2.6-patched/drivers/i2c/Kconfig
--- linux-2.6/drivers/i2c/Kconfig	2006-09-05 16:57:02.000000000 +0200
+++ linux-2.6-patched/drivers/i2c/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "I2C support"
+	depends on !S390
 
 config I2C
 	tristate "I2C support"
diff -urpN linux-2.6/drivers/ide/Kconfig linux-2.6-patched/drivers/ide/Kconfig
--- linux-2.6/drivers/ide/Kconfig	2006-09-05 16:57:21.000000000 +0200
+++ linux-2.6-patched/drivers/ide/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -7,6 +7,7 @@
 if BLOCK
 
 menu "ATA/ATAPI/MFM/RLL support"
+	depends on !S390
 
 config IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
diff -urpN linux-2.6/drivers/iio/Kconfig linux-2.6-patched/drivers/iio/Kconfig
--- linux-2.6/drivers/iio/Kconfig	2006-09-05 16:57:02.000000000 +0200
+++ linux-2.6-patched/drivers/iio/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -1,4 +1,6 @@
 menu "Industrial IO"
+	depends on !S390
+
 config IIO
 	tristate "Industrial IO"
 	help
diff -urpN linux-2.6/drivers/infiniband/Kconfig linux-2.6-patched/drivers/infiniband/Kconfig
--- linux-2.6/drivers/infiniband/Kconfig	2006-09-05 16:57:02.000000000 +0200
+++ linux-2.6-patched/drivers/infiniband/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -1,4 +1,5 @@
 menu "InfiniBand support"
+	depends on !S390
 
 config INFINIBAND
 	depends on PCI || BROKEN
diff -urpN linux-2.6/drivers/input/Kconfig linux-2.6-patched/drivers/input/Kconfig
--- linux-2.6/drivers/input/Kconfig	2006-09-05 16:57:03.000000000 +0200
+++ linux-2.6-patched/drivers/input/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Input device support"
+	depends on !S390
 
 config INPUT
 	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
diff -urpN linux-2.6/drivers/isdn/Kconfig linux-2.6-patched/drivers/isdn/Kconfig
--- linux-2.6/drivers/isdn/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/isdn/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "ISDN subsystem"
+	depends on !S390
 
 config ISDN
 	tristate "ISDN support"
diff -urpN linux-2.6/drivers/leds/Kconfig linux-2.6-patched/drivers/leds/Kconfig
--- linux-2.6/drivers/leds/Kconfig	2006-09-05 16:56:22.000000000 +0200
+++ linux-2.6-patched/drivers/leds/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "LED devices"
+	depends on !S390
 
 config NEW_LEDS
 	bool "LED Support"
diff -urpN linux-2.6/drivers/media/Kconfig linux-2.6-patched/drivers/media/Kconfig
--- linux-2.6/drivers/media/Kconfig	2006-09-05 16:56:22.000000000 +0200
+++ linux-2.6-patched/drivers/media/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Multimedia devices"
+	depends on !S390
 
 config VIDEO_DEV
 	tristate "Video For Linux"
diff -urpN linux-2.6/drivers/misc/Kconfig linux-2.6-patched/drivers/misc/Kconfig
--- linux-2.6/drivers/misc/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/misc/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Misc devices"
+	depends on !S390
 
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
diff -urpN linux-2.6/drivers/mmc/Kconfig linux-2.6-patched/drivers/mmc/Kconfig
--- linux-2.6/drivers/mmc/Kconfig	2006-09-05 16:57:03.000000000 +0200
+++ linux-2.6-patched/drivers/mmc/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "MMC/SD Card support"
+	depends on !S390
 
 config MMC
 	tristate "MMC support"
diff -urpN linux-2.6/drivers/mtd/Kconfig linux-2.6-patched/drivers/mtd/Kconfig
--- linux-2.6/drivers/mtd/Kconfig	2006-09-05 16:57:03.000000000 +0200
+++ linux-2.6-patched/drivers/mtd/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -1,6 +1,7 @@
 # $Id: Kconfig,v 1.11 2005/11/07 11:14:19 gleixner Exp $
 
 menu "Memory Technology Devices (MTD)"
+	depends on !S390
 
 config MTD
 	tristate "Memory Technology Device (MTD) support"
diff -urpN linux-2.6/drivers/net/Kconfig linux-2.6-patched/drivers/net/Kconfig
--- linux-2.6/drivers/net/Kconfig	2006-09-05 16:57:03.000000000 +0200
+++ linux-2.6-patched/drivers/net/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -1886,7 +1886,7 @@ endmenu
 #
 
 menu "Ethernet (1000 Mbit)"
-	depends on !UML
+	depends on !UML && !S390
 
 config ACENIC
 	tristate "Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support"
@@ -2322,7 +2322,7 @@ endmenu
 #
 
 menu "Ethernet (10000 Mbit)"
-	depends on !UML
+	depends on !UML && !S390
 
 config CHELSIO_T1
         tristate "Chelsio 10Gb Ethernet support"
diff -urpN linux-2.6/drivers/net/phy/Kconfig linux-2.6-patched/drivers/net/phy/Kconfig
--- linux-2.6/drivers/net/phy/Kconfig	2006-09-05 16:56:27.000000000 +0200
+++ linux-2.6-patched/drivers/net/phy/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "PHY device support"
+	depends on !S390
 
 config PHYLIB
 	tristate "PHY Device support and infrastructure"
diff -urpN linux-2.6/drivers/net/wireless/Kconfig linux-2.6-patched/drivers/net/wireless/Kconfig
--- linux-2.6/drivers/net/wireless/Kconfig	2006-09-05 16:57:04.000000000 +0200
+++ linux-2.6-patched/drivers/net/wireless/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menu "Wireless LAN (non-hamradio)"
-	depends on NETDEVICES
+	depends on NETDEVICES && !S390
 
 config NET_RADIO
 	bool "Wireless LAN drivers (non-hamradio) & Wireless Extensions"
diff -urpN linux-2.6/drivers/parport/Kconfig linux-2.6-patched/drivers/parport/Kconfig
--- linux-2.6/drivers/parport/Kconfig	2006-09-05 16:57:21.000000000 +0200
+++ linux-2.6-patched/drivers/parport/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -6,6 +6,7 @@
 #
 
 menu "Parallel port support"
+	depends on !S390
 
 config PARPORT
 	tristate "Parallel port support"
diff -urpN linux-2.6/drivers/pnp/Kconfig linux-2.6-patched/drivers/pnp/Kconfig
--- linux-2.6/drivers/pnp/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/pnp/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Plug and Play support"
+	depends on !S390
 
 config PNP
 	bool "Plug and Play support"
diff -urpN linux-2.6/drivers/rtc/Kconfig linux-2.6-patched/drivers/rtc/Kconfig
--- linux-2.6/drivers/rtc/Kconfig	2006-09-05 16:57:04.000000000 +0200
+++ linux-2.6-patched/drivers/rtc/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Real Time Clock"
+	depends on !S390
 
 config RTC_LIB
 	tristate
diff -urpN linux-2.6/drivers/serial/Kconfig linux-2.6-patched/drivers/serial/Kconfig
--- linux-2.6/drivers/serial/Kconfig	2006-09-05 16:57:21.000000000 +0200
+++ linux-2.6-patched/drivers/serial/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -5,6 +5,7 @@
 #
 
 menu "Serial drivers"
+	depends on !S390
 
 #
 # The new 8250/16550 serial drivers
diff -urpN linux-2.6/drivers/spi/Kconfig linux-2.6-patched/drivers/spi/Kconfig
--- linux-2.6/drivers/spi/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/spi/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -6,6 +6,7 @@
 # fully appropriate there, so it'd need some thought to do well.
 #
 menu "SPI support"
+	depends on !S390
 
 config SPI
 	bool "SPI support"
diff -urpN linux-2.6/drivers/telephony/Kconfig linux-2.6-patched/drivers/telephony/Kconfig
--- linux-2.6/drivers/telephony/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/telephony/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Telephony Support"
+	depends on !S390
 
 config PHONE
 	tristate "Linux telephony support"
diff -urpN linux-2.6/drivers/usb/Kconfig linux-2.6-patched/drivers/usb/Kconfig
--- linux-2.6/drivers/usb/Kconfig	2006-09-05 16:57:05.000000000 +0200
+++ linux-2.6-patched/drivers/usb/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "USB support"
+	depends on !S390
 
 # Host-side USB depends on having a host controller
 # NOTE:  dummy_hcd is always an option, but it's ignored here ...
diff -urpN linux-2.6/drivers/video/Kconfig linux-2.6-patched/drivers/video/Kconfig
--- linux-2.6/drivers/video/Kconfig	2006-09-05 16:57:21.000000000 +0200
+++ linux-2.6-patched/drivers/video/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Graphics support"
+	depends on !S390
 
 config FIRMWARE_EDID
        bool "Enable firmware EDID"
diff -urpN linux-2.6/drivers/w1/Kconfig linux-2.6-patched/drivers/w1/Kconfig
--- linux-2.6/drivers/w1/Kconfig	2006-09-05 16:56:37.000000000 +0200
+++ linux-2.6-patched/drivers/w1/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -1,4 +1,5 @@
 menu "Dallas's 1-wire bus"
+	depends on !S390
 
 config W1
 	tristate "Dallas's 1-wire support"
diff -urpN linux-2.6/sound/Kconfig linux-2.6-patched/sound/Kconfig
--- linux-2.6/sound/Kconfig	2006-09-05 16:56:48.000000000 +0200
+++ linux-2.6-patched/sound/Kconfig	2006-09-05 16:57:21.000000000 +0200
@@ -2,6 +2,7 @@
 #
 
 menu "Sound"
+	depends on !S390
 
 config SOUND
 	tristate "Sound card support"
