From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 15/28] ARCv2: SMP: clocksource: Enable Global Real Time counter
Date: Tue, 9 Jun 2015 17:18:15 +0530
Message-ID: <1433850508-26317-16-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33105 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753845AbbFILuZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:50:25 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig            |  5 +++++
 arch/arc/include/asm/mcip.h |  3 +++
 arch/arc/kernel/mcip.c      |  3 +++
 arch/arc/kernel/time.c      | 45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index ef5ca5969eaf..1b684595e258 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -384,6 +384,11 @@ config ARC_HAS_RTC
 	default n
 	depends on !SMP
 
+config ARC_HAS_GRTC
+	bool "SMP synchronized 64-bit cycle counter"
+	default y
+	depends on SMP
+
 config ARC_NUMBER_OF_INTERRUPTS
 	int "Number of interrupts"
 	range 8 240
diff --git a/arch/arc/include/asm/mcip.h b/arch/arc/include/asm/mcip.h
index 31f9bac77a27..52c11f0bb0e5 100644
--- a/arch/arc/include/asm/mcip.h
+++ b/arch/arc/include/asm/mcip.h
@@ -39,6 +39,9 @@ struct mcip_cmd {
 #define CMD_DEBUG_SET_MASK		0x34
 #define CMD_DEBUG_SET_SELECT		0x36
 
+#define CMD_GRTC_READ_LO		0x42
+#define CMD_GRTC_READ_HI		0x43
+
 #define CMD_IDU_ENABLE			0x71
 #define CMD_IDU_DISABLE			0x72
 #define CMD_IDU_SET_MODE		0x74
diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index 35921c3ab394..ad7e90b97f6e 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -154,4 +154,7 @@ void mcip_init_early_smp(void)
 		__mcip_cmd_data(CMD_DEBUG_SET_SELECT, 0, 0xf);
 		__mcip_cmd_data(CMD_DEBUG_SET_MASK, 0xf, 0xf);
 	}
+
+	if (IS_ENABLED(CONFIG_ARC_HAS_GRTC) && !mp.grtc)
+		panic("kernel trying to use non-existent GRTC\n");
 }
diff --git a/arch/arc/kernel/time.c b/arch/arc/kernel/time.c
index da495478a40b..3364d2bbc515 100644
--- a/arch/arc/kernel/time.c
+++ b/arch/arc/kernel/time.c
@@ -45,6 +45,8 @@
 #include <asm/clk.h>
 #include <asm/mach_desc.h>
 
+#include <asm/mcip.h>
+
 /* Timer related Aux registers */
 #define ARC_REG_TIMER0_LIMIT	0x23	/* timer 0 limit */
 #define ARC_REG_TIMER0_CTRL	0x22	/* timer 0 control */
@@ -60,6 +62,48 @@
 
 /********** Clock Source Device *********/
 
+#ifdef CONFIG_ARC_HAS_GRTC
+
+static int arc_counter_setup(void)
+{
+	return 1;
+}
+
+static cycle_t arc_counter_read(struct clocksource *cs)
+{
+	unsigned long flags;
+	union {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		struct { u32 h, l; };
+#else
+		struct { u32 l, h; };
+#endif
+		cycle_t  full;
+	} stamp;
+
+	local_irq_save(flags);
+
+	__mcip_cmd(CMD_GRTC_READ_LO, 0);
+	stamp.l = read_aux_reg(ARC_REG_MCIP_READBACK);
+
+	__mcip_cmd(CMD_GRTC_READ_HI, 0);
+	stamp.h = read_aux_reg(ARC_REG_MCIP_READBACK);
+
+	local_irq_restore(flags);
+
+	return stamp.full;
+}
+
+static struct clocksource arc_counter = {
+	.name   = "ARConnect GRTC",
+	.rating = 400,
+	.read   = arc_counter_read,
+	.mask   = CLOCKSOURCE_MASK(64),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+#else
+
 #ifdef CONFIG_ARC_HAS_RTC
 
 #define AUX_RTC_CTRL	0x103
@@ -135,6 +179,7 @@ static struct clocksource arc_counter = {
 };
 
 #endif
+#endif
 
 /********** Clock Event Device *********/
 
-- 
1.9.1
