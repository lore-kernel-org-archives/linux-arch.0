Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeKIWSU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Nov 2018 17:18:20 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 02/27] kernel: Add Monotonic boot time support
Date: Fri,  9 Nov 2018 12:37:05 +0000
Message-ID: <20181109123730.8743-3-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181109123705.fDJNkwozwX7EZYLsuTGE1x5h7hi_H7cjXNXlwLiLh7Q@z>

Currently, datapage.h has no support for CLOCK_BOOTTIME.
CLOCK_BOOTTIME is identical to CLOCK_MONOTONIC, but includes
any time spent in suspend.

This patch adds monotonic boot time support (btm_nsec) to datapage.h.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index a02ca170d56e..52189c21d422 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -32,6 +32,7 @@ struct vdso_data {
 	__u64 xtime_coarse_nsec;
 	__u64 wtm_clock_sec;	/* Wall to monotonic time */
 	__u64 wtm_clock_nsec;
+	__u64 btm_nsec;		/* Monotonic to boot time */
 	__u32 tb_seq_count;	/* Timebase sequence counter */
 	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
 	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
-- 
2.19.1
