From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v4 24/24] mips: Add support for generic vDSO
Date: Tue, 15 Jan 2019 13:55:39 +0000
Message-ID: <20190115135539.24762-25-vincenzo.frascino@arm.com>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190115135539.24762-1-vincenzo.frascino@arm.com>
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

The mips vDSO library requires some adaptations to use to take advantage
of the newly introduced generic vDSO library.

This patch introduces the following changes:
 - Modification of vdso.c to be compliant with the common vdso datapage
 - Use of lib/vdso for gettimeofday

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/Kconfig                         |   3 +
 arch/mips/include/asm/vdso.h              |  60 +----
 arch/mips/include/asm/vdso/gettimeofday.h | 168 +++++++++++++
 arch/mips/{ => include/asm}/vdso/vdso.h   |   6 +-
 arch/mips/kernel/vdso.c                   | 103 ++++++--
 arch/mips/vdso/Makefile                   |  23 +-
 arch/mips/vdso/elf.S                      |   2 +-
 arch/mips/vdso/gettimeofday.c             | 273 ----------------------
 arch/mips/vdso/sigreturn.S                |   2 +-
 arch/mips/vdso/vdso.lds.S                 |   1 +
 arch/mips/vdso/vgettimeofday.c            |  28 +++
 11 files changed, 313 insertions(+), 356 deletions(-)
 create mode 100644 arch/mips/include/asm/vdso/gettimeofday.h
 rename arch/mips/{ => include/asm}/vdso/vdso.h (90%)
 delete mode 100644 arch/mips/vdso/gettimeofday.c
 create mode 100644 arch/mips/vdso/vgettimeofday.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 787290781b8c..07fee0ced679 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -34,6 +34,7 @@ config MIPS
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_GETTIMEOFDAY
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
@@ -74,6 +75,8 @@ config MIPS
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
+	select HAVE_GENERIC_VDSO
+	select HAVE_HW_COUNTER
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index 91bf0c2c265c..0b1d0b4578a6 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -12,6 +12,7 @@
 #define __ASM_VDSO_H
 
 #include <linux/mm_types.h>
+#include <vdso/datapage.h>
 
 #include <asm/barrier.h>
 
@@ -54,12 +55,12 @@ extern struct mips_vdso_image vdso_image_n32;
 #endif
 
 /**
- * union mips_vdso_data - Data provided by the kernel for the VDSO.
+ * struct vdso_data - Data provided by the kernel for the VDSO.
  * @xtime_sec:		Current real time (seconds part).
  * @xtime_nsec:		Current real time (nanoseconds part, shifted).
  * @wall_to_mono_sec:	Wall-to-monotonic offset (seconds part).
  * @wall_to_mono_nsec:	Wall-to-monotonic offset (nanoseconds part).
- * @seq_count:		Counter to synchronise updates (odd = updating).
+ * @tb_seq_count:		Counter to synchronise updates (odd = updating).
  * @cs_shift:		Clocksource shift value.
  * @clock_mode:		Clocksource to use for time functions.
  * @cs_mult:		Clocksource multiplier value.
@@ -76,61 +77,8 @@ extern struct mips_vdso_image vdso_image_n32;
  * for both 64- and 32-bit (for 32-bit userland on 64-bit kernel).
  */
 union mips_vdso_data {
-	struct {
-		u64 xtime_sec;
-		u64 xtime_nsec;
-		u64 wall_to_mono_sec;
-		u64 wall_to_mono_nsec;
-		u32 seq_count;
-		u32 cs_shift;
-		u8 clock_mode;
-		u32 cs_mult;
-		u64 cs_cycle_last;
-		u64 cs_mask;
-		s32 tz_minuteswest;
-		s32 tz_dsttime;
-	};
-
+	struct vdso_data data;
 	u8 page[PAGE_SIZE];
 };
 
-static inline u32 vdso_data_read_begin(const union mips_vdso_data *data)
-{
-	u32 seq;
-
-	while (true) {
-		seq = READ_ONCE(data->seq_count);
-		if (likely(!(seq & 1))) {
-			/* Paired with smp_wmb() in vdso_data_write_*(). */
-			smp_rmb();
-			return seq;
-		}
-
-		cpu_relax();
-	}
-}
-
-static inline bool vdso_data_read_retry(const union mips_vdso_data *data,
-					u32 start_seq)
-{
-	/* Paired with smp_wmb() in vdso_data_write_*(). */
-	smp_rmb();
-	return unlikely(data->seq_count != start_seq);
-}
-
-static inline void vdso_data_write_begin(union mips_vdso_data *data)
-{
-	++data->seq_count;
-
-	/* Ensure sequence update is written before other data page values. */
-	smp_wmb();
-}
-
-static inline void vdso_data_write_end(union mips_vdso_data *data)
-{
-	/* Ensure data values are written before updating sequence again. */
-	smp_wmb();
-	++data->seq_count;
-}
-
 #endif /* __ASM_VDSO_H */
diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..e3ceabd2befc
--- /dev/null
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,168 @@
+/*
+ * Copyright (C) 2018 ARM Limited
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/compiler.h>
+#include <linux/time.h>
+
+#include <asm/vdso/vdso.h>
+#include <asm/clocksource.h>
+#include <asm/io.h>
+#include <asm/unistd.h>
+#include <asm/vdso.h>
+
+#define __arch_get_realtime_res(x)	(MONOTONIC_RES_NSEC)
+#define __arch_get_coarse_res(x)	(LOW_RES_NSEC)
+
+#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
+
+static __always_inline notrace long gettimeofday_fallback(
+					struct __vdso_timeval *_tv,
+					struct timezone *_tz)
+{
+	register struct timezone *tz asm("a1") = _tz;
+	register struct __vdso_timeval *tv asm("a0") = _tv;
+	register long ret asm("v0");
+	register long nr asm("v0") = __NR_gettimeofday;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
+	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
+
+	return error ? -ret : ret;
+}
+
+#else
+
+static __always_inline notrace long gettimeofday_fallback(
+					struct __vdso_timeval *_tv,
+					struct timezone *_tz)
+{
+	return -1;
+}
+
+#endif
+
+static __always_inline notrace long clock_gettime_fallback(
+						clockid_t _clkid,
+						struct __vdso_timespec *_ts)
+{
+	register struct __vdso_timespec *ts asm("a1") = _ts;
+	register clockid_t clkid asm("a0") = _clkid;
+	register long ret asm("v0");
+	register long nr asm("v0") = __NR_clock_gettime;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
+	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
+
+	return error ? -ret : ret;
+}
+
+static __always_inline notrace int clock_getres_fallback(
+						clockid_t _clkid,
+						struct __vdso_timespec *_ts)
+{
+	register struct __vdso_timespec *ts asm("a1") = _ts;
+	register clockid_t clkid asm("a0") = _clkid;
+	register long ret asm("v0");
+	register long nr asm("v0") = __NR_clock_getres;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
+	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
+
+	return error ? -ret : ret;
+}
+
+#ifdef CONFIG_CSRC_R4K
+
+static __always_inline u64 read_r4k_count(void)
+{
+	unsigned int count;
+
+	__asm__ __volatile__(
+	"	.set push\n"
+	"	.set mips32r2\n"
+	"	rdhwr	%0, $2\n"
+	"	.set pop\n"
+	: "=r" (count));
+
+	return count;
+}
+
+#endif
+
+#ifdef CONFIG_CLKSRC_MIPS_GIC
+
+static __always_inline u64 read_gic_count(const struct vdso_data *data)
+{
+	void __iomem *gic = get_gic(data);
+	u32 hi, hi2, lo;
+
+	do {
+		hi = __raw_readl(gic + sizeof(lo));
+		lo = __raw_readl(gic);
+		hi2 = __raw_readl(gic + sizeof(lo));
+	} while (hi2 != hi);
+
+	return (((u64)hi) << 32) + lo;
+}
+
+#endif
+
+static __always_inline notrace u64 __arch_get_hw_counter(s32 clock_mode)
+{
+	const struct vdso_data *data = get_vdso_data();
+	u64 cycle_now;
+
+	switch (clock_mode) {
+#ifdef CONFIG_CSRC_R4K
+	case VDSO_CLOCK_R4K:
+		cycle_now = read_r4k_count();
+		break;
+#endif
+#ifdef CONFIG_CLKSRC_MIPS_GIC
+	case VDSO_CLOCK_GIC:
+		cycle_now = read_gic_count(data);
+		break;
+#endif
+	default:
+		cycle_now = 0;
+		break;
+	}
+
+	return cycle_now;
+}
+
+static __always_inline notrace const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return get_vdso_data();
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/mips/vdso/vdso.h b/arch/mips/include/asm/vdso/vdso.h
similarity index 90%
rename from arch/mips/vdso/vdso.h
rename to arch/mips/include/asm/vdso/vdso.h
index cfb1be441dec..048d12fbb925 100644
--- a/arch/mips/vdso/vdso.h
+++ b/arch/mips/include/asm/vdso/vdso.h
@@ -72,14 +72,14 @@ static inline unsigned long get_vdso_base(void)
 	return addr;
 }
 
-static inline const union mips_vdso_data *get_vdso_data(void)
+static inline const struct vdso_data *get_vdso_data(void)
 {
-	return (const union mips_vdso_data *)(get_vdso_base() - PAGE_SIZE);
+	return (const struct vdso_data *)(get_vdso_base() - PAGE_SIZE);
 }
 
 #ifdef CONFIG_CLKSRC_MIPS_GIC
 
-static inline void __iomem *get_gic(const union mips_vdso_data *data)
+static inline void __iomem *get_gic(const struct vdso_data *data)
 {
 	return (void __iomem *)data - PAGE_SIZE;
 }
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 9df3ebdc7b0f..995d5be320bc 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -24,9 +24,11 @@
 #include <asm/mips-cps.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/helpers.h>
 
 /* Kernel-provided data used by the VDSO. */
-static union mips_vdso_data vdso_data __page_aligned_data;
+static union mips_vdso_data mips_vdso_data __page_aligned_data;
+static struct vdso_data *vdso_data = &mips_vdso_data.data;
 
 /*
  * Mapping for the VDSO data/GIC pages. The real pages are mapped manually, as
@@ -72,29 +74,90 @@ subsys_initcall(init_vdso);
 
 void update_vsyscall(struct timekeeper *tk)
 {
-	vdso_data_write_begin(&vdso_data);
-
-	vdso_data.xtime_sec = tk->xtime_sec;
-	vdso_data.xtime_nsec = tk->tkr_mono.xtime_nsec;
-	vdso_data.wall_to_mono_sec = tk->wall_to_monotonic.tv_sec;
-	vdso_data.wall_to_mono_nsec = tk->wall_to_monotonic.tv_nsec;
-	vdso_data.cs_shift = tk->tkr_mono.shift;
-
-	vdso_data.clock_mode = tk->tkr_mono.clock->archdata.vdso_clock_mode;
-	if (vdso_data.clock_mode != VDSO_CLOCK_NONE) {
-		vdso_data.cs_mult = tk->tkr_mono.mult;
-		vdso_data.cs_cycle_last = tk->tkr_mono.cycle_last;
-		vdso_data.cs_mask = tk->tkr_mono.mask;
+	struct vdso_timestamp *vdso_ts;
+	u64 nsec;
+
+	vdso_write_begin(vdso_data);
+
+	vdso_data->clock_mode = tk->tkr_mono.clock->archdata.vdso_clock_mode;
+#ifdef DISABLE_MIPS_VDSO
+	vdso_data->use_syscall = true;
+#else
+	vdso_data->use_syscall = !tk->tkr_mono.clock->archdata.vdso_direct;
+#endif /* DISABLE_MIPS_VDSO */
+
+	/* CLOCK_REALTIME_COARSE */
+	vdso_ts			= &vdso_data->basetime[CLOCK_REALTIME_COARSE];
+	vdso_ts->sec		= tk->xtime_sec;
+	vdso_ts->nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	/* CLOCK_MONOTONIC_COARSE */
+	vdso_ts			= &vdso_data->basetime[CLOCK_MONOTONIC_COARSE];
+	vdso_ts->sec		= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec			= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	nsec			= nsec + tk->wall_to_monotonic.tv_nsec;
+	while (nsec >= NSEC_PER_SEC) {
+		nsec = nsec - NSEC_PER_SEC;
+		vdso_ts->sec++;
+	}
+	vdso_ts->nsec		= nsec;
+
+	if (vdso_data->clock_mode != VDSO_CLOCK_NONE) {
+		vdso_data->clock_mode	= 0;
+		vdso_data->cycle_last	= tk->tkr_mono.cycle_last;
+		vdso_data->mask		= tk->tkr_mono.mask;
+		vdso_data->mult		= tk->tkr_mono.mult;
+		vdso_data->shift	= tk->tkr_mono.shift;
+		/* CLOCK_REALTIME */
+		vdso_ts			= &vdso_data->basetime[CLOCK_REALTIME];
+		vdso_ts->sec		= tk->xtime_sec;
+		vdso_ts->nsec		= tk->tkr_mono.xtime_nsec;
+		/* CLOCK_MONOTONIC */
+		vdso_ts			= &vdso_data->basetime[CLOCK_MONOTONIC];
+		vdso_ts->sec		= tk->xtime_sec +
+						tk->wall_to_monotonic.tv_sec;
+		nsec			= tk->tkr_mono.xtime_nsec;
+		nsec			= nsec +
+					  ((u64)tk->wall_to_monotonic.tv_nsec <<
+					   tk->tkr_mono.shift);
+		while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
+			nsec = nsec -
+				(((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
+			vdso_ts->sec++;
+		}
+		vdso_ts->nsec		= nsec;
+		/* CLOCK_MONOTONIC_RAW */
+		vdso_ts			= &vdso_data->basetime[CLOCK_MONOTONIC_RAW];
+		vdso_ts->sec		= tk->raw_sec;
+		vdso_ts->nsec		= tk->tkr_raw.xtime_nsec;
+		/* CLOCK_BOOTTIME */
+		vdso_ts			= &vdso_data->basetime[CLOCK_BOOTTIME];
+		vdso_ts->sec		= tk->xtime_sec +
+						tk->wall_to_monotonic.tv_sec;
+		nsec			= tk->tkr_mono.xtime_nsec;
+		nsec			= nsec +
+					  ((u64)(tk->wall_to_monotonic.tv_nsec +
+					   ktime_to_ns(tk->offs_boot)) <<
+					   tk->tkr_mono.shift);
+		while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
+			nsec = nsec -
+				(((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
+			vdso_ts->sec++;
+		}
+		vdso_ts->nsec		= nsec;
+		/* CLOCK_TAI */
+		vdso_ts			= &vdso_data->basetime[CLOCK_TAI];
+		vdso_ts->sec		= tk->xtime_sec + (s64)tk->tai_offset;
+		vdso_ts->nsec		= tk->tkr_mono.xtime_nsec;
 	}
 
-	vdso_data_write_end(&vdso_data);
+	vdso_write_end(vdso_data);
 }
 
 void update_vsyscall_tz(void)
 {
-	if (vdso_data.clock_mode != VDSO_CLOCK_NONE) {
-		vdso_data.tz_minuteswest = sys_tz.tz_minuteswest;
-		vdso_data.tz_dsttime = sys_tz.tz_dsttime;
+	if (vdso_data->clock_mode != VDSO_CLOCK_NONE) {
+		vdso_data->tz_minuteswest = sys_tz.tz_minuteswest;
+		vdso_data->tz_dsttime = sys_tz.tz_dsttime;
 	}
 }
 
@@ -167,7 +230,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 */
 	if (cpu_has_dc_aliases) {
 		base = __ALIGN_MASK(base, shm_align_mask);
-		base += ((unsigned long)&vdso_data - gic_size) & shm_align_mask;
+		base += ((unsigned long)vdso_data - gic_size) & shm_align_mask;
 	}
 
 	data_addr = base + gic_size;
@@ -193,7 +256,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	/* Map data page. */
 	ret = remap_pfn_range(vma, data_addr,
-			      virt_to_phys(&vdso_data) >> PAGE_SHIFT,
+			      virt_to_phys(vdso_data) >> PAGE_SHIFT,
 			      PAGE_SIZE, PAGE_READONLY);
 	if (ret)
 		goto out;
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index f6fd340e39c2..37af90f89ea4 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -1,6 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 # Objects to go into the VDSO.
-obj-vdso-y := elf.o gettimeofday.o sigreturn.o
+
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_MIPS_JUMP_SLOT|R_MIPS_GLOB_DAT
+include $(srctree)/lib/vdso/Makefile
+
+obj-vdso-y := elf.o vgettimeofday.o sigreturn.o
 
 # Common compiler flags between ABIs.
 ccflags-vdso := \
@@ -14,15 +20,23 @@ ifdef CONFIG_CC_IS_CLANG
 ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
 endif
 
+#
+# The -fno-jump-tables flag only prevents the compiler from generating
+# jump tables but does not prevent the compiler from emitting absolute
+# offsets.
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
 	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
-	-DDISABLE_BRANCH_PROFILING \
+	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
 	-D__ASSEMBLY__ -Wa,-gdwarf-2
 
+ifneq ($(c-gettimeofday-y),)
+CFLAGS_vgettimeofday.o = -include $(c-gettimeofday-y)
+endif
+
 #
 # For the pre-R6 code in arch/mips/vdso/vdso.h for locating
 # the base address of VDSO, the linker will emit a R_MIPS_PC32
@@ -49,6 +63,8 @@ VDSO_LDFLAGS := \
 	$(call cc-ldoption, -Wl$(comma)--hash-style=sysv) \
 	$(call cc-ldoption, -Wl$(comma)--build-id)
 
+CFLAGS_REMOVE_vdso.o = -pg
+
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 
@@ -97,6 +113,7 @@ $(obj)/vdso.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) $(native-abi)
 
 $(obj)/vdso.so.dbg.raw: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
+	$(call if_changed,vdso_check)
 
 $(obj)/vdso-image.c: $(obj)/vdso.so.dbg.raw $(obj)/vdso.so.raw \
                      $(obj)/genvdso FORCE
@@ -135,6 +152,7 @@ $(obj)/vdso-o32.lds: $(src)/vdso.lds.S FORCE
 
 $(obj)/vdso-o32.so.dbg.raw: $(obj)/vdso-o32.lds $(obj-vdso-o32) FORCE
 	$(call if_changed,vdsold)
+	$(call if_changed,vdso_check)
 
 $(obj)/vdso-o32-image.c: VDSO_NAME := o32
 $(obj)/vdso-o32-image.c: $(obj)/vdso-o32.so.dbg.raw $(obj)/vdso-o32.so.raw \
@@ -175,6 +193,7 @@ $(obj)/vdso-n32.lds: $(src)/vdso.lds.S FORCE
 
 $(obj)/vdso-n32.so.dbg.raw: $(obj)/vdso-n32.lds $(obj-vdso-n32) FORCE
 	$(call if_changed,vdsold)
+	$(call if_changed,vdso_check)
 
 $(obj)/vdso-n32-image.c: VDSO_NAME := n32
 $(obj)/vdso-n32-image.c: $(obj)/vdso-n32.so.dbg.raw $(obj)/vdso-n32.so.raw \
diff --git a/arch/mips/vdso/elf.S b/arch/mips/vdso/elf.S
index 428a1917afc6..c0c85d126094 100644
--- a/arch/mips/vdso/elf.S
+++ b/arch/mips/vdso/elf.S
@@ -8,7 +8,7 @@
  * option) any later version.
  */
 
-#include "vdso.h"
+#include <asm/vdso/vdso.h>
 
 #include <asm/isa-rev.h>
 
diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
deleted file mode 100644
index e22b422f282c..000000000000
--- a/arch/mips/vdso/gettimeofday.c
+++ /dev/null
@@ -1,273 +0,0 @@
-/*
- * Copyright (C) 2015 Imagination Technologies
- * Author: Alex Smith <alex.smith@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include "vdso.h"
-
-#include <linux/compiler.h>
-#include <linux/time.h>
-
-#include <asm/clocksource.h>
-#include <asm/io.h>
-#include <asm/unistd.h>
-#include <asm/vdso.h>
-
-#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
-
-static __always_inline long gettimeofday_fallback(struct timeval *_tv,
-					  struct timezone *_tz)
-{
-	register struct timezone *tz asm("a1") = _tz;
-	register struct timeval *tv asm("a0") = _tv;
-	register long ret asm("v0");
-	register long nr asm("v0") = __NR_gettimeofday;
-	register long error asm("a3");
-
-	asm volatile(
-	"       syscall\n"
-	: "=r" (ret), "=r" (error)
-	: "r" (tv), "r" (tz), "r" (nr)
-	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
-	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
-
-	return error ? -ret : ret;
-}
-
-#endif
-
-static __always_inline long clock_gettime_fallback(clockid_t _clkid,
-					   struct timespec *_ts)
-{
-	register struct timespec *ts asm("a1") = _ts;
-	register clockid_t clkid asm("a0") = _clkid;
-	register long ret asm("v0");
-	register long nr asm("v0") = __NR_clock_gettime;
-	register long error asm("a3");
-
-	asm volatile(
-	"       syscall\n"
-	: "=r" (ret), "=r" (error)
-	: "r" (clkid), "r" (ts), "r" (nr)
-	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
-	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
-
-	return error ? -ret : ret;
-}
-
-static __always_inline int do_realtime_coarse(struct timespec *ts,
-					      const union mips_vdso_data *data)
-{
-	u32 start_seq;
-
-	do {
-		start_seq = vdso_data_read_begin(data);
-
-		ts->tv_sec = data->xtime_sec;
-		ts->tv_nsec = data->xtime_nsec >> data->cs_shift;
-	} while (vdso_data_read_retry(data, start_seq));
-
-	return 0;
-}
-
-static __always_inline int do_monotonic_coarse(struct timespec *ts,
-					       const union mips_vdso_data *data)
-{
-	u32 start_seq;
-	u64 to_mono_sec;
-	u64 to_mono_nsec;
-
-	do {
-		start_seq = vdso_data_read_begin(data);
-
-		ts->tv_sec = data->xtime_sec;
-		ts->tv_nsec = data->xtime_nsec >> data->cs_shift;
-
-		to_mono_sec = data->wall_to_mono_sec;
-		to_mono_nsec = data->wall_to_mono_nsec;
-	} while (vdso_data_read_retry(data, start_seq));
-
-	ts->tv_sec += to_mono_sec;
-	timespec_add_ns(ts, to_mono_nsec);
-
-	return 0;
-}
-
-#ifdef CONFIG_CSRC_R4K
-
-static __always_inline u64 read_r4k_count(void)
-{
-	unsigned int count;
-
-	__asm__ __volatile__(
-	"	.set push\n"
-	"	.set mips32r2\n"
-	"	rdhwr	%0, $2\n"
-	"	.set pop\n"
-	: "=r" (count));
-
-	return count;
-}
-
-#endif
-
-#ifdef CONFIG_CLKSRC_MIPS_GIC
-
-static __always_inline u64 read_gic_count(const union mips_vdso_data *data)
-{
-	void __iomem *gic = get_gic(data);
-	u32 hi, hi2, lo;
-
-	do {
-		hi = __raw_readl(gic + sizeof(lo));
-		lo = __raw_readl(gic);
-		hi2 = __raw_readl(gic + sizeof(lo));
-	} while (hi2 != hi);
-
-	return (((u64)hi) << 32) + lo;
-}
-
-#endif
-
-static __always_inline u64 get_ns(const union mips_vdso_data *data)
-{
-	u64 cycle_now, delta, nsec;
-
-	switch (data->clock_mode) {
-#ifdef CONFIG_CSRC_R4K
-	case VDSO_CLOCK_R4K:
-		cycle_now = read_r4k_count();
-		break;
-#endif
-#ifdef CONFIG_CLKSRC_MIPS_GIC
-	case VDSO_CLOCK_GIC:
-		cycle_now = read_gic_count(data);
-		break;
-#endif
-	default:
-		return 0;
-	}
-
-	delta = (cycle_now - data->cs_cycle_last) & data->cs_mask;
-
-	nsec = (delta * data->cs_mult) + data->xtime_nsec;
-	nsec >>= data->cs_shift;
-
-	return nsec;
-}
-
-static __always_inline int do_realtime(struct timespec *ts,
-				       const union mips_vdso_data *data)
-{
-	u32 start_seq;
-	u64 ns;
-
-	do {
-		start_seq = vdso_data_read_begin(data);
-
-		if (data->clock_mode == VDSO_CLOCK_NONE)
-			return -ENOSYS;
-
-		ts->tv_sec = data->xtime_sec;
-		ns = get_ns(data);
-	} while (vdso_data_read_retry(data, start_seq));
-
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, ns);
-
-	return 0;
-}
-
-static __always_inline int do_monotonic(struct timespec *ts,
-					const union mips_vdso_data *data)
-{
-	u32 start_seq;
-	u64 ns;
-	u64 to_mono_sec;
-	u64 to_mono_nsec;
-
-	do {
-		start_seq = vdso_data_read_begin(data);
-
-		if (data->clock_mode == VDSO_CLOCK_NONE)
-			return -ENOSYS;
-
-		ts->tv_sec = data->xtime_sec;
-		ns = get_ns(data);
-
-		to_mono_sec = data->wall_to_mono_sec;
-		to_mono_nsec = data->wall_to_mono_nsec;
-	} while (vdso_data_read_retry(data, start_seq));
-
-	ts->tv_sec += to_mono_sec;
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, ns + to_mono_nsec);
-
-	return 0;
-}
-
-#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
-
-/*
- * This is behind the ifdef so that we don't provide the symbol when there's no
- * possibility of there being a usable clocksource, because there's nothing we
- * can do without it. When libc fails the symbol lookup it should fall back on
- * the standard syscall path.
- */
-int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
-{
-	const union mips_vdso_data *data = get_vdso_data();
-	struct timespec ts;
-	int ret;
-
-	ret = do_realtime(&ts, data);
-	if (ret)
-		return gettimeofday_fallback(tv, tz);
-
-	if (tv) {
-		tv->tv_sec = ts.tv_sec;
-		tv->tv_usec = ts.tv_nsec / 1000;
-	}
-
-	if (tz) {
-		tz->tz_minuteswest = data->tz_minuteswest;
-		tz->tz_dsttime = data->tz_dsttime;
-	}
-
-	return 0;
-}
-
-#endif /* CONFIG_MIPS_CLOCK_VSYSCALL */
-
-int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
-{
-	const union mips_vdso_data *data = get_vdso_data();
-	int ret = -1;
-
-	switch (clkid) {
-	case CLOCK_REALTIME_COARSE:
-		ret = do_realtime_coarse(ts, data);
-		break;
-	case CLOCK_MONOTONIC_COARSE:
-		ret = do_monotonic_coarse(ts, data);
-		break;
-	case CLOCK_REALTIME:
-		ret = do_realtime(ts, data);
-		break;
-	case CLOCK_MONOTONIC:
-		ret = do_monotonic(ts, data);
-		break;
-	default:
-		break;
-	}
-
-	if (ret)
-		ret = clock_gettime_fallback(clkid, ts);
-
-	return ret;
-}
diff --git a/arch/mips/vdso/sigreturn.S b/arch/mips/vdso/sigreturn.S
index 30c6219912ac..c2b05956e4cb 100644
--- a/arch/mips/vdso/sigreturn.S
+++ b/arch/mips/vdso/sigreturn.S
@@ -8,7 +8,7 @@
  * option) any later version.
  */
 
-#include "vdso.h"
+#include <asm/vdso/vdso.h>
 
 #include <uapi/asm/unistd.h>
 
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 8df7dd53e8e0..90b2c2785e32 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -99,6 +99,7 @@ VERSION
 	global:
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
+		__vdso_clock_getres;
 #endif
 	local: *;
 	};
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..8da361d919f0
--- /dev/null
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM64 compat userspace implementations of gettimeofday() and similar.
+ *
+ * Copyright (C) 2018 ARM Limited
+ *
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+notrace int __vdso_clock_gettime(clockid_t clock,
+				 struct __vdso_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+notrace int __vdso_gettimeofday(struct __vdso_timeval *tv,
+				struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+notrace int __vdso_clock_getres(clockid_t clock_id,
+				struct __vdso_timespec *res)
+{
+	return __cvdso_clock_getres(clock_id, res);
+}
+
-- 
2.20.1
