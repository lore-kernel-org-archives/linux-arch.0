Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730214AbeK3EMH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Nov 2018 23:12:07 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 04/28] kernel: Add masks support for Raw and NTP time
Date: Thu, 29 Nov 2018 17:05:06 +0000
Message-ID: <20181129170530.37789-5-vincenzo.frascino@arm.com>
In-Reply-To: <20181129170530.37789-1-vincenzo.frascino@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181129170506.6WL-LAKwu49zldvkju9xqZyHJSB9J0ps-7UeVP5Jn5o@z>

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
index d50a108afaed..0a7bdccf5773 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -34,6 +34,8 @@ struct vdso_data {
 	__u64 wtm_clock_nsec;
 	__u64 btm_nsec;		/* Monotonic to boot time */
 	__u64 tai_sec;		/* International Atomic Time */
+	__u64 cs_mono_mask;	/* NTP-adjusted clocksource mask */
+	__u64 cs_raw_mask;	/* Raw clocksource mask */
 	__u32 tb_seq_count;	/* Timebase sequence counter */
 	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
 	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
-- 
2.19.2
