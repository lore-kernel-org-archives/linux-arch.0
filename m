From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Date: Thu, 29 Nov 2018 17:05:08 +0000
Message-ID: <20181129170530.37789-7-vincenzo.frascino@arm.com>
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
 include/vdso/types.h    |  39 ++++
 lib/Kconfig             |   5 +
 lib/vdso/Kconfig        |  41 ++++
 lib/vdso/Makefile       |  22 +++
 lib/vdso/gettimeofday.c | 428 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 536 insertions(+)
 create mode 100644 include/vdso/types.h
 create mode 100644 lib/vdso/Kconfig
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/gettimeofday.c

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index deed007f567d..fef5e7c251b6 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -21,6 +21,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
+#include <vdso/types.h>
 
 struct vdso_data {
 	__u64 cs_cycle_last;	/* Timebase at clocksource init */
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
index 000000000000..e005cf5d379b
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
+config HAVE_ARCH_TIMER
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
index 000000000000..a8cfeeb1f40a
--- /dev/null
+++ b/lib/vdso/gettimeofday.c
@@ -0,0 +1,428 @@
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
+
+#include <asm/vdso/gettimeofday.h>
+
+/* To improve performances, in this file, __always_inline it is used
+ * for the functions called multiple times.
+ */
+static __always_inline notrace u32 vdso_read_begin(const struct vdso_data *vd)
+{
+	u32 seq;
+
+repeat:
+	/* Trying to access concurrent shared memory */
+	seq = READ_ONCE(vd->tb_seq_count);
+	if (seq & 1) {
+		cpu_relax();
+		goto repeat;
+	}
+
+	/* smp_rmb() pairs with the second smp_wmb() in update_vsyscall */
+	smp_rmb();
+	return seq;
+}
+
+static __always_inline notrace u32 vdso_read_retry(const struct vdso_data *vd,
+						   u32 start)
+{
+	u32 seq;
+
+	/* smp_rmb() pairs with the first smp_wmb() in update_vsyscall */
+	smp_rmb();
+	/* Trying to access concurrent shared memory */
+	seq = READ_ONCE(vd->tb_seq_count);
+	return seq != start;
+}
+
+/*
+ * Returns the clock delta, in nanoseconds left-shifted by the clock
+ * shift.
+ */
+static __always_inline notrace u64 get_clock_shifted_nsec(u64 cycle_last,
+							  u64 mult,
+							  u64 mask)
+{
+	u64 res;
+
+	/* Read the virtual counter. */
+	res = clock_get_virtual_counter();
+
+	if (res > cycle_last)
+		res = res - cycle_last;
+	/*
+	 * VDSO Precision Mask: represents the
+	 * precision bits we can guaranty.
+	 */
+	res &= mask;
+	return res * mult;
+}
+
+#ifdef CONFIG_HAVE_ARCH_TIMER
+static __always_inline notrace int __do_realtime_or_tai(
+		const struct vdso_data *vd,
+		struct __vdso_timespec *ts,
+		bool is_tai)
+{
+	u32 seq, cs_mono_mult, cs_shift;
+	u64 ns, sec;
+	u64 cycle_last, cs_mono_mask;
+
+	if (vd->use_syscall)
+		return -1;
+repeat:
+	seq = vdso_read_begin(vd);
+	cycle_last = vd->cs_cycle_last;
+	cs_mono_mult = vd->cs_mono_mult;
+	cs_shift = vd->cs_shift;
+	cs_mono_mask = vd->cs_mono_mask;
+
+	if (is_tai)
+		sec = vd->tai_sec;
+	else
+		sec = vd->xtime_clock_sec;
+	ns = vd->xtime_clock_nsec;
+
+	if (unlikely(vdso_read_retry(vd, seq)))
+		goto repeat;
+
+	ns += get_clock_shifted_nsec(cycle_last, cs_mono_mult, cs_mono_mask);
+	ns >>= cs_shift;
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+#else
+static __always_inline notrace int __do_realtime_or_tai(
+		const struct vdso_data *vd,
+		struct __vdso_timespec *ts,
+		bool is_tai)
+{
+	return -1;
+}
+#endif
+
+/*
+ * Handles CLOCK_REALTIME - A representation of the "wall-clock" time.
+ * Can be both stepped and slewed by time adjustment code. It can move
+ * forward and backward.
+ */
+static __always_inline notrace int do_realtime(const struct vdso_data *vd,
+					       struct __vdso_timespec *ts)
+{
+	return __do_realtime_or_tai(vd, ts, false);
+}
+
+/*
+ * Handles CLOCK_TAI - Like CLOCK_REALTIME, but uses the International
+ * Atomic Time (TAI) reference instead of UTC to avoid jumping on leap
+ * second updates.
+ */
+static notrace int do_tai(const struct vdso_data *vd,
+			  struct __vdso_timespec *ts)
+{
+	return __do_realtime_or_tai(vd, ts, true);
+}
+
+#ifdef CONFIG_HAVE_ARCH_TIMER
+static __always_inline notrace int __do_monotonic(const struct vdso_data *vd,
+						  struct __vdso_timespec *ts,
+						  bool boottime)
+{
+	u32 seq, cs_mono_mult, cs_shift;
+	u64 ns, wtm_ns, sec;
+	u64 cycle_last, cs_mono_mask;
+
+	if (vd->use_syscall)
+		return 1;
+
+repeat:
+	seq = vdso_read_begin(vd);
+
+	cycle_last = vd->cs_cycle_last;
+	cs_mono_mult = vd->cs_mono_mult;
+	cs_shift = vd->cs_shift;
+	cs_mono_mask = vd->cs_mono_mask;
+
+	sec = vd->xtime_clock_sec;
+	ns = vd->xtime_clock_nsec;
+	sec += vd->wtm_clock_sec;
+
+	if (boottime)
+		wtm_ns = vd->wtm_clock_nsec + vd->btm_nsec;
+	else
+		ns += vd->wtm_clock_nsec << cs_shift;
+
+	if (unlikely(vdso_read_retry(vd, seq)))
+		goto repeat;
+
+	ns += get_clock_shifted_nsec(cycle_last, cs_mono_mult, cs_mono_mask);
+	ns >>= cs_shift;
+
+	if (boottime)
+		ns += wtm_ns;
+
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+#else
+static __always_inline notrace int __do_monotonic(const struct vdso_data *vd,
+						  struct __vdso_timespec *ts,
+						  bool boottime)
+{
+	return -1;
+}
+#endif
+
+/*
+ * Handles CLOCK_MONOTONIC - A representation of the interval from an
+ * arbitrary given time. Can be slewed but not stepped by time adjustment
+ * code. It can move forward but not backward.
+ */
+static notrace int do_monotonic(const struct vdso_data *vd,
+				struct __vdso_timespec *ts)
+{
+	return __do_monotonic(vd, ts, false);
+}
+
+/*
+ * Handles CLOCK_MONOTONIC_RAW - This is a version of CLOCK_MONOTONIC that can
+ * be neither slewed nor stepped by time adjustment code. It cannot move
+ * forward or backward.
+ */
+static notrace int do_monotonic_raw(const struct vdso_data *vd,
+				    struct __vdso_timespec *ts)
+{
+	u32 seq, cs_raw_mult, cs_shift;
+	u64 ns, sec;
+	u64 cycle_last, cs_mono_mask;
+
+	if (vd->use_syscall)
+		return -1;
+
+repeat:
+	seq = vdso_read_begin(vd);
+
+	cycle_last = vd->cs_cycle_last;
+	cs_raw_mult = vd->cs_raw_mult;
+	cs_shift = vd->cs_shift;
+	cs_mono_mask = vd->cs_mono_mask;
+
+	sec = vd->raw_time_sec;
+	ns = vd->raw_time_nsec;
+
+	if (unlikely(vdso_read_retry(vd, seq)))
+		goto repeat;
+
+	ns += get_clock_shifted_nsec(cycle_last, cs_raw_mult, cs_mono_mask);
+	ns >>= cs_shift;
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
+/*
+ * Handles CLOCK_REALTIME_COARSE - This is a version of CLOCK_REALTIME
+ * at a lower resolution.
+ */
+static notrace void do_realtime_coarse(const struct vdso_data *vd,
+				       struct __vdso_timespec *ts)
+{
+	u32 seq;
+	u64 ns, sec;
+
+repeat:
+	seq = vdso_read_begin(vd);
+	sec = vd->xtime_coarse_sec;
+	ns = vd->xtime_coarse_nsec;
+
+	if (unlikely(vdso_read_retry(vd, seq)))
+		goto repeat;
+
+	ts->tv_sec = sec;
+	ts->tv_nsec = ns;
+}
+
+/*
+ * Handles CLOCK_MONOTONIC_COARSE - This is a version of CLOCK_MONOTONIC
+ * at a lower resolution.
+ */
+static notrace void do_monotonic_coarse(const struct vdso_data *vd,
+					struct __vdso_timespec *ts)
+{
+	u32 seq;
+	u64 ns, wtm_ns, sec, wtm_sec;
+
+repeat:
+	seq = vdso_read_begin(vd);
+
+	sec = vd->xtime_coarse_sec;
+	ns = vd->xtime_coarse_nsec;
+	wtm_sec = vd->wtm_clock_sec;
+	wtm_ns = vd->wtm_clock_nsec;
+
+	if (unlikely(vdso_read_retry(vd, seq)))
+		goto repeat;
+
+	sec += wtm_sec;
+	ns += wtm_ns;
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+}
+
+/*
+ * Handles CLOCK_BOOTTIME - This is a version of CLOCK_MONOTONIC that keeps
+ * into account the time spent in suspend mode.
+ * Available on on 2.6.39+ kernel version.
+ */
+static notrace int do_boottime(const struct vdso_data *vd,
+			       struct __vdso_timespec *ts)
+{
+	return __do_monotonic(vd, ts, true);
+}
+
+/*
+ * This hook allows the architecture to validate the arguments
+ * passed to the library.
+ */
+#ifndef __HAVE_VDSO_ARCH_VALIDATE_ARG
+#define __arch_valid_arg(x)	true
+#endif
+
+static notrace int __cvdso_clock_gettime(clockid_t clock,
+					 struct __vdso_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+
+	if (!__arch_valid_arg(ts))
+		return -EFAULT;
+
+	switch (clock) {
+	case CLOCK_REALTIME:
+		if (do_realtime(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_TAI:
+		if (do_tai(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_MONOTONIC:
+		if (do_monotonic(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		if (do_monotonic_raw(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_BOOTTIME:
+		if (do_boottime(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_REALTIME_COARSE:
+		do_realtime_coarse(vd, ts);
+		break;
+	case CLOCK_MONOTONIC_COARSE:
+		do_monotonic_coarse(vd, ts);
+		break;
+	default:
+		goto fallback;
+	}
+
+	return 0;
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
+		if (do_realtime(vd, &ts))
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
+
+	if (!__arch_valid_arg(time))
+		return -EFAULT;
+
+repeat:
+	seq = vdso_read_begin(vd);
+
+	t = vd->xtime_coarse_sec;
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
+static notrace int __cvdso_clock_getres(clockid_t clock_id,
+					struct __vdso_timespec *res)
+{
+	u64 ns;
+
+	if (!__arch_valid_arg(res))
+		return -EFAULT;
+
+	if (clock_id == CLOCK_REALTIME ||
+	    clock_id == CLOCK_TAI ||
+	    clock_id == CLOCK_BOOTTIME ||
+	    clock_id == CLOCK_MONOTONIC ||
+	    clock_id == CLOCK_MONOTONIC_RAW)
+		ns = MONOTONIC_RES_NSEC;
+	else if (clock_id == CLOCK_REALTIME_COARSE ||
+		 clock_id == CLOCK_MONOTONIC_COARSE)
+		ns = LOW_RES_NSEC;
+	else
+		return clock_getres_fallback(clock_id, res);
+
+	if (res) {
+		res->tv_sec = 0;
+		res->tv_nsec = ns;
+	}
+
+	return 0;
+}
-- 
2.19.2
