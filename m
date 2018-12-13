Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38004 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbeLMQ7p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Dec 2018 11:59:45 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 22/24] clock: csrc-4k: Add support for vdso_direct
Date: Thu, 13 Dec 2018 16:57:44 +0000
Message-ID: <20181213165746.56930-23-vincenzo.frascino@arm.com>
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181213165744.hmrM9EVzZMKjsbbLFSD4cM07CzKv34117Gd7RVFxhSM@z>

This patch is a consequence of the introduction of vdso_direct on mips
architectures.

If the clock source is selected, vdso_direct is set to true.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/kernel/csrc-r4k.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index eed099f35bf1..97e2a8aafdd6 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -77,8 +77,10 @@ int __init init_r4k_clocksource(void)
 	 * R2 onwards makes the count accessible to user mode so it can be used
 	 * by the VDSO (HWREna is configured by configure_hwrena()).
 	 */
-	if (cpu_has_mips_r2_r6 && rdhwr_count_usable())
+	if (cpu_has_mips_r2_r6 && rdhwr_count_usable()) {
+		clocksource_mips.archdata.vdso_direct = true;
 		clocksource_mips.archdata.vdso_clock_mode = VDSO_CLOCK_R4K;
+	}
 
 	clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
 
-- 
2.19.2
