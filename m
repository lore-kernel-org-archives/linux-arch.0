From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V3 25/26] clocksource: add C-SKY timers' build infrastructure
Date: Wed,  5 Sep 2018 20:08:04 +0800
Message-ID: <06ef7aacf1ada727ef83cda3b2b8e1ca742c96d5.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/clocksource/Kconfig  | 15 +++++++++++++++
 drivers/clocksource/Makefile |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dec0dd8..6ff0a25 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -609,4 +609,19 @@ config ATCPIT100_TIMER
 	help
 	  This option enables support for the Andestech ATCPIT100 timers.
 
+config CSKY_MPTIMER
+	bool "C-SKY mptimer driver"
+	depends on CSKY
+	select TIMER_OF
+	help
+	  This option enables support for C-SKY mptimer.
+
+config GX6605S_TIMER
+	bool "Gx6605s SOC system timer driver"
+	depends on CSKY
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  This option enables support for gx6605s timer.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 00caf37..764a45a 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -78,3 +78,5 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
+obj-$(CONFIG_CSKY_MPTIMER)		+= csky_mptimer.o
+obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
-- 
2.7.4
