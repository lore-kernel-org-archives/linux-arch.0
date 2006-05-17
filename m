Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:11919 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932093AbWEQIRc
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 May 2006 04:17:32 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.6/8.13.6) with ESMTP id k4H8HU7t168904
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 08:17:30 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4H8IxeV148814
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 10:18:59 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id k4H8HTcj032334
	for <linux-arch@vger.kernel.org>; Wed, 17 May 2006 10:17:30 +0200
Subject: Re: [patch] s390 kconfig cleanup.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20060516211216.GE23243@moss.sous-sol.org>
References: <20060515171645.GA11397@skybase> <200605151930.32241.ak@suse.de>
	 <20060515212431.GA25010@moss.sous-sol.org>
	 <1147766908.5289.4.camel@localhost>
	 <20060516211216.GE23243@moss.sous-sol.org>
Content-Type: text/plain
Date: Wed, 17 May 2006 10:17:31 +0200
Message-Id: <1147853851.6661.2.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-05-16 at 14:12 -0700, Chris Wright wrote:
> > Search for all menus tagged with !S390 in the patch and you will get a
> > good overview.
> 
> Sorry, I never got the original patch, mind sending it to me.

Sure, here it is again.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


--

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch] s390: kconfig cleanup.

Use common drivers/Kconfig instead of making copies of the required
options in drivers/s390/Kconfig. Since that would add a lot of other
options that do not make sense for a s390 machine, add "depends"
statements to all options and menues that should not be there for
s390.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig              |   46 ++------
 drivers/block/Kconfig          |    4 
 drivers/char/Kconfig           |   16 ++
 drivers/char/ipmi/Kconfig      |    2 
 drivers/char/tpm/Kconfig       |    1 
 drivers/crypto/Kconfig         |   10 +
 drivers/edac/Kconfig           |    1 
 drivers/hwmon/Kconfig          |    1 
 drivers/i2c/Kconfig            |    1 
 drivers/ide/Kconfig            |    1 
 drivers/ieee1394/Kconfig       |    1 
 drivers/infiniband/Kconfig     |    1 
 drivers/input/Kconfig          |    1 
 drivers/isdn/Kconfig           |    1 
 drivers/leds/Kconfig           |    1 
 drivers/media/Kconfig          |    3 
 drivers/message/fusion/Kconfig |    1 
 drivers/message/i2o/Kconfig    |    1 
 drivers/misc/Kconfig           |    1 
 drivers/mmc/Kconfig            |    1 
 drivers/mtd/Kconfig            |    1 
 drivers/net/phy/Kconfig        |    3 
 drivers/net/wireless/Kconfig   |    2 
 drivers/parport/Kconfig        |    1 
 drivers/pnp/Kconfig            |    1 
 drivers/rtc/Kconfig            |    3 
 drivers/s390/Kconfig           |  229 -----------------------------------------
 drivers/s390/char/Kconfig      |  153 +++++++++++++++++++++++++++
 drivers/scsi/Kconfig           |    2 
 drivers/serial/Kconfig         |    1 
 drivers/spi/Kconfig            |    1 
 drivers/telephony/Kconfig      |    1 
 drivers/usb/Kconfig            |    1 
 drivers/video/Kconfig          |    1 
 drivers/w1/Kconfig             |    1 
 include/asm-s390/param.h       |    2 
 lib/Kconfig.debug              |    2 
 sound/Kconfig                  |    1 
 38 files changed, 228 insertions(+), 273 deletions(-)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-kconfig/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-04-13 10:36:53.000000000 +0200
+++ linux-2.6-kconfig/arch/s390/Kconfig	2006-05-15 12:48:23.000000000 +0200
@@ -4,23 +4,19 @@
 #
 
 config MMU
-	bool
-	default y
+	def_bool y
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
 config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
+	def_bool y
 
 config GENERIC_HWEIGHT
-	bool
-	default y
+	def_bool y
 
 config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
+	def_bool y
 
 config GENERIC_BUST_SPINLOCK
 	bool
@@ -28,8 +24,7 @@ config GENERIC_BUST_SPINLOCK
 mainmenu "Linux Kernel Configuration"
 
 config S390
-	bool
-	default y
+	def_bool y
 
 source "init/Kconfig"
 
@@ -216,6 +211,10 @@ config WARN_STACK_SIZE
 	  This allows you to specify the maximum frame size a function may
 	  have without the compiler complaining about it.
 
+comment "Kernel preemption"
+
+source "kernel/Kconfig.preempt"
+
 source "mm/Kconfig"
 
 comment "I/O subsystem configuration"
@@ -261,17 +260,6 @@ config QDIO_DEBUG
 
 comment "Misc"
 
-config PREEMPT
-	bool "Preemptible Kernel"
-	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-	  This allows applications to run more reliably even when the system is
-	  under load.
-
-	  Say N if you are unsure.
-
 config IPL
 	bool "Builtin IPL record support"
 	help
@@ -427,6 +415,8 @@ config APPLDATA_NET_SUM
 	  This can also be compiled as a module, which will be called
 	  appldata_net_sum.o.
 
+source kernel/Kconfig.hz
+
 config NO_IDLE_HZ
 	bool "No HZ timer ticks in idle"
 	help
@@ -459,18 +449,12 @@ endmenu
 source "net/Kconfig"
 
 config PCMCIA
-	bool
-	default n
-
-source "drivers/base/Kconfig"
-
-source "drivers/connector/Kconfig"
-
-source "drivers/scsi/Kconfig"
+	def_bool n
 
-source "drivers/s390/Kconfig"
+config CCW
+	def_bool y
 
-source "drivers/net/Kconfig"
+source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
diff -urpN linux-2.6/drivers/block/Kconfig linux-2.6-kconfig/drivers/block/Kconfig
--- linux-2.6/drivers/block/Kconfig	2006-04-13 10:36:53.000000000 +0200
+++ linux-2.6-kconfig/drivers/block/Kconfig	2006-05-15 12:26:33.000000000 +0200
@@ -447,8 +447,6 @@ config CDROM_PKTCDVD_WCACHE
 	  this option is dangerous unless the CD-RW media is known good, as we
 	  don't do deferred write error handling yet.
 
-source "drivers/s390/block/Kconfig"
-
 config ATA_OVER_ETH
 	tristate "ATA over Ethernet support"
 	depends on NET
@@ -456,4 +454,6 @@ config ATA_OVER_ETH
 	This driver provides Support for ATA over Ethernet block
 	devices like the Coraid EtherDrive (R) Storage Blade.
 
+source "drivers/s390/block/Kconfig"
+
 endmenu
diff -urpN linux-2.6/drivers/char/ipmi/Kconfig linux-2.6-kconfig/drivers/char/ipmi/Kconfig
--- linux-2.6/drivers/char/ipmi/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/char/ipmi/Kconfig	2006-05-15 13:10:04.000000000 +0200
@@ -3,6 +3,8 @@
 #
 
 menu "IPMI"
+	depends on !S390
+
 config IPMI_HANDLER
        tristate 'IPMI top-level message handler'
        help
diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-kconfig/drivers/char/Kconfig
--- linux-2.6/drivers/char/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/char/Kconfig	2006-05-15 13:21:15.000000000 +0200
@@ -6,6 +6,7 @@ menu "Character devices"
 
 config VT
 	bool "Virtual terminal" if EMBEDDED
+	depends on !S390
 	select INPUT
 	default y if !VIOCONS
 	---help---
@@ -59,11 +60,12 @@ config VT_CONSOLE
 
 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !UML
+	depends on VT && !UML
 	default y
 
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
+	depends on !S390
 	---help---
 	  Say Y here if you have any non-standard serial boards -- boards
 	  which aren't supported using the standard "dumb" serial driver.
@@ -713,7 +715,7 @@ config NVRAM
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM
+	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !S390
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -761,7 +763,7 @@ config SGI_IP27_RTC
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
+	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S390
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -814,6 +816,7 @@ config COBALT_LCD
 
 config DTLK
 	tristate "Double Talk PC internal speech card support"
+	depends on !S390
 	help
 	  This driver is for the DoubleTalk PC, a speech synthesizer
 	  manufactured by RC Systems (<http://www.rcsys.com/>).  It is also
@@ -824,6 +827,7 @@ config DTLK
 
 config R3964
 	tristate "Siemens R3964 line discipline"
+	depends on !S390
 	---help---
 	  This driver allows synchronous communication with devices using the
 	  Siemens R3964 packet protocol. Unless you are dealing with special
@@ -867,6 +871,7 @@ config TANBAC_TB0219
 	depends TANBAC_TB022X
 
 menu "Ftape, the floppy tape device driver"
+	depends on !S390
 
 config FTAPE
 	tristate "Ftape (QIC-80/Travan) support"
@@ -1006,7 +1011,7 @@ config HPET_MMAP
 
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
-	depends on X86 || IA64 || PPC64
+	depends on X86 || IA64 || PPC64 || S390
 	help
 	  The hangcheck-timer module detects when the system has gone
 	  out to lunch past a certain margin.  It can reboot the system
@@ -1025,6 +1030,7 @@ source "drivers/char/tpm/Kconfig"
 config TELCLOCK
 	tristate "Telecom clock driver for MPBL0010 ATCA SBC"
 	depends on EXPERIMENTAL
+	depends on !S390
 	default n
 	help
 	  The telecom clock device is specific to the MPBL0010 ATCA computer and
@@ -1034,5 +1040,7 @@ config TELCLOCK
 	  sysfs directory, /sys/devices/platform/telco_clock, with a number of
 	  files for controlling the behavior of this hardware.
 
+source "drivers/s390/char/Kconfig"
+
 endmenu
 
diff -urpN linux-2.6/drivers/char/tpm/Kconfig linux-2.6-kconfig/drivers/char/tpm/Kconfig
--- linux-2.6/drivers/char/tpm/Kconfig	2006-04-24 10:11:00.000000000 +0200
+++ linux-2.6-kconfig/drivers/char/tpm/Kconfig	2006-05-15 13:13:53.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "TPM devices"
+	depends on !S390
 
 config TCG_TPM
 	tristate "TPM Hardware Support"
diff -urpN linux-2.6/drivers/crypto/Kconfig linux-2.6-kconfig/drivers/crypto/Kconfig
--- linux-2.6/drivers/crypto/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/crypto/Kconfig	2006-05-15 13:23:00.000000000 +0200
@@ -20,4 +20,14 @@ config CRYPTO_DEV_PADLOCK_AES
 	help
 	  Use VIA PadLock for AES algorithm.
 
+config Z90CRYPT
+	tristate "Support for PCI-attached cryptographic adapters"
+	depends on S390
+        default "m"
+        help
+	  Select this option if you want to use a PCI-attached cryptographic
+	  adapter like the PCI Cryptographic Accelerator (PCICA) or the PCI
+	  Cryptographic Coprocessor (PCICC).  This option is also available
+	  as a module called z90crypt.ko.
+
 endmenu
diff -urpN linux-2.6/drivers/edac/Kconfig linux-2.6-kconfig/drivers/edac/Kconfig
--- linux-2.6/drivers/edac/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/edac/Kconfig	2006-05-15 13:31:42.000000000 +0200
@@ -7,6 +7,7 @@
 #
 
 menu 'EDAC - error detection and reporting (RAS) (EXPERIMENTAL)'
+	depends on !S390
 
 config EDAC
 	tristate "EDAC core system error reporting (EXPERIMENTAL)"
diff -urpN linux-2.6/drivers/hwmon/Kconfig linux-2.6-kconfig/drivers/hwmon/Kconfig
--- linux-2.6/drivers/hwmon/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/hwmon/Kconfig	2006-05-15 13:27:39.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Hardware Monitoring support"
+	depends on !S390
 
 config HWMON
 	tristate "Hardware Monitoring support"
diff -urpN linux-2.6/drivers/i2c/Kconfig linux-2.6-kconfig/drivers/i2c/Kconfig
--- linux-2.6/drivers/i2c/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/i2c/Kconfig	2006-05-15 12:44:09.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "I2C support"
+	depends on !S390
 
 config I2C
 	tristate "I2C support"
diff -urpN linux-2.6/drivers/ide/Kconfig linux-2.6-kconfig/drivers/ide/Kconfig
--- linux-2.6/drivers/ide/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/ide/Kconfig	2006-05-15 12:27:00.000000000 +0200
@@ -5,6 +5,7 @@
 #
 
 menu "ATA/ATAPI/MFM/RLL support"
+	depends on !S390
 
 config IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
diff -urpN linux-2.6/drivers/ieee1394/Kconfig linux-2.6-kconfig/drivers/ieee1394/Kconfig
--- linux-2.6/drivers/ieee1394/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/ieee1394/Kconfig	2006-05-15 12:35:01.000000000 +0200
@@ -1,6 +1,7 @@
 # -*- shell-script -*-
 
 menu "IEEE 1394 (FireWire) support"
+	depends on PCI || BROKEN
 
 config IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
diff -urpN linux-2.6/drivers/infiniband/Kconfig linux-2.6-kconfig/drivers/infiniband/Kconfig
--- linux-2.6/drivers/infiniband/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/infiniband/Kconfig	2006-05-15 14:33:38.000000000 +0200
@@ -1,4 +1,5 @@
 menu "InfiniBand support"
+	depends on !S390
 
 config INFINIBAND
 	depends on PCI || BROKEN
diff -urpN linux-2.6/drivers/input/Kconfig linux-2.6-kconfig/drivers/input/Kconfig
--- linux-2.6/drivers/input/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/input/Kconfig	2006-05-15 13:02:16.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Input device support"
+	depends on !S390
 
 config INPUT
 	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
diff -urpN linux-2.6/drivers/isdn/Kconfig linux-2.6-kconfig/drivers/isdn/Kconfig
--- linux-2.6/drivers/isdn/Kconfig	2006-04-13 10:36:54.000000000 +0200
+++ linux-2.6-kconfig/drivers/isdn/Kconfig	2006-05-15 13:01:06.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "ISDN subsystem"
+	depends on !S390
 
 config ISDN
 	tristate "ISDN support"
diff -urpN linux-2.6/drivers/leds/Kconfig linux-2.6-kconfig/drivers/leds/Kconfig
--- linux-2.6/drivers/leds/Kconfig	2006-04-13 10:36:55.000000000 +0200
+++ linux-2.6-kconfig/drivers/leds/Kconfig	2006-05-15 13:31:06.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "LED devices"
+	depends on !S390
 
 config NEW_LEDS
 	bool "LED Support"
diff -urpN linux-2.6/drivers/media/Kconfig linux-2.6-kconfig/drivers/media/Kconfig
--- linux-2.6/drivers/media/Kconfig	2006-04-13 10:36:55.000000000 +0200
+++ linux-2.6-kconfig/drivers/media/Kconfig	2006-05-15 13:28:45.000000000 +0200
@@ -2,7 +2,8 @@
 # Multimedia device configuration
 #
 
-menu "Multimedia devices"
+menu "Multimedia devices"	
+	depends on !S390
 
 config VIDEO_DEV
 	tristate "Video For Linux"
diff -urpN linux-2.6/drivers/message/fusion/Kconfig linux-2.6-kconfig/drivers/message/fusion/Kconfig
--- linux-2.6/drivers/message/fusion/Kconfig	2006-04-13 10:36:55.000000000 +0200
+++ linux-2.6-kconfig/drivers/message/fusion/Kconfig	2006-05-15 12:30:30.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "Fusion MPT device support"
+	depends on PCI
 
 config FUSION
 	bool
diff -urpN linux-2.6/drivers/message/i2o/Kconfig linux-2.6-kconfig/drivers/message/i2o/Kconfig
--- linux-2.6/drivers/message/i2o/Kconfig	2006-04-13 10:36:55.000000000 +0200
+++ linux-2.6-kconfig/drivers/message/i2o/Kconfig	2006-05-15 12:58:28.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "I2O device support"
+	depends on PCI
 
 config I2O
 	tristate "I2O support"
diff -urpN linux-2.6/drivers/misc/Kconfig linux-2.6-kconfig/drivers/misc/Kconfig
--- linux-2.6/drivers/misc/Kconfig	2006-04-13 10:36:55.000000000 +0200
+++ linux-2.6-kconfig/drivers/misc/Kconfig	2006-05-15 13:28:19.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Misc devices"
+	depends on !S390
 
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
diff -urpN linux-2.6/drivers/mmc/Kconfig linux-2.6-kconfig/drivers/mmc/Kconfig
--- linux-2.6/drivers/mmc/Kconfig	2006-04-13 10:36:55.000000000 +0200
+++ linux-2.6-kconfig/drivers/mmc/Kconfig	2006-05-15 13:30:44.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "MMC/SD Card support"
+	depends on !S390
 
 config MMC
 	tristate "MMC support"
diff -urpN linux-2.6/drivers/mtd/Kconfig linux-2.6-kconfig/drivers/mtd/Kconfig
--- linux-2.6/drivers/mtd/Kconfig	2006-04-13 10:36:55.000000000 +0200
+++ linux-2.6-kconfig/drivers/mtd/Kconfig	2006-05-15 12:23:10.000000000 +0200
@@ -1,6 +1,7 @@
 # $Id: Kconfig,v 1.11 2005/11/07 11:14:19 gleixner Exp $
 
 menu "Memory Technology Devices (MTD)"
+	depends on !S390
 
 config MTD
 	tristate "Memory Technology Device (MTD) support"
diff -urpN linux-2.6/drivers/net/phy/Kconfig linux-2.6-kconfig/drivers/net/phy/Kconfig
--- linux-2.6/drivers/net/phy/Kconfig	2006-04-13 10:36:56.000000000 +0200
+++ linux-2.6-kconfig/drivers/net/phy/Kconfig	2006-05-15 12:56:00.000000000 +0200
@@ -3,10 +3,11 @@
 #
 
 menu "PHY device support"
+	depends on !S390
 
 config PHYLIB
 	tristate "PHY Device support and infrastructure"
-	depends on NET_ETHERNET && (BROKEN || !S390)
+	depends on NET_ETHERNET
 	help
 	  Ethernet controllers are usually attached to PHY
 	  devices.  This option provides infrastructure for
diff -urpN linux-2.6/drivers/net/wireless/Kconfig linux-2.6-kconfig/drivers/net/wireless/Kconfig
--- linux-2.6/drivers/net/wireless/Kconfig	2006-04-21 10:09:47.000000000 +0200
+++ linux-2.6-kconfig/drivers/net/wireless/Kconfig	2006-05-15 12:57:21.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menu "Wireless LAN (non-hamradio)"
-	depends on NETDEVICES
+	depends on NETDEVICES && !S390
 
 config NET_RADIO
 	bool "Wireless LAN drivers (non-hamradio) & Wireless Extensions"
diff -urpN linux-2.6/drivers/parport/Kconfig linux-2.6-kconfig/drivers/parport/Kconfig
--- linux-2.6/drivers/parport/Kconfig	2006-04-13 10:36:56.000000000 +0200
+++ linux-2.6-kconfig/drivers/parport/Kconfig	2006-05-15 12:23:45.000000000 +0200
@@ -6,6 +6,7 @@
 #
 
 menu "Parallel port support"
+	depends on !S390
 
 config PARPORT
 	tristate "Parallel port support"
diff -urpN linux-2.6/drivers/pnp/Kconfig linux-2.6-kconfig/drivers/pnp/Kconfig
--- linux-2.6/drivers/pnp/Kconfig	2006-04-13 10:36:56.000000000 +0200
+++ linux-2.6-kconfig/drivers/pnp/Kconfig	2006-05-15 12:24:11.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Plug and Play support"
+	depends on !S390
 
 config PNP
 	bool "Plug and Play support"
diff -urpN linux-2.6/drivers/rtc/Kconfig linux-2.6-kconfig/drivers/rtc/Kconfig
--- linux-2.6/drivers/rtc/Kconfig	2006-04-13 10:36:56.000000000 +0200
+++ linux-2.6-kconfig/drivers/rtc/Kconfig	2006-05-15 13:45:57.000000000 +0200
@@ -1,8 +1,9 @@
-\#
+#
 # RTC class/drivers configuration
 #
 
 menu "Real Time Clock"
+	depends on !S390
 
 config RTC_LIB
 	tristate
diff -urpN linux-2.6/drivers/s390/char/Kconfig linux-2.6-kconfig/drivers/s390/char/Kconfig
--- linux-2.6/drivers/s390/char/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-kconfig/drivers/s390/char/Kconfig	2006-05-15 13:24:23.000000000 +0200
@@ -0,0 +1,153 @@
+comment "S/390 character device drivers"
+
+config TN3270
+	tristate "Support for locally attached 3270 terminals"
+	help
+	  Include support for IBM 3270 terminals.
+
+config TN3270_TTY
+	tristate "Support for tty input/output on 3270 terminals"
+	depends on TN3270
+	help
+	  Include support for using an IBM 3270 terminal as a Linux tty.
+
+config TN3270_FS
+	tristate "Support for fullscreen applications on 3270 terminals"
+	depends on TN3270
+	help
+	  Include support for fullscreen applications on an IBM 3270 terminal.
+
+config TN3270_CONSOLE
+	bool "Support for console on 3270 terminal"
+	depends on TN3270=y && TN3270_TTY=y
+	help
+	  Include support for using an IBM 3270 terminal as a Linux system
+	  console.  Available only if 3270 support is compiled in statically.
+
+config TN3215
+	bool "Support for 3215 line mode terminal"
+	help
+	  Include support for IBM 3215 line-mode terminals.
+
+config TN3215_CONSOLE
+	bool "Support for console on 3215 line mode terminal"
+	depends on TN3215
+	help
+	  Include support for using an IBM 3215 line-mode terminal as a
+	  Linux system console.
+
+config CCW_CONSOLE
+ 	bool
+ 	depends on TN3215_CONSOLE || TN3270_CONSOLE
+ 	default y
+ 
+config SCLP
+	bool "Support for SCLP"
+	help
+	  Include support for the SCLP interface to the service element.
+
+config SCLP_TTY
+	bool "Support for SCLP line mode terminal"
+	depends on SCLP
+	help
+	  Include support for IBM SCLP line-mode terminals.
+
+config SCLP_CONSOLE
+	bool "Support for console on SCLP line mode terminal"
+	depends on SCLP_TTY
+	help
+	  Include support for using an IBM HWC line-mode terminal as the Linux
+	  system console.
+
+config SCLP_VT220_TTY
+	bool "Support for SCLP VT220-compatible terminal"
+	depends on SCLP
+	help
+	  Include support for an IBM SCLP VT220-compatible terminal.
+
+config SCLP_VT220_CONSOLE
+	bool "Support for console on SCLP VT220-compatible terminal"
+	depends on SCLP_VT220_TTY
+	help
+	  Include support for using an IBM SCLP VT220-compatible terminal as a
+	  Linux system console.
+
+config SCLP_CPI
+	tristate "Control-Program Identification"
+	depends on SCLP
+	help
+	  This option enables the hardware console interface for system
+	  identification. This is commonly used for workload management and
+	  gives you a nice name for the system on the service element.
+	  Please select this option as a module since built-in operation is
+	  completely untested.
+	  You should only select this option if you know what you are doing,
+	  need this feature and intend to run your kernel in LPAR.
+
+config S390_TAPE
+	tristate "S/390 tape device support"
+	help
+	  Select this option if you want to access channel-attached tape
+	  devices on IBM S/390 or zSeries.
+	  If you select this option you will also want to select at
+	  least one of the tape interface options and one of the tape
+	  hardware options in order to access a tape device.
+	  This option is also available as a module. The module will be
+	  called tape390 and include all selected interfaces and
+	  hardware drivers.
+
+comment "S/390 tape interface support"
+	depends on S390_TAPE
+
+config S390_TAPE_BLOCK
+	bool "Support for tape block devices"
+	depends on S390_TAPE
+	help
+	  Select this option if you want to access your channel-attached tape
+	  devices using the block device interface.  This interface is similar
+	  to CD-ROM devices on other platforms.  The tapes can only be
+	  accessed read-only when using this interface.  Have a look at
+	  <file:Documentation/s390/TAPE> for further information about creating
+	  volumes for and using this interface.  It is safe to say "Y" here.
+
+comment "S/390 tape hardware support"
+	depends on S390_TAPE
+
+config S390_TAPE_34XX
+	tristate "Support for 3480/3490 tape hardware"
+	depends on S390_TAPE
+	help
+	  Select this option if you want to access IBM 3480/3490 magnetic
+	  tape subsystems and 100% compatibles.
+	  It is safe to say "Y" here.
+
+config S390_TAPE_3590
+	tristate "Support for 3590 tape hardware"
+	depends on S390_TAPE
+	help
+	  Select this option if you want to access IBM 3590 magnetic
+	  tape subsystems and 100% compatibles.
+	  It is safe to say "Y" here.
+
+config VMLOGRDR
+	tristate "Support for the z/VM recording system services (VM only)"
+	depends on IUCV
+	help
+	  Select this option if you want to be able to receive records collected
+	  by the z/VM recording system services, eg. from *LOGREC, *ACCOUNT or
+	  *SYMPTOM.
+	  This driver depends on the IUCV support driver.
+
+config VMCP
+	tristate "Support for the z/VM CP interface (VM only)"
+	help
+	  Select this option if you want to be able to interact with the control
+	  program on z/VM
+
+
+config MONREADER
+	tristate "API for reading z/VM monitor service records"
+	depends on IUCV
+	help
+	  Character device driver for reading z/VM monitor service records
+
diff -urpN linux-2.6/drivers/s390/Kconfig linux-2.6-kconfig/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	2006-04-13 10:36:56.000000000 +0200
+++ linux-2.6-kconfig/drivers/s390/Kconfig	1970-01-01 01:00:00.000000000 +0100
@@ -1,229 +0,0 @@
-config CCW
-	bool
-	default y
-
-source "drivers/block/Kconfig"
-
-source "drivers/md/Kconfig"
-
-
-menu "Character device drivers"
-
-config UNIX98_PTYS
-	bool "Unix98 PTY support"
-	---help---
-	  A pseudo terminal (PTY) is a software device consisting of two
-	  halves: a master and a slave. The slave device behaves identical to
-	  a physical terminal; the master device is used by a process to
-	  read data from and write data to the slave, thereby emulating a
-	  terminal. Typical programs for the master side are telnet servers
-	  and xterms.
-
-	  Linux has traditionally used the BSD-like names /dev/ptyxx for
-	  masters and /dev/ttyxx for slaves of pseudo terminals. This scheme
-	  has a number of problems. The GNU C library glibc 2.1 and later,
-	  however, supports the Unix98 naming standard: in order to acquire a
-	  pseudo terminal, a process opens /dev/ptmx; the number of the pseudo
-	  terminal is then made available to the process and the pseudo
-	  terminal slave can be accessed as /dev/pts/<number>. What was
-	  traditionally /dev/ttyp2 will then be /dev/pts/2, for example.
-
-	  The entries in /dev/pts/ are created on the fly by a virtual
-	  file system; therefore, if you say Y here you should say Y to
-	  "/dev/pts file system for Unix98 PTYs" as well.
-
-	  If you want to say Y here, you need to have the C library glibc 2.1
-	  or later (equal to libc-6.1, check with "ls -l /lib/libc.so.*").
-	  Read the instructions in <file:Documentation/Changes> pertaining to
-	  pseudo terminals. It's safe to say N.
-
-config UNIX98_PTY_COUNT
-	int "Maximum number of Unix98 PTYs in use (0-2048)"
-	depends on UNIX98_PTYS
-	default "256"
-	help
-	  The maximum number of Unix98 PTYs that can be used at any one time.
-	  The default is 256, and should be enough for desktop systems. Server
-	  machines which support incoming telnet/rlogin/ssh connections and/or
-	  serve several X terminals may want to increase this: every incoming
-	  connection and every xterm uses up one PTY.
-
-	  When not in use, each additional set of 256 PTYs occupy
-	  approximately 8 KB of kernel memory on 32-bit architectures.
-
-config HANGCHECK_TIMER
-	tristate "Hangcheck timer"
-	help
-	  The hangcheck-timer module detects when the system has gone
-	  out to lunch past a certain margin.  It can reboot the system
-	  or merely print a warning.
-
-source "drivers/char/watchdog/Kconfig"
-
-comment "S/390 character device drivers"
-
-config TN3270
-	tristate "Support for locally attached 3270 terminals"
-	help
-	  Include support for IBM 3270 terminals.
-
-config TN3270_TTY
-	tristate "Support for tty input/output on 3270 terminals"
-	depends on TN3270
-	help
-	  Include support for using an IBM 3270 terminal as a Linux tty.
-
-config TN3270_FS
-	tristate "Support for fullscreen applications on 3270 terminals"
-	depends on TN3270
-	help
-	  Include support for fullscreen applications on an IBM 3270 terminal.
-
-config TN3270_CONSOLE
-	bool "Support for console on 3270 terminal"
-	depends on TN3270=y && TN3270_TTY=y
-	help
-	  Include support for using an IBM 3270 terminal as a Linux system
-	  console.  Available only if 3270 support is compiled in statically.
-
-config TN3215
-	bool "Support for 3215 line mode terminal"
-	help
-	  Include support for IBM 3215 line-mode terminals.
-
-config TN3215_CONSOLE
-	bool "Support for console on 3215 line mode terminal"
-	depends on TN3215
-	help
-	  Include support for using an IBM 3215 line-mode terminal as a
-	  Linux system console.
-
-config CCW_CONSOLE
- 	bool
- 	depends on TN3215_CONSOLE || TN3270_CONSOLE
- 	default y
- 
-config SCLP
-	bool "Support for SCLP"
-	help
-	  Include support for the SCLP interface to the service element.
-
-config SCLP_TTY
-	bool "Support for SCLP line mode terminal"
-	depends on SCLP
-	help
-	  Include support for IBM SCLP line-mode terminals.
-
-config SCLP_CONSOLE
-	bool "Support for console on SCLP line mode terminal"
-	depends on SCLP_TTY
-	help
-	  Include support for using an IBM HWC line-mode terminal as the Linux
-	  system console.
-
-config SCLP_VT220_TTY
-	bool "Support for SCLP VT220-compatible terminal"
-	depends on SCLP
-	help
-	  Include support for an IBM SCLP VT220-compatible terminal.
-
-config SCLP_VT220_CONSOLE
-	bool "Support for console on SCLP VT220-compatible terminal"
-	depends on SCLP_VT220_TTY
-	help
-	  Include support for using an IBM SCLP VT220-compatible terminal as a
-	  Linux system console.
-
-config SCLP_CPI
-	tristate "Control-Program Identification"
-	depends on SCLP
-	help
-	  This option enables the hardware console interface for system
-	  identification. This is commonly used for workload management and
-	  gives you a nice name for the system on the service element.
-	  Please select this option as a module since built-in operation is
-	  completely untested.
-	  You should only select this option if you know what you are doing,
-	  need this feature and intend to run your kernel in LPAR.
-
-config S390_TAPE
-	tristate "S/390 tape device support"
-	help
-	  Select this option if you want to access channel-attached tape
-	  devices on IBM S/390 or zSeries.
-	  If you select this option you will also want to select at
-	  least one of the tape interface options and one of the tape
-	  hardware options in order to access a tape device.
-	  This option is also available as a module. The module will be
-	  called tape390 and include all selected interfaces and
-	  hardware drivers.
-
-comment "S/390 tape interface support"
-	depends on S390_TAPE
-
-config S390_TAPE_BLOCK
-	bool "Support for tape block devices"
-	depends on S390_TAPE
-	help
-	  Select this option if you want to access your channel-attached tape
-	  devices using the block device interface.  This interface is similar
-	  to CD-ROM devices on other platforms.  The tapes can only be
-	  accessed read-only when using this interface.  Have a look at
-	  <file:Documentation/s390/TAPE> for further information about creating
-	  volumes for and using this interface.  It is safe to say "Y" here.
-
-comment "S/390 tape hardware support"
-	depends on S390_TAPE
-
-config S390_TAPE_34XX
-	tristate "Support for 3480/3490 tape hardware"
-	depends on S390_TAPE
-	help
-	  Select this option if you want to access IBM 3480/3490 magnetic
-	  tape subsystems and 100% compatibles.
-	  It is safe to say "Y" here.
-
-config S390_TAPE_3590
-	tristate "Support for 3590 tape hardware"
-	depends on S390_TAPE
-	help
-	  Select this option if you want to access IBM 3590 magnetic
-	  tape subsystems and 100% compatibles.
-	  It is safe to say "Y" here.
-
-config VMLOGRDR
-	tristate "Support for the z/VM recording system services (VM only)"
-	depends on IUCV
-	help
-	  Select this option if you want to be able to receive records collected
-	  by the z/VM recording system services, eg. from *LOGREC, *ACCOUNT or
-	  *SYMPTOM.
-	  This driver depends on the IUCV support driver.
-
-config VMCP
-	tristate "Support for the z/VM CP interface (VM only)"
-	help
-	  Select this option if you want to be able to interact with the control
-	  program on z/VM
-
-
-config MONREADER
-	tristate "API for reading z/VM monitor service records"
-	depends on IUCV
-	help
-	  Character device driver for reading z/VM monitor service records
-
-endmenu
-
-menu "Cryptographic devices"
-
-config Z90CRYPT
-	tristate "Support for PCI-attached cryptographic adapters"
-        default "m"
-        help
-	  Select this option if you want to use a PCI-attached cryptographic
-	  adapter like the PCI Cryptographic Accelerator (PCICA) or the PCI
-	  Cryptographic Coprocessor (PCICC).  This option is also available
-	  as a module called z90crypt.ko.
-
-endmenu
diff -urpN linux-2.6/drivers/scsi/Kconfig linux-2.6-kconfig/drivers/scsi/Kconfig
--- linux-2.6/drivers/scsi/Kconfig	2006-05-02 11:21:17.000000000 +0200
+++ linux-2.6-kconfig/drivers/scsi/Kconfig	2006-05-15 12:33:52.000000000 +0200
@@ -473,7 +473,7 @@ source "drivers/scsi/megaraid/Kconfig.me
 
 config SCSI_SATA
 	tristate "Serial ATA (SATA) support"
-	depends on SCSI
+	depends on SCSI && !S390
 	help
 	  This driver family supports Serial ATA host controllers
 	  and devices.
diff -urpN linux-2.6/drivers/serial/Kconfig linux-2.6-kconfig/drivers/serial/Kconfig
--- linux-2.6/drivers/serial/Kconfig	2006-04-13 10:36:58.000000000 +0200
+++ linux-2.6-kconfig/drivers/serial/Kconfig	2006-05-15 13:08:05.000000000 +0200
@@ -5,6 +5,7 @@
 #
 
 menu "Serial drivers"
+	depends on !S390
 
 #
 # The new 8250/16550 serial drivers
diff -urpN linux-2.6/drivers/spi/Kconfig linux-2.6-kconfig/drivers/spi/Kconfig
--- linux-2.6/drivers/spi/Kconfig	2006-04-13 10:36:58.000000000 +0200
+++ linux-2.6-kconfig/drivers/spi/Kconfig	2006-05-15 13:26:28.000000000 +0200
@@ -6,6 +6,7 @@
 # fully appropriate there, so it'd need some thought to do well.
 #
 menu "SPI support"
+	depends on !S390
 
 config SPI
 	bool "SPI support"
diff -urpN linux-2.6/drivers/telephony/Kconfig linux-2.6-kconfig/drivers/telephony/Kconfig
--- linux-2.6/drivers/telephony/Kconfig	2006-04-13 10:36:58.000000000 +0200
+++ linux-2.6-kconfig/drivers/telephony/Kconfig	2006-05-15 13:01:27.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Telephony Support"
+	depends on !S390
 
 config PHONE
 	tristate "Linux telephony support"
diff -urpN linux-2.6/drivers/usb/Kconfig linux-2.6-kconfig/drivers/usb/Kconfig
--- linux-2.6/drivers/usb/Kconfig	2006-04-13 10:36:58.000000000 +0200
+++ linux-2.6-kconfig/drivers/usb/Kconfig	2006-05-15 13:30:16.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "USB support"
+	depends on !S390
 
 # Host-side USB depends on having a host controller
 # NOTE:  dummy_hcd is always an option, but it's ignored here ...
diff -urpN linux-2.6/drivers/video/Kconfig linux-2.6-kconfig/drivers/video/Kconfig
--- linux-2.6/drivers/video/Kconfig	2006-05-02 11:21:17.000000000 +0200
+++ linux-2.6-kconfig/drivers/video/Kconfig	2006-05-15 13:29:15.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Graphics support"
+	depends on !S390
 
 config FB
 	tristate "Support for frame buffer devices"
diff -urpN linux-2.6/drivers/w1/Kconfig linux-2.6-kconfig/drivers/w1/Kconfig
--- linux-2.6/drivers/w1/Kconfig	2006-04-13 10:36:59.000000000 +0200
+++ linux-2.6-kconfig/drivers/w1/Kconfig	2006-05-15 13:27:09.000000000 +0200
@@ -1,4 +1,5 @@
 menu "Dallas's 1-wire bus"
+	depends on !S390
 
 config W1
 	tristate "Dallas's 1-wire support"
diff -urpN linux-2.6/include/asm-s390/param.h linux-2.6-kconfig/include/asm-s390/param.h
--- linux-2.6/include/asm-s390/param.h	2006-05-15 14:06:44.000000000 +0200
+++ linux-2.6-kconfig/include/asm-s390/param.h	2006-05-15 14:05:55.000000000 +0200
@@ -10,7 +10,7 @@
 #define _ASMS390_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		100		/* Internal kernel timer frequency */
+# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
diff -urpN linux-2.6/lib/Kconfig.debug linux-2.6-kconfig/lib/Kconfig.debug
--- linux-2.6/lib/Kconfig.debug	2006-05-15 09:57:03.000000000 +0200
+++ linux-2.6-kconfig/lib/Kconfig.debug	2006-05-15 13:47:03.000000000 +0200
@@ -48,7 +48,7 @@ config LOG_BUF_SHIFT
 
 config DETECT_SOFTLOCKUP
 	bool "Detect Soft Lockups"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !S390
 	default y
 	help
 	  Say Y here to enable the kernel to detect "soft lockups",
diff -urpN linux-2.6/sound/Kconfig linux-2.6-kconfig/sound/Kconfig
--- linux-2.6/sound/Kconfig	2006-04-13 10:37:05.000000000 +0200
+++ linux-2.6-kconfig/sound/Kconfig	2006-05-15 13:29:40.000000000 +0200
@@ -2,6 +2,7 @@
 #
 
 menu "Sound"
+	depends on !S390
 
 config SOUND
 	tristate "Sound card support"


