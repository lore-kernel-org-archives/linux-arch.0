From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 02/24] kernel: Define gettimeofday vdso common code
Date: Thu, 13 Dec 2018 16:57:24 +0000
Message-ID: <20181213165746.56930-3-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
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

In the last few years we assisted to an explosion of vdso
implementations that mostly share similar code.

This patch tries to unify the gettimeofday vdso implementation
introducing lib/vdso. The code contained in this library can
ideally be reused by all the architectures avoiding, where
possible, code duplication.

In doing so, tries to maintain the performances using inlining
as much as possible and consequently reduces the surface for
ROP type of attacks.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h |   1 +
 include/vdso/helpers.h  |  58 +++++++++++++
 include/vdso/types.h    |  39 +++++++++
 lib/Kconfig             |   5 ++
 lib/vdso/Kconfig        |  41 +++++++++
 lib/vdso/Makefile       |  22 +++++
 lib/vdso/gettimeofday.c | 188 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 354 insertions(+)
 create mode 100644 include/vdso/helpers.h
 create mode 100644 include/vdso/types.h
 create mode 100644 lib/vdso/Kconfig
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/gettimeofday.c

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index e88678f918e5..bdc9648720eb 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -9,6 +9,7 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/time.h>
+#include <vdso/types.h>
 
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
new file mode 100644
index 000000000000..66ec7f6b459d
--- /dev/null
+++ b/include/vdso/helpers.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_HELPERS_H
+#define __VDSO_HELPERS_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+#include <vdso/datapage.h>
+
+/*
+ * To improve performances, in this file, __always_inline it is used
+ * for the functions called multiple times.
+ */
+static __always_inline notrace u32 vdso_read_begin(const struct vdso_data *vd)
+{
+	u32 seq;
+
+repeat:
+	/* Trying to access concurrent shared memory */
+	seq = READ_ONCE(vd->seq);
+	if (seq & 1) {
+		cpu_relax();
+		goto repeat;
+	}
+
+	smp_rmb();
+	return seq;
+}
+
+static __always_inline notrace u32 vdso_read_retry(const struct vdso_data *vd,
+						   u32 start)
+{
+	u32 seq;
+
+	smp_rmb();
+	/* Trying to access concurrent shared memory */
+	seq = READ_ONCE(vd->seq);
+	return seq != start;
+}
+
+static __always_inline notrace void vdso_write_begin(struct vdso_data *vd)
+{
+	++vd->seq;
+	smp_wmb();
+}
+
+static __always_inline notrace void vdso_write_end(struct vdso_data *vd)
+{
+	smp_wmb();
+	++vd->seq;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __VDSO_HELPERS_H */
diff --git a/include/vdso/types.h b/include/vdso/types.h
new file mode 100644
index 000000000000..f456a0a6a2e1
--- /dev/null
+++ b/include/vdso/types.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_TYPES_H
+#define __VDSO_TYPES_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+#include <linux/time.h>
+
+/*
+ * The definitions below are required to overcome the limitations
+ * of time_t on 32 bit architectures, which overflows in 2038.
+ * The new code should use the replacements based on time64_t and
+ * timespec64.
+ *
+ * The abstraction below will be updated once the migration to
+ * time64_t is complete.
+ */
+#ifdef CONFIG_GENERIC_VDSO_32
+#define __vdso_timespec		old_timespec32
+#define __vdso_timeval		old_timeval32
+#else
+#ifdef ENABLE_COMPAT_VDSO
+#define __vdso_timespec		old_timespec32
+#define __vdso_timeval		old_timeval32
+#else
+#define __vdso_timespec		__kernel_timespec
+#define __vdso_timeval		__kernel_old_timeval
+#endif /* CONFIG_COMPAT_VDSO */
+#endif /* CONFIG_GENERIC_VDSO_32 */
+
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __VDSO_TYPES_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index a9965f4af4dd..38a048e514a2 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -557,6 +557,11 @@ config OID_REGISTRY
 config UCS2_STRING
         tristate
 
+#
+# generic vdso
+#
+source "lib/vdso/Kconfig"
+
 source "lib/fonts/Kconfig"
 
 config SG_SPLIT
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
new file mode 100644
index 000000000000..55c453b95dcd
--- /dev/null
+++ b/lib/vdso/Kconfig
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config HAVE_GENERIC_VDSO
+	bool
+	default n
+
+if HAVE_GENERIC_VDSO
+
+config GENERIC_GETTIMEOFDAY
+	bool
+	help
+	  This is a generic implementation of gettimeofday vdso.
+	  Each architecture that enables this feature has to
+	  provide the fallback implementation.
+
+config GENERIC_VDSO_32
+	bool
+	depends on GENERIC_GETTIMEOFDAY && !64BIT
+	help
+	  This config option helps to avoid possible performance issues
+	  in 32 bit only architectures.
+
+config HAVE_HW_COUNTER
+	bool
+	depends on GENERIC_GETTIMEOFDAY
+	help
+	  Select this configuration option if the architecture has an arch
+	  timer.
+
+config GENERIC_COMPAT_VDSO
+	bool
+	help
+	  This config option enables the compat VDSO layer.
+
+config CROSS_COMPILE_COMPAT_VDSO
+	string "32 bit Toolchain prefix for compat vDSO"
+	depends on GENERIC_COMPAT_VDSO
+	help
+	  Defines the cross-compiler prefix for compiling compat vDSO.
+
+endif
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
new file mode 100644
index 000000000000..c415a685d61b
--- /dev/null
+++ b/lib/vdso/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+
+GENERIC_VDSO_MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
+GENERIC_VDSO_DIR := $(dir $(GENERIC_VDSO_MK_PATH))
+
+c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) := $(addprefix $(GENERIC_VDSO_DIR), gettimeofday.c)
+
+# This cmd checks that the vdso library does not contain absolute relocation
+# It has to be called after the linking of the vdso library and requires it
+# as a parameter.
+#
+# $(ARCH_REL_TYPE_ABS) is defined in the arch specific makefile and corresponds
+# to the absolute relocation types printed by "objdump -R" and accepted by the
+# dynamic linker.
+ifndef ARCH_REL_TYPE_ABS
+$(error ARCH_REL_TYPE_ABS is not set)
+endif
+
+quiet_cmd_vdso_check = VDSOCHK $@
+      cmd_vdso_check = if $(OBJDUMP) -R $@ | egrep -h "$(ARCH_REL_TYPE_ABS)"; \
+		       then (echo >&2 "$@: dynamic relocations are not supported"; \
+			     rm -f $@; /bin/false); fi
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
new file mode 100644
index 000000000000..30010d25bf5b
--- /dev/null
+++ b/lib/vdso/gettimeofday.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic userspace implementations of gettimeofday() and similar.
+ *
+ * Copyright (C) 2018 ARM Limited
+ * Copyright (C) 2017 Cavium, Inc.
+ * Copyright (C) 2015 Mentor Graphics Corporation
+ *
+ */
+#include <linux/compiler.h>
+#include <linux/math64.h>
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/hrtimer.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
+
+/*
+ * The generic vDSO implementation requires that gettimeofday.h
+ * provides:
+ * - __arch_get_vdso_data(): to get the vdso datapage.
+ * - __arch_get_hw_counter(): to get the hw counter based on the
+ *   clock_mode.
+ * - __arch_get_realtime_res(): to get the correct realtime res.
+ * - __arch_get_coarse_res(): to get the correct coarse res.
+ * - gettimeofday_fallback(): fallback for gettimeofday.
+ * - clock_gettime_fallback(): fallback for clock_gettime.
+ * - clock_getres_fallback(): fallback for clock_getres.
+ */
+#include <asm/vdso/gettimeofday.h>
+
+#ifdef CONFIG_HAVE_HW_COUNTER
+static notrace int do_hres(const struct vdso_data *vd,
+			   clockid_t clk,
+			   struct __vdso_timespec *ts)
+{
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	u64 cycles, last, sec, ns;
+	u32 seq;
+
+	if (vd->use_syscall)
+		return -1;
+
+	do {
+		seq = vdso_read_begin(vd);
+		cycles = __arch_get_hw_counter(vd->clock_mode) & vd->mask;
+		ns = vdso_ts->nsec;
+		last = vd->cycle_last;
+		if (unlikely((s64)cycles < 0))
+			return clock_gettime_fallback(clk, ts);
+		if (cycles > last)
+			ns += (cycles - last) * vd->mult;
+		ns >>= vd->shift;
+		sec = vdso_ts->sec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+#else
+static notrace int do_hres(const struct vdso_data *vd,
+			   clockid_t clk,
+			   struct __vdso_timespec *ts)
+{
+	return -1;
+}
+#endif
+
+static notrace void do_coarse(const struct vdso_data *vd,
+			      clockid_t clk,
+			      struct __vdso_timespec *ts)
+{
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vd);
+		ts->tv_sec = vdso_ts->sec;
+		ts->tv_nsec = vdso_ts->nsec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+}
+
+static notrace int __cvdso_clock_gettime(clockid_t clock,
+					 struct __vdso_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+	u32 msk;
+
+	/* Check for negative values or invalid clocks */
+	if (unlikely((u32) clock >= MAX_CLOCKS))
+		goto fallback;
+
+	/*
+	 * Convert the clockid to a bitmask and use it to check which
+	 * clocks are handled in the VDSO directly.
+	 */
+	msk = 1U << clock;
+	if (likely(msk & VDSO_HRES)) {
+		return do_hres(vd, clock, ts);
+	} else if (msk & VDSO_COARSE) {
+		do_coarse(vd, clock, ts);
+		return 0;
+	}
+fallback:
+	return clock_gettime_fallback(clock, ts);
+}
+
+static notrace int __cvdso_gettimeofday(struct __vdso_timeval *tv,
+					struct timezone *tz)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+
+	if (likely(tv != NULL)) {
+		struct __vdso_timespec ts;
+
+		if (do_hres(vd, CLOCK_REALTIME, &ts))
+			return gettimeofday_fallback(tv, tz);
+
+		tv->tv_sec = ts.tv_sec;
+		tv->tv_usec = ts.tv_nsec / 1000;
+	}
+
+	if (unlikely(tz != NULL)) {
+		tz->tz_minuteswest = vd->tz_minuteswest;
+		tz->tz_dsttime = vd->tz_dsttime;
+	}
+
+	return 0;
+}
+
+#ifdef VDSO_HAS_TIME
+static notrace time_t __cvdso_time(time_t *time)
+{
+	u32 seq;
+	time_t t;
+	const struct vdso_data *vd = __arch_get_vdso_data();
+	struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
+
+repeat:
+	seq = vdso_read_begin(vd);
+
+	t = vdso_ts->sec;
+
+	if (unlikely(vdso_read_retry(vd, seq)))
+		goto repeat;
+
+	if (unlikely(time != NULL))
+		*time = t;
+
+	return t;
+}
+#endif /* VDSO_HAS_TIME */
+
+static notrace int __cvdso_clock_getres(clockid_t clock,
+					struct __vdso_timespec *res)
+{
+	u64 ns;
+	u32 msk;
+
+	/* Check for negative values or invalid clocks */
+	if (unlikely((u32) clock >= MAX_CLOCKS))
+		goto fallback;
+
+	/*
+	 * Convert the clockid to a bitmask and use it to check which
+	 * clocks are handled in the VDSO directly.
+	 */
+	msk = 1U << clock;
+	if (msk & VDSO_HRES)
+		ns = __arch_get_realtime_res(clock);
+	else if (msk & VDSO_COARSE)
+		ns = __arch_get_coarse_res(clock);
+	else
+		goto fallback;
+
+	if (res) {
+		res->tv_sec = 0;
+		res->tv_nsec = ns;
+	}
+
+	return 0;
+
+fallback:
+	return clock_getres_fallback(clock, res);
+}
-- 
2.19.2
