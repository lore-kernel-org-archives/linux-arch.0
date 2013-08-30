From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 10/11] xtensa: fix !CONFIG_XTENSA_CALIBRATE_CCOUNT build failure
Date: Fri, 30 Aug 2013 19:35:02 +0400
Message-ID: <1377876903-27860-11-git-send-email-jcmvbkbc@gmail.com>
References: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:53996 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599Ab3H3Pfa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:30 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so1679155lab.10
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:27 -0700 (PDT)
In-Reply-To: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Max Filippov <jcmvbkbc@gmail.com>

From: Baruch Siach <baruch@tkos.co.il>

Commits 925f5532 (xtensa: ccount based clockevent implementation) and e3f43291
(xtensa: ccount based sched_clock) introduced users of ccount_freq. This
variable doesn't exist when CONFIG_XTENSA_CALIBRATE_CCOUNT is disabled. Add
ccount_freq definition in this case.

Reported-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/timex.h |    5 -----
 arch/xtensa/kernel/time.c       |    4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/xtensa/include/asm/timex.h b/arch/xtensa/include/asm/timex.h
index 69f9017..86aca77 100644
--- a/arch/xtensa/include/asm/timex.h
+++ b/arch/xtensa/include/asm/timex.h
@@ -35,13 +35,8 @@
 # error "Bad timer number for Linux configurations!"
 #endif
 
-#ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
 extern unsigned long ccount_freq;
 #define CCOUNT_PER_JIFFY (ccount_freq / HZ)
-#else
-#define CCOUNT_PER_JIFFY (CONFIG_XTENSA_CPU_CLOCK*(1000000UL/HZ))
-#endif
-
 
 typedef unsigned long long cycles_t;
 
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 24bb0c17..a65cb38 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -29,9 +29,7 @@
 #include <asm/timex.h>
 #include <asm/platform.h>
 
-#ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
 unsigned long ccount_freq;		/* ccount Hz */
-#endif
 
 static cycle_t ccount_read(struct clocksource *cs)
 {
@@ -129,6 +127,8 @@ void __init time_init(void)
 	platform_calibrate_ccount();
 	printk("%d.%02d MHz\n", (int)ccount_freq/1000000,
 			(int)(ccount_freq/10000)%100);
+#else
+	ccount_freq = CONFIG_XTENSA_CPU_CLOCK*1000000UL;
 #endif
 	clocksource_register_hz(&ccount_clocksource, CCOUNT_PER_JIFFY * HZ);
 
-- 
1.7.7.6
