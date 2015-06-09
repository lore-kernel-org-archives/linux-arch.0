From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 12/28] ARCv2: clocksource: Introduce 64bit local RTC counter
Date: Tue, 9 Jun 2015 17:18:12 +0530
Message-ID: <1433850508-26317-13-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33103 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753844AbbFILuZ (ORCPT
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
 arch/arc/Kconfig        |  5 +++++
 arch/arc/kernel/setup.c |  9 +++++++--
 arch/arc/kernel/time.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 974ed9058018..f09e03a0d604 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -372,6 +372,11 @@ config ARC_HAS_LL64
 	  dest operands with 2 possible source operands.
 	default y
 
+config ARC_HAS_RTC
+	bool "Local 64-bit r/o cycle counter"
+	default n
+	depends on !SMP
+
 config ARC_NUMBER_OF_INTERRUPTS
 	int "Number of interrupts"
 	range 8 240
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index ca71cef4bafd..a3d186211ed3 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -200,9 +200,11 @@ static char *arc_cpu_mumbojumbo(int cpu_id, char *buf, int len)
 		       (unsigned int)(arc_get_core_freq() / 1000000),
 		       (unsigned int)(arc_get_core_freq() / 10000) % 100);
 
-	n += scnprintf(buf + n, len - n, "Timers\t\t: %s%s\nISA Extn\t: ",
+	n += scnprintf(buf + n, len - n, "Timers\t\t: %s%s%s%s\nISA Extn\t: ",
 		       IS_AVAIL1(cpu->timers.t0, "Timer0 "),
-		       IS_AVAIL1(cpu->timers.t1, "Timer1 "));
+		       IS_AVAIL1(cpu->timers.t1, "Timer1 "),
+		       IS_AVAIL2(cpu->timers.rtc, "64-bit RTC ",
+				 CONFIG_ARC_HAS_RTC));
 
 	n += i = scnprintf(buf + n, len - n, "%s%s%s%s%s",
 			   IS_AVAIL2(atomic, "atomic ", CONFIG_ARC_HAS_LLSC),
@@ -290,6 +292,9 @@ static void arc_chk_core_config(void)
 	if (!cpu->timers.t1)
 		panic("Timer1 is not present!\n");
 
+	if (IS_ENABLED(CONFIG_ARC_HAS_RTC) && !cpu->timers.rtc)
+		panic("RTC is not present\n");
+
 #ifdef CONFIG_ARC_HAS_DCCM
 	/*
 	 * DCCM can be arbit placed in hardware.
diff --git a/arch/arc/kernel/time.c b/arch/arc/kernel/time.c
index 71493f75ae6b..da495478a40b 100644
--- a/arch/arc/kernel/time.c
+++ b/arch/arc/kernel/time.c
@@ -60,6 +60,54 @@
 
 /********** Clock Source Device *********/
 
+#ifdef CONFIG_ARC_HAS_RTC
+
+#define AUX_RTC_CTRL	0x103
+#define AUX_RTC_LOW	0x104
+#define AUX_RTC_HIGH	0x105
+
+int arc_counter_setup(void)
+{
+	write_aux_reg(AUX_RTC_CTRL, 1);
+
+	/* Not usable in SMP */
+	return !IS_ENABLED(CONFIG_SMP);
+}
+
+static cycle_t arc_counter_read(struct clocksource *cs)
+{
+	unsigned long status;
+	union {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		struct { u32 high, low; };
+#else
+		struct { u32 low, high; };
+#endif
+		cycle_t  full;
+	} stamp;
+
+
+	__asm__ __volatile(
+	"1:						\n"
+	"	lr		%0, [AUX_RTC_LOW]	\n"
+	"	lr		%1, [AUX_RTC_HIGH]	\n"
+	"	lr		%2, [AUX_RTC_CTRL]	\n"
+	"	bbit0.nt	%2, 31, 1b		\n"
+	: "=r" (stamp.low), "=r" (stamp.high), "=r" (status));
+
+	return stamp.full;
+}
+
+static struct clocksource arc_counter = {
+	.name   = "ARCv2 RTC",
+	.rating = 350,
+	.read   = arc_counter_read,
+	.mask   = CLOCKSOURCE_MASK(64),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+#else /* !CONFIG_ARC_HAS_RTC */
+
 /*
  * set 32bit TIMER1 to keep counting monotonically and wraparound
  */
@@ -86,6 +134,8 @@ static struct clocksource arc_counter = {
 	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+#endif
+
 /********** Clock Event Device *********/
 
 /*
-- 
1.9.1
