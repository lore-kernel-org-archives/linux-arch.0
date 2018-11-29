From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 01/28] kernel: Standardize vdso_datapage
Date: Thu, 29 Nov 2018 17:05:03 +0000
Message-ID: <20181129170530.37789-2-vincenzo.frascino@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181129170530.37789-1-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
List-Id: linux-arch.vger.kernel.org

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
2.19.2
