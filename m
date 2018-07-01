From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 13/19] csky: Library functions
Date: Mon,  2 Jul 2018 01:30:16 +0800
Message-ID: <7a1490b307d8e62cebe80ebc03fea6bad8b0f227.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/bswapdi.c      |  18 +++
 arch/csky/abiv1/bswapsi.c      |  15 ++
 arch/csky/abiv1/memcpy.S       | 344 +++++++++++++++++++++++++++++++++++++++++
 arch/csky/abiv2/memcpy.c       |  43 ++++++
 arch/csky/include/asm/string.h |  19 +++
 arch/csky/kernel/asm-offsets.c |  85 ++++++++++
 arch/csky/kernel/cskyksyms.c   |  31 ++++
 arch/csky/kernel/platform.c    |  18 +++
 arch/csky/kernel/power.c       |  31 ++++
 arch/csky/lib/delay.c          |  40 +++++
 arch/csky/lib/memset.c         |  38 +++++
 11 files changed, 682 insertions(+)
 create mode 100644 arch/csky/abiv1/bswapdi.c
 create mode 100644 arch/csky/abiv1/bswapsi.c
 create mode 100644 arch/csky/abiv1/memcpy.S
 create mode 100644 arch/csky/abiv2/memcpy.c
 create mode 100644 arch/csky/include/asm/string.h
 create mode 100644 arch/csky/kernel/asm-offsets.c
 create mode 100644 arch/csky/kernel/cskyksyms.c
 create mode 100644 arch/csky/kernel/platform.c
 create mode 100644 arch/csky/kernel/power.c
 create mode 100644 arch/csky/lib/delay.c
 create mode 100644 arch/csky/lib/memset.c

diff --git a/arch/csky/abiv1/bswapdi.c b/arch/csky/abiv1/bswapdi.c
new file mode 100644
index 0000000..7346252
--- /dev/null
+++ b/arch/csky/abiv1/bswapdi.c
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
diff --git a/arch/csky/abiv1/bswapsi.c b/arch/csky/abiv1/bswapsi.c
new file mode 100644
index 0000000..21958ca
--- /dev/null
+++ b/arch/csky/abiv1/bswapsi.c
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
diff --git a/arch/csky/abiv1/memcpy.S b/arch/csky/abiv1/memcpy.S
new file mode 100644
index 0000000..f86ad75
--- /dev/null
+++ b/arch/csky/abiv1/memcpy.S
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
diff --git a/arch/csky/abiv2/memcpy.c b/arch/csky/abiv2/memcpy.c
new file mode 100644
index 0000000..67d8d01
--- /dev/null
+++ b/arch/csky/abiv2/memcpy.c
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
index 0000000..d7868dd
--- /dev/null
+++ b/arch/csky/kernel/asm-offsets.c
@@ -0,0 +1,85 @@
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
+	DEFINE(THREAD_SR,         offsetof(struct thread_struct, sr));
+	DEFINE(THREAD_ESP0,       offsetof(struct thread_struct, esp0));
+	DEFINE(THREAD_FESR,       offsetof(struct thread_struct, user_fp.fesr));
+	DEFINE(THREAD_FCR,        offsetof(struct thread_struct, user_fp.fcr));
+	DEFINE(THREAD_FPREG,      offsetof(struct thread_struct, user_fp.vr));
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
+	DEFINE(PT_R15,            offsetof(struct pt_regs, lr));
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
+	DEFINE(PT_USP,            offsetof(struct pt_regs, usp));
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
-- 
2.7.4
