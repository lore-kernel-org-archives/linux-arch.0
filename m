Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-co1nam03on0082.outbound.protection.outlook.com ([104.47.40.82]:17958
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751600AbeCOLCS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 07:02:18 -0400
From: Aaron Wu <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 27/28] documentation: Remove Blackfin documentation
Date: Thu, 15 Mar 2018 18:50:27 +0800
Message-ID: <1521111028-19856-27-git-send-email-aaron.wu@analog.com>
In-Reply-To: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, f.fainelli@gmail.com, linux-arch@vger.kernel.org, kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, liqin.linux@gmail.com, lennox.wu@gmail.com, gxt@mprc.pku.edu.cn, linux@roeck-us.net
Cc: viro@zeniv.linux.org.uk, jhogan@kernel.org, linux-metag@vger.kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, openrisc@lists.librecores.org, dhowells@redhat.com, peterz@infradead.org, aaron.wu@analog.com

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin documentation
---
 Documentation/00-INDEX                             |  2 -
 Documentation/admin-guide/kernel-parameters.rst    |  1 -
 Documentation/admin-guide/kernel-parameters.txt    |  2 +-
 Documentation/blackfin/00-INDEX                    |  6 --
 Documentation/blackfin/bfin-gpio-notes.txt         | 71 ----------------------
 Documentation/blackfin/bfin-spi-notes.txt          | 16 -----
 .../driver-api/usb/writing_musb_glue_layer.rst     |  3 -
 .../features/core/BPF-JIT/arch-support.txt         |  1 -
 .../core/generic-idle-thread/arch-support.txt      |  1 -
 .../features/core/jump-labels/arch-support.txt     |  1 -
 .../features/core/tracehook/arch-support.txt       |  1 -
 .../features/debug/KASAN/arch-support.txt          |  1 -
 .../debug/gcov-profile-all/arch-support.txt        |  1 -
 Documentation/features/debug/kgdb/arch-support.txt |  1 -
 .../debug/kprobes-on-ftrace/arch-support.txt       |  1 -
 .../features/debug/kprobes/arch-support.txt        |  1 -
 .../features/debug/kretprobes/arch-support.txt     |  1 -
 .../features/debug/optprobes/arch-support.txt      |  1 -
 .../features/debug/stackprotector/arch-support.txt |  1 -
 .../features/debug/uprobes/arch-support.txt        |  1 -
 .../debug/user-ret-profiler/arch-support.txt       |  1 -
 .../features/io/dma-api-debug/arch-support.txt     |  1 -
 .../features/io/dma-contiguous/arch-support.txt    |  1 -
 .../features/io/sg-chain/arch-support.txt          |  1 -
 .../features/lib/strncasecmp/arch-support.txt      |  1 -
 .../locking/cmpxchg-local/arch-support.txt         |  1 -
 .../features/locking/lockdep/arch-support.txt      |  1 -
 .../locking/queued-rwlocks/arch-support.txt        |  1 -
 .../locking/queued-spinlocks/arch-support.txt      |  1 -
 .../locking/rwsem-optimized/arch-support.txt       |  1 -
 .../features/perf/kprobes-event/arch-support.txt   |  1 -
 .../features/perf/perf-regs/arch-support.txt       |  1 -
 .../features/perf/perf-stackdump/arch-support.txt  |  1 -
 .../sched/membarrier-sync-core/arch-support.txt    |  1 -
 .../features/sched/numa-balancing/arch-support.txt |  1 -
 .../seccomp/seccomp-filter/arch-support.txt        |  1 -
 .../time/arch-tick-broadcast/arch-support.txt      |  1 -
 .../features/time/clockevents/arch-support.txt     |  1 -
 .../time/context-tracking/arch-support.txt         |  1 -
 .../features/time/irq-time-acct/arch-support.txt   |  1 -
 .../time/modern-timekeeping/arch-support.txt       |  1 -
 .../features/time/virt-cpuacct/arch-support.txt    |  1 -
 .../features/vm/ELF-ASLR/arch-support.txt          |  1 -
 .../features/vm/PG_uncached/arch-support.txt       |  1 -
 Documentation/features/vm/THP/arch-support.txt     |  1 -
 Documentation/features/vm/TLB/arch-support.txt     |  1 -
 .../features/vm/huge-vmap/arch-support.txt         |  1 -
 .../features/vm/ioremap_prot/arch-support.txt      |  1 -
 .../features/vm/numa-memblock/arch-support.txt     |  1 -
 .../features/vm/pte_special/arch-support.txt       |  1 -
 50 files changed, 1 insertion(+), 143 deletions(-)
 delete mode 100644 Documentation/blackfin/00-INDEX
 delete mode 100644 Documentation/blackfin/bfin-gpio-notes.txt
 delete mode 100644 Documentation/blackfin/bfin-spi-notes.txt

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 7f3a072..2956d7f 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -66,8 +66,6 @@ backlight/
 	- directory with info on controlling backlights in flat panel displays
 bcache.txt
 	- Block-layer cache on fast SSDs to improve slow (raid) I/O performance.
-blackfin/
-	- directory with documentation for the Blackfin arch.
 block/
 	- info on the Block I/O (BIO) layer.
 blockdev/
diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 7242cbd..b8d0bc0 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -89,7 +89,6 @@ parameter is applicable::
 	APM	Advanced Power Management support is enabled.
 	ARM	ARM architecture is enabled.
 	AX25	Appropriate AX.25 support is enabled.
-	BLACKFIN Blackfin architecture is enabled.
 	CLK	Common clock infrastructure is enabled.
 	CMA	Contiguous Memory Area support is enabled.
 	DRM	Direct Rendering Management support is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f..0d9b5b7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1025,7 +1025,7 @@
 			address. The serial port must already be setup
 			and configured. Options are not yet supported.
 
-	earlyprintk=	[X86,SH,BLACKFIN,ARM,M68k,S390]
+	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
 			earlyprintk=efi
 			earlyprintk=sclp
diff --git a/Documentation/blackfin/00-INDEX b/Documentation/blackfin/00-INDEX
deleted file mode 100644
index 265a1ef..0000000
--- a/Documentation/blackfin/00-INDEX
+++ /dev/null
@@ -1,6 +0,0 @@
-00-INDEX
-	- This file
-bfin-gpio-notes.txt
-	- Notes in developing/using bfin-gpio driver.
-bfin-spi-notes.txt
-	- Notes for using bfin spi bus driver.
diff --git a/Documentation/blackfin/bfin-gpio-notes.txt b/Documentation/blackfin/bfin-gpio-notes.txt
deleted file mode 100644
index d245f39..0000000
--- a/Documentation/blackfin/bfin-gpio-notes.txt
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * File:         Documentation/blackfin/bfin-gpio-notes.txt
- * Based on:
- * Author:
- *
- * Created:      $Id: bfin-gpio-note.txt 2008-11-24 16:42 grafyang $
- * Description:  This file contains the notes in developing/using bfin-gpio.
- *
- *
- * Rev:
- *
- * Modified:
- *               Copyright 2004-2008 Analog Devices Inc.
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- */
-
-
-1. Blackfin GPIO introduction
-
-    There are many GPIO pins on Blackfin. Most of these pins are muxed to
-    multi-functions. They can be configured as peripheral, or just as GPIO,
-    configured to input with interrupt enabled, or output.
-
-    For detailed information, please see "arch/blackfin/kernel/bfin_gpio.c",
-    or the relevant HRM.
-
-
-2. Avoiding resource conflict
-
-    Followed function groups are used to avoiding resource conflict,
-    - Use the pin as peripheral,
-	int peripheral_request(unsigned short per, const char *label);
-	int peripheral_request_list(const unsigned short per[], const char *label);
-	void peripheral_free(unsigned short per);
-	void peripheral_free_list(const unsigned short per[]);
-    - Use the pin as GPIO,
-	int bfin_gpio_request(unsigned gpio, const char *label);
-	void bfin_gpio_free(unsigned gpio);
-    - Use the pin as GPIO interrupt,
-	int bfin_gpio_irq_request(unsigned gpio, const char *label);
-	void bfin_gpio_irq_free(unsigned gpio);
-
-    The request functions will record the function state for a certain pin,
-    the free functions will clear its function state.
-    Once a pin is requested, it can't be requested again before it is freed by
-    previous caller, otherwise kernel will dump stacks, and the request
-    function fail.
-    These functions are wrapped by other functions, most of the users need not
-    care.
-
-
-3. But there are some exceptions
-    - Kernel permit the identical GPIO be requested both as GPIO and GPIO
-    interrupt.
-    Some drivers, like gpio-keys, need this behavior. Kernel only print out
-    warning messages like,
-	bfin-gpio: GPIO 24 is already reserved by gpio-keys: BTN0, and you are
-configuring it as IRQ!
-
-        Note: Consider the case that, if there are two drivers need the
-	identical GPIO, one of them use it as GPIO, the other use it as
-	GPIO interrupt. This will really cause resource conflict. So if
-	there is any abnormal driver behavior, please check the bfin-gpio
-	warning messages.
-
-    - Kernel permit the identical GPIO be requested from the same driver twice.
-
-
-
diff --git a/Documentation/blackfin/bfin-spi-notes.txt b/Documentation/blackfin/bfin-spi-notes.txt
deleted file mode 100644
index eae6eaf..0000000
--- a/Documentation/blackfin/bfin-spi-notes.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-SPI Chip Select behavior:
-
-With the Blackfin on-chip SPI peripheral, there is some logic tied to the CPHA
-bit whether the Slave Select Line is controlled by hardware (CPHA=0) or
-controlled by software (CPHA=1). However, the Linux SPI bus driver assumes that
-the Slave Select is always under software control and being asserted during
-the entire SPI transfer. - And not just bits_per_word duration.
-
-In most cases you can utilize SPI MODE_3 instead of MODE_0 to work-around this
-behavior. If your SPI slave device in question requires SPI MODE_0 or MODE_2
-timing, you can utilize the GPIO controlled SPI Slave Select option instead.
-In this case, you should use GPIO based CS for all of your slaves and not just
-the ones using mode 0 or 2 in order to guarantee correct CS toggling behavior.
-
-You can even use the same pin whose peripheral role is a SSEL,
-but use it as a GPIO instead.
diff --git a/Documentation/driver-api/usb/writing_musb_glue_layer.rst b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
index e90e8fa..5bf7152 100644
--- a/Documentation/driver-api/usb/writing_musb_glue_layer.rst
+++ b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
@@ -718,6 +718,3 @@ http://www.maximintegrated.com/app-notes/index.mvp/id/1822
 
 Texas Instruments USB Configuration Wiki Page:
 http://processors.wiki.ti.com/index.php/Usbgeneralpage
-
-Analog Devices Blackfin MUSB Configuration:
-http://docs.blackfin.uclinux.org/doku.php?id=linux-kernel:drivers:musb
diff --git a/Documentation/features/core/BPF-JIT/arch-support.txt b/Documentation/features/core/BPF-JIT/arch-support.txt
index 5575d2d..740879c 100644
--- a/Documentation/features/core/BPF-JIT/arch-support.txt
+++ b/Documentation/features/core/BPF-JIT/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index abb5f27..eff8cc3 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index dbdaffc..7f90c27 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index dfb638c..9239b54 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: |  ok  |
     |        cris: | TODO |
     |         frv: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index 3406fae..38f2b5f 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 830dbe8..d5f6330 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index 0217bf6..1100345 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 1e84be3c..250248d 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 529f66e..a23d2f3 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 4335324..145f65b 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index f559f1b..6a4bb93 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 59a4c9f..38f2ed4 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 53ed42b..6f617f7 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 1494439..6b772ed0 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/io/dma-api-debug/arch-support.txt b/Documentation/features/io/dma-api-debug/arch-support.txt
index 6be9206..1c07e83b 100644
--- a/Documentation/features/io/dma-api-debug/arch-support.txt
+++ b/Documentation/features/io/dma-api-debug/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: |  ok  |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 0eb08e1..2d86648 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
index 514ad34..62bc1e0 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/lib/strncasecmp/arch-support.txt b/Documentation/features/lib/strncasecmp/arch-support.txt
index 532c6f0..d71b852 100644
--- a/Documentation/features/lib/strncasecmp/arch-support.txt
+++ b/Documentation/features/lib/strncasecmp/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index f3eec26..4e9f51b 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index 9756abc..4632644 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index 62f4ee5..1cf417e 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 321b32f..aea2efa 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
index 79bfa4d..7414867 100644
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 00f1606..f0f6cec 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 7d516ea..6b305e6 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index f974b8d..cafa704 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 2c815a7..ccbfb24 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -33,7 +33,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 1d3c0f6..54fa603 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ..  |
     |         arm: |  ..  |
     |       arm64: |  ..  |
-    |    blackfin: |  ..  |
     |         c6x: |  ..  |
     |        cris: |  ..  |
     |         frv: |  ..  |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index a32d5b2..dc0a901 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index caee8f6..ca3aa5c 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 1cd87f6..8535d3c 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: |  ok  |
     |        cris: |  ok  |
     |         frv: | TODO |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index e6d7c7b..cffcf08 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 15c6071..9b1ab68 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/modern-timekeeping/arch-support.txt
index baee761..fe4df2f 100644
--- a/Documentation/features/time/modern-timekeeping/arch-support.txt
+++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: |  ok  |
     |        cris: | TODO |
     |         frv: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index 9129530..304b941 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index f6829af..3efb2ae 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index 1a09ea9..aadc97f 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index d170e62..76cfb97 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ..  |
     |         c6x: |  ..  |
     |        cris: |  ..  |
     |         frv: |  ..  |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index abfab40..3a6546a 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: |  ..  |
     |        cris: |  ..  |
     |         frv: |  ..  |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index f81f09b..fe1e3b2 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 0cc3e11..d42dbe0 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
index 9a3fdac..bb9cd30 100644
--- a/Documentation/features/vm/numa-memblock/arch-support.txt
+++ b/Documentation/features/vm/numa-memblock/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ..  |
     |         arm: |  ..  |
     |       arm64: |  ..  |
-    |    blackfin: |  ..  |
     |         c6x: |  ..  |
     |        cris: |  ..  |
     |         frv: |  ..  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index dfaa39e..f7b7626 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
     |        cris: | TODO |
     |         frv: | TODO |
-- 
2.7.4
