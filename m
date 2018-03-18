From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 11/19] csky: Library functions
Date: Mon, 19 Mar 2018 03:51:33 +0800
Message-ID: <919c62d7963a32f33262aae09f1afbb8271e367c.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/src/bswapdi.c    |  18 ++
 arch/csky/abiv1/src/bswapsi.c    |  15 ++
 arch/csky/abiv1/src/memcpy.S     | 344 +++++++++++++++++++++++++++++++++++++++
 arch/csky/abiv2/src/fpu.c        | 312 +++++++++++++++++++++++++++++++++++
 arch/csky/abiv2/src/memcpy.c     |  43 +++++
 arch/csky/include/asm/bitops.h   |  83 ++++++++++
 arch/csky/include/asm/checksum.h |  77 +++++++++
 arch/csky/include/asm/string.h   |  19 +++
 arch/csky/kernel/asm-offsets.c   |  86 ++++++++++
 arch/csky/kernel/cskyksyms.c     |  31 ++++
 arch/csky/kernel/platform.c      |  18 ++
 arch/csky/kernel/power.c         |  31 ++++
 arch/csky/lib/delay.c            |  40 +++++
 arch/csky/lib/memset.c           |  38 +++++
 arch/csky/lib/usercopy.c         | 271 ++++++++++++++++++++++++++++++
 arch/csky/oprofile/init.c        |  16 ++
 16 files changed, 1442 insertions(+)
 create mode 100644 arch/csky/abiv1/src/bswapdi.c
 create mode 100644 arch/csky/abiv1/src/bswapsi.c
 create mode 100644 arch/csky/abiv1/src/memcpy.S
 create mode 100644 arch/csky/abiv2/src/fpu.c
 create mode 100644 arch/csky/abiv2/src/memcpy.c
 create mode 100644 arch/csky/include/asm/bitops.h
 create mode 100644 arch/csky/include/asm/checksum.h
 create mode 100644 arch/csky/include/asm/string.h
 create mode 100644 arch/csky/kernel/asm-offsets.c
 create mode 100644 arch/csky/kernel/cskyksyms.c
 create mode 100644 arch/csky/kernel/platform.c
 create mode 100644 arch/csky/kernel/power.c
 create mode 100644 arch/csky/lib/delay.c
 create mode 100644 arch/csky/lib/memset.c
 create mode 100644 arch/csky/lib/usercopy.c
 create mode 100644 arch/csky/oprofile/init.c

diff --git a/arch/csky/abiv1/src/bswapdi.c b/arch/csky/abiv1/src/bswapdi.c
new file mode 100644
index 0000000..7346252
--- /dev/null
+++ b/arch/csky/abiv1/src/bswapdi.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/export.h>
+#include <linux/compiler.h>
+
+unsigned long long notrace __bswapdi2(unsigned long long u)
+{
+	return (((u) & 0xff00000000000000ull) >> 56) |
+	       (((u) & 0x00ff000000000000ull) >> 40) |
+	       (((u) & 0x0000ff0000000000ull) >> 24) |
+	       (((u) & 0x000000ff00000000ull) >>  8) |
+	       (((u) & 0x00000000ff000000ull) <<  8) |
+	       (((u) & 0x0000000000ff0000ull) << 24) |
+	       (((u) & 0x000000000000ff00ull) << 40) |
+	       (((u) & 0x00000000000000ffull) << 56);
+}
+
+EXPORT_SYMBOL(__bswapdi2);
diff --git a/arch/csky/abiv1/src/bswapsi.c b/arch/csky/abiv1/src/bswapsi.c
new file mode 100644
index 0000000..21958ca
--- /dev/null
+++ b/arch/csky/abiv1/src/bswapsi.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/export.h>
+#include <linux/compiler.h>
+
+unsigned int notrace __bswapsi2(unsigned int u)
+{
+	return (((u) & 0xff000000) >> 24) |
+	       (((u) & 0x00ff0000) >>  8) |
+	       (((u) & 0x0000ff00) <<  8) |
+	       (((u) & 0x000000ff) << 24);
+}
+
+EXPORT_SYMBOL(__bswapsi2);
+
diff --git a/arch/csky/abiv1/src/memcpy.S b/arch/csky/abiv1/src/memcpy.S
new file mode 100644
index 0000000..f86ad75
--- /dev/null
+++ b/arch/csky/abiv1/src/memcpy.S
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/linkage.h>
+
+.macro	GET_FRONT_BITS rx y
+#ifdef	__cskyLE__
+	lsri	\rx, \y
+#else
+	lsli	\rx, \y
+#endif
+.endm
+
+.macro	GET_AFTER_BITS rx y
+#ifdef	__cskyLE__
+	lsli	\rx, \y
+#else
+	lsri	\rx, \y
+#endif
+.endm
+
+/* void *memcpy(void *dest, const void *src, size_t n); */
+ENTRY(memcpy)
+	mov	r7, r2
+	cmplti	r4, 4                                   /* If len less than 4 bytes */
+	bt	.L_copy_by_byte
+	mov	r6, r2
+	andi	r6, 3
+	cmpnei	r6, 0
+	jbt	.L_dest_not_aligned                     /* If dest is not 4 bytes aligned */
+	mov	r6, r3
+	andi	r6, 3
+	cmpnei	r6, 0
+	jbt	.L_dest_aligned_but_src_not_aligned     /* If dest is aligned, but src is not aligned */
+.L0:
+	cmplti	r4, 16
+	jbt	.L_aligned_and_len_less_16bytes         /* If len less than 16 bytes */
+	subi	sp, 8
+	stw	r8, (sp, 0)
+.L_aligned_and_len_larger_16bytes:                      /* src and dst are all aligned, and len > 16 bytes */
+	ldw	r1, (r3, 0)
+	ldw	r5, (r3, 4)
+	ldw	r8, (r3, 8)
+	stw	r1, (r7, 0)
+	ldw	r1, (r3, 12)
+	stw	r5, (r7, 4)
+	stw	r8, (r7, 8)
+	stw	r1, (r7, 12)
+	subi	r4, 16
+	addi	r3, 16
+	addi	r7, 16
+	cmplti	r4, 16
+	jbf	.L_aligned_and_len_larger_16bytes
+	ldw	r8, (sp, 0)
+	addi	sp, 8
+	cmpnei	r4, 0                    /* If len == 0, return, else goto .L_aligned_and_len_less_16bytes  */
+	jbf	.L_return
+
+.L_aligned_and_len_less_16bytes:
+	cmplti	r4, 4
+	bt	.L_copy_by_byte
+.L1:
+	ldw	r1, (r3, 0)
+	stw	r1, (r7, 0)
+	subi	r4, 4
+	addi	r3, 4
+	addi	r7, 4
+	cmplti	r4, 4
+	jbf	.L1
+	br	.L_copy_by_byte
+
+.L_return:
+	rts
+
+.L_copy_by_byte:                      /* len less than 4 bytes */
+	cmpnei	r4, 0
+	jbf	.L_return
+.L4:
+	ldb	r1, (r3, 0)
+	stb	r1, (r7, 0)
+	addi	r3, 1
+	addi	r7, 1
+	decne	r4
+	jbt	.L4
+	rts
+
+/* If dest is not aligned, just copying some bytes makes the dest align.
+   Afther that, we judge whether the src is aligned. */
+.L_dest_not_aligned:
+	mov	r5, r3
+	rsub	r5, r5, r7
+	abs	r5, r5
+	cmplt	r5, r4
+	bt	.L_copy_by_byte
+	mov	r5, r7
+	sub	r5, r3
+	cmphs	r5, r4
+	bf	.L_copy_by_byte
+	mov	r5, r6
+.L5:
+	ldb	r1, (r3, 0)              /* makes the dest align. */
+	stb	r1, (r7, 0)
+	addi	r5, 1
+	subi	r4, 1
+	addi	r3, 1
+	addi	r7, 1
+	cmpnei	r5, 4
+	jbt	.L5
+	cmplti	r4, 4
+	jbt	.L_copy_by_byte
+	mov	r6, r3                   /* judge whether the src is aligned. */
+	andi	r6, 3
+	cmpnei	r6, 0
+	jbf	.L0
+
+/* Judge the number of misaligned, 1, 2, 3? */
+.L_dest_aligned_but_src_not_aligned:
+	mov	r5, r3
+	rsub	r5, r5, r7
+	abs	r5, r5
+	cmplt	r5, r4
+	bt	.L_copy_by_byte
+	bclri	r3, 0
+	bclri	r3, 1
+	ldw	r1, (r3, 0)
+	addi	r3, 4
+	cmpnei	r6, 2
+	bf	.L_dest_aligned_but_src_not_aligned_2bytes
+	cmpnei	r6, 3
+	bf	.L_dest_aligned_but_src_not_aligned_3bytes
+
+.L_dest_aligned_but_src_not_aligned_1byte:
+	mov	r5, r7
+	sub	r5, r3
+	cmphs	r5, r4
+	bf	.L_copy_by_byte
+	cmplti	r4, 16
+	bf	.L11
+.L10:                                     /* If the len is less than 16 bytes */
+	GET_FRONT_BITS r1 8
+	mov	r5, r1
+	ldw	r6, (r3, 0)
+	mov	r1, r6
+	GET_AFTER_BITS r6 24
+	or	r5, r6
+	stw	r5, (r7, 0)
+	subi	r4, 4
+	addi	r3, 4
+	addi	r7, 4
+	cmplti	r4, 4
+	bf	.L10
+	subi	r3, 3
+	br	.L_copy_by_byte
+.L11:
+	subi	sp, 16
+	stw	r8, (sp, 0)
+	stw	r9, (sp, 4)
+	stw	r10, (sp, 8)
+	stw	r11, (sp, 12)
+.L12:
+	ldw	r5, (r3, 0)
+	ldw	r11, (r3, 4)
+	ldw	r8, (r3, 8)
+	ldw	r9, (r3, 12)
+
+	GET_FRONT_BITS r1 8               /* little or big endian? */
+	mov	r10, r5
+	GET_AFTER_BITS r5 24
+	or	r5, r1
+
+	GET_FRONT_BITS r10 8
+	mov	r1, r11
+	GET_AFTER_BITS r11 24
+	or	r11, r10
+
+	GET_FRONT_BITS r1 8
+	mov	r10, r8
+	GET_AFTER_BITS r8 24
+	or	r8, r1
+
+	GET_FRONT_BITS r10 8
+	mov	r1, r9
+	GET_AFTER_BITS r9 24
+	or	r9, r10
+
+	stw	r5, (r7, 0)
+	stw	r11, (r7, 4)
+	stw	r8, (r7, 8)
+	stw	r9, (r7, 12)
+	subi	r4, 16
+	addi	r3, 16
+	addi	r7, 16
+	cmplti	r4, 16
+	jbf	.L12
+	ldw	r8, (sp, 0)
+	ldw	r9, (sp, 4)
+	ldw	r10, (sp, 8)
+	ldw	r11, (sp, 12)
+	addi	sp , 16
+	cmplti	r4, 4
+	bf	.L10
+	subi	r3, 3
+	br	.L_copy_by_byte
+
+.L_dest_aligned_but_src_not_aligned_2bytes:
+	cmplti	r4, 16
+	bf	.L21
+.L20:
+	GET_FRONT_BITS r1 16
+	mov	r5, r1
+	ldw	r6, (r3, 0)
+	mov	r1, r6
+	GET_AFTER_BITS r6 16
+	or	r5, r6
+	stw	r5, (r7, 0)
+	subi	r4, 4
+	addi	r3, 4
+	addi	r7, 4
+	cmplti	r4, 4
+	bf	.L20
+	subi	r3, 2
+	br	.L_copy_by_byte
+	rts
+
+.L21:	/* n > 16 */
+	subi 	sp, 16
+	stw	r8, (sp, 0)
+	stw	r9, (sp, 4)
+	stw	r10, (sp, 8)
+	stw	r11, (sp, 12)
+
+.L22:
+	ldw	r5, (r3, 0)
+	ldw	r11, (r3, 4)
+	ldw	r8, (r3, 8)
+	ldw	r9, (r3, 12)
+
+	GET_FRONT_BITS r1 16
+	mov	r10, r5
+	GET_AFTER_BITS r5 16
+	or	r5, r1
+
+	GET_FRONT_BITS r10 16
+	mov	r1, r11
+	GET_AFTER_BITS r11 16
+	or	r11, r10
+
+	GET_FRONT_BITS r1 16
+	mov	r10, r8
+	GET_AFTER_BITS r8 16
+	or	r8, r1
+
+	GET_FRONT_BITS r10 16
+	mov	r1, r9
+	GET_AFTER_BITS r9 16
+	or	r9, r10
+
+	stw	r5, (r7, 0)
+	stw	r11, (r7, 4)
+	stw	r8, (r7, 8)
+	stw	r9, (r7, 12)
+	subi	r4, 16
+	addi	r3, 16
+	addi	r7, 16
+	cmplti	r4, 16
+	jbf	.L22
+	ldw	r8, (sp, 0)
+	ldw	r9, (sp, 4)
+	ldw	r10, (sp, 8)
+	ldw	r11, (sp, 12)
+	addi	sp, 16
+	cmplti	r4, 4
+	bf	.L20
+	subi	r3, 2
+	br	.L_copy_by_byte
+
+
+.L_dest_aligned_but_src_not_aligned_3bytes:
+	cmplti	r4, 16
+	bf	.L31
+.L30:
+	GET_FRONT_BITS r1 24
+	mov	r5, r1
+	ldw	r6, (r3, 0)
+	mov	r1, r6
+	GET_AFTER_BITS r6 8
+	or	r5, r6
+	stw	r5, (r7, 0)
+	subi	r4, 4
+	addi	r3, 4
+	addi	r7, 4
+	cmplti	r4, 4
+	bf	.L30
+	subi	r3, 1
+	br	.L_copy_by_byte
+.L31:
+	subi	sp, 16
+	stw	r8, (sp, 0)
+	stw	r9, (sp, 4)
+	stw	r10, (sp, 8)
+	stw	r11, (sp, 12)
+.L32:
+	ldw	r5, (r3, 0)
+	ldw	r11, (r3, 4)
+	ldw	r8, (r3, 8)
+	ldw	r9, (r3, 12)
+
+	GET_FRONT_BITS r1 24
+	mov	r10, r5
+	GET_AFTER_BITS r5 8
+	or	r5, r1
+
+	GET_FRONT_BITS r10 24
+	mov	r1, r11
+	GET_AFTER_BITS r11 8
+	or	r11, r10
+
+	GET_FRONT_BITS r1 24
+	mov	r10, r8
+	GET_AFTER_BITS r8 8
+	or	r8, r1
+
+	GET_FRONT_BITS r10 24
+	mov	r1, r9
+	GET_AFTER_BITS r9 8
+	or	r9, r10
+
+	stw	r5, (r7, 0)
+	stw	r11, (r7, 4)
+	stw	r8, (r7, 8)
+	stw	r9, (r7, 12)
+	subi	r4, 16
+	addi	r3, 16
+	addi	r7, 16
+	cmplti	r4, 16
+	jbf	.L32
+	ldw	r8, (sp, 0)
+	ldw	r9, (sp, 4)
+	ldw	r10, (sp, 8)
+	ldw	r11, (sp, 12)
+	addi	sp, 16
+	cmplti	r4, 4
+	bf	.L30
+	subi	r3, 1
+	br	.L_copy_by_byte
diff --git a/arch/csky/abiv2/src/fpu.c b/arch/csky/abiv2/src/fpu.c
new file mode 100644
index 0000000..2d5d2da
--- /dev/null
+++ b/arch/csky/abiv2/src/fpu.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/ptrace.h>
+#include <linux/uaccess.h>
+
+#if 0 /* FIXME: to support fpu exceptions */
+#define CONFIG_FCR (IDE_STAT | IXE_STAT | UFE_STAT |\
+		    OFE_STAT | DZE_STAT | IOE_STAT)
+#else
+#define CONFIG_FCR 0
+#endif
+
+inline unsigned int
+read_pt_regs(unsigned int rx, struct pt_regs *regs)
+{
+	unsigned int value;
+
+	if(rx < 14)
+		value  = *((int *)regs + rx + 3);
+	else if(rx == 14)
+		if(user_mode(regs))
+			asm volatile("mfcr %0, cr<14, 1>\n":"=r"(value));
+		else
+			value = sizeof(struct pt_regs) + ((unsigned int)regs);
+	else
+		value = *((int *)regs + rx + 2);
+
+	return value;
+}
+
+inline void
+write_pt_regs(unsigned int value, unsigned int rx, struct pt_regs *regs)
+{
+	if(rx < 14)
+		*((int *)regs + rx + 3) = value;
+	else if(rx == 14)
+		if(user_mode(regs))
+			asm volatile("mtcr %0, cr<14, 1>\n"::"r"(value));
+		else
+			printk("math emulate trying to write sp.\n");
+	else
+		*((int *)regs + rx + 2) = value;
+}
+
+void __init init_fpu(void)
+{
+	unsigned long fcr;
+
+	fcr = CONFIG_FCR;
+	asm volatile("mtcr %0, cr<1, 2>\n"::"r"(fcr));
+}
+
+inline unsigned int read_fpcr(void)
+{
+	unsigned int result = 0;
+	asm volatile("mfcr %0, cr<1, 2>\n":"=r"(result));
+	return result;
+}
+
+inline void write_fpcr(unsigned int val)
+{
+	unsigned int result = val | CONFIG_FCR;
+	asm volatile("mtcr %0, cr<1, 2>\n"::"r"(result));
+}
+
+inline unsigned int read_fpesr(void)
+{
+	unsigned int result = 0;
+	asm volatile("mfcr %0, cr<2, 2>\n":"=r"(result));
+	return result;
+}
+
+inline void write_fpesr(unsigned int val)
+{
+	unsigned int result = val;
+	asm volatile("mtcr %0, cr<2, 2>\n"::"r"(result));
+}
+
+/* use as fpc control reg read/write in glibc. */
+int fpu_libc_helper(struct pt_regs * regs)
+{
+	mm_segment_t fs;
+	unsigned long instrptr, regx = 0;
+	unsigned int fault;
+
+	u16 instr_hi, instr_low;
+	unsigned long index_regx = 0, index_fpregx_prev = 0, index_fpregx_next = 0;
+	unsigned long tinstr = 0;
+
+	instrptr = instruction_pointer(regs);
+
+	/* CSKYV2's 32 bit instruction may not align 4 words */
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	fault = __get_user(instr_low, (u16 *)(instrptr & ~1));
+	set_fs(fs);
+	if (fault) {
+		goto bad_or_fault;
+	}
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	fault = __get_user(instr_hi, (u16 *)((instrptr + 2) & ~1));
+	set_fs(fs);
+	if (fault) {
+		goto bad_or_fault;
+	}
+
+	tinstr = instr_hi | ((unsigned long)instr_low << 16);
+
+	index_fpregx_next = ((tinstr >> 21) & 0x1F);
+
+	/* just want to handle instruction which opration cr<1, 2> or cr<2, 2> */
+	if(index_fpregx_next != 2){
+		goto bad_or_fault;
+	}
+
+	/*
+	 * define four macro to distinguish the instruction is mfcr or mtcr.
+	 */
+#define MTCR_MASK 0xFC00FFE0
+#define MFCR_MASK 0xFC00FFE0
+#define MTCR_DISTI 0xC0006420
+#define MFCR_DISTI 0xC0006020
+
+	if ((tinstr & MTCR_MASK) == MTCR_DISTI)
+	{
+		index_regx = (tinstr >> 16) & 0x1F;
+		index_fpregx_prev = tinstr & 0x1F;
+
+		regx = read_pt_regs(index_regx, regs);
+
+		if(index_fpregx_prev == 1) {
+			write_fpcr(regx);
+		} else if (index_fpregx_prev == 2) {
+			write_fpesr(regx);
+		} else {
+			goto bad_or_fault;
+		}
+
+		regs->pc +=4;
+		return 1;
+	} else if ((tinstr & MFCR_MASK) == MFCR_DISTI) {
+		index_regx = tinstr & 0x1F;
+		index_fpregx_prev = ((tinstr >> 16) & 0x1F);
+
+		if (index_fpregx_prev == 1) {
+			regx = read_fpcr();
+		} else if (index_fpregx_prev == 2) {
+			regx = read_fpesr();
+		} else {
+			goto bad_or_fault;
+		}
+
+		write_pt_regs(regx, index_regx, regs);
+
+		regs->pc +=4;
+		return 1;
+	}
+
+bad_or_fault:
+	return 0;
+}
+
+void fpu_fpe(struct pt_regs * regs)
+{
+	int sig;
+	unsigned int fesr;
+	siginfo_t info;
+	asm volatile("mfcr %0, cr<2, 2>":"=r"(fesr));
+
+	if(fesr & FPE_ILLE){
+		info.si_code = ILL_ILLOPC;
+		sig = SIGILL;
+	}
+	else if(fesr & FPE_IDC){
+		info.si_code = ILL_ILLOPN;
+		sig = SIGILL;
+	}
+	else if(fesr & FPE_FEC){
+		sig = SIGFPE;
+		if(fesr & FPE_IOC){
+			info.si_code = FPE_FLTINV;
+		}
+		else if(fesr & FPE_DZC){
+			info.si_code = FPE_FLTDIV;
+		}
+		else if(fesr & FPE_UFC){
+			info.si_code = FPE_FLTUND;
+		}
+		else if(fesr & FPE_OFC){
+			info.si_code = FPE_FLTOVF;
+		}
+		else if(fesr & FPE_IXC){
+			info.si_code = FPE_FLTRES;
+		}
+		else {
+			info.si_code = NSIGFPE;
+		}
+	}
+	else {
+		info.si_code = NSIGFPE;
+		sig = SIGFPE;
+	}
+	info.si_signo = SIGFPE;
+	info.si_errno = 0;
+	info.si_addr = (void *)regs->pc;
+	force_sig_info(sig, &info, current);
+}
+
+typedef struct fpregset {
+	int f_fcr;
+	int f_fsr;		/* Nothing in CPU_CSKYV2 */
+	int f_fesr;
+	int f_feinst1;		/* Nothing in CPU_CSKYV2 */
+	int f_feinst2;		/* Nothing in CPU_CSKYV2 */
+	int f_fpregs[32];
+} fpregset_t;
+
+int save_fpu_state(struct sigcontext *sc, struct pt_regs *regs)
+{
+	int err = 0;
+	fpregset_t fpregs;
+	unsigned long flg;
+	unsigned long tmp1, tmp2, tmp3, tmp4;
+	int * fpgr;
+
+	local_irq_save(flg);
+	fpgr = &(fpregs.f_fpregs[0]);
+	asm volatile(
+		"mfcr    %0, cr<1, 2>\n"
+		"mfcr    %1, cr<2, 2>\n"
+		:"=r"(fpregs.f_fcr),"=r"(fpregs.f_fesr));
+
+	asm volatile(
+		FMFVR_FPU_REGS(vr0, vr1)
+		STW_FPU_REGS(0, 4, 8, 12)
+		FMFVR_FPU_REGS(vr2, vr3)
+		STW_FPU_REGS(16, 20, 24, 28)
+		FMFVR_FPU_REGS(vr4, vr5)
+		STW_FPU_REGS(32, 36, 40, 44)
+		FMFVR_FPU_REGS(vr6, vr7)
+		STW_FPU_REGS(48, 52, 56, 60)
+		"addi    %4, 32\n"
+		"addi    %4, 32\n"
+		FMFVR_FPU_REGS(vr8, vr9)
+		STW_FPU_REGS(0, 4, 8, 12)
+		FMFVR_FPU_REGS(vr10, vr11)
+		STW_FPU_REGS(16, 20, 24, 28)
+		FMFVR_FPU_REGS(vr12, vr13)
+		STW_FPU_REGS(32, 36, 40, 44)
+		FMFVR_FPU_REGS(vr14, vr15)
+		STW_FPU_REGS(48, 52, 56, 60)
+		:"=a"(tmp1),"=a"(tmp2),"=a"(tmp3),
+		"=a"(tmp4),"+a"(fpgr));
+	local_irq_restore(flg);
+
+	err |= copy_to_user(&sc->sc_fcr, &fpregs, sizeof(fpregs));
+	return err;
+}
+
+int restore_fpu_state(struct sigcontext *sc)
+{
+	int err = 0;
+	fpregset_t fpregs;
+	unsigned long flg;
+	unsigned long tmp1, tmp2, tmp3, tmp4;
+	unsigned long fctl0, fctl1, fctl2;
+	int * fpgr;
+
+	if (__copy_from_user(&fpregs, &sc->sc_fcr, sizeof(fpregs)))
+	{
+		err = 1;
+		goto out;
+	}
+
+	local_irq_save(flg);
+	fctl0 = fpregs.f_fcr;
+	fctl1 = fpregs.f_fsr;
+	fctl2 = fpregs.f_fesr;
+	fpgr = &(fpregs.f_fpregs[0]);
+	asm volatile(
+		"mtcr   %0, cr<1, 2>\n"
+		"mtcr   %1, cr<2, 2>\n"
+		::"r"(fctl0), "r"(fctl2));
+
+	asm volatile(
+		LDW_FPU_REGS(0, 4, 8, 12)
+		FMTVR_FPU_REGS(vr0, vr1)
+		LDW_FPU_REGS(16, 20, 24, 28)
+		FMTVR_FPU_REGS(vr2, vr3)
+		LDW_FPU_REGS(32, 36, 40, 44)
+		FMTVR_FPU_REGS(vr4, vr5)
+		LDW_FPU_REGS(48, 52, 56, 60)
+		FMTVR_FPU_REGS(vr6, vr7)
+		"addi   %4, 32\n"
+		"addi   %4, 32\n"
+		LDW_FPU_REGS(0, 4, 8, 12)
+		FMTVR_FPU_REGS(vr8, vr9)
+		LDW_FPU_REGS(16, 20, 24, 28)
+		FMTVR_FPU_REGS(vr10, vr11)
+		LDW_FPU_REGS(32, 36, 40, 44)
+		FMTVR_FPU_REGS(vr12, vr13)
+		LDW_FPU_REGS(48, 52, 56, 60)
+		FMTVR_FPU_REGS(vr14, vr15)
+		:"=a"(tmp1),"=a"(tmp2),"=a"(tmp3),
+		"=a"(tmp4),"+a"(fpgr));
+	local_irq_restore(flg);
+out:
+	return err;
+}
+
diff --git a/arch/csky/abiv2/src/memcpy.c b/arch/csky/abiv2/src/memcpy.c
new file mode 100644
index 0000000..67d8d01
--- /dev/null
+++ b/arch/csky/abiv2/src/memcpy.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/types.h>
+
+/*
+ * memory copy function.
+ */
+void *memcpy (void *to, const void *from, size_t l)
+{
+	char *d = to;
+	const char *s = from;
+
+	if (((long)d | (long)s) & 0x3)
+	{
+		while (l--) *d++ = *s++;
+	}
+	else
+	{
+        	while (l >= 16)
+		{
+			*(((long *)d)) = *(((long *)s));
+			*(((long *)d)+1) = *(((long *)s)+1);
+			*(((long *)d)+2) = *(((long *)s)+2);
+			*(((long *)d)+3) = *(((long *)s)+3);
+			l -= 16;
+			d += 16;
+			s += 16;
+		}
+		while (l > 3)
+		{
+			*(((long *)d)) = *(((long *)s));
+			d = d +4;
+			s = s +4;
+			l -= 4;
+		}
+		while (l)
+		{
+			*d++ = *s++;
+			l--;	
+		}
+	}
+	return to;
+}
diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
new file mode 100644
index 0000000..0688786
--- /dev/null
+++ b/arch/csky/include/asm/bitops.h
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_BITOPS_H
+#define __ASM_CSKY_BITOPS_H
+
+#include <linux/irqflags.h>
+#include <linux/compiler.h>
+#include <asm/barrier.h>
+
+/*
+ * asm-generic/bitops/ffs.h
+ */
+static inline int ffs(int x)
+{
+	if(!x) return 0;
+
+	asm volatile (
+		"brev %0\n"
+		"ff1  %0\n"
+		"addi %0, 1\n"
+		:"=r"(x)
+		:"0"(x));
+	return x;
+}
+
+/*
+ * asm-generic/bitops/__ffs.h
+ */
+static __always_inline unsigned long __ffs(unsigned long x)
+{
+	asm volatile (
+		"brev %0\n"
+		"ff1  %0\n"
+		:"=r"(x)
+		:"0"(x));
+	return x;
+}
+
+/*
+ * asm-generic/bitops/fls.h
+ */
+static __always_inline int fls(int x)
+{
+	asm volatile(
+		"ff1 %0\n"
+		:"=r"(x)
+		:"0"(x));
+
+	return (32 - x);
+}
+
+/*
+ * asm-generic/bitops/__fls.h
+ */
+static __always_inline unsigned long __fls(unsigned long x)
+{
+	return fls(x) - 1;
+}
+
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/find.h>
+
+#ifndef _LINUX_BITOPS_H
+#error only <linux/bitops.h> can be included directly
+#endif
+
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
+
+#include <asm-generic/bitops/atomic.h>
+
+/*
+ * bug fix, why only could use atomic!!!!
+ */
+#include <asm-generic/bitops/non-atomic.h>
+#define __clear_bit(nr,vaddr) clear_bit(nr,vaddr)
+
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+#endif /* __ASM_CSKY_BITOPS_H */
+
diff --git a/arch/csky/include/asm/checksum.h b/arch/csky/include/asm/checksum.h
new file mode 100644
index 0000000..3f7d255
--- /dev/null
+++ b/arch/csky/include/asm/checksum.h
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_CHECKSUM_H
+#define __ASM_CSKY_CHECKSUM_H
+
+#include <linux/in6.h>
+#include <asm/byteorder.h>
+
+static inline __sum16 csum_fold(__wsum csum)
+{
+	u32 tmp;
+	asm volatile(
+		"mov	%1, %0\n"
+		"rori	%0, 16\n"
+		"addu	%0, %1\n"
+		"lsri	%0, 16\n"
+		:"=r"(csum), "=r"(tmp)
+		:"0"(csum));
+	return (__force __sum16)~csum;
+}
+#define csum_fold csum_fold
+
+static inline __wsum
+csum_tcpudp_nofold(
+	__be32 saddr,
+	__be32 daddr,
+	unsigned short len,
+	unsigned short proto,
+	__wsum sum
+	)
+{
+	asm volatile(
+		"clrc\n"
+		"addc    %0, %1\n"
+		"addc    %0, %2\n"
+		"addc    %0, %3\n"
+		"inct    %0\n"
+		:"=r"(sum)
+		:"r"((__force u32)saddr),
+		"r"((__force u32)daddr),
+#ifdef __BIG_ENDIAN
+		"r"(proto + len),
+#else
+		"r"((proto + len) << 8),
+#endif
+		"0" ((__force unsigned long)sum)
+		:"cc");
+	return sum;
+}
+#define csum_tcpudp_nofold csum_tcpudp_nofold
+
+static __inline__ __sum16
+csum_ipv6_magic(
+	const struct in6_addr *saddr,
+	const struct in6_addr *daddr,
+	__u32 len,
+	unsigned short proto,
+	__wsum sum
+	)
+{
+	sum += saddr->in6_u.u6_addr32[0];
+	sum += saddr->in6_u.u6_addr32[1];
+	sum += saddr->in6_u.u6_addr32[2];
+	sum += saddr->in6_u.u6_addr32[3];
+	sum += daddr->in6_u.u6_addr32[0];
+	sum += daddr->in6_u.u6_addr32[1];
+	sum += daddr->in6_u.u6_addr32[2];
+	sum += daddr->in6_u.u6_addr32[3];
+	sum += (len + proto);
+
+	return csum_fold(sum);
+}
+#define _HAVE_ARCH_IPV6_CSUM
+
+#include <asm-generic/checksum.h>
+
+#endif /* __ASM_CSKY_CHECKSUM_H */
diff --git a/arch/csky/include/asm/string.h b/arch/csky/include/asm/string.h
new file mode 100644
index 0000000..2c4878b
--- /dev/null
+++ b/arch/csky/include/asm/string.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef _CSKY_STRING_MM_H_
+#define _CSKY_STRING_MM_H_
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+#define __HAVE_ARCH_MEMCPY
+extern void * memcpy(void *to, const void *from, size_t l);
+
+/* New and improved.  In arch/csky/lib/memset.c */
+#define __HAVE_ARCH_MEMSET
+extern void * memset(void *dest, int c, size_t l);
+
+#endif
+
+#endif /* _CSKY_STRING_MM_H_ */
diff --git a/arch/csky/kernel/asm-offsets.c b/arch/csky/kernel/asm-offsets.c
new file mode 100644
index 0000000..767fa9c
--- /dev/null
+++ b/arch/csky/kernel/asm-offsets.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/sched.h>
+#include <linux/kernel_stat.h>
+#include <linux/kbuild.h>
+#include <abi/regdef.h>
+
+int main(void)
+{
+	/* offsets into the task struct */
+	DEFINE(TASK_STATE,        offsetof(struct task_struct, state));
+	DEFINE(TASK_THREAD_INFO,  offsetof(struct task_struct, stack));
+	DEFINE(TASK_FLAGS,        offsetof(struct task_struct, flags));
+	DEFINE(TASK_PTRACE,       offsetof(struct task_struct, ptrace));
+	DEFINE(TASK_THREAD,       offsetof(struct task_struct, thread));
+	DEFINE(TASK_MM,           offsetof(struct task_struct, mm));
+	DEFINE(TASK_ACTIVE_MM,    offsetof(struct task_struct, active_mm));
+
+	/* offsets into the thread struct */
+	DEFINE(THREAD_KSP,        offsetof(struct thread_struct, ksp));
+	DEFINE(THREAD_USP,        offsetof(struct thread_struct, usp));
+	DEFINE(THREAD_SR,         offsetof(struct thread_struct, sr));
+	DEFINE(THREAD_ESP0,       offsetof(struct thread_struct, esp0));
+	DEFINE(THREAD_FESR,       offsetof(struct thread_struct, fesr));
+	DEFINE(THREAD_FSR,        offsetof(struct thread_struct, fsr));
+	DEFINE(THREAD_FCR,        offsetof(struct thread_struct, fcr));
+	DEFINE(THREAD_FPREG,      offsetof(struct thread_struct, fp));
+	DEFINE(THREAD_DSPHI,      offsetof(struct thread_struct, hi));
+	DEFINE(THREAD_DSPLO,      offsetof(struct thread_struct, lo));
+
+	/* offsets into the thread_info struct */
+	DEFINE(TINFO_FLAGS,       offsetof(struct thread_info, flags));
+	DEFINE(TINFO_PREEMPT,     offsetof(struct thread_info, preempt_count));
+	DEFINE(TINFO_ADDR_LIMIT,  offsetof(struct thread_info, addr_limit));
+	DEFINE(TINFO_TP_VALUE,   offsetof(struct thread_info, tp_value));
+	DEFINE(TINFO_TASK,        offsetof(struct thread_info, task));
+
+	/* offsets into the pt_regs */
+	DEFINE(PT_PC,             offsetof(struct pt_regs, pc));
+	DEFINE(PT_ORIG_AO,        offsetof(struct pt_regs, orig_a0));
+	DEFINE(PT_SR,             offsetof(struct pt_regs, sr));
+
+	DEFINE(PT_A0,             offsetof(struct pt_regs, a0));
+	DEFINE(PT_A1,             offsetof(struct pt_regs, a1));
+	DEFINE(PT_A2,             offsetof(struct pt_regs, a2));
+	DEFINE(PT_A3,             offsetof(struct pt_regs, a3));
+	DEFINE(PT_REGS0,          offsetof(struct pt_regs, regs[0]));
+	DEFINE(PT_REGS1,          offsetof(struct pt_regs, regs[1]));
+	DEFINE(PT_REGS2,          offsetof(struct pt_regs, regs[2]));
+	DEFINE(PT_REGS3,          offsetof(struct pt_regs, regs[3]));
+	DEFINE(PT_REGS4,          offsetof(struct pt_regs, regs[4]));
+	DEFINE(PT_REGS5,          offsetof(struct pt_regs, regs[5]));
+	DEFINE(PT_REGS6,          offsetof(struct pt_regs, regs[6]));
+	DEFINE(PT_REGS7,          offsetof(struct pt_regs, regs[7]));
+	DEFINE(PT_REGS8,          offsetof(struct pt_regs, regs[8]));
+	DEFINE(PT_REGS9,          offsetof(struct pt_regs, regs[9]));
+	DEFINE(PT_R15,            offsetof(struct pt_regs, r15));
+#if defined(__CSKYABIV2__)
+	DEFINE(PT_R16,            offsetof(struct pt_regs, exregs[0]));
+	DEFINE(PT_R17,            offsetof(struct pt_regs, exregs[1]));
+	DEFINE(PT_R18,            offsetof(struct pt_regs, exregs[2]));
+	DEFINE(PT_R19,            offsetof(struct pt_regs, exregs[3]));
+	DEFINE(PT_R20,            offsetof(struct pt_regs, exregs[4]));
+	DEFINE(PT_R21,            offsetof(struct pt_regs, exregs[5]));
+	DEFINE(PT_R22,            offsetof(struct pt_regs, exregs[6]));
+	DEFINE(PT_R23,            offsetof(struct pt_regs, exregs[7]));
+	DEFINE(PT_R24,            offsetof(struct pt_regs, exregs[8]));
+	DEFINE(PT_R25,            offsetof(struct pt_regs, exregs[9]));
+	DEFINE(PT_R26,            offsetof(struct pt_regs, exregs[10]));
+	DEFINE(PT_R27,            offsetof(struct pt_regs, exregs[11]));
+	DEFINE(PT_R28,            offsetof(struct pt_regs, exregs[12]));
+	DEFINE(PT_R29,            offsetof(struct pt_regs, exregs[13]));
+	DEFINE(PT_R30,            offsetof(struct pt_regs, exregs[14]));
+	DEFINE(PT_R31,            offsetof(struct pt_regs, exregs[15]));
+	DEFINE(PT_RHI,            offsetof(struct pt_regs, rhi));
+	DEFINE(PT_RLO,            offsetof(struct pt_regs, rlo));
+#endif
+	/* offsets into the irq_cpustat_t struct */
+	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t, __softirq_pending));
+
+	/* signal defines */
+	DEFINE(SIGSEGV, SIGSEGV);
+	DEFINE(SIGTRAP, SIGTRAP);
+
+	return 0;
+}
diff --git a/arch/csky/kernel/cskyksyms.c b/arch/csky/kernel/cskyksyms.c
new file mode 100644
index 0000000..3f13594
--- /dev/null
+++ b/arch/csky/kernel/cskyksyms.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <asm/cacheflush.h>
+
+/*
+ * Defined in libgcc
+ *
+ * See arch/csky/Makefile:
+ *	-print-libgcc-file-name
+ */
+extern void __ashldi3 (void);
+extern void __ashrdi3 (void);
+extern void __lshrdi3 (void);
+extern void __muldi3 (void);
+extern void __ucmpdi2 (void);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__ucmpdi2);
+
+/*
+ * Defined in abiv1/src/memcpy.S
+ * and abiv2/src/memcpy.c
+ */
+EXPORT_SYMBOL(memcpy);
+
+/* Defined in lib/memset.c */
+EXPORT_SYMBOL(memset);
diff --git a/arch/csky/kernel/platform.c b/arch/csky/kernel/platform.c
new file mode 100644
index 0000000..f51654f
--- /dev/null
+++ b/arch/csky/kernel/platform.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/io.h>
+
+static int __init csky_platform_init(void)
+{
+	return of_platform_default_populate(NULL, NULL, NULL);
+}
+device_initcall(csky_platform_init);
+
+
diff --git a/arch/csky/kernel/power.c b/arch/csky/kernel/power.c
new file mode 100644
index 0000000..d35e882
--- /dev/null
+++ b/arch/csky/kernel/power.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/reboot.h>
+
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
+void machine_power_off(void)
+{
+	local_irq_disable();
+	if (pm_power_off)
+		pm_power_off();
+	asm volatile ("bkpt");
+}
+
+void machine_halt(void)
+{
+	local_irq_disable();
+	if (pm_power_off)
+		pm_power_off();
+	asm volatile ("bkpt");
+}
+
+void machine_restart(char *cmd)
+{
+	local_irq_disable();
+	do_kernel_restart(cmd);
+	asm volatile ("bkpt");
+}
+
+
diff --git a/arch/csky/lib/delay.c b/arch/csky/lib/delay.c
new file mode 100644
index 0000000..34766a4
--- /dev/null
+++ b/arch/csky/lib/delay.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+void __delay(unsigned long loops)
+{
+       asm volatile (
+		"mov r0, r0\n"
+		"1:declt %0\n"
+		"bf	1b"
+                :"=r"(loops)
+	        :"0"(loops));
+}
+EXPORT_SYMBOL(__delay);
+
+extern unsigned long loops_per_jiffy;
+
+void __const_udelay(unsigned long xloops)
+{
+	unsigned long long loops;
+
+	loops = (unsigned long long)xloops * loops_per_jiffy * HZ;
+
+	__delay(loops >> 32);
+}
+EXPORT_SYMBOL(__const_udelay);
+
+void __udelay(unsigned long usecs)
+{
+	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+}
+EXPORT_SYMBOL(__udelay);
+
+void __ndelay(unsigned long nsecs)
+{
+	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+}
+EXPORT_SYMBOL(__ndelay);
diff --git a/arch/csky/lib/memset.c b/arch/csky/lib/memset.c
new file mode 100644
index 0000000..b7897af
--- /dev/null
+++ b/arch/csky/lib/memset.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/types.h>
+
+void *memset(void *dest, int c, size_t l)
+{
+	char *d = dest;
+	int ch = c;
+	int tmp;
+
+	if ((long)d & 0x3)
+		while (l--) *d++ = ch;
+	else {
+		ch &= 0xff;
+		tmp = (ch | ch << 8 | ch << 16 | ch << 24);
+
+		while (l >= 16) {
+			*(((long *)d)) = tmp;
+			*(((long *)d)+1) = tmp;
+			*(((long *)d)+2) = tmp;
+			*(((long *)d)+3) = tmp;
+			l -= 16;
+			d += 16;
+		}
+
+		while (l > 3) {
+			*(((long *)d)) = tmp;
+			d = d + 4;
+			l -= 4;
+		}
+
+		while (l) {
+			*d++ = ch;
+			l--;
+		}
+	}
+	return dest;
+}
diff --git a/arch/csky/lib/usercopy.c b/arch/csky/lib/usercopy.c
new file mode 100644
index 0000000..ace4190
--- /dev/null
+++ b/arch/csky/lib/usercopy.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/uaccess.h>
+#include <linux/types.h>
+
+unsigned long
+raw_copy_from_user(
+		void *to,
+		const void *from,
+		unsigned long n)
+{
+	if (access_ok(VERIFY_READ, from, n))
+		__copy_user_zeroing(to,from,n); 
+	else
+		memset(to,0, n);
+	return n;
+}
+EXPORT_SYMBOL(raw_copy_from_user);
+
+unsigned long
+raw_copy_to_user(
+		void *to,
+		const void *from,
+		unsigned long n)
+{
+	if (access_ok(VERIFY_WRITE, to, n))
+		__copy_user(to,from,n);
+	return n;
+}
+EXPORT_SYMBOL(raw_copy_to_user);
+
+
+/*
+ * copy a null terminated string from userspace.	
+ */
+#define __do_strncpy_from_user(dst,src,count,res)       \
+do{                                                     \
+        int tmp;                                        \
+        long faultres;                                  \
+        asm volatile(                           \
+        "       cmpnei  %3, 0           \n"             \
+        "       bf      4f              \n"             \
+        "1:     cmpnei  %1, 0          	\n"             \
+        "       bf      5f              \n"             \
+        "2:     ldb     %4, (%3, 0)     \n"             \
+        "       stb     %4, (%2, 0)     \n"             \
+        "       cmpnei  %4, 0           \n"             \
+        "       bf      3f              \n"             \
+        "       addi    %3,  1          \n"             \
+        "       addi    %2,  1          \n"             \
+        "       subi    %1,  1          \n"             \
+        "       br      1b              \n"             \
+        "3:     subu	%0, %1          \n"             \
+        "       br      5f              \n"             \
+        "4:     mov     %0, %5          \n"             \
+        "       br      5f              \n"             \
+        ".section __ex_table, \"a\"     \n"             \
+        ".align   2                     \n"             \
+        ".long    2b, 4b                \n"             \
+        ".previous                      \n"             \
+        "5:                             \n"             \
+          :"=r"(res),"=r"(count),"=r"(dst),"=r"(src), "=r"(tmp),"=r"(faultres) \
+          : "5"(-EFAULT),"0"(count), "1"(count), "2"(dst),"3"(src)     	       \
+          : "memory" );	                                \
+} while(0)		
+
+/*
+ * __strncpy_from_user: - Copy a NUL terminated string from userspace, with less checking.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @src:   Source address, in user space.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ * 
+ * Copies a NUL-terminated string from userspace to kernel space.
+ * Caller must check the specified block with access_ok() before calling
+ * this function.
+ *
+ * On success, returns the length of the string (not including the trailing
+ * NUL).
+ *
+ * If access to userspace fails, returns -EFAULT (some data may have been
+ * copied).
+ *
+ * If @count is smaller than the length of the string, copies @count bytes
+ * and returns @count.
+ */
+long
+__strncpy_from_user(
+	char *dst,
+	const char *src,
+	long count)
+{
+	long res;
+	__do_strncpy_from_user(dst, src, count, res);
+	return res;
+}
+EXPORT_SYMBOL(__strncpy_from_user);
+
+/*
+ * strncpy_from_user: - Copy a NUL terminated string from userspace.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @src:   Source address, in user space.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ * 
+ * Copies a NUL-terminated string from userspace to kernel space.
+ *
+ * On success, returns the length of the string (not including the trailing
+ * NUL).
+ *
+ * If access to userspace fails, returns -EFAULT (some data may have been
+ * copied).
+ *
+ * If @count is smaller than the length of the string, copies @count bytes
+ * and returns @count.
+ */
+long
+strncpy_from_user(
+	char *dst,
+	const char *src,
+	long count)
+{
+	long res = -EFAULT;
+	if (access_ok(VERIFY_READ, src, 1))
+		__do_strncpy_from_user(dst, src, count, res);
+	return res;
+}
+EXPORT_SYMBOL(strncpy_from_user);
+
+/*
+ * strlen_user: - Get the size of a string in user space.
+ * @str: The string to measure.
+ * @n:   The maximum valid length
+ *
+ * Get the size of a NUL-terminated string in user space.
+ *
+ * Returns the size of the string INCLUDING the terminating NUL.
+ * On exception, returns 0.
+ * If the string is too long, returns a value greater than @n.
+ */
+long strnlen_user(const char *s, long n)
+{
+
+	unsigned long res,tmp;
+	if(s){
+	asm volatile(
+        "       cmpnei  %1, 0           \n"
+        "       bf      3f              \n"
+        "1:     cmpnei  %0, 0           \n"              
+        "       bf      3f              \n"
+        "2:     ldb     %3, (%1, 0)     \n"             
+        "       cmpnei  %3, 0           \n"             
+        "       bf      3f              \n"             
+        "       subi    %0,  1          \n"             
+        "       addi    %1,  1          \n"             
+        "       br      1b              \n"
+        "3:     subu    %2, %0          \n"
+        "       addi    %2,  1          \n"             
+        "       br      5f              \n"             
+        "4:     movi    %0, 0           \n"             
+        "       br      5f              \n"             
+        ".section __ex_table, \"a\"     \n"             
+        ".align   2                     \n"
+        ".long    2b, 4b                \n"             
+        ".previous                      \n"             
+        "5:                             \n"             
+        :"=r"(n),"=r"(s), "=r"(res), "=r"(tmp)   
+        : "0"(n), "1"(s), "2"(n)      
+        : "cc" );
+		return res;     
+	}
+	return 0;     
+}
+EXPORT_SYMBOL(strnlen_user);
+
+#define __do_clear_user(addr, size)                             \
+do {                                                            \
+	int __d0;                                               \
+	int zvalue;                                             \
+	int tmp;                                                \
+	asm volatile(						\
+		"0:     cmpnei  %1, 0           \n"             \
+		"       bf      7f              \n"             \
+		"       mov     %3, %1          \n"             \
+		"       andi    %3, 3           \n"             \
+		"       cmpnei  %3, 0           \n"             \
+		"       bf      1f              \n"             \
+		"       br      5f              \n"             \
+		"1:     cmplti  %0, 32          \n"   /* 4W */  \
+		"       bt      3f              \n"             \
+		"8:     stw     %2, (%1, 0)     \n"             \
+		"10:    stw     %2, (%1, 4)     \n"             \
+		"11:    stw     %2, (%1, 8)     \n"             \
+		"12:    stw     %2, (%1, 12)    \n"             \
+		"13:    stw     %2, (%1, 16)    \n"             \
+		"14:    stw     %2, (%1, 20)    \n"             \
+		"15:    stw     %2, (%1, 24)    \n"             \
+		"16:    stw     %2, (%1, 28)    \n"             \
+		"       addi    %1, 32          \n"             \
+		"       subi    %0, 32          \n"             \
+		"       br      1b              \n"             \
+		"3:     cmplti  %0, 4           \n"  /* 1W */   \
+		"       bt      5f              \n"             \
+		"4:     stw     %2, (%1, 0)     \n"             \
+		"       addi    %1, 4           \n"             \
+		"       subi    %0, 4           \n"             \
+		"       br      3b              \n"             \
+		"5:     cmpnei  %0, 0           \n"  /* 1B */   \
+		"9:     bf      7f              \n"             \
+		"6:     stb     %2, (%1, 0)     \n"             \
+		"       addi    %1,  1          \n"             \
+		"       subi    %0,  1          \n"             \
+		"       br      5b              \n"             \
+		".section __ex_table,\"a\"      \n"             \
+		".align   2                     \n"             \
+		".long    8b, 9b                \n"             \
+		".long    10b, 9b               \n"             \
+		".long    11b, 9b               \n"             \
+		".long    12b, 9b               \n"             \
+		".long    13b, 9b               \n"             \
+		".long    14b, 9b               \n"             \
+		".long    15b, 9b               \n"             \
+		".long    16b, 9b               \n"             \
+		".long    4b, 9b                \n"             \
+		".long    6b, 9b                \n"             \
+		".previous                      \n"             \
+		"7:                             \n"             \
+		: "=r"(size), "=r" (__d0), "=r"(zvalue), "=r"(tmp) \
+		: "0"(size), "1"(addr), "2"(0)                  \
+		: "memory"                                      \
+	);                                                      \
+} while (0)
+
+/*
+ * clear_user: - Zero a block of memory in user space.
+ * @to:   Destination address, in user space.
+ * @n:    Number of bytes to zero.
+ *
+ * Zero a block of memory in user space.
+ *
+ * Returns number of bytes that could not be cleared.
+ * On success, this will be zero.
+ */	
+unsigned long 
+clear_user(void __user *to, unsigned long n)
+{
+	if (access_ok(VERIFY_WRITE, to, n))
+		__do_clear_user(to, n);
+	return n;
+}
+EXPORT_SYMBOL(clear_user);
+
+/*
+ * __clear_user: - Zero a block of memory in user space, with less checking.
+ * @to:   Destination address, in user space.
+ * @n:    Number of bytes to zero.
+ *
+ * Zero a block of memory in user space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be cleared.
+ * On success, this will be zero.
+ */
+unsigned long
+__clear_user(void __user *to, unsigned long n)
+{
+	__do_clear_user(to, n);
+	return n;
+}
+EXPORT_SYMBOL(__clear_user);
+
diff --git a/arch/csky/oprofile/init.c b/arch/csky/oprofile/init.c
new file mode 100644
index 0000000..413ad18
--- /dev/null
+++ b/arch/csky/oprofile/init.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/kernel.h>
+#include <linux/oprofile.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+
+int __init oprofile_arch_init(struct oprofile_operations *ops)
+{
+	return oprofile_perf_init(ops);
+}
+
+void oprofile_arch_exit(void)
+{
+	oprofile_perf_exit();
+}
-- 
2.7.4
