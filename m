Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:9091 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbbBUHyS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Feb 2015 02:54:18 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v4 14/15] serial: Add h8300
Date: Sat, 21 Feb 2015 16:53:58 +0900
Message-ID: <1424505239-7082-15-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1424505239-7082-1-git-send-email-ysato@users.sourceforge.jp>
References: <1424505239-7082-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150221075358.-qLbanF1FLQF1pyAiV7Q5-CTDAzcFn9r8Rkl-d2AJhU@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index c79b43c..ed01f33 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -747,7 +747,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST || H8300
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
-- 
2.1.4

