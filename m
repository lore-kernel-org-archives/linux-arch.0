From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 11/11] xtensa: remove CCOUNT_PER_JIFFY
Date: Fri, 30 Aug 2013 19:35:03 +0400
Message-ID: <1377876903-27860-12-git-send-email-jcmvbkbc@gmail.com>
References: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:60664 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603Ab3H3Pfb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:31 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so1336820lbh.28
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:29 -0700 (PDT)
In-Reply-To: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Max Filippov <jcmvbkbc@gmail.com>

From: Baruch Siach <baruch@tkos.co.il>

Use ccount_freq directly to make the code a little more readable.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/timex.h |    1 -
 arch/xtensa/kernel/setup.c      |    4 ++--
 arch/xtensa/kernel/time.c       |    4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/include/asm/timex.h b/arch/xtensa/include/asm/timex.h
index 86aca77..27fa3c1 100644
--- a/arch/xtensa/include/asm/timex.h
+++ b/arch/xtensa/include/asm/timex.h
@@ -36,7 +36,6 @@
 #endif
 
 extern unsigned long ccount_freq;
-#define CCOUNT_PER_JIFFY (ccount_freq / HZ)
 
 typedef unsigned long long cycles_t;
 
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 42a8bba..4a8f027 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -585,8 +585,8 @@ c_show(struct seq_file *f, void *slot)
 		     "bogomips\t: %lu.%02lu\n",
 		     XCHAL_BUILD_UNIQUE_ID,
 		     XCHAL_HAVE_BE ?  "big" : "little",
-		     CCOUNT_PER_JIFFY/(1000000/HZ),
-		     (CCOUNT_PER_JIFFY/(10000/HZ)) % 100,
+		     ccount_freq/1000000,
+		     (ccount_freq/10000) % 100,
 		     loops_per_jiffy/(500000/HZ),
 		     (loops_per_jiffy/(5000/HZ)) % 100);
 
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index a65cb38..9af3dd8 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -130,7 +130,7 @@ void __init time_init(void)
 #else
 	ccount_freq = CONFIG_XTENSA_CPU_CLOCK*1000000UL;
 #endif
-	clocksource_register_hz(&ccount_clocksource, CCOUNT_PER_JIFFY * HZ);
+	clocksource_register_hz(&ccount_clocksource, ccount_freq);
 
 	ccount_timer.evt.cpumask = cpumask_of(0);
 	ccount_timer.evt.irq = irq_create_mapping(NULL, LINUX_TIMER_INT);
@@ -164,7 +164,7 @@ irqreturn_t timer_interrupt (int irq, void *dev_id)
 #ifndef CONFIG_GENERIC_CALIBRATE_DELAY
 void calibrate_delay(void)
 {
-	loops_per_jiffy = CCOUNT_PER_JIFFY;
+	loops_per_jiffy = ccount_freq / HZ;
 	printk("Calibrating delay loop (skipped)... "
 	       "%lu.%02lu BogoMIPS preset\n",
 	       loops_per_jiffy/(1000000/HZ),
-- 
1.7.7.6
