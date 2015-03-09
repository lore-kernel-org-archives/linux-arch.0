Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:42868 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbbCIIr3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 04:47:29 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v6 14/16] serial: Add h8300
Date: Mon,  9 Mar 2015 17:47:08 +0900
Message-ID: <1425890830-29399-15-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
References: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150309084708.lcNNbERcGW_WdLoza-Pt7VQUaZ-s9PUvc-_zY-kIdo8@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d2501f0..db93a85 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -738,7 +738,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST || H8300
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
-- 
2.1.4

