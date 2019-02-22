Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59030 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbfBVMZl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:25:41 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 01/23] kernel: Standardize vdso_datapage
Date: Fri, 22 Feb 2019 12:24:08 +0000
Message-ID: <20190222122430.21180-2-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222122408.zK-j1EMugmOSiLHLG5mUo0IsoUbTMgexta01PN7He2Y@z>

In an effort to unify the common code for managing the vdso library in
between all the architectures that support it, this patch tries to
provide a common format for the vdso datapage.

As a result of this, this patch generalized the data structures in vgtod.h
from x86 private includes to general includes (include/vdso).

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 74 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 include/vdso/datapage.h

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
new file mode 100644
index 000000000000..da346ad02b03
--- /dev/null
+++ b/include/vdso/datapage.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_DATAPAGE_H
+#define __VDSO_DATAPAGE_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+#include <linux/bits.h>
+#include <linux/types.h>
+#include <linux/time.h>
+
+#define VDSO_BASES	(CLOCK_TAI + 1)
+#define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
+			 BIT(CLOCK_MONOTONIC)		| \
+			 BIT(CLOCK_MONOTONIC_RAW)	| \
+			 BIT(CLOCK_BOOTTIME)		| \
+			 BIT(CLOCK_TAI))
+#define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
+			 BIT(CLOCK_MONOTONIC_COARSE))
+
+/*
+ * There is one vdso_timestamp object in vvar for each vDSO-accelerated
+ * clock_id. For high-resolution clocks, this encodes the time
+ * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
+ * the actual time.
+ *
+ * To be noticed that for highres clocks nsec is left-shifted by
+ * vdso_data.cs[x].shift.
+ */
+struct vdso_timestamp {
+	u64 sec;
+	u64 nsec;
+};
+
+#define CLOCKSOURCE_RAW		0
+#define CLOCKSOURCE_MONO	1
+#define CLOCKSOURCE_BASES	(CLOCKSOURCE_MONO + 1)
+
+/*
+ * There is one vdso_clocksource object in vvar for each vDSO clocksource
+ * (mono, raw). This struct is designed to keep vdso_data "cache-line friendly"
+ * and optimal in terms of access pattern.
+ *
+ * Note that mask and shift are the same for mono and raw.
+ */
+struct vdso_clocksource {
+	u64 mask;		/* Clocksource mask */
+	u32 mult;		/* Clocksource multiplier */
+	u32 shift;		/* Clocksource shift */
+};
+
+/*
+ * vdso_data will be accessed by 32 and 64 bit code at the same time
+ * so we should be careful before modifying this structure.
+ */
+struct vdso_data {
+	u32 seq;		/* Timebase sequence counter */
+
+	s32 clock_mode;
+	u64 cycle_last;		/* Timebase at clocksource init */
+
+	struct vdso_clocksource cs[CLOCKSOURCE_BASES];
+	struct vdso_timestamp basetime[VDSO_BASES];
+
+	s32 tz_minuteswest;	/* Timezone definitions */
+	s32 tz_dsttime;
+};
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __VDSO_DATAPAGE_H */
-- 
2.20.1
