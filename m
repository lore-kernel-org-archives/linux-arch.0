Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58620 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeKIWSS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Nov 2018 17:18:18 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 01/27] kernel: Standardize vdso_datapage
Date: Fri,  9 Nov 2018 12:37:04 +0000
Message-ID: <20181109123730.8743-2-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181109123704.GFzcw7pWjDAjsXVE1ZXvCS95oP8JquJiAkOvvq8wXCI@z>

In an effort to unify the common code for managing the vdso library in
between all the architectures that support it, this patch tries to
provide a common format for the vdso datapage.

As a result of this, this patch moves vdso_datapage.h from arm64 private
includes to general includes (include/vdso) and to avoid possible conflicts
replaces the header guard.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 include/vdso/datapage.h

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
new file mode 100644
index 000000000000..a02ca170d56e
--- /dev/null
+++ b/include/vdso/datapage.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __VDSO_DATAPAGE_H
+#define __VDSO_DATAPAGE_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+struct vdso_data {
+	__u64 cs_cycle_last;	/* Timebase at clocksource init */
+	__u64 raw_time_sec;	/* Raw time */
+	__u64 raw_time_nsec;
+	__u64 xtime_clock_sec;	/* Kernel time */
+	__u64 xtime_clock_nsec;
+	__u64 xtime_coarse_sec;	/* Coarse time */
+	__u64 xtime_coarse_nsec;
+	__u64 wtm_clock_sec;	/* Wall to monotonic time */
+	__u64 wtm_clock_nsec;
+	__u32 tb_seq_count;	/* Timebase sequence counter */
+	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
+	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
+	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
+	__u32 tz_minuteswest;	/* Whacky timezone stuff */
+	__u32 tz_dsttime;
+	__u32 use_syscall;
+};
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __VDSO_DATAPAGE_H */
-- 
2.19.1
