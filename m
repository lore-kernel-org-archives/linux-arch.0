Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:55203 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932202AbWIEQda
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 12:33:30 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.7/8.13.7) with ESMTP id k85GXTwT053382
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 16:33:29 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k85Gbqd01867806
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:37:52 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k85GXST3005228
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:33:28 +0200
Received: from localhost (dyn-9-152-216-78.boeblingen.de.ibm.com [9.152.216.78])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k85GXSCi005225
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 18:33:28 +0200
Date: Tue, 5 Sep 2006 18:33:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/5] Kconfig: use disable command.
Message-ID: <20060905163328.GD6510@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 3/5] Kconfig: use disable command.

Use the new disable command to simplify some Kconfig options.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/arm/Kconfig              |    5 +++++
 arch/arm26/Kconfig            |    2 ++
 arch/frv/Kconfig              |   12 ++++++++++++
 arch/h8300/Kconfig            |    2 +-
 arch/i386/Kconfig             |    4 ++++
 arch/ia64/Kconfig             |    5 +++++
 arch/m32r/Kconfig             |    3 +++
 arch/m68k/Kconfig             |   11 +++++++++++
 arch/m68knommu/Kconfig        |   10 ++++++++++
 arch/parisc/Kconfig           |   11 +++++++++++
 arch/powerpc/Kconfig          |   10 ++++++++++
 arch/ppc/Kconfig              |    8 ++++++++
 arch/s390/Kconfig             |    2 ++
 arch/sparc/Kconfig            |   14 ++++++++++++++
 arch/sparc64/Kconfig          |   12 ++++++++++++
 arch/um/Kconfig               |    3 +++
 arch/x86_64/Kconfig           |    4 ++++
 drivers/block/Kconfig         |    2 --
 drivers/char/Kconfig          |    5 ++---
 drivers/eisa/Kconfig          |    2 +-
 drivers/fc4/Kconfig           |    2 +-
 drivers/firmware/Kconfig      |    1 -
 drivers/ide/Kconfig           |    2 +-
 drivers/input/misc/Kconfig    |    2 +-
 drivers/input/serio/Kconfig   |    1 -
 drivers/isdn/hisax/Kconfig    |   11 +++++------
 drivers/media/video/Kconfig   |    6 +++---
 drivers/parport/Kconfig       |    2 +-
 drivers/serial/Kconfig        |    2 +-
 drivers/video/Kconfig         |    2 +-
 drivers/video/console/Kconfig |    5 ++---
 sound/pci/Kconfig             |    2 +-
 32 files changed, 137 insertions(+), 28 deletions(-)

diff -urpN linux-2.6/arch/arm/Kconfig linux-2.6-patched/arch/arm/Kconfig
--- linux-2.6/arch/arm/Kconfig	2006-09-05 16:56:14.000000000 +0200
+++ linux-2.6-patched/arch/arm/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -3,6 +3,11 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+disable GEN_RTC
+disable RTC
+disable SERIO_I8042 if !ARCH_SHARK && !FOOTBRIDGE_HOST
+disable VGA_CONSOLE if ARCH_ACORN || ARCH_EBSA110 || ARCH_VERSATILE
+
 mainmenu "Linux Kernel Configuration"
 
 config ARM
diff -urpN linux-2.6/arch/arm26/Kconfig linux-2.6-patched/arch/arm26/Kconfig
--- linux-2.6/arch/arm26/Kconfig	2006-09-05 16:56:15.000000000 +0200
+++ linux-2.6-patched/arch/arm26/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -3,6 +3,8 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+disable VGA_CONSOLE
+
 mainmenu "Linux Kernel Configuration"
 
 config ARM
diff -urpN linux-2.6/arch/frv/Kconfig linux-2.6-patched/arch/frv/Kconfig
--- linux-2.6/arch/frv/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/frv/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -2,6 +2,18 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/kconfig-language.txt.
 #
+
+disable BLK_DEV_INITRD if !BROKEN
+disable GEN_RTC
+disable HISAX_ENTERNOW_PCI if !BROKEN
+disable HISAX_HFC_PCI if !BROKEN
+disable HISAX_NETJET if !BROKEN
+disable HISAX_NETJET_U if !BROKEN
+disable HISAX_TELESPCI if !BROKEN
+disable PARPORT_PC
+disable RTC
+disable VGA_CONSOLE
+
 config FRV
 	bool
 	default y
diff -urpN linux-2.6/arch/h8300/Kconfig linux-2.6-patched/arch/h8300/Kconfig
--- linux-2.6/arch/h8300/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/h8300/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -136,7 +136,7 @@ config VT_CONSOLE
 
 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !UM
+	depends on VT
 	default y
 
 comment "Unix98 PTY support"
diff -urpN linux-2.6/arch/i386/Kconfig linux-2.6-patched/arch/i386/Kconfig
--- linux-2.6/arch/i386/Kconfig	2006-09-05 16:57:00.000000000 +0200
+++ linux-2.6-patched/arch/i386/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -762,6 +762,10 @@ config VGA_NOPROBE
          data.  Say N here unless you are absolutely sure this is what you
          want.
 
+disable VGA_CONSOLE if VGA_NOPROBE
+disable FB_VESA if VGA_NOPROBE
+disable FB_SIS if VGA_NOPROBE
+
 source kernel/Kconfig.hz
 
 config KEXEC
diff -urpN linux-2.6/arch/ia64/Kconfig linux-2.6-patched/arch/ia64/Kconfig
--- linux-2.6/arch/ia64/Kconfig	2006-09-05 16:57:00.000000000 +0200
+++ linux-2.6-patched/arch/ia64/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -3,6 +3,11 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+disable EDD
+disable GEN_RTC
+disable RTC
+disable SERIAL_8250_MANY_PORTS
+
 mainmenu "IA-64 Linux Kernel Configuration"
 
 source "init/Kconfig"
diff -urpN linux-2.6/arch/m32r/Kconfig linux-2.6-patched/arch/m32r/Kconfig
--- linux-2.6/arch/m32r/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/m32r/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -3,6 +3,9 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+disable GEN_RTC
+disable PARPORT_PC
+
 mainmenu "Linux/M32R Kernel Configuration"
 
 config M32R
diff -urpN linux-2.6/arch/m68k/Kconfig linux-2.6-patched/arch/m68k/Kconfig
--- linux-2.6/arch/m68k/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/m68k/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -2,6 +2,17 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/kconfig-language.txt.
 #
+
+disable HISAX_ENTERNOW_PCI if !BROKEN
+disable HISAX_HFC_PCI if !BROKEN
+disable HISAX_NETJET if !BROKEN
+disable HISAX_NETJET_U if !BROKEN
+disable HISAX_TELESPCI if !BROKEN
+disable MDA_CONSOLE
+disable RTC
+disable SERIO_I8042
+disable VGA_CONSOLE
+
 config M68K
 	bool
 	default y
diff -urpN linux-2.6/arch/m68knommu/Kconfig linux-2.6-patched/arch/m68knommu/Kconfig
--- linux-2.6/arch/m68knommu/Kconfig	2006-09-05 16:56:16.000000000 +0200
+++ linux-2.6-patched/arch/m68knommu/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -3,6 +3,16 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+disable HISAX_ENTERNOW_PCI if !BROKEN
+disable HISAX_HFC_PCI if !BROKEN
+disable HISAX_NETJET if !BROKEN
+disable HISAX_NETJET_U if !BROKEN
+disable HISAX_TELESPCI if !BROKEN
+disable MDA_CONSOLE
+disable RTC
+disable SERIO_I8042
+disable VGA_CONSOLE
+
 mainmenu "uClinux/68k (w/o MMU) Kernel Configuration"
 
 config M68K
diff -urpN linux-2.6/arch/parisc/Kconfig linux-2.6-patched/arch/parisc/Kconfig
--- linux-2.6/arch/parisc/Kconfig	2006-09-05 16:57:00.000000000 +0200
+++ linux-2.6-patched/arch/parisc/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -3,6 +3,17 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+disable EISA_PCI_EISA
+disable HISAX_ENTERNOW_PCI if !BROKEN
+disable HISAX_HFC_PCI if !BROKEN
+disable HISAX_NETJET if !BROKEN
+disable HISAX_NETJET_U if !BROKEN
+disable HISAX_TELESPCI if !BROKEN
+disable MDA_CONSOLE
+disable RTC
+disable SERIO_I8042
+disable VGA_CONSOLE
+
 mainmenu "Linux/PA-RISC Kernel Configuration"
 
 config PARISC
diff -urpN linux-2.6/arch/powerpc/Kconfig linux-2.6-patched/arch/powerpc/Kconfig
--- linux-2.6/arch/powerpc/Kconfig	2006-09-05 16:57:01.000000000 +0200
+++ linux-2.6-patched/arch/powerpc/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -2,6 +2,16 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+disable HISAX_ENTERNOW_PCI if !BROKEN
+disable HISAX_FRITZPCI if !BROKEN
+disable HISAX_HFC_PCI if !BROKEN
+disable HISAX_NETJET if !BROKEN
+disable HISAX_NETJET_U if !BROKEN
+disable HISAX_TELESPCI if !BROKEN
+disable RTC
+disable VIDEO_STRADIS
+disable VGA_CONSOLE if 4xx || 8xx
+
 mainmenu "Linux/PowerPC Kernel Configuration"
 
 config PPC64
diff -urpN linux-2.6/arch/ppc/Kconfig linux-2.6-patched/arch/ppc/Kconfig
--- linux-2.6/arch/ppc/Kconfig	2006-09-05 16:57:01.000000000 +0200
+++ linux-2.6-patched/arch/ppc/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -2,6 +2,14 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+disable HISAX_ENTERNOW_PCI if !BROKEN
+disable HISAX_HFC_PCI if !BROKEN
+disable HISAX_NETJET if !BROKEN
+disable HISAX_NETJET_U if !BROKEN
+disable HISAX_TELESPCI if !BROKEN
+disable RTC
+disable VGA_CONSOLE if 4xx || 8xx
+
 mainmenu "Linux/PowerPC Kernel Configuration"
 
 config MMU
diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-09-05 16:57:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2006-09-05 16:57:19.000000000 +0200
@@ -3,6 +3,8 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+disable HW_CONSOLE
+
 config MMU
 	bool
 	default y
diff -urpN linux-2.6/arch/sparc/Kconfig linux-2.6-patched/arch/sparc/Kconfig
--- linux-2.6/arch/sparc/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/sparc/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -3,6 +3,20 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+disable FB_ATY
+disable FONT_MINI_4x6
+disable GEN_RTC
+disable HISAX_ENTERNOW_PCI if !BROKEN
+disable HISAX_HFC_PCI if !BROKEN
+disable HISAX_NETJET if !BROKEN
+disable HISAX_NETJET_U if !BROKEN
+disable HISAX_TELESPCI if !BROKEN
+disable PARPORT_PC
+disable RTC if !PCI
+disable SCSI_FCAL
+disable VGA_CONSOLE
+disable VIDEO_VIVI
+
 mainmenu "Linux/SPARC Kernel Configuration"
 
 config MMU
diff -urpN linux-2.6/arch/sparc64/Kconfig linux-2.6-patched/arch/sparc64/Kconfig
--- linux-2.6/arch/sparc64/Kconfig	2006-09-05 16:57:01.000000000 +0200
+++ linux-2.6-patched/arch/sparc64/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -3,6 +3,18 @@
 # see the Configure script.
 #
 
+disable FONT_MINI_4x6
+disable GEN_RTC
+disable HISAX_ENTERNOW_PCI if !BROKEN
+disable HISAX_HFC_PCI if !BROKEN
+disable HISAX_NETJET if !BROKEN
+disable HISAX_NETJET_U if !BROKEN
+disable PARPORT_PC if !PCI
+disable RTC if !PCI
+disable SCSI_FCAL
+disable VGA_CONSOLE
+disable VIDEO_VIVI
+
 mainmenu "Linux/UltraSPARC Kernel Configuration"
 
 config SPARC
diff -urpN linux-2.6/arch/um/Kconfig linux-2.6-patched/arch/um/Kconfig
--- linux-2.6/arch/um/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/um/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -1,3 +1,6 @@
+disable CDROM_PKTCDVD
+disable HW_CONSOLE
+
 # UML uses the generic IRQ sugsystem
 config GENERIC_HARDIRQS
 	bool
diff -urpN linux-2.6/arch/x86_64/Kconfig linux-2.6-patched/arch/x86_64/Kconfig
--- linux-2.6/arch/x86_64/Kconfig	2006-09-05 16:57:01.000000000 +0200
+++ linux-2.6-patched/arch/x86_64/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -7,6 +7,10 @@
 # ISA drivers you need yourself.
 #
 
+disable BLK_DEV_CS5535
+disable INPUT_WISTRON_BTNS
+disable SND_CS5535AUDIO
+
 mainmenu "Linux Kernel Configuration"
 
 config X86_64
diff -urpN linux-2.6/drivers/block/Kconfig linux-2.6-patched/drivers/block/Kconfig
--- linux-2.6/drivers/block/Kconfig	2006-09-05 16:57:02.000000000 +0200
+++ linux-2.6-patched/drivers/block/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -414,7 +414,6 @@ config BLK_DEV_RAM_BLOCKSIZE
 
 config BLK_DEV_INITRD
 	bool "Initial RAM filesystem and RAM disk (initramfs/initrd) support"
-	depends on BROKEN || !FRV
 	help
 	  The initial RAM filesystem is a ramfs which is loaded by the
 	  boot loader (loadlin or lilo) and that is mounted as root
@@ -428,7 +427,6 @@ config BLK_DEV_INITRD
 
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media"
-	depends on !UML
 	help
 	  If you have a CDROM drive that supports packet writing, say Y to
 	  include preliminary support. It should work with any MMC/Mt Fuji
diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-patched/drivers/char/Kconfig
--- linux-2.6/drivers/char/Kconfig	2006-09-05 16:57:18.000000000 +0200
+++ linux-2.6-patched/drivers/char/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -59,7 +59,7 @@ config VT_CONSOLE
 
 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !UML
+	depends on VT
 	default y
 
 config VT_HW_CONSOLE_BINDING
@@ -749,7 +749,6 @@ config NVRAM
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -797,7 +796,7 @@ config SGI_IP27_RTC
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
+	depends on RTC!=y
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
diff -urpN linux-2.6/drivers/eisa/Kconfig linux-2.6-patched/drivers/eisa/Kconfig
--- linux-2.6/drivers/eisa/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/eisa/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -14,7 +14,7 @@ config EISA_VLB_PRIMING
 
 config EISA_PCI_EISA
 	bool "Generic PCI/EISA bridge"
-	depends on !PARISC && PCI && EISA
+	depends on PCI && EISA
 	default y
 	---help---
 	  Activate this option if your system contains a PCI to EISA
diff -urpN linux-2.6/drivers/fc4/Kconfig linux-2.6-patched/drivers/fc4/Kconfig
--- linux-2.6/drivers/fc4/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/fc4/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -75,7 +75,7 @@ config SCSI_FCAL
 
 config SCSI_FCAL
 	prompt "Generic FC-AL disk driver"
-	depends on FC4!=n && SCSI && !SPARC
+	depends on FC4!=n && SCSI
 
 endmenu
 
diff -urpN linux-2.6/drivers/firmware/Kconfig linux-2.6-patched/drivers/firmware/Kconfig
--- linux-2.6/drivers/firmware/Kconfig	2006-09-05 16:57:02.000000000 +0200
+++ linux-2.6-patched/drivers/firmware/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -7,7 +7,6 @@ menu "Firmware Drivers"
 
 config EDD
 	tristate "BIOS Enhanced Disk Drive calls determine boot disk"
-	depends on !IA64
 	help
 	  Say Y or M here if you want to enable BIOS Enhanced Disk Drive
 	  Services real mode BIOS calls to determine which disk
diff -urpN linux-2.6/drivers/ide/Kconfig linux-2.6-patched/drivers/ide/Kconfig
--- linux-2.6/drivers/ide/Kconfig	2006-09-05 16:57:02.000000000 +0200
+++ linux-2.6-patched/drivers/ide/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -543,7 +543,7 @@ config BLK_DEV_CS5530
 
 config BLK_DEV_CS5535
 	tristate "AMD CS5535 chipset support"
-	depends on X86 && !X86_64
+	depends on X86
 	help
 	  Include support for UDMA on the NSC/AMD CS5535 companion chipset.
 	  This will automatically be detected and configured if found.
diff -urpN linux-2.6/drivers/input/misc/Kconfig linux-2.6-patched/drivers/input/misc/Kconfig
--- linux-2.6/drivers/input/misc/Kconfig	2006-09-05 16:56:22.000000000 +0200
+++ linux-2.6-patched/drivers/input/misc/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -42,7 +42,7 @@ config INPUT_M68K_BEEP
 
 config INPUT_WISTRON_BTNS
 	tristate "x86 Wistron laptop button interface"
-	depends on X86 && !X86_64
+	depends on X86
 	help
 	  Say Y here for support of Winstron laptop button interface, used on
 	  laptops of various brands, including Acer and Fujitsu-Siemens.
diff -urpN linux-2.6/drivers/input/serio/Kconfig linux-2.6-patched/drivers/input/serio/Kconfig
--- linux-2.6/drivers/input/serio/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/input/serio/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -21,7 +21,6 @@ if SERIO
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
-	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,
diff -urpN linux-2.6/drivers/isdn/hisax/Kconfig linux-2.6-patched/drivers/isdn/hisax/Kconfig
--- linux-2.6/drivers/isdn/hisax/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/isdn/hisax/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -110,7 +110,7 @@ config HISAX_16_3
 
 config HISAX_TELESPCI
 	bool "Teles PCI"
-	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
+	depends on PCI
 	help
 	  This enables HiSax support for the Teles PCI.
 	  See <file:Documentation/isdn/README.HiSax> on how to configure it.
@@ -134,7 +134,6 @@ config HISAX_AVM_A1
 
 config HISAX_FRITZPCI
 	bool "AVM PnP/PCI (Fritz!PnP/PCI)"
-	depends on BROKEN || !PPC64
 	help
 	  This enables HiSax support for the AVM "Fritz!PnP" and "Fritz!PCI".
 	  See <file:Documentation/isdn/README.HiSax> on how to configure it.
@@ -238,7 +237,7 @@ config HISAX_MIC
 
 config HISAX_NETJET
 	bool "NETjet card"
-	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
+	depends on PCI
 	help
 	  This enables HiSax support for the NetJet from Traverse
 	  Technologies.
@@ -249,7 +248,7 @@ config HISAX_NETJET
 
 config HISAX_NETJET_U
 	bool "NETspider U card"
-	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
+	depends on PCI
 	help
 	  This enables HiSax support for the Netspider U interface ISDN card
 	  from Traverse Technologies.
@@ -317,7 +316,7 @@ config HISAX_GAZEL
 
 config HISAX_HFC_PCI
 	bool "HFC PCI-Bus cards"
-	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
+	depends on PCI
 	help
 	  This enables HiSax support for the HFC-S PCI 2BDS0 based cards.
 
@@ -344,7 +343,7 @@ config HISAX_HFC_SX
 
 config HISAX_ENTERNOW_PCI
 	bool "Formula-n enter:now PCI card"
-	depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || FRV))
+	depends on PCI
 	help
 	  This enables HiSax support for the Formula-n enter:now PCI
 	  ISDN card.
diff -urpN linux-2.6/drivers/media/video/Kconfig linux-2.6-patched/drivers/media/video/Kconfig
--- linux-2.6/drivers/media/video/Kconfig	2006-09-05 16:57:03.000000000 +0200
+++ linux-2.6-patched/drivers/media/video/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -18,7 +18,7 @@ config VIDEO_ADV_DEBUG
 
 config VIDEO_VIVI
 	tristate "Virtual Video Driver"
-	depends on VIDEO_V4L2 && !SPARC32 && !SPARC64
+	depends on VIDEO_V4L2
 	select VIDEO_BUF
 	default n
 	---help---
@@ -170,7 +170,7 @@ config VIDEO_VINO
 
 config VIDEO_STRADIS
 	tristate "Stradis 4:2:2 MPEG-2 video driver  (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PCI && VIDEO_V4L1 && !PPC64
+	depends on EXPERIMENTAL && PCI && VIDEO_V4L1
 	help
 	  Say Y here to enable support for the Stradis 4:2:2 MPEG-2 video
 	  driver for PCI.  There is a product page at
@@ -178,7 +178,7 @@ config VIDEO_STRADIS
 
 config VIDEO_ZORAN
 	tristate "Zoran ZR36057/36067 Video For Linux"
-	depends on PCI && I2C_ALGOBIT && VIDEO_V4L1 && !PPC64
+	depends on PCI && I2C_ALGOBIT && VIDEO_V4L1
 	help
 	  Say Y for support for MJPEG capture cards based on the Zoran
 	  36057/36067 PCI controller chipset. This includes the Iomega
diff -urpN linux-2.6/drivers/parport/Kconfig linux-2.6-patched/drivers/parport/Kconfig
--- linux-2.6/drivers/parport/Kconfig	2006-09-05 16:56:28.000000000 +0200
+++ linux-2.6-patched/drivers/parport/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -34,7 +34,7 @@ config PARPORT
 
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on PARPORT && (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV
+	depends on PARPORT
 	---help---
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
diff -urpN linux-2.6/drivers/serial/Kconfig linux-2.6-patched/drivers/serial/Kconfig
--- linux-2.6/drivers/serial/Kconfig	2006-09-05 16:57:05.000000000 +0200
+++ linux-2.6-patched/drivers/serial/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -140,7 +140,7 @@ config SERIAL_8250_EXTENDED
 
 config SERIAL_8250_MANY_PORTS
 	bool "Support more than 4 legacy serial ports"
-	depends on SERIAL_8250_EXTENDED && !IA64
+	depends on SERIAL_8250_EXTENDED
 	help
 	  Say Y here if you have dumb serial boards other than the four
 	  standard COM 1/2/3/4 ports. This may happen if you have an AST
diff -urpN linux-2.6/drivers/video/console/Kconfig linux-2.6-patched/drivers/video/console/Kconfig
--- linux-2.6/drivers/video/console/Kconfig	2006-09-05 16:57:08.000000000 +0200
+++ linux-2.6-patched/drivers/video/console/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -6,7 +6,6 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if (EMBEDDED || !X86)
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE && !VGA_NOPROBE
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
@@ -67,7 +66,7 @@ config VIDEO_SELECT
 	  about the Video mode selection support. If unsure, say N.
 
 config MDA_CONSOLE
-	depends on !M68K && !PARISC && ISA
+	depends on ISA
 	tristate "MDA text console (dual-headed) (EXPERIMENTAL)"
 	---help---
 	  Say Y here if you have an old MDA or monochrome Hercules graphics
@@ -215,7 +214,7 @@ config FONT_ACORN_8x8
 
 config FONT_MINI_4x6
 	bool "Mini 4x6 font"
-	depends on !SPARC && FONTS
+	depends on FONTS
 
 config FONT_SUN8x16
 	bool "Sparc console 8x16 font"
diff -urpN linux-2.6/drivers/video/Kconfig linux-2.6-patched/drivers/video/Kconfig
--- linux-2.6/drivers/video/Kconfig	2006-09-05 16:57:08.000000000 +0200
+++ linux-2.6-patched/drivers/video/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -1090,7 +1090,7 @@ config FB_ATY128_BACKLIGHT
 
 config FB_ATY
 	tristate "ATI Mach64 display support" if PCI || ATARI
-	depends on FB && !SPARC32
+	depends on FB
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff -urpN linux-2.6/sound/pci/Kconfig linux-2.6-patched/sound/pci/Kconfig
--- linux-2.6/sound/pci/Kconfig	2006-09-05 16:57:13.000000000 +0200
+++ linux-2.6-patched/sound/pci/Kconfig	2006-09-05 16:57:20.000000000 +0200
@@ -217,7 +217,7 @@ config SND_CS46XX_NEW_DSP
 
 config SND_CS5535AUDIO
 	tristate "CS5535/CS5536 Audio"
-	depends on SND && X86 && !X86_64
+	depends on SND && X86
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
