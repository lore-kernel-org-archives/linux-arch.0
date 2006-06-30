Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:5579 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932560AbWF3M2F
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 08:28:05 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.6/8.13.6) with ESMTP id k5UCS1d1131610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 12:28:02 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5UCUVtO113642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 14:30:34 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5UCRogm022770
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 14:27:51 +0200
Subject: [patch] s390 kconfig cleanup, 2nd version.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Fri, 30 Jun 2006 14:26:44 +0200
Message-Id: <1151670404.11575.5.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, ak@suse.de, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx
Cc: akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

Hi folks,
it has been a few weeks since the s390 kconfig discussion died down.
I have put together a new patch that includes all of the suggestions
made so far. With this patch "make allyesconfig" and "make allmodconfig"
now works on s390.

Please check that it does not break anything on your favorite 
architecture. It really shouldn't but you never know. I want to push
this patch soon.

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
 arch/s390/Kconfig              |   53 ++-------
 arch/s390/kernel/Makefile      |    4 
 drivers/block/Kconfig          |    4 
 drivers/char/Kconfig           |   13 +-
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
 drivers/media/Kconfig          |    1 
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
 drivers/s390/block/dasd.c      |    2 
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
 net/ax25/Kconfig               |    2 
 net/bluetooth/Kconfig          |    2 
 net/irda/Kconfig               |    2 
 sound/Kconfig                  |    1 
 43 files changed, 231 insertions(+), 284 deletions(-)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2006-06-30 13:32:17.000000000 +0200
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
 
@@ -110,13 +105,6 @@ config SYSVIPC_COMPAT
 	depends on COMPAT && SYSVIPC
 	default y
 
-config BINFMT_ELF32
-	tristate "Kernel support for 31 bit ELF binaries"
-	depends on COMPAT
-	help
-	  This allows you to run 32-bit Linux/ELF binaries on your zSeries
-	  in 64 bit mode. Everybody wants this; say Y.
-
 comment "Code generation options"
 
 choice
@@ -216,6 +204,10 @@ config WARN_STACK_SIZE
 	  This allows you to specify the maximum frame size a function may
 	  have without the compiler complaining about it.
 
+comment "Kernel preemption"
+
+source "kernel/Kconfig.preempt"
+
 source "mm/Kconfig"
 
 comment "I/O subsystem configuration"
@@ -261,17 +253,6 @@ config QDIO_DEBUG
 
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
@@ -427,6 +408,8 @@ config APPLDATA_NET_SUM
 	  This can also be compiled as a module, which will be called
 	  appldata_net_sum.o.
 
+source kernel/Kconfig.hz
+
 config NO_IDLE_HZ
 	bool "No HZ timer ticks in idle"
 	help
@@ -467,18 +450,12 @@ endmenu
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
 
diff -urpN linux-2.6/arch/s390/kernel/Makefile linux-2.6-patched/arch/s390/kernel/Makefile
--- linux-2.6/arch/s390/kernel/Makefile	2006-06-14 11:06:14.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/Makefile	2006-06-30 13:32:52.000000000 +0200
@@ -17,8 +17,8 @@ obj-$(CONFIG_MODULES)		+= s390_ksyms.o m
 obj-$(CONFIG_SMP)		+= smp.o
 
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o \
-					compat_wrapper.o compat_exec_domain.o
-obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o
+					compat_wrapper.o compat_exec_domain.o \
+					binfmt_elf32.o
 
 obj-$(CONFIG_VIRT_TIMER)	+= vtime.o
 
diff -urpN linux-2.6/drivers/block/Kconfig linux-2.6-patched/drivers/block/Kconfig
--- linux-2.6/drivers/block/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/block/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -448,8 +448,6 @@ config CDROM_PKTCDVD_WCACHE
 	  this option is dangerous unless the CD-RW media is known good, as we
 	  don't do deferred write error handling yet.
 
-source "drivers/s390/block/Kconfig"
-
 config ATA_OVER_ETH
 	tristate "ATA over Ethernet support"
 	depends on NET
@@ -457,4 +455,6 @@ config ATA_OVER_ETH
 	This driver provides Support for ATA over Ethernet block
 	devices like the Coraid EtherDrive (R) Storage Blade.
 
+source "drivers/s390/block/Kconfig"
+
 endmenu
diff -urpN linux-2.6/drivers/char/ipmi/Kconfig linux-2.6-patched/drivers/char/ipmi/Kconfig
--- linux-2.6/drivers/char/ipmi/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/char/ipmi/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -3,6 +3,8 @@
 #
 
 menu "IPMI"
+	depends on !S390
+
 config IPMI_HANDLER
        tristate 'IPMI top-level message handler'
        help
diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-patched/drivers/char/Kconfig
--- linux-2.6/drivers/char/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/char/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -6,6 +6,7 @@ menu "Character devices"
 
 config VT
 	bool "Virtual terminal" if EMBEDDED
+	depends on !S390
 	select INPUT
 	default y if !VIOCONS
 	---help---
@@ -81,6 +82,7 @@ config VT_HW_CONSOLE_BINDING
 
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
+	depends on !S390
 	---help---
 	  Say Y here if you have any non-standard serial boards -- boards
 	  which aren't supported using the standard "dumb" serial driver.
@@ -717,7 +719,7 @@ config NVRAM
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM
+	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !S390
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -765,7 +767,7 @@ config SGI_IP27_RTC
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
+	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S390
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -818,6 +820,7 @@ config COBALT_LCD
 
 config DTLK
 	tristate "Double Talk PC internal speech card support"
+	depends on ISA
 	help
 	  This driver is for the DoubleTalk PC, a speech synthesizer
 	  manufactured by RC Systems (<http://www.rcsys.com/>).  It is also
@@ -872,6 +875,7 @@ config TANBAC_TB0219
 	select GPIO_VR41XX
 
 menu "Ftape, the floppy tape device driver"
+	depends on BROKEN_ON_SMP && (ALPHA || X86)
 
 config FTAPE
 	tristate "Ftape (QIC-80/Travan) support"
@@ -1035,7 +1039,7 @@ config HPET_MMAP
 
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
-	depends on X86 || IA64 || PPC64
+	depends on X86 || IA64 || PPC64 || S390
 	help
 	  The hangcheck-timer module detects when the system has gone
 	  out to lunch past a certain margin.  It can reboot the system
@@ -1054,6 +1058,7 @@ source "drivers/char/tpm/Kconfig"
 config TELCLOCK
 	tristate "Telecom clock driver for MPBL0010 ATCA SBC"
 	depends on EXPERIMENTAL
+	depends on X86
 	default n
 	help
 	  The telecom clock device is specific to the MPBL0010 ATCA computer and
@@ -1063,5 +1068,7 @@ config TELCLOCK
 	  sysfs directory, /sys/devices/platform/telco_clock, with a number of
 	  files for controlling the behavior of this hardware.
 
+source "drivers/s390/char/Kconfig"
+
 endmenu
 
diff -urpN linux-2.6/drivers/char/tpm/Kconfig linux-2.6-patched/drivers/char/tpm/Kconfig
--- linux-2.6/drivers/char/tpm/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/char/tpm/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "TPM devices"
+	depends on !S390
 
 config TCG_TPM
 	tristate "TPM Hardware Support"
diff -urpN linux-2.6/drivers/crypto/Kconfig linux-2.6-patched/drivers/crypto/Kconfig
--- linux-2.6/drivers/crypto/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/crypto/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -20,4 +20,14 @@ config CRYPTO_DEV_PADLOCK_AES
 	help
 	  Use VIA PadLock for AES algorithm.
 
+config Z90CRYPT
+	tristate "Support for PCI-attached cryptographic adapters"
+	depends on S390
+	default "m"
+	help
+	  Select this option if you want to use a PCI-attached cryptographic
+	  adapter like the PCI Cryptographic Accelerator (PCICA) or the PCI
+	  Cryptographic Coprocessor (PCICC).  This option is also available
+	  as a module called z90crypt.ko.
+
 endmenu
diff -urpN linux-2.6/drivers/edac/Kconfig linux-2.6-patched/drivers/edac/Kconfig
--- linux-2.6/drivers/edac/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/edac/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -7,6 +7,7 @@
 #
 
 menu 'EDAC - error detection and reporting (RAS) (EXPERIMENTAL)'
+	depends on !S390
 
 config EDAC
 	tristate "EDAC core system error reporting (EXPERIMENTAL)"
diff -urpN linux-2.6/drivers/hwmon/Kconfig linux-2.6-patched/drivers/hwmon/Kconfig
--- linux-2.6/drivers/hwmon/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/hwmon/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Hardware Monitoring support"
+	depends on !S390
 
 config HWMON
 	tristate "Hardware Monitoring support"
diff -urpN linux-2.6/drivers/i2c/Kconfig linux-2.6-patched/drivers/i2c/Kconfig
--- linux-2.6/drivers/i2c/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/i2c/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "I2C support"
+	depends on !S390
 
 config I2C
 	tristate "I2C support"
diff -urpN linux-2.6/drivers/ide/Kconfig linux-2.6-patched/drivers/ide/Kconfig
--- linux-2.6/drivers/ide/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/ide/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -5,6 +5,7 @@
 #
 
 menu "ATA/ATAPI/MFM/RLL support"
+	depends on !S390
 
 config IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
diff -urpN linux-2.6/drivers/ieee1394/Kconfig linux-2.6-patched/drivers/ieee1394/Kconfig
--- linux-2.6/drivers/ieee1394/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/ieee1394/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -1,6 +1,7 @@
 # -*- shell-script -*-
 
 menu "IEEE 1394 (FireWire) support"
+	depends on PCI || BROKEN
 
 config IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
diff -urpN linux-2.6/drivers/infiniband/Kconfig linux-2.6-patched/drivers/infiniband/Kconfig
--- linux-2.6/drivers/infiniband/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/infiniband/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -1,4 +1,5 @@
 menu "InfiniBand support"
+	depends on !S390
 
 config INFINIBAND
 	depends on PCI || BROKEN
diff -urpN linux-2.6/drivers/input/Kconfig linux-2.6-patched/drivers/input/Kconfig
--- linux-2.6/drivers/input/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/input/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Input device support"
+	depends on !S390
 
 config INPUT
 	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
diff -urpN linux-2.6/drivers/isdn/Kconfig linux-2.6-patched/drivers/isdn/Kconfig
--- linux-2.6/drivers/isdn/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/isdn/Kconfig	2006-06-30 11:21:06.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "ISDN subsystem"
+	depends on !S390
 
 config ISDN
 	tristate "ISDN support"
diff -urpN linux-2.6/drivers/leds/Kconfig linux-2.6-patched/drivers/leds/Kconfig
--- linux-2.6/drivers/leds/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/leds/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "LED devices"
+	depends on !S390
 
 config NEW_LEDS
 	bool "LED Support"
diff -urpN linux-2.6/drivers/media/Kconfig linux-2.6-patched/drivers/media/Kconfig
--- linux-2.6/drivers/media/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/media/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Multimedia devices"
+	depends on !S390
 
 config VIDEO_DEV
 	tristate "Video For Linux"
diff -urpN linux-2.6/drivers/message/fusion/Kconfig linux-2.6-patched/drivers/message/fusion/Kconfig
--- linux-2.6/drivers/message/fusion/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/message/fusion/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "Fusion MPT device support"
+	depends on PCI
 
 config FUSION
 	bool
diff -urpN linux-2.6/drivers/message/i2o/Kconfig linux-2.6-patched/drivers/message/i2o/Kconfig
--- linux-2.6/drivers/message/i2o/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/message/i2o/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "I2O device support"
+	depends on PCI
 
 config I2O
 	tristate "I2O support"
diff -urpN linux-2.6/drivers/misc/Kconfig linux-2.6-patched/drivers/misc/Kconfig
--- linux-2.6/drivers/misc/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/misc/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Misc devices"
+	depends on !S390
 
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
diff -urpN linux-2.6/drivers/mmc/Kconfig linux-2.6-patched/drivers/mmc/Kconfig
--- linux-2.6/drivers/mmc/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/mmc/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "MMC/SD Card support"
+	depends on !S390
 
 config MMC
 	tristate "MMC support"
diff -urpN linux-2.6/drivers/mtd/Kconfig linux-2.6-patched/drivers/mtd/Kconfig
--- linux-2.6/drivers/mtd/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/mtd/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -1,6 +1,7 @@
 # $Id: Kconfig,v 1.11 2005/11/07 11:14:19 gleixner Exp $
 
 menu "Memory Technology Devices (MTD)"
+	depends on !S390
 
 config MTD
 	tristate "Memory Technology Device (MTD) support"
diff -urpN linux-2.6/drivers/net/phy/Kconfig linux-2.6-patched/drivers/net/phy/Kconfig
--- linux-2.6/drivers/net/phy/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/net/phy/Kconfig	2006-06-30 11:21:07.000000000 +0200
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
diff -urpN linux-2.6/drivers/net/wireless/Kconfig linux-2.6-patched/drivers/net/wireless/Kconfig
--- linux-2.6/drivers/net/wireless/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/net/wireless/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menu "Wireless LAN (non-hamradio)"
-	depends on NETDEVICES
+	depends on NETDEVICES && !S390
 
 config NET_RADIO
 	bool "Wireless LAN drivers (non-hamradio) & Wireless Extensions"
diff -urpN linux-2.6/drivers/parport/Kconfig linux-2.6-patched/drivers/parport/Kconfig
--- linux-2.6/drivers/parport/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/parport/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -6,6 +6,7 @@
 #
 
 menu "Parallel port support"
+	depends on !S390
 
 config PARPORT
 	tristate "Parallel port support"
diff -urpN linux-2.6/drivers/pnp/Kconfig linux-2.6-patched/drivers/pnp/Kconfig
--- linux-2.6/drivers/pnp/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/pnp/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Plug and Play support"
+	depends on !S390
 
 config PNP
 	bool "Plug and Play support"
diff -urpN linux-2.6/drivers/rtc/Kconfig linux-2.6-patched/drivers/rtc/Kconfig
--- linux-2.6/drivers/rtc/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/rtc/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -1,8 +1,9 @@
-\#
+#
 # RTC class/drivers configuration
 #
 
 menu "Real Time Clock"
+	depends on !S390
 
 config RTC_LIB
 	tristate
diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-06-30 13:51:21.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-06-30 13:30:09.000000000 +0200
@@ -1821,7 +1821,7 @@ dasd_device_operations = {
 };
 
 
-static void
+static void __exit
 dasd_exit(void)
 {
 #ifdef CONFIG_PROC_FS
diff -urpN linux-2.6/drivers/s390/char/Kconfig linux-2.6-patched/drivers/s390/char/Kconfig
--- linux-2.6/drivers/s390/char/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/Kconfig	2006-06-30 11:21:07.000000000 +0200
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
+	bool
+	depends on TN3215_CONSOLE || TN3270_CONSOLE
+	default y
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
diff -urpN linux-2.6/drivers/s390/Kconfig linux-2.6-patched/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/s390/Kconfig	1970-01-01 01:00:00.000000000 +0100
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
diff -urpN linux-2.6/drivers/scsi/Kconfig linux-2.6-patched/drivers/scsi/Kconfig
--- linux-2.6/drivers/scsi/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/scsi/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -473,7 +473,7 @@ source "drivers/scsi/megaraid/Kconfig.me
 
 config SCSI_SATA
 	tristate "Serial ATA (SATA) support"
-	depends on SCSI
+	depends on SCSI && !S390
 	help
 	  This driver family supports Serial ATA host controllers
 	  and devices.
diff -urpN linux-2.6/drivers/serial/Kconfig linux-2.6-patched/drivers/serial/Kconfig
--- linux-2.6/drivers/serial/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/serial/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -5,6 +5,7 @@
 #
 
 menu "Serial drivers"
+	depends on !S390
 
 #
 # The new 8250/16550 serial drivers
diff -urpN linux-2.6/drivers/spi/Kconfig linux-2.6-patched/drivers/spi/Kconfig
--- linux-2.6/drivers/spi/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/spi/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -6,6 +6,7 @@
 # fully appropriate there, so it'd need some thought to do well.
 #
 menu "SPI support"
+	depends on !S390
 
 config SPI
 	bool "SPI support"
diff -urpN linux-2.6/drivers/telephony/Kconfig linux-2.6-patched/drivers/telephony/Kconfig
--- linux-2.6/drivers/telephony/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/telephony/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Telephony Support"
+	depends on !S390
 
 config PHONE
 	tristate "Linux telephony support"
diff -urpN linux-2.6/drivers/usb/Kconfig linux-2.6-patched/drivers/usb/Kconfig
--- linux-2.6/drivers/usb/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/usb/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "USB support"
+	depends on !S390
 
 # Host-side USB depends on having a host controller
 # NOTE:  dummy_hcd is always an option, but it's ignored here ...
diff -urpN linux-2.6/drivers/video/Kconfig linux-2.6-patched/drivers/video/Kconfig
--- linux-2.6/drivers/video/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/video/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Graphics support"
+	depends on !S390
 
 config FIRMWARE_EDID
        bool "Enable firmware EDID"
diff -urpN linux-2.6/drivers/w1/Kconfig linux-2.6-patched/drivers/w1/Kconfig
--- linux-2.6/drivers/w1/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/drivers/w1/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -1,4 +1,5 @@
 menu "Dallas's 1-wire bus"
+	depends on !S390
 
 config W1
 	tristate "Dallas's 1-wire support"
diff -urpN linux-2.6/include/asm-s390/param.h linux-2.6-patched/include/asm-s390/param.h
--- linux-2.6/include/asm-s390/param.h	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/param.h	2006-06-30 11:21:07.000000000 +0200
@@ -10,7 +10,7 @@
 #define _ASMS390_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		100		/* Internal kernel timer frequency */
+# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
diff -urpN linux-2.6/lib/Kconfig.debug linux-2.6-patched/lib/Kconfig.debug
--- linux-2.6/lib/Kconfig.debug	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/lib/Kconfig.debug	2006-06-30 11:21:07.000000000 +0200
@@ -64,7 +64,7 @@ config LOG_BUF_SHIFT
 
 config DETECT_SOFTLOCKUP
 	bool "Detect Soft Lockups"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !S390
 	default y
 	help
 	  Say Y here to enable the kernel to detect "soft lockups",
diff -urpN linux-2.6/net/ax25/Kconfig linux-2.6-patched/net/ax25/Kconfig
--- linux-2.6/net/ax25/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/net/ax25/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -7,7 +7,7 @@
 # 19980129	Moved to net/ax25/Config.in, sourcing device drivers.
 
 menuconfig HAMRADIO
-	depends on NET
+	depends on NET && !S390
 	bool "Amateur Radio support"
 	help
 	  If you want to connect your Linux box to an amateur radio, answer Y
diff -urpN linux-2.6/net/bluetooth/Kconfig linux-2.6-patched/net/bluetooth/Kconfig
--- linux-2.6/net/bluetooth/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/net/bluetooth/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menuconfig BT
-	depends on NET
+	depends on NET && !S390
 	tristate "Bluetooth subsystem support"
 	help
 	  Bluetooth is low-cost, low-power, short-range wireless technology.
diff -urpN linux-2.6/net/irda/Kconfig linux-2.6-patched/net/irda/Kconfig
--- linux-2.6/net/irda/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/net/irda/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menuconfig IRDA
-	depends on NET
+	depends on NET && !S390
 	tristate "IrDA (infrared) subsystem support"
 	select CRC_CCITT
 	---help---
diff -urpN linux-2.6/sound/Kconfig linux-2.6-patched/sound/Kconfig
--- linux-2.6/sound/Kconfig	2006-06-30 13:35:13.000000000 +0200
+++ linux-2.6-patched/sound/Kconfig	2006-06-30 11:21:07.000000000 +0200
@@ -2,6 +2,7 @@
 #
 
 menu "Sound"
+	depends on !S390
 
 config SOUND
 	tristate "Sound card support"


