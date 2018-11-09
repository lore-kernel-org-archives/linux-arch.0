Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeKIWSX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Nov 2018 17:18:23 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 03/27] kernel: Add International Atomic Time support
Date: Fri,  9 Nov 2018 12:37:06 +0000
Message-ID: <20181109123730.8743-4-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181109123706.AD3_1spvPd1XcWaZCT_7MfGtb_KmLMrNNtqA2_NjUFg@z>

Currently, datapage.h has no support for CLOCK_TAI.
CLOCK_TAI is similar to CLOCK_REALTIME, but uses the International
Atomic Time (TAI) reference instead of UTC to avoid jumping on leap
second updates.

This patch adds CLOCK_TAI (tai_sec) support to datapage.h.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 52189c21d422..d50a108afaed 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -33,6 +33,7 @@ struct vdso_data {
 	__u64 wtm_clock_sec;	/* Wall to monotonic time */
 	__u64 wtm_clock_nsec;
 	__u64 btm_nsec;		/* Monotonic to boot time */
+	__u64 tai_sec;		/* International Atomic Time */
 	__u32 tb_seq_count;	/* Timebase sequence counter */
 	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
 	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
-- 
2.19.1
