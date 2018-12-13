Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbeLMQ7r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Dec 2018 11:59:47 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 23/24] clock: gic-timer: Add support for vdso_direct
Date: Thu, 13 Dec 2018 16:57:45 +0000
Message-ID: <20181213165746.56930-24-vincenzo.frascino@arm.com>
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181213165745.qiWqa0heRj5h_2Lc8l25Rvky7qxjZy2b6Jiy59kqW_4@z>

This patch is a consequence of the introduction of vdso_direct on
mips architectures.

If the clock source is selected, vdso_direct is set to true.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/clocksource/mips-gic-timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 54f8a331b53a..e7e0789084cd 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -158,7 +158,10 @@ static struct clocksource gic_clocksource = {
 	.name		= "GIC",
 	.read		= gic_hpt_read,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-	.archdata	= { .vdso_clock_mode = VDSO_CLOCK_GIC },
+	.archdata	= {
+			    .vdso_direct = true,
+			    .vdso_clock_mode = VDSO_CLOCK_GIC
+			  },
 };
 
 static int __init __gic_clocksource_init(void)
-- 
2.19.2
