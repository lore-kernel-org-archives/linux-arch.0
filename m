From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Date: Fri,  9 Nov 2018 12:37:10 +0000
Message-ID: <20181109123730.8743-8-vincenzo.frascino@arm.com>
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

To take advantage of the commonly defined vdso interface for
gettimeofday the architectural code requires an adaptation.

This patch re-implements the gettimeofday vdso in C in order to use
lib/vdso.

With the new implementation arm64 gains support for CLOCK_BOOTTIME,
CLOCK_TAI and __kernel_time.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Kconfig                         |   3 +
 arch/arm64/include/asm/vdso/gettimeofday.h |  82 ++++++
 arch/arm64/include/asm/vdso_datapage.h     |  47 ---
 arch/arm64/kernel/asm-offsets.c            |   7 +-
 arch/arm64/kernel/vdso.c                   |   9 +-
 arch/arm64/kernel/vdso/Makefile            |  24 +-
 arch/arm64/kernel/vdso/gettimeofday.S      | 328 ---------------------
 arch/arm64/kernel/vdso/vdso.lds.S          |   1 +
 arch/arm64/kernel/vdso/vgettimeofday.c     |  30 ++
 9 files changed, 146 insertions(+), 385 deletions(-)
 create mode 100644 arch/arm64/include/asm/vdso/gettimeofday.h
 delete mode 100644 arch/arm64/include/asm/vdso_datapage.h
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S
 create mode 100644 arch/arm64/kernel/vdso/vgettimeofday.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d7850e064..71ca1995a088 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -69,6 +69,7 @@ config ARM64
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
+	select HAVE_ARCH_TIMER
 	select ARM_GIC
 	select AUDIT_ARCH_COMPAT_GENERIC
 	select ARM_GIC_V2M if PCI
@@ -101,6 +102,7 @@ config ARM64
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_GETTIMEOFDAY
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_ACPI_APEI if (ACPI && EFI)
@@ -153,6 +155,7 @@ config ARM64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..b41a3af66e56
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 ARM Limited
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/unistd.h>
+#include <uapi/linux/time.h>
+
+extern struct vdso_data _vdso_data;
+
+static __always_inline notrace int gettimeofday_fallback(struct timeval *_tv,
+							 struct timezone *_tz)
+{
+	register struct timezone *tz asm("x1") = _tz;
+	register struct timeval *tv asm("x0") = _tv;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_gettimeofday;
+
+	asm volatile(
+	"       svc #0\n"
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
+	register struct timespec *ts asm("x1") = _ts;
+	register clockid_t clkid asm("x0") = _clkid;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_clock_gettime;
+
+	asm volatile(
+	"       svc #0\n"
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
+	register struct timespec *ts asm("x1") = _ts;
+	register clockid_t clkid asm("x0") = _clkid;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_clock_getres;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline notrace u64 clock_get_virtual_counter(void)
+{
+	u64 res;
+
+	asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
+
+	return res;
+}
+
+static __always_inline notrace const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return &_vdso_data;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso_datapage.h b/arch/arm64/include/asm/vdso_datapage.h
deleted file mode 100644
index 2b9a63771eda..000000000000
--- a/arch/arm64/include/asm/vdso_datapage.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * Copyright (C) 2012 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_VDSO_DATAPAGE_H
-#define __ASM_VDSO_DATAPAGE_H
-
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-struct vdso_data {
-	__u64 cs_cycle_last;	/* Timebase at clocksource init */
-	__u64 raw_time_sec;	/* Raw time */
-	__u64 raw_time_nsec;
-	__u64 xtime_clock_sec;	/* Kernel time */
-	__u64 xtime_clock_nsec;
-	__u64 xtime_coarse_sec;	/* Coarse time */
-	__u64 xtime_coarse_nsec;
-	__u64 wtm_clock_sec;	/* Wall to monotonic time */
-	__u64 wtm_clock_nsec;
-	__u32 tb_seq_count;	/* Timebase sequence counter */
-	/* cs_* members must be adjacent and in this order (ldp accesses) */
-	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
-	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
-	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
-	__u32 tz_minuteswest;	/* Whacky timezone stuff */
-	__u32 tz_dsttime;
-	__u32 use_syscall;
-};
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASM_VDSO_DATAPAGE_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 323aeb5f2fe6..06cfd2363a86 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -25,13 +25,13 @@
 #include <linux/kvm_host.h>
 #include <linux/preempt.h>
 #include <linux/suspend.h>
+#include <vdso/datapage.h>
 #include <asm/cpufeature.h>
 #include <asm/fixmap.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
-#include <asm/vdso_datapage.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
 
@@ -114,13 +114,18 @@ int main(void)
   DEFINE(VDSO_XTIME_CRS_NSEC,	offsetof(struct vdso_data, xtime_coarse_nsec));
   DEFINE(VDSO_WTM_CLK_SEC,	offsetof(struct vdso_data, wtm_clock_sec));
   DEFINE(VDSO_WTM_CLK_NSEC,	offsetof(struct vdso_data, wtm_clock_nsec));
+  DEFINE(VDSO_BTM_NSEC,		offsetof(struct vdso_data, btm_nsec));
+  DEFINE(VDSO_CLK_TAI,		offsetof(struct vdso_data, tai_sec));
   DEFINE(VDSO_TB_SEQ_COUNT,	offsetof(struct vdso_data, tb_seq_count));
   DEFINE(VDSO_CS_MONO_MULT,	offsetof(struct vdso_data, cs_mono_mult));
+  DEFINE(VDSO_CS_MONO_MASK,	offsetof(struct vdso_data, cs_mono_mask));
   DEFINE(VDSO_CS_RAW_MULT,	offsetof(struct vdso_data, cs_raw_mult));
   DEFINE(VDSO_CS_SHIFT,		offsetof(struct vdso_data, cs_shift));
+  DEFINE(VDSO_CS_RAW_MASK,	offsetof(struct vdso_data, cs_raw_mask));
   DEFINE(VDSO_TZ_MINWEST,	offsetof(struct vdso_data, tz_minuteswest));
   DEFINE(VDSO_TZ_DSTTIME,	offsetof(struct vdso_data, tz_dsttime));
   DEFINE(VDSO_USE_SYSCALL,	offsetof(struct vdso_data, use_syscall));
+  DEFINE(VDSO_CLK_MODE,		offsetof(struct vdso_data, clock_mode));
   BLANK();
   DEFINE(TVAL_TV_SEC,		offsetof(struct timeval, tv_sec));
   DEFINE(TVAL_TV_USEC,		offsetof(struct timeval, tv_usec));
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 2d419006ad43..47834fe0bbe3 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -31,11 +31,11 @@
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
+#include <vdso/datapage.h>
 
 #include <asm/cacheflush.h>
 #include <asm/signal32.h>
 #include <asm/vdso.h>
-#include <asm/vdso_datapage.h>
 
 extern char vdso_start[], vdso_end[];
 static unsigned long vdso_pages __ro_after_init;
@@ -215,6 +215,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	return PTR_ERR(ret);
 }
 
+#define VDSO_PRECISION_MASK	~(0xFF00ULL<<48)
+
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
@@ -243,6 +245,11 @@ void update_vsyscall(struct timekeeper *tk)
 		vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
 		/* tkr_mono.shift == tkr_raw.shift */
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
+		vdso_data->btm_nsec		= ktime_to_ns(tk->offs_boot);
+		vdso_data->tai_sec		= tk->xtime_sec +
+							tk->tai_offset;
+		vdso_data->cs_mono_mask		= VDSO_PRECISION_MASK;
+		vdso_data->cs_raw_mask		= VDSO_PRECISION_MASK;
 	}
 
 	smp_wmb();
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index b215c712d897..4e9fbd8dd95f 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -6,16 +6,29 @@
 # Heavily based on the vDSO Makefiles for other archs.
 #
 
-obj-vdso := gettimeofday.o note.o sigreturn.o
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_AARCH64_JUMP_SLOT|R_AARCH64_GLOB_DAT|R_AARCH64_ABS64
+include $(srctree)/lib/vdso/Makefile
+
+obj-vdso := vgettimeofday.o note.o sigreturn.o
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
-ccflags-y := -shared -fno-common -fno-builtin
+ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector
+ccflags-y += -DDISABLE_BRANCH_PROFILING
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
 		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 
+CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
+ifeq ($(c-gettimeofday-y),)
+CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny
+else
+CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -include $(c-gettimeofday-y)
+endif
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
@@ -33,6 +46,7 @@ $(obj)/vdso.o : $(obj)/vdso.so
 # Link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso)
 	$(call if_changed,vdsold)
+	$(call if_changed,vdso_check)
 
 # Strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
@@ -49,15 +63,9 @@ endef
 include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
-# Assembly rules for the .S files
-$(obj-vdso): %.o: %.S FORCE
-	$(call if_changed_dep,vdsoas)
-
 # Actual build commands
 quiet_cmd_vdsold = VDSOL   $@
       cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
-quiet_cmd_vdsoas = VDSOA   $@
-      cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
 
 # Install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
deleted file mode 100644
index c39872a7b03c..000000000000
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ /dev/null
@@ -1,328 +0,0 @@
-/*
- * Userspace implementations of gettimeofday() and friends.
- *
- * Copyright (C) 2012 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * Author: Will Deacon <will.deacon@arm.com>
- */
-
-#include <linux/linkage.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-
-#define NSEC_PER_SEC_LO16	0xca00
-#define NSEC_PER_SEC_HI16	0x3b9a
-
-vdso_data	.req	x6
-seqcnt		.req	w7
-w_tmp		.req	w8
-x_tmp		.req	x8
-
-/*
- * Conventions for macro arguments:
- * - An argument is write-only if its name starts with "res".
- * - All other arguments are read-only, unless otherwise specified.
- */
-
-	.macro	seqcnt_acquire
-9999:	ldr	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	tbnz	seqcnt, #0, 9999b
-	dmb	ishld
-	.endm
-
-	.macro	seqcnt_check fail
-	dmb	ishld
-	ldr	w_tmp, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	cmp	w_tmp, seqcnt
-	b.ne	\fail
-	.endm
-
-	.macro	syscall_check fail
-	ldr	w_tmp, [vdso_data, #VDSO_USE_SYSCALL]
-	cbnz	w_tmp, \fail
-	.endm
-
-	.macro get_nsec_per_sec res
-	mov	\res, #NSEC_PER_SEC_LO16
-	movk	\res, #NSEC_PER_SEC_HI16, lsl #16
-	.endm
-
-	/*
-	 * Returns the clock delta, in nanoseconds left-shifted by the clock
-	 * shift.
-	 */
-	.macro	get_clock_shifted_nsec res, cycle_last, mult
-	/* Read the virtual counter. */
-	isb
-	mrs	x_tmp, cntvct_el0
-	/* Calculate cycle delta and convert to ns. */
-	sub	\res, x_tmp, \cycle_last
-	/* We can only guarantee 56 bits of precision. */
-	movn	x_tmp, #0xff00, lsl #48
-	and	\res, x_tmp, \res
-	mul	\res, \res, \mult
-	.endm
-
-	/*
-	 * Returns in res_{sec,nsec} the REALTIME timespec, based on the
-	 * "wall time" (xtime) and the clock_mono delta.
-	 */
-	.macro	get_ts_realtime res_sec, res_nsec, \
-			clock_nsec, xtime_sec, xtime_nsec, nsec_to_sec
-	add	\res_nsec, \clock_nsec, \xtime_nsec
-	udiv	x_tmp, \res_nsec, \nsec_to_sec
-	add	\res_sec, \xtime_sec, x_tmp
-	msub	\res_nsec, x_tmp, \nsec_to_sec, \res_nsec
-	.endm
-
-	/*
-	 * Returns in res_{sec,nsec} the timespec based on the clock_raw delta,
-	 * used for CLOCK_MONOTONIC_RAW.
-	 */
-	.macro	get_ts_clock_raw res_sec, res_nsec, clock_nsec, nsec_to_sec
-	udiv	\res_sec, \clock_nsec, \nsec_to_sec
-	msub	\res_nsec, \res_sec, \nsec_to_sec, \clock_nsec
-	.endm
-
-	/* sec and nsec are modified in place. */
-	.macro add_ts sec, nsec, ts_sec, ts_nsec, nsec_to_sec
-	/* Add timespec. */
-	add	\sec, \sec, \ts_sec
-	add	\nsec, \nsec, \ts_nsec
-
-	/* Normalise the new timespec. */
-	cmp	\nsec, \nsec_to_sec
-	b.lt	9999f
-	sub	\nsec, \nsec, \nsec_to_sec
-	add	\sec, \sec, #1
-9999:
-	cmp	\nsec, #0
-	b.ge	9998f
-	add	\nsec, \nsec, \nsec_to_sec
-	sub	\sec, \sec, #1
-9998:
-	.endm
-
-	.macro clock_gettime_return, shift=0
-	.if \shift == 1
-	lsr	x11, x11, x12
-	.endif
-	stp	x10, x11, [x1, #TSPEC_TV_SEC]
-	mov	x0, xzr
-	ret
-	.endm
-
-	.macro jump_slot jumptable, index, label
-	.if (. - \jumptable) != 4 * (\index)
-	.error "Jump slot index mismatch"
-	.endif
-	b	\label
-	.endm
-
-	.text
-
-/* int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz); */
-ENTRY(__kernel_gettimeofday)
-	.cfi_startproc
-	adr	vdso_data, _vdso_data
-	/* If tv is NULL, skip to the timezone code. */
-	cbz	x0, 2f
-
-	/* Compute the time of day. */
-1:	seqcnt_acquire
-	syscall_check fail=4f
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=1b
-
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-
-	/* Convert ns to us. */
-	mov	x13, #1000
-	lsl	x13, x13, x12
-	udiv	x11, x11, x13
-	stp	x10, x11, [x0, #TVAL_TV_SEC]
-2:
-	/* If tz is NULL, return 0. */
-	cbz	x1, 3f
-	ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST]
-	stp	w4, w5, [x1, #TZ_MINWEST]
-3:
-	mov	x0, xzr
-	ret
-4:
-	/* Syscall fallback. */
-	mov	x8, #__NR_gettimeofday
-	svc	#0
-	ret
-	.cfi_endproc
-ENDPROC(__kernel_gettimeofday)
-
-#define JUMPSLOT_MAX CLOCK_MONOTONIC_COARSE
-
-/* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
-ENTRY(__kernel_clock_gettime)
-	.cfi_startproc
-	cmp	w0, #JUMPSLOT_MAX
-	b.hi	syscall
-	adr	vdso_data, _vdso_data
-	adr	x_tmp, jumptable
-	add	x_tmp, x_tmp, w0, uxtw #2
-	br	x_tmp
-
-	ALIGN
-jumptable:
-	jump_slot jumptable, CLOCK_REALTIME, realtime
-	jump_slot jumptable, CLOCK_MONOTONIC, monotonic
-	b	syscall
-	b	syscall
-	jump_slot jumptable, CLOCK_MONOTONIC_RAW, monotonic_raw
-	jump_slot jumptable, CLOCK_REALTIME_COARSE, realtime_coarse
-	jump_slot jumptable, CLOCK_MONOTONIC_COARSE, monotonic_coarse
-
-	.if (. - jumptable) != 4 * (JUMPSLOT_MAX + 1)
-	.error	"Wrong jumptable size"
-	.endif
-
-	ALIGN
-realtime:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=realtime
-
-	/* All computations are done with left-shifted nsecs. */
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-monotonic:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	ldp	x3, x4, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic
-
-	/* All computations are done with left-shifted nsecs. */
-	lsl	x4, x4, x12
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-
-	add_ts sec=x10, nsec=x11, ts_sec=x3, ts_nsec=x4, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-monotonic_raw:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_raw_mult, w12 = cs_shift */
-	ldp	w12, w11, [vdso_data, #VDSO_CS_SHIFT]
-	ldp	x13, x14, [vdso_data, #VDSO_RAW_TIME_SEC]
-	seqcnt_check fail=monotonic_raw
-
-	/* All computations are done with left-shifted nsecs. */
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_clock_raw res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, nsec_to_sec=x9
-
-	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-realtime_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	seqcnt_check fail=realtime_coarse
-	clock_gettime_return
-
-	ALIGN
-monotonic_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	ldp	x13, x14, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic_coarse
-
-	/* Computations are done in (non-shifted) nsecs. */
-	get_nsec_per_sec res=x9
-	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return
-
-	ALIGN
-syscall: /* Syscall fallback. */
-	mov	x8, #__NR_clock_gettime
-	svc	#0
-	ret
-	.cfi_endproc
-ENDPROC(__kernel_clock_gettime)
-
-/* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
-ENTRY(__kernel_clock_getres)
-	.cfi_startproc
-	cmp	w0, #CLOCK_REALTIME
-	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
-	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
-	b.ne	1f
-
-	ldr	x2, 5f
-	b	2f
-1:
-	cmp	w0, #CLOCK_REALTIME_COARSE
-	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
-	b.ne	4f
-	ldr	x2, 6f
-2:
-	cbz	x1, 3f
-	stp	xzr, x2, [x1]
-
-3:	/* res == NULL. */
-	mov	w0, wzr
-	ret
-
-4:	/* Syscall fallback. */
-	mov	x8, #__NR_clock_getres
-	svc	#0
-	ret
-5:
-	.quad	CLOCK_REALTIME_RES
-6:
-	.quad	CLOCK_COARSE_RES
-	.cfi_endproc
-ENDPROC(__kernel_clock_getres)
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index beca249bc2f3..9de0ffc369c5 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -88,6 +88,7 @@ VERSION
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
+		__kernel_time;
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso/vgettimeofday.c b/arch/arm64/kernel/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..288c85a6e308
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vgettimeofday.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM64 userspace implementations of gettimeofday() and similar.
+ *
+ * Copyright (C) 2018 ARM Limited
+ *
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+notrace int __kernel_clock_gettime(clockid_t clock, struct timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+notrace int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+notrace time_t __kernel_time(time_t *time)
+{
+	return __cvdso_time(time);
+}
+
+notrace int __kernel_clock_getres(clockid_t clock_id, struct timespec *res)
+{
+	return __cvdso_clock_getres(clock_id, res);
+}
+
-- 
2.19.1
