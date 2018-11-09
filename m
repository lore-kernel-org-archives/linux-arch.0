From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 23/27] arm: Add support for generic vDSO
Date: Fri,  9 Nov 2018 12:37:26 +0000
Message-ID: <20181109123730.8743-24-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
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

The arm vDSO library requires some adaptations to use to take advantage
of the newly introduced generic vDSO library.

This patch introduces the following changes:
 - Modification vdso.c to be compliant with the common vdso datapage
 - Use of lib/vdso for gettimeofday
 - Implementation of __vdso_time
 - Implementation of elf note

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm/Kconfig                         |   4 +
 arch/arm/include/asm/vdso/gettimeofday.h |  79 +++++++
 arch/arm/include/asm/vdso_datapage.h     |  25 +--
 arch/arm/kernel/vdso.c                   |  28 ++-
 arch/arm/vdso/Makefile                   |  13 +-
 arch/arm/vdso/note.c                     |  15 ++
 arch/arm/vdso/vdso.lds.S                 |   2 +
 arch/arm/vdso/vgettimeofday.c            | 263 ++---------------------
 8 files changed, 143 insertions(+), 286 deletions(-)
 create mode 100644 arch/arm/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/arm/vdso/note.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df65..ebcbdcf02283 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -47,6 +47,8 @@ config ARM
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_32
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
@@ -96,6 +98,7 @@ config ARM
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select HAVE_GENERIC_VDSO
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
@@ -1353,6 +1356,7 @@ config HAVE_ARM_ARCH_TIMER
 	bool "Architected timer support"
 	depends on CPU_V7
 	select ARM_ARCH_TIMER
+	select HAVE_ARCH_TIMER
 	select GENERIC_CLOCKEVENTS
 	help
 	  This option enables support for the ARM architected timer
diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..e66b0d28ca9d
--- /dev/null
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 ARM Limited
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/arch_timer.h>
+#include <asm/unistd.h>
+#include <uapi/linux/time.h>
+
+extern struct vdso_data *__get_datapage(void);
+
+static __always_inline notrace int gettimeofday_fallback(struct timeval *_tv,
+							 struct timezone *_tz)
+{
+	register struct timezone *tz asm("r1") = _tz;
+	register struct timeval *tv asm("r0") = _tv;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_gettimeofday;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline notrace long clock_gettime_fallback(clockid_t _clkid,
+							   struct timespec *_ts)
+{
+	register struct timespec *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_gettime;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline notrace int clock_getres_fallback(clockid_t _clkid,
+							 struct timespec *_ts)
+{
+	register struct timespec *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_getres;
+
+	asm volatile(
+	"       swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline notrace u64 clock_get_virtual_counter(void)
+{
+	return arch_counter_get_cntvct();
+}
+
+static __always_inline notrace const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return __get_datapage();
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
index 9be259442fca..b31df2467827 100644
--- a/arch/arm/include/asm/vdso_datapage.h
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -22,32 +22,9 @@
 
 #ifndef __ASSEMBLY__
 
+#include <vdso/datapage.h>
 #include <asm/page.h>
 
-/* Try to be cache-friendly on systems that don't implement the
- * generic timer: fit the unconditionally updated fields in the first
- * 32 bytes.
- */
-struct vdso_data {
-	u32 seq_count;		/* sequence count - odd during updates */
-	u16 tk_is_cntvct;	/* fall back to syscall if false */
-	u16 cs_shift;		/* clocksource shift */
-	u32 xtime_coarse_sec;	/* coarse time */
-	u32 xtime_coarse_nsec;
-
-	u32 wtm_clock_sec;	/* wall to monotonic offset */
-	u32 wtm_clock_nsec;
-	u32 xtime_clock_sec;	/* CLOCK_REALTIME - seconds */
-	u32 cs_mult;		/* clocksource multiplier */
-
-	u64 cs_cycle_last;	/* last cycle value */
-	u64 cs_mask;		/* clocksource mask */
-
-	u64 xtime_clock_snsec;	/* CLOCK_REALTIME sub-ns base */
-	u32 tz_minuteswest;	/* timezone info for gettimeofday(2) */
-	u32 tz_dsttime;
-};
-
 union vdso_data_store {
 	struct vdso_data data;
 	u8 page[PAGE_SIZE];
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index f4dd7f9663c1..b26fb6a1d5c7 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -276,14 +276,14 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
 
 static void vdso_write_begin(struct vdso_data *vdata)
 {
-	++vdso_data->seq_count;
+	++vdso_data->tb_seq_count;
 	smp_wmb(); /* Pairs with smp_rmb in vdso_read_retry */
 }
 
 static void vdso_write_end(struct vdso_data *vdata)
 {
 	smp_wmb(); /* Pairs with smp_rmb in vdso_read_begin */
-	++vdso_data->seq_count;
+	++vdso_data->tb_seq_count;
 }
 
 static bool tk_is_cntvct(const struct timekeeper *tk)
@@ -307,10 +307,10 @@ static bool tk_is_cntvct(const struct timekeeper *tk)
  * counter again, making it even, indicating to userspace that the
  * update is finished.
  *
- * Userspace is expected to sample seq_count before reading any other
- * fields from the data page.  If seq_count is odd, userspace is
+ * Userspace is expected to sample tb_seq_count before reading any other
+ * fields from the data page.  If tb_seq_count is odd, userspace is
  * expected to wait until it becomes even.  After copying data from
- * the page, userspace must sample seq_count again; if it has changed
+ * the page, userspace must sample tb_seq_count again; if it has changed
  * from its previous value, userspace must retry the whole sequence.
  *
  * Calls to update_vsyscall are serialized by the timekeeping core.
@@ -318,6 +318,7 @@ static bool tk_is_cntvct(const struct timekeeper *tk)
 void update_vsyscall(struct timekeeper *tk)
 {
 	struct timespec64 *wtm = &tk->wall_to_monotonic;
+	u32 __tk_is_cntvct = tk_is_cntvct(tk);
 
 	if (!cntvct_ok) {
 		/* The entry points have been zeroed, so there is no
@@ -328,20 +329,27 @@ void update_vsyscall(struct timekeeper *tk)
 
 	vdso_write_begin(vdso_data);
 
-	vdso_data->tk_is_cntvct			= tk_is_cntvct(tk);
+	vdso_data->use_syscall			= !__tk_is_cntvct;
 	vdso_data->xtime_coarse_sec		= tk->xtime_sec;
 	vdso_data->xtime_coarse_nsec		= (u32)(tk->tkr_mono.xtime_nsec >>
 							tk->tkr_mono.shift);
 	vdso_data->wtm_clock_sec		= wtm->tv_sec;
 	vdso_data->wtm_clock_nsec		= wtm->tv_nsec;
 
-	if (vdso_data->tk_is_cntvct) {
+	if (__tk_is_cntvct) {
 		vdso_data->cs_cycle_last	= tk->tkr_mono.cycle_last;
+		vdso_data->raw_time_sec		= tk->raw_sec;
+		vdso_data->raw_time_nsec	= tk->tkr_raw.xtime_nsec;
 		vdso_data->xtime_clock_sec	= tk->xtime_sec;
-		vdso_data->xtime_clock_snsec	= tk->tkr_mono.xtime_nsec;
-		vdso_data->cs_mult		= tk->tkr_mono.mult;
+		vdso_data->xtime_clock_nsec	= tk->tkr_mono.xtime_nsec;
+		vdso_data->cs_mono_mult		= tk->tkr_mono.mult;
+		vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
-		vdso_data->cs_mask		= tk->tkr_mono.mask;
+		vdso_data->btm_nsec		= ktime_to_ns(tk->offs_boot);
+		vdso_data->tai_sec		= tk->xtime_sec +
+							tk->tai_offset;
+		vdso_data->cs_mono_mask		= tk->tkr_mono.mask;
+		vdso_data->cs_raw_mask		= tk->tkr_raw.mask;
 	}
 
 	vdso_write_end(vdso_data);
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index f4efff9d3afb..05f8c6699d48 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -1,7 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_ARM_JUMP_SLOT|R_ARM_GLOB_DAT|R_ARM_ABS32
+include $(srctree)/lib/vdso/Makefile
+
 hostprogs-y := vdsomunge
 
-obj-vdso := vgettimeofday.o datapage.o
+obj-vdso := vgettimeofday.o datapage.o note.o
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.so.raw vdso.lds
@@ -25,7 +31,11 @@ CFLAGS_REMOVE_vdso.o = -pg
 
 # Force -O2 to avoid libgcc dependencies
 CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
+ifeq ($(c-gettimeofday-y),)
 CFLAGS_vgettimeofday.o = -O2
+else
+CFLAGS_vgettimeofday.o = -O2 -include $(c-gettimeofday-y)
+endif
 
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
@@ -39,6 +49,7 @@ $(obj)/vdso.o : $(obj)/vdso.so
 # Link rule for the .so file
 $(obj)/vdso.so.raw: $(src)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
+	$(call if_changed,vdso_check)
 
 $(obj)/vdso.so.dbg: $(obj)/vdso.so.raw $(obj)/vdsomunge FORCE
 	$(call if_changed,vdsomunge)
diff --git a/arch/arm/vdso/note.c b/arch/arm/vdso/note.c
new file mode 100644
index 000000000000..eff5bf9efb8b
--- /dev/null
+++ b/arch/arm/vdso/note.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012-2018 ARM Limited
+ *
+ * This supplies .note.* sections to go into the PT_NOTE inside the vDSO text.
+ * Here we can supply some information useful to userland.
+ */
+
+#include <linux/uts.h>
+#include <linux/version.h>
+#include <linux/elfnote.h>
+#include <linux/build-salt.h>
+
+ELFNOTE32("Linux", 0, LINUX_VERSION_CODE);
+BUILD_SALT;
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 89ca89f12d23..1eb577091d1f 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -82,6 +82,8 @@ VERSION
 	global:
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
+		__vdso_clock_getres;
+		__vdso_time;
 	local: *;
 	};
 }
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index a9dd619c6c29..9c01b4e50e65 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -1,270 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2015 Mentor Graphics Corporation.
+ * ARM64 compat userspace implementations of gettimeofday() and similar.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2 of the
- * License.
+ * Copyright (C) 2018 ARM Limited
  *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-
-#include <linux/compiler.h>
-#include <linux/hrtimer.h>
 #include <linux/time.h>
-#include <asm/arch_timer.h>
-#include <asm/barrier.h>
-#include <asm/bug.h>
-#include <asm/page.h>
-#include <asm/unistd.h>
-#include <asm/vdso_datapage.h>
-
-#ifndef CONFIG_AEABI
-#error This code depends on AEABI system call conventions
-#endif
-
-extern struct vdso_data *__get_datapage(void);
-
-static notrace u32 __vdso_read_begin(const struct vdso_data *vdata)
-{
-	u32 seq;
-repeat:
-	seq = READ_ONCE(vdata->seq_count);
-	if (seq & 1) {
-		cpu_relax();
-		goto repeat;
-	}
-	return seq;
-}
-
-static notrace u32 vdso_read_begin(const struct vdso_data *vdata)
-{
-	u32 seq;
-
-	seq = __vdso_read_begin(vdata);
-
-	smp_rmb(); /* Pairs with smp_wmb in vdso_write_end */
-	return seq;
-}
-
-static notrace int vdso_read_retry(const struct vdso_data *vdata, u32 start)
-{
-	smp_rmb(); /* Pairs with smp_wmb in vdso_write_begin */
-	return vdata->seq_count != start;
-}
-
-static notrace long clock_gettime_fallback(clockid_t _clkid,
-					   struct timespec *_ts)
-{
-	register struct timespec *ts asm("r1") = _ts;
-	register clockid_t clkid asm("r0") = _clkid;
-	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_clock_gettime;
-
-	asm volatile(
-	"	swi #0\n"
-	: "=r" (ret)
-	: "r" (clkid), "r" (ts), "r" (nr)
-	: "memory");
-
-	return ret;
-}
-
-static notrace int do_realtime_coarse(struct timespec *ts,
-				      struct vdso_data *vdata)
-{
-	u32 seq;
-
-	do {
-		seq = vdso_read_begin(vdata);
-
-		ts->tv_sec = vdata->xtime_coarse_sec;
-		ts->tv_nsec = vdata->xtime_coarse_nsec;
-
-	} while (vdso_read_retry(vdata, seq));
-
-	return 0;
-}
-
-static notrace int do_monotonic_coarse(struct timespec *ts,
-				       struct vdso_data *vdata)
-{
-	struct timespec tomono;
-	u32 seq;
-
-	do {
-		seq = vdso_read_begin(vdata);
-
-		ts->tv_sec = vdata->xtime_coarse_sec;
-		ts->tv_nsec = vdata->xtime_coarse_nsec;
-
-		tomono.tv_sec = vdata->wtm_clock_sec;
-		tomono.tv_nsec = vdata->wtm_clock_nsec;
-
-	} while (vdso_read_retry(vdata, seq));
-
-	ts->tv_sec += tomono.tv_sec;
-	timespec_add_ns(ts, tomono.tv_nsec);
-
-	return 0;
-}
-
-#ifdef CONFIG_ARM_ARCH_TIMER
-
-static notrace u64 get_ns(struct vdso_data *vdata)
-{
-	u64 cycle_delta;
-	u64 cycle_now;
-	u64 nsec;
-
-	cycle_now = arch_counter_get_cntvct();
+#include <linux/types.h>
 
-	cycle_delta = (cycle_now - vdata->cs_cycle_last) & vdata->cs_mask;
-
-	nsec = (cycle_delta * vdata->cs_mult) + vdata->xtime_clock_snsec;
-	nsec >>= vdata->cs_shift;
-
-	return nsec;
-}
-
-static notrace int do_realtime(struct timespec *ts, struct vdso_data *vdata)
-{
-	u64 nsecs;
-	u32 seq;
-
-	do {
-		seq = vdso_read_begin(vdata);
-
-		if (!vdata->tk_is_cntvct)
-			return -1;
-
-		ts->tv_sec = vdata->xtime_clock_sec;
-		nsecs = get_ns(vdata);
-
-	} while (vdso_read_retry(vdata, seq));
-
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, nsecs);
-
-	return 0;
-}
-
-static notrace int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
-{
-	struct timespec tomono;
-	u64 nsecs;
-	u32 seq;
-
-	do {
-		seq = vdso_read_begin(vdata);
-
-		if (!vdata->tk_is_cntvct)
-			return -1;
-
-		ts->tv_sec = vdata->xtime_clock_sec;
-		nsecs = get_ns(vdata);
-
-		tomono.tv_sec = vdata->wtm_clock_sec;
-		tomono.tv_nsec = vdata->wtm_clock_nsec;
-
-	} while (vdso_read_retry(vdata, seq));
-
-	ts->tv_sec += tomono.tv_sec;
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, nsecs + tomono.tv_nsec);
-
-	return 0;
-}
-
-#else /* CONFIG_ARM_ARCH_TIMER */
-
-static notrace int do_realtime(struct timespec *ts, struct vdso_data *vdata)
-{
-	return -1;
-}
-
-static notrace int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
+notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 {
-	return -1;
+	return __cvdso_clock_gettime(clock, ts);
 }
 
-#endif /* CONFIG_ARM_ARCH_TIMER */
-
-notrace int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
+notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
-	struct vdso_data *vdata;
-	int ret = -1;
-
-	vdata = __get_datapage();
-
-	switch (clkid) {
-	case CLOCK_REALTIME_COARSE:
-		ret = do_realtime_coarse(ts, vdata);
-		break;
-	case CLOCK_MONOTONIC_COARSE:
-		ret = do_monotonic_coarse(ts, vdata);
-		break;
-	case CLOCK_REALTIME:
-		ret = do_realtime(ts, vdata);
-		break;
-	case CLOCK_MONOTONIC:
-		ret = do_monotonic(ts, vdata);
-		break;
-	default:
-		break;
-	}
-
-	if (ret)
-		ret = clock_gettime_fallback(clkid, ts);
-
-	return ret;
+	return __cvdso_gettimeofday(tv, tz);
 }
 
-static notrace long gettimeofday_fallback(struct timeval *_tv,
-					  struct timezone *_tz)
+notrace time_t __vdso_time(time_t *time)
 {
-	register struct timezone *tz asm("r1") = _tz;
-	register struct timeval *tv asm("r0") = _tv;
-	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_gettimeofday;
-
-	asm volatile(
-	"	swi #0\n"
-	: "=r" (ret)
-	: "r" (tv), "r" (tz), "r" (nr)
-	: "memory");
-
-	return ret;
+	return __cvdso_time(time);
 }
 
-notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+notrace int __vdso_clock_getres(clockid_t clock_id, struct timespec *res)
 {
-	struct timespec ts;
-	struct vdso_data *vdata;
-	int ret;
-
-	vdata = __get_datapage();
-
-	ret = do_realtime(&ts, vdata);
-	if (ret)
-		return gettimeofday_fallback(tv, tz);
-
-	if (tv) {
-		tv->tv_sec = ts.tv_sec;
-		tv->tv_usec = ts.tv_nsec / 1000;
-	}
-	if (tz) {
-		tz->tz_minuteswest = vdata->tz_minuteswest;
-		tz->tz_dsttime = vdata->tz_dsttime;
-	}
-
-	return ret;
+	return __cvdso_clock_getres(clock_id, res);
 }
 
 /* Avoid unresolved references emitted by GCC */
-- 
2.19.1
