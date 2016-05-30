Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:53157 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161870AbcE3S60 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2016 14:58:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 06/16] char/genrtc: remove mn10300 support
Date: Mon, 30 May 2016 20:57:54 +0200
Message-ID: <1464634684-1248135-7-git-send-email-arnd@arndb.de>
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, gregkh@linuxfoundation.org, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com, linux-arch@vger.kernel.org
Message-ID: <20160530185754.SGbBzE2LYeaywYid2WCpywkNNr--Pf0uFxJdkknF97k@z>

The genrtc driver serves no purpose on mn10300 because it drives the
same hardware as the original rtc.c driver, and the newer rtc-generic.c
or rtc-cmos.c drivers on architectures that use the asm-generic/rtc.h
header.

I assume it was initially only added for completeness when the
mn10300 port was done, but the older rtc.c driver was always used
instead.

We can also stop include asm-generic/rtc.h now, because we
just call mc146818_set_time() directly.

It would be nice to change the architecture to use the rtc-cmos driver
next, and remove support for the old rtc driver as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mn10300/include/asm/rtc.h          | 2 --
 arch/mn10300/kernel/rtc.c               | 2 +-
 arch/mn10300/proc-mn103e010/proc-init.c | 1 +
 arch/mn10300/proc-mn2ws0050/proc-init.c | 1 +
 drivers/char/Kconfig                    | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mn10300/include/asm/rtc.h b/arch/mn10300/include/asm/rtc.h
index 6c14bb1d0d9b..07dc87656197 100644
--- a/arch/mn10300/include/asm/rtc.h
+++ b/arch/mn10300/include/asm/rtc.h
@@ -25,6 +25,4 @@ static inline void calibrate_clock(void)
 
 #endif /* !CONFIG_MN10300_RTC */
 
-#include <asm-generic/rtc.h>
-
 #endif /* _ASM_RTC_H */
diff --git a/arch/mn10300/kernel/rtc.c b/arch/mn10300/kernel/rtc.c
index 48d7058b3295..77e0be4d92ea 100644
--- a/arch/mn10300/kernel/rtc.c
+++ b/arch/mn10300/kernel/rtc.c
@@ -27,7 +27,7 @@ void read_persistent_clock(struct timespec *ts)
 {
 	struct rtc_time tm;
 
-	get_rtc_time(&tm);
+	mc146818_set_time(&tm);
 
 	ts->tv_nsec = 0;
 	ts->tv_sec = mktime(tm.tm_year, tm.tm_mon, tm.tm_mday,
diff --git a/arch/mn10300/proc-mn103e010/proc-init.c b/arch/mn10300/proc-mn103e010/proc-init.c
index 27b97980dca4..d4dcb0c56b35 100644
--- a/arch/mn10300/proc-mn103e010/proc-init.c
+++ b/arch/mn10300/proc-mn103e010/proc-init.c
@@ -9,6 +9,7 @@
  * 2 of the Licence, or (at your option) any later version.
  */
 #include <linux/kernel.h>
+#include <asm/cacheflush.h>
 #include <asm/fpu.h>
 #include <asm/rtc.h>
 #include <asm/busctl-regs.h>
diff --git a/arch/mn10300/proc-mn2ws0050/proc-init.c b/arch/mn10300/proc-mn2ws0050/proc-init.c
index ee6d03dbc8d8..950cc8dbb284 100644
--- a/arch/mn10300/proc-mn2ws0050/proc-init.c
+++ b/arch/mn10300/proc-mn2ws0050/proc-init.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 
+#include <asm/cacheflush.h>
 #include <asm/processor.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index e3f2f3e293e5..1d9e3063373b 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -328,7 +328,7 @@ config JS_RTC
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on M68K || MN10300 || PARISC || PPC
+	depends on M68K || PARISC || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0

