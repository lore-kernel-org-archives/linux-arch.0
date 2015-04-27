From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v9 14/17] serial: Add H8300.
Date: Mon, 27 Apr 2015 14:35:21 +0900
Message-ID: <1430112924-1134-15-git-send-email-ysato@users.sourceforge.jp>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

h8300 internal serial controller of same as sh-sci.
So h8300 use SH_SCI.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f8120c1..130f201 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -728,7 +728,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_SHMOBILE || H8300 || COMPILE_TEST 
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
-- 
2.1.4
