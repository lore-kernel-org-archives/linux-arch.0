Return-Path: <SRS0=Irbl=4Z=lists.infradead.org=linux-riscv-bounces+rppt=kernel.org@kernel.org>
From: guoren@kernel.org
Subject: [RFC PATCH V3 09/11] riscv: Add task switch support for VECTOR
Date: Sun,  8 Mar 2020 17:49:52 +0800
Message-ID: <20200308094954.13258-10-guoren@kernel.org>
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
References: <20200308094954.13258-1-guoren@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+rppt=kernel.org@lists.infradead.org
To: paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com, greentime.hu@sifive.com
Cc: linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, Dave Martin <Dave.Martin@arm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200308094952.QEU4bPQDjjBSYTL5LWm4UumdLzU13ahzWWdKMjBUMZk@z>

From: Guo Ren <guoren@linux.alibaba.com>

This patch add task switch and task create for VECTOR, and now
the applications with vector instructions wouldn't be broken by
linux task switch.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/asm/switch_to.h | 48 +++++++++++++++++
 arch/riscv/kernel/Makefile         |  1 +
 arch/riscv/kernel/process.c        | 10 ++++
 arch/riscv/kernel/vector.S         | 84 ++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+)
 create mode 100644 arch/riscv/kernel/vector.S

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index b9234e7178d0..6e1c7fa599be 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -63,6 +63,52 @@ extern bool has_fpu;
 #define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
+#ifdef CONFIG_VECTOR
+extern void __vstate_save(struct task_struct *save_to);
+extern void __vstate_restore(struct task_struct *restore_from);
+
+static inline void __vstate_clean(struct pt_regs *regs)
+{
+	regs->status |= (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
+}
+
+static inline void vstate_save(struct task_struct *task,
+			       struct pt_regs *regs)
+{
+	if ((regs->status & SR_VS) == SR_VS_DIRTY) {
+		__vstate_save(task);
+		__vstate_clean(regs);
+	}
+}
+
+static inline void vstate_restore(struct task_struct *task,
+				  struct pt_regs *regs)
+{
+	if ((regs->status & SR_VS) != SR_VS_OFF) {
+		__vstate_restore(task);
+		__vstate_clean(regs);
+	}
+}
+
+static inline void __switch_to_vector(struct task_struct *prev,
+				   struct task_struct *next)
+{
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(prev);
+	if (unlikely(regs->status & SR_SD))
+		vstate_save(prev, regs);
+	vstate_restore(next, task_pt_regs(next));
+}
+
+extern bool has_vector;
+#else
+#define has_vector false
+#define vstate_save(task, regs) do { } while (0)
+#define vstate_restore(task, regs) do { } while (0)
+#define __switch_to_vector(__prev, __next) do { } while (0)
+#endif
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -72,6 +118,8 @@ do {							\
 	struct task_struct *__next = (next);		\
 	if (has_fpu)					\
 		__switch_to_fpu(__prev, __next);	\
+	if (has_vector)					\
+		__switch_to_vector(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f40205cb9a22..e5276c3bdffc 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_M_MODE)	+= clint.o
 obj-$(CONFIG_FPU)		+= fpu.o
+obj-$(CONFIG_VECTOR)		+= vector.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_MODULES)		+= module.o
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 817cf7b0974c..c572557701b4 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -74,6 +74,16 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 		 */
 		fstate_restore(current, regs);
 	}
+
+	if (has_vector) {
+		regs->status |= SR_VS_INITIAL;
+		/*
+		 * Restore the initial value to the vector register
+		 * before starting the user program.
+		 */
+		vstate_restore(current, regs);
+	}
+
 	regs->epc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
new file mode 100644
index 000000000000..dbe1989fa9d7
--- /dev/null
+++ b/arch/riscv/kernel/vector.S
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ * Copyright (C) 2019 Alibaba Group Holding Limited
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/csr.h>
+#include <asm/asm-offsets.h>
+
+ENTRY(__vstate_save)
+	li	a2,  TASK_THREAD_V0
+	add	a0,  a0, a2
+
+	li	t1, (SR_VS | SR_FS)
+	csrs	sstatus, t1
+
+	csrr	t0,  CSR_VSTART
+	sd	t0,  TASK_THREAD_VSTART_V0(a0)
+	csrr	t0,  CSR_VXSAT
+	sd	t0,  TASK_THREAD_VXSAT_V0(a0)
+	csrr	t0,  CSR_VXRM
+	sd	t0,  TASK_THREAD_VXRM_V0(a0)
+	csrr	t0,  CSR_VL
+	sd	t0,  TASK_THREAD_VL_V0(a0)
+	csrr	t0,  CSR_VTYPE
+	sd	t0,  TASK_THREAD_VTYPE_V0(a0)
+
+	vsetvli	t0, x0, e8,m8
+	vsb.v	v0,  (a0)
+	addi	a0, a0, 128*8
+	vsb.v	v8,  (a0)
+	addi	a0, a0, 128*8
+	vsb.v	v16, (a0)
+	addi	a0, a0, 128*8
+	vsb.v	v24, (a0)
+
+	csrc	sstatus, t1
+	ret
+ENDPROC(__vstate_save)
+
+ENTRY(__vstate_restore)
+	li	a2,  TASK_THREAD_V0
+	add	a0,  a0, a2
+	mv	t2,  a0
+
+	li	t1, (SR_VS | SR_FS)
+	csrs	sstatus, t1
+
+	vsetvli	t0, x0, e8,m8
+	vlb.v	v0,  (a0)
+	addi	a0, a0, 128*8
+	vlb.v	v8,  (a0)
+	addi	a0, a0, 128*8
+	vlb.v	v16, (a0)
+	addi	a0, a0, 128*8
+	vlb.v	v24, (a0)
+
+	mv	a0,  t2
+	ld	t0,  TASK_THREAD_VSTART_V0(a0)
+	csrw	CSR_VSTART, t0
+	ld	t0,  TASK_THREAD_VXSAT_V0(a0)
+	csrw	CSR_VXSAT, t0
+	ld	t0,  TASK_THREAD_VXRM_V0(a0)
+	csrw	CSR_VXRM, t0
+	ld	t0,  TASK_THREAD_VL_V0(a0)
+	ld	t2,  TASK_THREAD_VTYPE_V0(a0)
+	vsetvl	t0, t0, t2
+
+	csrc	sstatus, t1
+	ret
+ENDPROC(__vstate_restore)
-- 
2.17.0
