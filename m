Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59058 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfBVMZo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:25:44 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
Date: Fri, 22 Feb 2019 12:24:09 +0000
Message-ID: <20190222122430.21180-3-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222122409._c4paIW1rsshFA8VCTrvsEHxn9MQzHsrsfmc2gaer6Y@z>

In the last few years we assisted to an explosion of vdso
implementations that mostly share similar code.

Try to unify the gettimeofday vdso implementation introducing
lib/vdso. The code contained in this library can ideally be
reused by all the architectures avoiding, where possible, code
duplication.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h |   1 +
 include/vdso/helpers.h  |  52 ++++++++++++
 include/vdso/types.h    |  39 +++++++++
 lib/Kconfig             |   5 ++
 lib/vdso/Kconfig        |  37 +++++++++
 lib/vdso/Makefile       |  22 +++++
 lib/vdso/gettimeofday.c | 175 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 331 insertions(+)
 create mode 100644 include/vdso/helpers.h
 create mode 100644 include/vdso/types.h
 create mode 100644 lib/vdso/Kconfig
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/gettimeofday.c

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index da346ad02b03..ff332fcba73c 100644
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
index 000000000000..511dea979f6b
--- /dev/null
+++ b/include/vdso/helpers.h
@@ -0,0 +1,52 @@
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
+static __always_inline notrace u32 vdso_read_begin(const struct vdso_data *vd)
+{
+	u32 seq;
+
+repeat:
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
index a9e56539bd11..dff3e3c782da 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -565,6 +565,11 @@ config OID_REGISTRY
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
index 000000000000..34d91f952d70
--- /dev/null
+++ b/lib/vdso/Kconfig
@@ -0,0 +1,37 @@
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
+config GENERIC_COMPAT_VDSO
+	bool
+	help
+	  This config option enables the compat VDSO layer.
+
+config CROSS_COMPILE_COMPAT_VDSO
+	string "32 bit Toolchain prefix for compat vDSO"
+	default ""
+	depends on GENERIC_COMPAT_VDSO
+	help
+	  Defines the cross-compiler prefix for compiling compat vDSO.
+	  If a 64 bit compiler (i.e. x86_64) can compile the VDSO for
+	  32 bit, it does not need to define this parameter.
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
index 000000000000..39f92f7d3218
--- /dev/null
+++ b/lib/vdso/gettimeofday.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic userspace implementations of gettimeofday() and similar.
+ */
+#include <linux/compiler.h>
+#include <linux/math64.h>
+#include <linux/time.h>
+#include <linux/kernel.h>
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
+ * - gettimeofday_fallback(): fallback for gettimeofday.
+ * - clock_gettime_fallback(): fallback for clock_gettime.
+ * - clock_getres_fallback(): fallback for clock_getres.
+ */
+#include <asm/vdso/gettimeofday.h>
+
+static notrace int do_hres(const struct vdso_data *vd,
+			   clockid_t clk,
+			   struct __vdso_timespec *ts)
+{
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	u64 cycles, last, sec, ns;
+	u32 seq, cs_index = CLOCKSOURCE_MONO;
+
+	if (clk == CLOCK_MONOTONIC_RAW)
+		cs_index = CLOCKSOURCE_RAW;
+
+	do {
+		seq = vdso_read_begin(vd);
+		cycles = __arch_get_hw_counter(vd->clock_mode) &
+			vd->cs[cs_index].mask;
+		ns = vdso_ts->nsec;
+		last = vd->cycle_last;
+		if (unlikely((s64)cycles < 0))
+			return clock_gettime_fallback(clk, ts);
+		if (cycles > last)
+			ns += (cycles - last) * vd->cs[cs_index].mult;
+		ns >>= vd->cs[cs_index].shift;
+		sec = vdso_ts->sec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
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
+		tv->tv_usec = ts.tv_nsec / NSEC_PER_USEC;
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
+	const struct vdso_data *vd = __arch_get_vdso_data();
+	time_t t = READ_ONCE(vd->basetime[CLOCK_REALTIME].sec);
+
+	if (time)
+		*time = t;
+
+	return t;
+}
+#endif /* VDSO_HAS_TIME */
+
+static notrace int __cvdso_clock_getres(clockid_t clock,
+					struct __vdso_timespec *res)
+{
+	u64 sec, ns;
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
+	if (msk & VDSO_HRES) {
+		/*
+		 * Preserves the behaviour of posix_get_hrtimer_res().
+		 */
+		sec = 0;
+		ns = MONOTONIC_RES_NSEC;
+	} else if (msk & VDSO_COARSE) {
+		/*
+		 * Preserves the behaviour of posix_get_coarse_res().
+		 */
+		ns = LOW_RES_NSEC;
+		sec = __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	} else {
+		goto fallback;
+	}
+
+	if (res) {
+		res->tv_sec = sec;
+		res->tv_nsec = ns;
+	}
+
+	return 0;
+
+fallback:
+	return clock_getres_fallback(clock, res);
+}
-- 
2.20.1
