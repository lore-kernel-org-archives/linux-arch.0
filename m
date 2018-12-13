Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbeLMQ6z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Dec 2018 11:58:55 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 01/24] kernel: Standardize vdso_datapage
Date: Thu, 13 Dec 2018 16:57:23 +0000
Message-ID: <20181213165746.56930-2-vincenzo.frascino@arm.com>
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181213165723.tV7w5mVw4jvOMilCn-U1xPszoRPup1kOFf3qWvko9ZI@z>

In an effort to unify the common code for managing the vdso library in
between all the architectures that support it, this patch tries to
provide a common format for the vdso datapage.

As a result of this, this patch generalized the data structures in vgtod.h
from x86 private includes to general includes (include/vdso).

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 include/vdso/datapage.h

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
new file mode 100644
index 000000000000..e88678f918e5
--- /dev/null
+++ b/include/vdso/datapage.h
@@ -0,0 +1,60 @@
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
+ * To be noticed that nsec is left-shifted by vdso_data.shift.
+ */
+struct vdso_timestamp {
+	u64 sec;
+	u64 nsec;
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
+	u64 mask;		/* Clocksource mask (mono = raw) */
+	u32 mult;		/* Clocksource multiplier */
+	u32 shift;		/* Clocksource shift (mono = raw) */
+
+	struct vdso_timestamp basetime[VDSO_BASES];
+
+	s32 tz_minuteswest;	/* Timezone definitions */
+	s32 tz_dsttime;
+	u32 use_syscall;
+	u32 __reserved;
+};
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __VDSO_DATAPAGE_H */
-- 
2.19.2
