Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54814 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161878AbcE3S61 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2016 14:58:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 05/16] char/genrtc: remove alpha support
Date: Mon, 30 May 2016 20:57:53 +0200
Message-ID: <1464634684-1248135-6-git-send-email-arnd@arndb.de>
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, gregkh@linuxfoundation.org, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com, linux-arch@vger.kernel.org
Message-ID: <20160530185753.SQHwCRqL0zp0I4uA0RxYZ_2geedxLx8v5fsdkIXEJL0@z>

The genrtc driver serves no purpose on Alpha because it drives the
same hardware as the original rtc.c driver, and the newer rtc-generic.c
or rtc-cmos.c drivers on architectures that use the asm-generic/rtc.h
header.

The defconfig uses CONFIG_RTC=y, so this driver is not used by default.
At one point it was used to abstract a quirk for the "Marvel" platform,
but it does not do this any more after the code was moved into yet
another driver in arch/alpha/kernel/rtc.c.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/rtc.h    | 1 -
 arch/alpha/kernel/core_marvel.c | 1 -
 drivers/char/Kconfig            | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)
 delete mode 100644 arch/alpha/include/asm/rtc.h

diff --git a/arch/alpha/include/asm/rtc.h b/arch/alpha/include/asm/rtc.h
deleted file mode 100644
index f71c3b0ed360..000000000000
--- a/arch/alpha/include/asm/rtc.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/rtc.h>
diff --git a/arch/alpha/kernel/core_marvel.c b/arch/alpha/kernel/core_marvel.c
index 53dd2f1a53aa..d5f0580746a5 100644
--- a/arch/alpha/kernel/core_marvel.c
+++ b/arch/alpha/kernel/core_marvel.c
@@ -24,7 +24,6 @@
 #include <asm/gct.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/rtc.h>
 #include <asm/vga.h>
 
 #include "proto.h"
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 31b5861649ee..e3f2f3e293e5 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -328,7 +328,7 @@ config JS_RTC
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on ALPHA || M68K || MN10300 || PARISC || PPC
+	depends on M68K || MN10300 || PARISC || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0

