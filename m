Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeKIWSZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Nov 2018 17:18:25 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 04/27] kernel: Add masks support for Raw and NTP time
Date: Fri,  9 Nov 2018 12:37:07 +0000
Message-ID: <20181109123730.8743-5-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181109123707.mmd3do9Zi2oi25ZB35yNFNe7ftjoNOR89o_ty1PPSA8@z>

Depending on the clocksource selected there can be supported a
different resolution hence we require a mask to be applied to the
time calculation.

This patch exposes the mask in the datapage for Raw and NTP adjusted
clock.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index d50a108afaed..fb6ce4c3f2d0 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -36,8 +36,10 @@ struct vdso_data {
 	__u64 tai_sec;		/* International Atomic Time */
 	__u32 tb_seq_count;	/* Timebase sequence counter */
 	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
+	__u64 cs_mono_mask;	/* NTP-adjusted clocksource mask */
 	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
 	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
+	__u64 cs_raw_mask;	/* Raw clocksource mask */
 	__u32 tz_minuteswest;	/* Whacky timezone stuff */
 	__u32 tz_dsttime;
 	__u32 use_syscall;
-- 
2.19.1
