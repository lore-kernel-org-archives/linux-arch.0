Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55371 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893Ab2HNRxM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:12 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 22/31] arm64: Floating point and SIMD
Date: Tue, 14 Aug 2012 18:52:23 +0100
Message-ID: <1344966752-16102-23-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175223.ViK2g2lNJ6SN0t5BtAMT6gujLXDjJTkjgcpzx6pjnps@z>

This patch adds support for FP/ASIMD register bank saving and restoring
during context switch and FP exception handling to generate SIGFPE.
There are 32 128-bit registers and the context switching is currently
done non-lazily. Benchmarks on real hardware are required before
implementing lazy FP state saving/restoring.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/fpsimd.h  |   64 +++++++++++++++++++++++
 arch/arm64/kernel/entry-fpsimd.S |   80 ++++++++++++++++++++++++++++
 arch/arm64/kernel/fpsimd.c       |  106 ++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 250 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/fpsimd.h
 create mode 100644 arch/arm64/kernel/entry-fpsimd.S
 create mode 100644 arch/arm64/kernel/fpsimd.c

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsim=
d.h
new file mode 100644
index 0000000..7ea4711
--- /dev/null
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef __ASM_FP_H
+#define __ASM_FP_H
+
+#include <asm/ptrace.h>
+
+#ifndef __ASSEMBLY__
+
+/*
+ * FP/SIMD storage area has:
+ *  - FPSR and FPCR
+ *  - 32 128-bit data registers
+ *
+ * Note that user_fp forms a prefix of this structure, which is relied
+ * upon in the ptrace FP/SIMD accessors. struct user_fpsimd_state must
+ * form a prefix of struct fpsimd_state.
+ */
+struct fpsimd_state {
+=09union {
+=09=09struct user_fpsimd_state user_fpsimd;
+=09=09struct {
+=09=09=09__uint128_t vregs[32];
+=09=09=09u32 fpsr;
+=09=09=09u32 fpcr;
+=09=09};
+=09};
+};
+
+#if defined(__KERNEL__) && defined(CONFIG_AARCH32_EMULATION)
+/* Masks for extracting the FPSR and FPCR from the FPSCR */
+#define VFP_FPSCR_STAT_MASK=090xf800009f
+#define VFP_FPSCR_CTRL_MASK=090x07f79f00
+/*
+ * The VFP state has 32x64-bit registers and a single 32-bit
+ * control/status register.
+ */
+#define VFP_STATE_SIZE=09=09((32 * 8) + 4)
+#endif
+
+struct task_struct;
+
+extern void fpsimd_save_state(struct fpsimd_state *state);
+extern void fpsimd_load_state(struct fpsimd_state *state);
+
+extern void fpsimd_thread_switch(struct task_struct *next);
+extern void fpsimd_flush_thread(void);
+
+#endif
+
+#endif
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fps=
imd.S
new file mode 100644
index 0000000..17988a6
--- /dev/null
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -0,0 +1,80 @@
+/*
+ * FP/SIMD state saving and restoring
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Catalin Marinas <catalin.marinas@arm.com>
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
+
+#include <linux/linkage.h>
+
+#include <asm/assembler.h>
+
+/*
+ * Save the FP registers.
+ *
+ * x0 - pointer to struct fpsimd_state
+ */
+ENTRY(fpsimd_save_state)
+=09stp=09q0, q1, [x0, #16 * 0]
+=09stp=09q2, q3, [x0, #16 * 2]
+=09stp=09q4, q5, [x0, #16 * 4]
+=09stp=09q6, q7, [x0, #16 * 6]
+=09stp=09q8, q9, [x0, #16 * 8]
+=09stp=09q10, q11, [x0, #16 * 10]
+=09stp=09q12, q13, [x0, #16 * 12]
+=09stp=09q14, q15, [x0, #16 * 14]
+=09stp=09q16, q17, [x0, #16 * 16]
+=09stp=09q18, q19, [x0, #16 * 18]
+=09stp=09q20, q21, [x0, #16 * 20]
+=09stp=09q22, q23, [x0, #16 * 22]
+=09stp=09q24, q25, [x0, #16 * 24]
+=09stp=09q26, q27, [x0, #16 * 26]
+=09stp=09q28, q29, [x0, #16 * 28]
+=09stp=09q30, q31, [x0, #16 * 30]!
+=09mrs=09x8, fpsr
+=09str=09w8, [x0, #16 * 2]
+=09mrs=09x8, fpcr
+=09str=09w8, [x0, #16 * 2 + 4]
+=09ret
+ENDPROC(fpsimd_save_state)
+
+/*
+ * Load the FP registers.
+ *
+ * x0 - pointer to struct fpsimd_state
+ */
+ENTRY(fpsimd_load_state)
+=09ldp=09q0, q1, [x0, #16 * 0]
+=09ldp=09q2, q3, [x0, #16 * 2]
+=09ldp=09q4, q5, [x0, #16 * 4]
+=09ldp=09q6, q7, [x0, #16 * 6]
+=09ldp=09q8, q9, [x0, #16 * 8]
+=09ldp=09q10, q11, [x0, #16 * 10]
+=09ldp=09q12, q13, [x0, #16 * 12]
+=09ldp=09q14, q15, [x0, #16 * 14]
+=09ldp=09q16, q17, [x0, #16 * 16]
+=09ldp=09q18, q19, [x0, #16 * 18]
+=09ldp=09q20, q21, [x0, #16 * 20]
+=09ldp=09q22, q23, [x0, #16 * 22]
+=09ldp=09q24, q25, [x0, #16 * 24]
+=09ldp=09q26, q27, [x0, #16 * 26]
+=09ldp=09q28, q29, [x0, #16 * 28]
+=09ldp=09q30, q31, [x0, #16 * 30]!
+=09ldr=09w8, [x0, #16 * 2]
+=09ldr=09w9, [x0, #16 * 2 + 4]
+=09msr=09fpsr, x8
+=09msr=09fpcr, x9
+=09ret
+ENDPROC(fpsimd_load_state)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
new file mode 100644
index 0000000..e8b8357
--- /dev/null
+++ b/arch/arm64/kernel/fpsimd.c
@@ -0,0 +1,106 @@
+/*
+ * FP/SIMD context switching and fault handling
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Catalin Marinas <catalin.marinas@arm.com>
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
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+
+#include <asm/fpsimd.h>
+#include <asm/cputype.h>
+
+#define FPEXC_IOF=09(1 << 0)
+#define FPEXC_DZF=09(1 << 1)
+#define FPEXC_OFF=09(1 << 2)
+#define FPEXC_UFF=09(1 << 3)
+#define FPEXC_IXF=09(1 << 4)
+#define FPEXC_IDF=09(1 << 7)
+
+/*
+ * Trapped FP/ASIMD access.
+ */
+void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
+{
+=09/* TODO: implement lazy context saving/restoring */
+=09WARN_ON(1);
+}
+
+/*
+ * Raise a SIGFPE for the current process.
+ */
+void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
+{
+=09siginfo_t info;
+=09unsigned int si_code =3D 0;
+
+=09if (esr & FPEXC_IOF)
+=09=09si_code =3D FPE_FLTINV;
+=09else if (esr & FPEXC_DZF)
+=09=09si_code =3D FPE_FLTDIV;
+=09else if (esr & FPEXC_OFF)
+=09=09si_code =3D FPE_FLTOVF;
+=09else if (esr & FPEXC_UFF)
+=09=09si_code =3D FPE_FLTUND;
+=09else if (esr & FPEXC_IXF)
+=09=09si_code =3D FPE_FLTRES;
+
+=09memset(&info, 0, sizeof(info));
+=09info.si_signo =3D SIGFPE;
+=09info.si_code =3D si_code;
+=09info.si_addr =3D (void __user *)instruction_pointer(regs);
+
+=09send_sig_info(SIGFPE, &info, current);
+}
+
+void fpsimd_thread_switch(struct task_struct *next)
+{
+=09/* check if not kernel threads */
+=09if (current->mm)
+=09=09fpsimd_save_state(&current->thread.fpsimd_state);
+=09if (next->mm)
+=09=09fpsimd_load_state(&next->thread.fpsimd_state);
+}
+
+void fpsimd_flush_thread(void)
+{
+=09memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
+=09fpsimd_load_state(&current->thread.fpsimd_state);
+}
+
+/*
+ * FP/SIMD support code initialisation.
+ */
+static int __init fpsimd_init(void)
+{
+=09u64 pfr =3D read_cpuid(ID_AA64PFR0_EL1);
+
+=09if (pfr & (0xf << 16)) {
+=09=09pr_notice("Floating-point is not implemented\n");
+=09=09return 0;
+=09}
+=09elf_hwcap |=3D HWCAP_FP;
+
+=09if (pfr & (0xf << 20))
+=09=09pr_notice("Advanced SIMD is not implemented\n");
+=09else
+=09=09elf_hwcap |=3D HWCAP_ASIMD;
+
+=09return 0;
+}
+late_initcall(fpsimd_init);

