From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v7 14/17] serial: Add H8300.
Date: Wed, 11 Mar 2015 23:21:05 +0900
Message-ID: <1426083668-5011-15-git-send-email-ysato@users.sourceforge.jp>
References: <1426083668-5011-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:26581 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbbCKOVX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2015 10:21:23 -0400
In-Reply-To: <1426083668-5011-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

h8300 internal serial controller of same as sh-sci.
So h8300 use SH_SCI.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d2501f0..77d77d4 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -738,7 +738,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_SHMOBILE || H8300 || COMPILE_TEST 
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
-- 
2.1.4
