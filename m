From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 14/15] serial: Add h8300
Date: Wed, 28 Jan 2015 22:32:08 +0900
Message-ID: <05a2a27b9735e982de73125b5a9c44c2479470ad.1422429854.git.ysato@users.sourceforge.jp>
References: <cover.1422429854.git.ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:57135 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641AbbA1U6Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jan 2015 15:58:24 -0500
In-Reply-To: <cover.1422429854.git.ysato@users.sourceforge.jp>
In-Reply-To: <cover.1422429854.git.ysato@users.sourceforge.jp>
References: <cover.1422429854.git.ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

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
2.1.3
