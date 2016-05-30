From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH v4 13/16] char/genrtc: remove powerpc support
Date: Mon, 30 May 2016 20:58:01 +0200
Message-ID: <1464634684-1248135-14-git-send-email-arnd@arndb.de>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDEKVJM7XAHRBPU2WK5AKGQEYDMY6AY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, dalias-8zAoT0mYgF4@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

PowerPC is the last architecture using the GEN_RTC driver on some
machines, but we can migrate them all to using the RTC_DRV_GENERIC
driver instead now.

This moves over the CONFIG_GEN_RTC option from drivers/char into
arch/powerpc/platforms/Kconfig and makes it just select the
replacement driver instead, for the only reason of not breaking
existing defconfig and .config files that users may have.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 arch/powerpc/include/asm/rtc.h    | 78 ---------------------------------------
 arch/powerpc/platforms/Kconfig    | 11 ++++++
 arch/powerpc/platforms/ps3/time.c |  2 +-
 drivers/char/Kconfig              |  4 +-
 drivers/char/Makefile             |  2 +-
 5 files changed, 15 insertions(+), 82 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/rtc.h

diff --git a/arch/powerpc/include/asm/rtc.h b/arch/powerpc/include/asm/rtc.h
deleted file mode 100644
index f5802926b6c0..000000000000
--- a/arch/powerpc/include/asm/rtc.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * Real-time clock definitions and interfaces
- *
- * Author: Tom Rini <trini-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
- *
- * 2002 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Based on:
- * include/asm-m68k/rtc.h
- *
- * Copyright Richard Zidlicky
- * implementation details for genrtc/q40rtc driver
- *
- * And the old drivers/macintosh/rtc.c which was heavily based on:
- * Linux/SPARC Real Time Clock Driver
- * Copyright (C) 1996 Thomas K. Dyas (tdyas-plZrL8KR64B+CIkdHa1UOg@public.gmane.org)
- *
- * With additional work by Paul Mackerras and Franz Sirl.
- */
-
-#ifndef __ASM_POWERPC_RTC_H__
-#define __ASM_POWERPC_RTC_H__
-
-#ifdef __KERNEL__
-
-#include <linux/rtc.h>
-
-#include <asm/machdep.h>
-#include <asm/time.h>
-
-#define RTC_PIE 0x40		/* periodic interrupt enable */
-#define RTC_AIE 0x20		/* alarm interrupt enable */
-#define RTC_UIE 0x10		/* update-finished interrupt enable */
-
-/* some dummy definitions */
-#define RTC_BATT_BAD 0x100	/* battery bad */
-#define RTC_SQWE 0x08		/* enable square-wave output */
-#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
-#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
-#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
-
-static inline unsigned int get_rtc_time(struct rtc_time *time)
-{
-	if (ppc_md.get_rtc_time)
-		ppc_md.get_rtc_time(time);
-	return RTC_24H;
-}
-
-/* Set the current date and time in the real time clock. */
-static inline int set_rtc_time(struct rtc_time *time)
-{
-	if (ppc_md.set_rtc_time)
-		return ppc_md.set_rtc_time(time);
-	return -EINVAL;
-}
-
-static inline unsigned int get_rtc_ss(void)
-{
-	struct rtc_time h;
-
-	get_rtc_time(&h);
-	return h.tm_sec;
-}
-
-static inline int get_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-static inline int set_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-
-#endif /* __KERNEL__ */
-#endif /* __ASM_POWERPC_RTC_H__ */
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 46a3533d3acb..863aa4341390 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -321,6 +321,17 @@ config OF_RTC
 	  Uses information from the OF or flattened device tree to instantiate
 	  platform devices for direct mapped RTC chips like the DS1742 or DS1743.
 
+config GEN_RTC
+	bool "Use the platform RTC operations from user space"
+	select RTC_CLASS
+	select RTC_DRV_GENERIC
+	help
+	  This option provides backwards compatibility with the old gen_rtc.ko
+	  module that was traditionally used for old PowerPC machines.
+	  Platforms should migrate to enabling the RTC_DRV_GENERIC by hand
+	  replacing their get_rtc_time/set_rtc_time callbacks with
+	  a proper RTC device driver.
+
 config SIMPLE_GPIO
 	bool "Support for simple, memory-mapped GPIO controllers"
 	depends on PPC
diff --git a/arch/powerpc/platforms/ps3/time.c b/arch/powerpc/platforms/ps3/time.c
index 791c6142c4a7..11b45b58c81b 100644
--- a/arch/powerpc/platforms/ps3/time.c
+++ b/arch/powerpc/platforms/ps3/time.c
@@ -20,9 +20,9 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/rtc.h>
 
 #include <asm/firmware.h>
-#include <asm/rtc.h>
 #include <asm/lv1call.h>
 #include <asm/ps3.h>
 
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index fccac76257c9..153e90f8a445 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -325,10 +325,10 @@ config JS_RTC
 	  To compile this driver as a module, choose M here: the
 	  module will be called js-rtc.
 
-config GEN_RTC
+config OLD_GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on PPC
+	depends on BROKEN
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index d8a7579300d2..fc0905aa7373 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_APPLICOM)		+= applicom.o
 obj-$(CONFIG_SONYPI)		+= sonypi.o
 obj-$(CONFIG_RTC)		+= rtc.o
 obj-$(CONFIG_HPET)		+= hpet.o
-obj-$(CONFIG_GEN_RTC)		+= genrtc.o
+obj-$(CONFIG_OLD_GEN_RTC)	+= genrtc.o
 obj-$(CONFIG_EFI_RTC)		+= efirtc.o
 obj-$(CONFIG_DS1302)		+= ds1302.o
 obj-$(CONFIG_XILINX_HWICAP)	+= xilinx_hwicap/
-- 
2.7.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
