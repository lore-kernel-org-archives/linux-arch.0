From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 14/17] RISC-V: lib files
Date: Tue,  6 Jun 2017 16:00:04 -0700
Message-ID: <20170606230007.19101-15-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org

Most of these files are based off code in GCC, but the delay code is
mostly from ARM.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/lib/Makefile  |   5 ++
 arch/riscv/lib/delay.c   | 107 ++++++++++++++++++++++++++++++++++++++++
 arch/riscv/lib/memcpy.S  |  98 +++++++++++++++++++++++++++++++++++++
 arch/riscv/lib/memset.S  | 118 ++++++++++++++++++++++++++++++++++++++++++++
 arch/riscv/lib/uaccess.S | 125 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/riscv/lib/udivdi3.S |  39 +++++++++++++++
 6 files changed, 492 insertions(+)
 create mode 100644 arch/riscv/lib/Makefile
 create mode 100644 arch/riscv/lib/delay.c
 create mode 100644 arch/riscv/lib/memcpy.S
 create mode 100644 arch/riscv/lib/memset.S
 create mode 100644 arch/riscv/lib/uaccess.S
 create mode 100644 arch/riscv/lib/udivdi3.S

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
new file mode 100644
index 000000000000..120c38e77a46
--- /dev/null
+++ b/arch/riscv/lib/Makefile
@@ -0,0 +1,5 @@
+lib-y	:= delay.o memcpy.o memset.o uaccess.o
+
+ifeq ($(CONFIG_64BIT),)
+lib-y += udivdi3.o
+endif
diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
new file mode 100644
index 000000000000..ceff08a5b762
--- /dev/null
+++ b/arch/riscv/lib/delay.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
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
+#include <linux/delay.h>
+#include <linux/param.h>
+#include <linux/timex.h>
+#include <linux/export.h>
+
+/*
+ * This is copies from arch/arm/include/asm/delay.h
+ *
+ * Loop (or tick) based delay:
+ *
+ * loops = loops_per_jiffy * jiffies_per_sec * delay_us / us_per_sec
+ *
+ * where:
+ *
+ * jiffies_per_sec = HZ
+ * us_per_sec = 1000000
+ *
+ * Therefore the constant part is HZ / 1000000 which is a small
+ * fractional number. To make this usable with integer math, we
+ * scale up this constant by 2^31, perform the actual multiplication,
+ * and scale the result back down by 2^31 with a simple shift:
+ *
+ * loops = (loops_per_jiffy * delay_us * UDELAY_MULT) >> 31
+ *
+ * where:
+ *
+ * UDELAY_MULT = 2^31 * HZ / 1000000
+ *             = (2^31 / 1000000) * HZ
+ *             = 2147.483648 * HZ
+ *             = 2147 * HZ + 483648 * HZ / 1000000
+ *
+ * 31 is the biggest scale shift value that won't overflow 32 bits for
+ * delay_us * UDELAY_MULT assuming HZ <= 1000 and delay_us <= 2000.
+ */
+#define MAX_UDELAY_US	2000
+#define MAX_UDELAY_HZ	1000
+#define UDELAY_MULT	(2147UL * HZ + 483648UL * HZ / 1000000UL)
+#define UDELAY_SHIFT	31
+
+#if HZ > MAX_UDELAY_HZ
+#error "HZ > MAX_UDELAY_HZ"
+#endif
+
+/* RISC-V supports both UDELAY and NDELAY.  This is largely the same as above,
+ * but with different constants.  I added 10 bits to the shift to get this, but
+ * the result is that I need a 64-bit multiply, which is slow on 32-bit
+ * platforms.
+ *
+ * NDELAY_MULT = 2^41 * HZ / 1000000000
+ *             = (2^41 / 1000000000) * HZ
+ *             = 2199.02325555 * HZ
+ *             = 2199 * HZ + 23255550 * HZ / 1000000000
+ *
+ * The maximum here is to avoid 64-bit overflow, but it isn't checked as it
+ * won't happen.
+ */
+#define MAX_NDELAY_NS   (1ULL << 42)
+#define MAX_NDELAY_HZ	MAX_UDELAY_HZ
+#define NDELAY_MULT	((unsigned long long)(2199ULL * HZ + 23255550ULL * HZ / 1000000000ULL))
+#define NDELAY_SHIFT	41
+
+#if HZ > MAX_NDELAY_HZ
+#error "HZ > MAX_NDELAY_HZ"
+#endif
+
+void __delay(unsigned long cycles)
+{
+	u64 t0 = get_cycles();
+
+	while ((unsigned long)(get_cycles() - t0) < cycles)
+		cpu_relax();
+}
+
+void udelay(unsigned long usecs)
+{
+	unsigned long ucycles = usecs * lpj_fine * UDELAY_MULT;
+
+	if (usecs > MAX_UDELAY_US) {
+		__delay((u64)usecs * riscv_timebase / 1000000ULL);
+		return;
+	}
+
+	__delay(ucycles >> UDELAY_SHIFT);
+}
+EXPORT_SYMBOL(udelay);
+
+void ndelay(unsigned long nsecs)
+{
+	/* This doesn't bother checking for overflow, as it won't happen (it's
+	 * an hour) of delay. */
+	unsigned long long ncycles = nsecs * lpj_fine * NDELAY_MULT;
+	__delay(ncycles >> NDELAY_SHIFT);
+}
+EXPORT_SYMBOL(ndelay);
diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
new file mode 100644
index 000000000000..5b576cf041eb
--- /dev/null
+++ b/arch/riscv/lib/memcpy.S
@@ -0,0 +1,98 @@
+/*
+ * Copyright (C) 2013 Regents of the University of California
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
+#include <asm/asm.h>
+
+/* void *memcpy(void *, const void *, size_t) */
+ENTRY(memcpy)
+	move t6, a0  /* Preserve return value */
+
+	/* Defer to byte-oriented copy for small sizes */
+	sltiu a3, a2, 128
+	bnez a3, 4f
+	/* Use word-oriented copy only if low-order bits match */
+	andi a3, t6, SZREG-1
+	andi a4, a1, SZREG-1
+	bne a3, a4, 4f
+
+	beqz a3, 2f  /* Skip if already aligned */
+	/* Round to nearest double word-aligned address
+	   greater than or equal to start address */
+	andi a3, a1, ~(SZREG-1)
+	addi a3, a3, SZREG
+	/* Handle initial misalignment */
+	sub a4, a3, a1
+1:
+	lb a5, 0(a1)
+	addi a1, a1, 1
+	sb a5, 0(t6)
+	addi t6, t6, 1
+	bltu a1, a3, 1b
+	sub a2, a2, a4  /* Update count */
+
+2:
+	andi a4, a2, ~((16*SZREG)-1)
+	beqz a4, 4f
+	add a3, a1, a4
+3:
+	REG_L a4,       0(a1)
+	REG_L a5,   SZREG(a1)
+	REG_L a6, 2*SZREG(a1)
+	REG_L a7, 3*SZREG(a1)
+	REG_L t0, 4*SZREG(a1)
+	REG_L t1, 5*SZREG(a1)
+	REG_L t2, 6*SZREG(a1)
+	REG_L t3, 7*SZREG(a1)
+	REG_L t4, 8*SZREG(a1)
+	REG_L t5, 9*SZREG(a1)
+	REG_S a4,       0(t6)
+	REG_S a5,   SZREG(t6)
+	REG_S a6, 2*SZREG(t6)
+	REG_S a7, 3*SZREG(t6)
+	REG_S t0, 4*SZREG(t6)
+	REG_S t1, 5*SZREG(t6)
+	REG_S t2, 6*SZREG(t6)
+	REG_S t3, 7*SZREG(t6)
+	REG_S t4, 8*SZREG(t6)
+	REG_S t5, 9*SZREG(t6)
+	REG_L a4, 10*SZREG(a1)
+	REG_L a5, 11*SZREG(a1)
+	REG_L a6, 12*SZREG(a1)
+	REG_L a7, 13*SZREG(a1)
+	REG_L t0, 14*SZREG(a1)
+	REG_L t1, 15*SZREG(a1)
+	addi a1, a1, 16*SZREG
+	REG_S a4, 10*SZREG(t6)
+	REG_S a5, 11*SZREG(t6)
+	REG_S a6, 12*SZREG(t6)
+	REG_S a7, 13*SZREG(t6)
+	REG_S t0, 14*SZREG(t6)
+	REG_S t1, 15*SZREG(t6)
+	addi t6, t6, 16*SZREG
+	bltu a1, a3, 3b
+	andi a2, a2, (16*SZREG)-1  /* Update count */
+
+4:
+	/* Handle trailing misalignment */
+	beqz a2, 6f
+	add a3, a1, a2
+5:
+	lb a4, 0(a1)
+	addi a1, a1, 1
+	sb a4, 0(t6)
+	addi t6, t6, 1
+	bltu a1, a3, 5b
+6:
+	ret
+END(memcpy)
diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
new file mode 100644
index 000000000000..d83c38099653
--- /dev/null
+++ b/arch/riscv/lib/memset.S
@@ -0,0 +1,118 @@
+/*
+ * Copyright (C) 2013 Regents of the University of California
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
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+
+/* void *memset(void *, int, size_t) */
+ENTRY(memset)
+	move t0, a0  /* Preserve return value */
+
+	/* Defer to byte-oriented fill for small sizes */
+	sltiu a3, a2, 16
+	bnez a3, 4f
+
+	/* Round to nearest XLEN-aligned address
+	   greater than or equal to start address */
+	addi a3, t0, SZREG-1
+	andi a3, a3, ~(SZREG-1)
+	beq a3, t0, 2f  /* Skip if already aligned */
+	/* Handle initial misalignment */
+	sub a4, a3, t0
+1:
+	sb a1, 0(t0)
+	addi t0, t0, 1
+	bltu t0, a3, 1b
+	sub a2, a2, a4  /* Update count */
+
+2: /* Duff's device with 32 XLEN stores per iteration */
+	/* Broadcast value into all bytes */
+	andi a1, a1, 0xff
+	slli a3, a1, 8
+	or a1, a3, a1
+	slli a3, a1, 16
+	or a1, a3, a1
+#ifdef CONFIG_64BIT
+	slli a3, a1, 32
+	or a1, a3, a1
+#endif
+
+	/* Calculate end address */
+	andi a4, a2, ~(SZREG-1)
+	add a3, t0, a4
+
+	andi a4, a4, 31*SZREG  /* Calculate remainder */
+	beqz a4, 3f            /* Shortcut if no remainder */
+	neg a4, a4
+	addi a4, a4, 32*SZREG  /* Calculate initial offset */
+
+	/* Adjust start address with offset */
+	sub t0, t0, a4
+
+	/* Jump into loop body */
+	/* Assumes 32-bit instruction lengths */
+	la a5, 3f
+#ifdef CONFIG_64BIT
+	srli a4, a4, 1
+#endif
+	add a5, a5, a4
+	jr a5
+3:
+	REG_S a1,        0(t0)
+	REG_S a1,    SZREG(t0)
+	REG_S a1,  2*SZREG(t0)
+	REG_S a1,  3*SZREG(t0)
+	REG_S a1,  4*SZREG(t0)
+	REG_S a1,  5*SZREG(t0)
+	REG_S a1,  6*SZREG(t0)
+	REG_S a1,  7*SZREG(t0)
+	REG_S a1,  8*SZREG(t0)
+	REG_S a1,  9*SZREG(t0)
+	REG_S a1, 10*SZREG(t0)
+	REG_S a1, 11*SZREG(t0)
+	REG_S a1, 12*SZREG(t0)
+	REG_S a1, 13*SZREG(t0)
+	REG_S a1, 14*SZREG(t0)
+	REG_S a1, 15*SZREG(t0)
+	REG_S a1, 16*SZREG(t0)
+	REG_S a1, 17*SZREG(t0)
+	REG_S a1, 18*SZREG(t0)
+	REG_S a1, 19*SZREG(t0)
+	REG_S a1, 20*SZREG(t0)
+	REG_S a1, 21*SZREG(t0)
+	REG_S a1, 22*SZREG(t0)
+	REG_S a1, 23*SZREG(t0)
+	REG_S a1, 24*SZREG(t0)
+	REG_S a1, 25*SZREG(t0)
+	REG_S a1, 26*SZREG(t0)
+	REG_S a1, 27*SZREG(t0)
+	REG_S a1, 28*SZREG(t0)
+	REG_S a1, 29*SZREG(t0)
+	REG_S a1, 30*SZREG(t0)
+	REG_S a1, 31*SZREG(t0)
+	addi t0, t0, 32*SZREG
+	bltu t0, a3, 3b
+	andi a2, a2, SZREG-1  /* Update count */
+
+4:
+	/* Handle trailing misalignment */
+	beqz a2, 6f
+	add a3, t0, a2
+5:
+	sb a1, 0(t0)
+	addi t0, t0, 1
+	bltu t0, a3, 5b
+6:
+	ret
+END(memset)
diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
new file mode 100644
index 000000000000..cba994696aff
--- /dev/null
+++ b/arch/riscv/lib/uaccess.S
@@ -0,0 +1,125 @@
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/csr.h>
+
+	.altmacro
+	.macro fixup op reg addr lbl
+	LOCAL _epc
+_epc:
+	\op \reg, \addr
+	.section __ex_table,"a"
+	.balign RISCV_SZPTR
+	RISCV_PTR _epc, \lbl
+	.previous
+	.endm
+
+ENTRY(__copy_user)
+
+#ifdef CONFIG_RV_PUM
+	/* Enable access to user memory */
+	li t6, SR_SUM
+	csrs sstatus, t6
+#endif
+
+	add a3, a1, a2
+	/* Use word-oriented copy only if low-order bits match */
+	andi t0, a0, SZREG-1
+	andi t1, a1, SZREG-1
+	bne t0, t1, 2f
+
+	addi t0, a1, SZREG-1
+	andi t1, a3, ~(SZREG-1)
+	andi t0, t0, ~(SZREG-1)
+	/* a3: terminal address of source region
+	 * t0: lowest XLEN-aligned address in source
+	 * t1: highest XLEN-aligned address in source
+	 */
+	bgeu t0, t1, 2f
+	bltu a1, t0, 4f
+1:
+	fixup REG_L, t2, (a1), 10f
+	fixup REG_S, t2, (a0), 10f
+	addi a1, a1, SZREG
+	addi a0, a0, SZREG
+	bltu a1, t1, 1b
+2:
+	bltu a1, a3, 5f
+
+3:
+#ifdef CONFIG_RV_PUM
+	/* Disable access to user memory */
+	csrc sstatus, t6
+#endif
+	li a0, 0
+	ret
+4: /* Edge case: unalignment */
+	fixup lbu, t2, (a1), 10f
+	fixup sb, t2, (a0), 10f
+	addi a1, a1, 1
+	addi a0, a0, 1
+	bltu a1, t0, 4b
+	j 1b
+5: /* Edge case: remainder */
+	fixup lbu, t2, (a1), 10f
+	fixup sb, t2, (a0), 10f
+	addi a1, a1, 1
+	addi a0, a0, 1
+	bltu a1, a3, 5b
+	j 3b
+ENDPROC(__copy_user)
+
+
+ENTRY(__clear_user)
+
+#ifdef CONFIG_RV_PUM
+	/* Enable access to user memory */
+	li t6, SR_SUM
+	csrs sstatus, t6
+#endif
+
+	add a3, a0, a1
+	addi t0, a0, SZREG-1
+	andi t1, a3, ~(SZREG-1)
+	andi t0, t0, ~(SZREG-1)
+	/* a3: terminal address of target region
+	 * t0: lowest doubleword-aligned address in target region
+	 * t1: highest doubleword-aligned address in target region
+	 */
+	bgeu t0, t1, 2f
+	bltu a0, t0, 4f
+1:
+	fixup REG_S, zero, (a0), 10f
+	addi a0, a0, SZREG
+	bltu a0, t1, 1b
+2:
+	bltu a0, a3, 5f
+
+3:
+#ifdef CONFIG_RV_PUM
+	/* Disable access to user memory */
+	csrc sstatus, t6
+#endif
+	li a0, 0
+	ret
+4: /* Edge case: unalignment */
+	fixup sb, zero, (a0), 10f
+	addi a0, a0, 1
+	bltu a0, t0, 4b
+	j 1b
+5: /* Edge case: remainder */
+	fixup sb, zero, (a0), 10f
+	addi a0, a0, 1
+	bltu a0, a3, 5b
+	j 3b
+ENDPROC(__clear_user)
+
+	.section .fixup,"ax"
+	.balign 4
+10:
+#ifdef CONFIG_RV_PUM
+	/* Disable access to user memory */
+	csrs sstatus, t6
+#endif
+	sub a0, a3, a0
+	ret
+	.previous
diff --git a/arch/riscv/lib/udivdi3.S b/arch/riscv/lib/udivdi3.S
new file mode 100644
index 000000000000..d8a7a1d03615
--- /dev/null
+++ b/arch/riscv/lib/udivdi3.S
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2016-2017 Free Software Foundation, Inc.
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
+  .globl __udivdi3
+__udivdi3:
+  mv    a2, a1
+  mv    a1, a0
+  li    a0, -1
+  beqz  a2, .L5
+  li    a3, 1
+  bgeu  a2, a1, .L2
+.L1:
+  blez  a2, .L2
+  slli  a2, a2, 1
+  slli  a3, a3, 1
+  bgtu  a1, a2, .L1
+.L2:
+  li    a0, 0
+.L3:
+  bltu  a1, a2, .L4
+  sub   a1, a1, a2
+  or    a0, a0, a3
+.L4:
+  srli  a3, a3, 1
+  srli  a2, a2, 1
+  bnez  a3, .L3
+.L5:
+  ret
+
-- 
2.13.0
