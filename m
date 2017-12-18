From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v4 19/36] nds32: Library functions
Date: Mon, 18 Dec 2017 14:46:31 +0800
Message-ID: <a66bb2e78daf9971295aeb6a2c31e60d40e74c4a.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch add support for various library functions.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/string.h  |   17 +++
 arch/nds32/include/asm/swab.h    |   35 +++++
 arch/nds32/include/asm/uaccess.h |  283 ++++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/nds32_ksyms.c  |   31 +++++
 arch/nds32/lib/Makefile          |    3 +
 arch/nds32/lib/clear_user.S      |   42 ++++++
 arch/nds32/lib/copy_from_user.S  |   45 ++++++
 arch/nds32/lib/copy_template.S   |   70 ++++++++++
 arch/nds32/lib/copy_to_user.S    |   45 ++++++
 arch/nds32/lib/memcpy.S          |   30 ++++
 arch/nds32/lib/memmove.S         |   70 ++++++++++
 arch/nds32/lib/memset.S          |   33 +++++
 arch/nds32/lib/memzero.S         |   18 +++
 13 files changed, 722 insertions(+)
 create mode 100644 arch/nds32/include/asm/string.h
 create mode 100644 arch/nds32/include/asm/swab.h
 create mode 100644 arch/nds32/include/asm/uaccess.h
 create mode 100644 arch/nds32/kernel/nds32_ksyms.c
 create mode 100644 arch/nds32/lib/Makefile
 create mode 100644 arch/nds32/lib/clear_user.S
 create mode 100644 arch/nds32/lib/copy_from_user.S
 create mode 100644 arch/nds32/lib/copy_template.S
 create mode 100644 arch/nds32/lib/copy_to_user.S
 create mode 100644 arch/nds32/lib/memcpy.S
 create mode 100644 arch/nds32/lib/memmove.S
 create mode 100644 arch/nds32/lib/memset.S
 create mode 100644 arch/nds32/lib/memzero.S

diff --git a/arch/nds32/include/asm/string.h b/arch/nds32/include/asm/string.h
new file mode 100644
index 0000000..179272c
--- /dev/null
+++ b/arch/nds32/include/asm/string.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_NDS32_STRING_H
+#define __ASM_NDS32_STRING_H
+
+#define __HAVE_ARCH_MEMCPY
+extern void *memcpy(void *, const void *, __kernel_size_t);
+
+#define __HAVE_ARCH_MEMMOVE
+extern void *memmove(void *, const void *, __kernel_size_t);
+
+#define __HAVE_ARCH_MEMSET
+extern void *memset(void *, int, __kernel_size_t);
+
+extern void *memzero(void *ptr, __kernel_size_t n);
+#endif
diff --git a/arch/nds32/include/asm/swab.h b/arch/nds32/include/asm/swab.h
new file mode 100644
index 0000000..e01a755
--- /dev/null
+++ b/arch/nds32/include/asm/swab.h
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __NDS32_SWAB_H__
+#define __NDS32_SWAB_H__
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
+{
+	__asm__("wsbh   %0, %0\n\t"	/* word swap byte within halfword */
+		"rotri  %0, %0, #16\n"
+		:"=r"(x)
+		:"0"(x));
+	return x;
+}
+
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
+{
+	__asm__("wsbh   %0, %0\n"	/* word swap byte within halfword */
+		:"=r"(x)
+		:"0"(x));
+	return x;
+}
+
+#define __arch_swab32(x) ___arch__swab32(x)
+#define __arch_swab16(x) ___arch__swab16(x)
+
+#if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
+#define __BYTEORDER_HAS_U64__
+#define __SWAB_64_THRU_32__
+#endif
+
+#endif /* __NDS32_SWAB_H__ */
diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
new file mode 100644
index 0000000..18a009f
--- /dev/null
+++ b/arch/nds32/include/asm/uaccess.h
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef _ASMANDES_UACCESS_H
+#define _ASMANDES_UACCESS_H
+
+/*
+ * User space memory access functions
+ */
+#include <linux/sched.h>
+#include <asm/errno.h>
+#include <asm/memory.h>
+#include <asm/types.h>
+#include <linux/mm.h>
+
+#define VERIFY_READ	0
+#define VERIFY_WRITE	1
+
+#define __asmeq(x, y)  ".ifnc " x "," y " ; .err ; .endif\n\t"
+
+/*
+ * The exception table consists of pairs of addresses: the first is the
+ * address of an instruction that is allowed to fault, and the second is
+ * the address at which the program should continue.  No registers are
+ * modified, so it is entirely up to the continuation code to figure out
+ * what to do.
+ *
+ * All the routines below use bits of fixup code that are out of line
+ * with the main instruction path.  This means when everything is well,
+ * we don't even have to jump over them.  Further, they do not intrude
+ * on our cache or tlb entries.
+ */
+
+struct exception_table_entry {
+	unsigned long insn, fixup;
+};
+
+extern int fixup_exception(struct pt_regs *regs);
+
+#define KERNEL_DS 	((mm_segment_t) { ~0UL })
+#define USER_DS     	((mm_segment_t) {TASK_SIZE - 1})
+
+#define get_ds()	(KERNEL_DS)
+#define get_fs()	(current_thread_info()->addr_limit)
+#define user_addr_max	get_fs
+
+static inline void set_fs(mm_segment_t fs)
+{
+	current_thread_info()->addr_limit = fs;
+}
+
+#define segment_eq(a, b)    ((a) == (b))
+
+#define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs() -size))
+
+#define access_ok(type, addr, size)                 \
+	__range_ok((unsigned long)addr, (unsigned long)size)
+/*
+ * Single-value transfer routines.  They automatically use the right
+ * size if we just have the right pointer type.  Note that the functions
+ * which read from user space (*get_*) need to take care not to leak
+ * kernel data even if the calling code is buggy and fails to check
+ * the return value.  This means zeroing out the destination variable
+ * or buffer on error.  Normally this is done out of line by the
+ * fixup code, but there are a few places where it intrudes on the
+ * main code path.  When we only write to user space, there is no
+ * problem.
+ *
+ * The "__xxx" versions of the user access functions do not verify the
+ * address space - it must have been done previously with a separate
+ * "access_ok()" call.
+ *
+ * The "xxx_error" versions set the third argument to EFAULT if an
+ * error occurs, and leave it unchanged on success.  Note that these
+ * versions are void (ie, don't return a value as such).
+ */
+
+#define get_user(x,p)							\
+({									\
+	long __e = -EFAULT;						\
+	if(likely(access_ok(VERIFY_READ,  p, sizeof(*p)))) {		\
+		__e = __get_user(x,p);					\
+	} else								\
+		x = 0;							\
+	__e;								\
+})
+#define __get_user(x,ptr)						\
+({									\
+	long __gu_err = 0;						\
+	__get_user_err((x),(ptr),__gu_err);				\
+	__gu_err;							\
+})
+
+#define __get_user_error(x,ptr,err)					\
+({									\
+	__get_user_err((x),(ptr),err);					\
+	(void) 0;							\
+})
+
+#define __get_user_err(x,ptr,err)					\
+do {									\
+	unsigned long __gu_addr = (unsigned long)(ptr);			\
+	unsigned long __gu_val;						\
+	__chk_user_ptr(ptr);						\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		__get_user_asm("lbi",__gu_val,__gu_addr,err);		\
+		break;							\
+	case 2:								\
+		__get_user_asm("lhi",__gu_val,__gu_addr,err);		\
+		break;							\
+	case 4:								\
+		__get_user_asm("lwi",__gu_val,__gu_addr,err);		\
+		break;							\
+	case 8:								\
+		__get_user_asm_dword(__gu_val,__gu_addr,err);		\
+		break;							\
+	default:							\
+		BUILD_BUG(); 						\
+		break;							\
+	}								\
+	(x) = (__typeof__(*(ptr)))__gu_val;				\
+} while (0)
+
+#define __get_user_asm(inst,x,addr,err)					\
+	asm volatile(							\
+	"1:	"inst"	%1,[%2]\n"					\
+	"2:\n"								\
+	"	.section .fixup,\"ax\"\n"				\
+	"	.align	2\n"						\
+	"3:	move %0, %3\n"						\
+	"	move %1, #0\n"						\
+	"	b	2b\n"						\
+	"	.previous\n"						\
+	"	.section __ex_table,\"a\"\n"				\
+	"	.align	3\n"						\
+	"	.long	1b, 3b\n"					\
+	"	.previous"						\
+	: "+r" (err), "=&r" (x)						\
+	: "r" (addr), "i" (-EFAULT)					\
+	: "cc")
+
+#ifdef __NDS32_EB__
+#define __gu_reg_oper0 "%H1"
+#define __gu_reg_oper1 "%L1"
+#else
+#define __gu_reg_oper0 "%L1"
+#define __gu_reg_oper1 "%H1"
+#endif
+
+#define __get_user_asm_dword(x, addr, err) 				\
+	asm volatile(			    				\
+	"\n1:\tlwi " __gu_reg_oper0 ",[%2]\n"				\
+	"\n2:\tlwi " __gu_reg_oper1 ",[%2+4]\n"				\
+	"3:\n"								\
+	"	.section .fixup,\"ax\"\n"				\
+	"	.align	2\n"						\
+	"4:	move	%0, %3\n"					\
+	"	b	3b\n"						\
+	"	.previous\n"						\
+	"	.section __ex_table,\"a\"\n"				\
+	"	.align	3\n"						\
+	"	.long	1b, 4b\n"					\
+	"	.long	2b, 4b\n"					\
+	"	.previous"						\
+	: "+r"(err), "=&r"(x)                				\
+	: "r"(addr), "i"(-EFAULT) 					\
+	: "cc")
+#define put_user(x,p)							\
+({									\
+	long __e = -EFAULT;						\
+	if(likely(access_ok(VERIFY_WRITE,  p, sizeof(*p)))) {		\
+		__e = __put_user(x,p);					\
+	}								\
+	__e;								\
+})
+#define __put_user(x,ptr)						\
+({									\
+	long __pu_err = 0;						\
+	__put_user_err((x),(ptr),__pu_err);				\
+	__pu_err;							\
+})
+
+#define __put_user_error(x,ptr,err)					\
+({									\
+	__put_user_err((x),(ptr),err);					\
+	(void) 0;							\
+})
+
+#define __put_user_err(x,ptr,err)					\
+do {									\
+	unsigned long __pu_addr = (unsigned long)(ptr);			\
+	__typeof__(*(ptr)) __pu_val = (x);				\
+	__chk_user_ptr(ptr);						\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		__put_user_asm("sbi",__pu_val,__pu_addr,err);		\
+		break;							\
+	case 2: 							\
+		__put_user_asm("shi",__pu_val,__pu_addr,err);		\
+		break;							\
+	case 4: 							\
+		__put_user_asm("swi",__pu_val,__pu_addr,err);		\
+		break;							\
+	case 8:								\
+		__put_user_asm_dword(__pu_val,__pu_addr,err);		\
+		break;							\
+	default:							\
+		BUILD_BUG(); 						\
+		break;							\
+	}								\
+} while (0)
+
+#define __put_user_asm(inst,x,addr,err)					\
+	asm volatile(							\
+	"1:	"inst"	%1,[%2]\n"					\
+	"2:\n"								\
+	"	.section .fixup,\"ax\"\n"				\
+	"	.align	2\n"						\
+	"3:	move	%0, %3\n"					\
+	"	b	2b\n"						\
+	"	.previous\n"						\
+	"	.section __ex_table,\"a\"\n"				\
+	"	.align	3\n"						\
+	"	.long	1b, 3b\n"					\
+	"	.previous"						\
+	: "+r" (err)							\
+	: "r" (x), "r" (addr), "i" (-EFAULT)				\
+	: "cc")
+
+#ifdef __NDS32_EB__
+#define __pu_reg_oper0 "%H2"
+#define __pu_reg_oper1 "%L2"
+#else
+#define __pu_reg_oper0 "%L2"
+#define __pu_reg_oper1 "%H2"
+#endif
+
+#define __put_user_asm_dword(x, addr, err) 				\
+	asm volatile(			    				\
+	"\n1:\tswi " __pu_reg_oper0 ",[%1]\n"				\
+	"\n2:\tswi " __pu_reg_oper1 ",[%1+4]\n"				\
+	"3:\n"								\
+	"	.section .fixup,\"ax\"\n"				\
+	"	.align	2\n"						\
+	"4:	move	%0, %3\n"					\
+	"	b	3b\n"						\
+	"	.previous\n"						\
+	"	.section __ex_table,\"a\"\n"				\
+	"	.align	3\n"						\
+	"	.long	1b, 4b\n"					\
+	"	.long	2b, 4b\n"					\
+	"	.previous"						\
+	: "+r"(err)                					\
+	: "r"(addr), "r"(x), "i"(-EFAULT) 				\
+	: "cc")
+extern unsigned long __arch_clear_user(void __user * addr, unsigned long n);
+extern long strncpy_from_user(char *dest, const char __user * src, long count);
+extern __must_check long strlen_user(const char __user * str);
+extern __must_check long strnlen_user(const char __user * str, long n);
+extern unsigned long __arch_copy_from_user(void *to, const void __user * from,
+                                           unsigned long n);
+extern unsigned long __arch_copy_to_user(void __user * to, const void *from,
+                                         unsigned long n);
+
+#define raw_copy_from_user __arch_copy_from_user
+#define raw_copy_to_user __arch_copy_to_user
+
+#define INLINE_COPY_FROM_USER
+#define INLINE_COPY_TO_USER
+static inline unsigned long clear_user(void __user * to, unsigned long n)
+{
+	if (access_ok(VERIFY_WRITE, to, n))
+		n = __arch_clear_user(to, n);
+	return n;
+}
+
+static inline unsigned long __clear_user(void __user * to, unsigned long n)
+{
+	return __arch_clear_user(to, n);
+}
+
+#endif /* _ASMNDS32_UACCESS_H */
diff --git a/arch/nds32/kernel/nds32_ksyms.c b/arch/nds32/kernel/nds32_ksyms.c
new file mode 100644
index 0000000..5ecebd0
--- /dev/null
+++ b/arch/nds32/kernel/nds32_ksyms.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/in6.h>
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+
+#include <asm/checksum.h>
+#include <asm/io.h>
+#include <asm/ftrace.h>
+#include <asm/proc-fns.h>
+
+/* mem functions */
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(memzero);
+
+/* user mem (segment) */
+EXPORT_SYMBOL(__arch_copy_from_user);
+EXPORT_SYMBOL(__arch_copy_to_user);
+EXPORT_SYMBOL(__arch_clear_user);
+
+/* cache handling */
+EXPORT_SYMBOL(cpu_icache_inval_all);
+EXPORT_SYMBOL(cpu_dcache_wbinval_all);
+EXPORT_SYMBOL(cpu_dma_inval_range);
+EXPORT_SYMBOL(cpu_dma_wb_range);
diff --git a/arch/nds32/lib/Makefile b/arch/nds32/lib/Makefile
new file mode 100644
index 0000000..0f98401
--- /dev/null
+++ b/arch/nds32/lib/Makefile
@@ -0,0 +1,3 @@
+lib-y		:= copy_page.o memcpy.o memmove.o   \
+		   memset.o memzero.o \
+		   copy_from_user.o copy_to_user.o clear_user.o
diff --git a/arch/nds32/lib/clear_user.S b/arch/nds32/lib/clear_user.S
new file mode 100644
index 0000000..805dfcd
--- /dev/null
+++ b/arch/nds32/lib/clear_user.S
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/errno.h>
+
+/* Prototype: int __arch_clear_user(void *addr, size_t sz)
+ * Purpose  : clear some user memory
+ * Params   : addr - user memory address to clear
+ *          : sz   - number of bytes to clear
+ * Returns  : number of bytes NOT cleared
+ */
+	.text
+	.align	5
+ENTRY(__arch_clear_user)
+	add	$r5, $r0, $r1
+	beqz	$r1, clear_exit
+	xor	$p1, $p1, $p1		! Use $p1=0 to clear mem
+	srli	$p0, $r1, #2		! $p0 = number of word to clear
+	andi	$r1, $r1, #3		! Bytes less than a word to copy
+	beqz	$p0, byte_clear		! Only less than a word to clear
+word_clear:
+USER(	smw.bim,$p1, [$r0], $p1)	! Clear the word
+	addi	$p0, $p0, #-1		! Decrease word count
+	bnez	$p0, word_clear		! Continue looping to clear all words
+	beqz	$r1, clear_exit		! No left bytes to copy
+byte_clear:
+USER(	sbi.bi,	$p1, [$r0], #1)		! Clear the byte
+	addi	$r1, $r1, #-1		! Decrease byte count
+	bnez	$r1, byte_clear		! Continue looping to clear all left bytes
+clear_exit:
+	move	$r0, $r1		! Set return value
+	ret
+
+	.section .fixup,"ax"
+	.align	0
+9001:
+	sub	$r0, $r5, $r0		! Bytes left to copy
+	ret
+	.previous
+ENDPROC(__arch_clear_user)
diff --git a/arch/nds32/lib/copy_from_user.S b/arch/nds32/lib/copy_from_user.S
new file mode 100644
index 0000000..ad1857b
--- /dev/null
+++ b/arch/nds32/lib/copy_from_user.S
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/errno.h>
+
+.macro 	lbi1 dst, addr, adj
+USER( lbi.bi, \dst, [\addr], \adj)
+.endm
+
+.macro 	sbi1 src, addr, adj
+sbi.bi	\src, [\addr], \adj
+.endm
+
+.macro	lmw1 start_reg, addr, end_reg
+USER( lmw.bim, \start_reg, [\addr], \end_reg)
+.endm
+
+.macro	smw1 start_reg, addr, end_reg
+smw.bim \start_reg, [\addr], \end_reg
+.endm
+
+
+/* Prototype: int __arch_copy_from_user(void *to, const char *from, size_t n)
+ * Purpose  : copy a block from user memory to kernel memory
+ * Params   : to   - kernel memory
+ *          : from - user memory
+ *          : n    - number of bytes to copy
+ * Returns  : Number of bytes NOT copied.
+ */
+
+.text
+ENTRY(__arch_copy_from_user)
+	add	$r5, $r0, $r2
+#include "copy_template.S"
+	move	$r0, $r2
+	ret
+.section .fixup,"ax"
+.align  2
+9001:
+	sub	$r0, $r5, $r0
+	ret
+.previous
+ENDPROC(__arch_copy_from_user)
diff --git a/arch/nds32/lib/copy_template.S b/arch/nds32/lib/copy_template.S
new file mode 100644
index 0000000..b5621fb
--- /dev/null
+++ b/arch/nds32/lib/copy_template.S
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+
+	beq	$r1, $r0, quit_memcpy
+	beqz	$r2, quit_memcpy
+	srli    $r3, $r2, #5	! check if len < cache-line size 32
+	beqz	$r3, word_copy_entry
+	andi	$r4, $r0, #0x3	! check byte-align
+	beqz	$r4, unalign_word_copy_entry
+
+	addi	$r4, $r4,#-4
+	abs	$r4, $r4	! check how many un-align byte to copy
+	sub	$r2, $r2, $r4	! update $R2
+
+unalign_byte_copy:
+	lbi1	$r3, $r1, #1
+	addi	$r4, $r4, #-1
+	sbi1	$r3, $r0, #1
+	bnez	$r4, unalign_byte_copy
+	beqz	$r2, quit_memcpy
+
+unalign_word_copy_entry:
+	andi	$r3, $r0, 0x1f	! check cache-line unaligncount
+	beqz	$r3, cache_copy
+
+	addi	$r3, $r3, #-32
+	abs	$r3, $r3
+	sub	$r2, $r2, $r3	! update $R2
+
+unalign_word_copy:
+	lmw1	$r4, $r1, $r4
+	addi	$r3, $r3, #-4
+	smw1	$r4, $r0, $r4
+	bnez	$r3, unalign_word_copy
+	beqz	$r2, quit_memcpy
+
+	addi	$r3, $r2, #-32	! to check $r2< cache_line , than go to word_copy
+	bltz	$r3, word_copy_entry
+cache_copy:
+	srli	$r3, $r2, #5
+	beqz	$r3, word_copy_entry
+3:
+	lmw1	$r17, $r1, $r24
+	addi	$r3, $r3, #-1
+	smw1	$r17, $r0, $r24
+	bnez	$r3, 3b
+
+word_copy_entry:
+	andi	$r2, $r2, #31
+
+	beqz	$r2, quit_memcpy
+5:
+	srli	$r3, $r2, #2
+	beqz	$r3, byte_copy
+word_copy:
+	lmw1	$r4, $r1, $r4
+	addi	$r3, $r3, #-1
+	smw1	$r4, $r0, $r4
+	bnez	$r3, word_copy
+	andi	$r2, $r2, #3
+	beqz	$r2, quit_memcpy
+byte_copy:
+	lbi1	$r3, $r1, #1
+	addi	$r2, $r2, #-1
+
+	sbi1	$r3, $r0, #1
+	bnez	$r2, byte_copy
+quit_memcpy:
+
diff --git a/arch/nds32/lib/copy_to_user.S b/arch/nds32/lib/copy_to_user.S
new file mode 100644
index 0000000..3230044
--- /dev/null
+++ b/arch/nds32/lib/copy_to_user.S
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/errno.h>
+
+.macro 	lbi1 dst, addr, adj
+lbi.bi	\dst, [\addr], \adj
+.endm
+
+.macro 	sbi1 src, addr, adj
+USER( sbi.bi, \src, [\addr], \adj)
+.endm
+
+.macro	lmw1 start_reg, addr, end_reg
+lmw.bim \start_reg, [\addr], \end_reg
+.endm
+
+.macro	smw1 start_reg, addr, end_reg
+USER( smw.bim, \start_reg, [\addr], \end_reg)
+.endm
+
+
+/* Prototype: int __arch_copy_to_user(void *to, const char *from, size_t n)
+ * Purpose  : copy a block to user memory from kernel memory
+ * Params   : to   - user memory
+ *          : from - kernel memory
+ *          : n    - number of bytes to copy
+ * Returns  : Number of bytes NOT copied.
+ */
+
+.text
+ENTRY(__arch_copy_to_user)
+	add	$r5, $r0, $r2
+#include "copy_template.S"
+	move	$r0, $r2
+	ret
+.section .fixup,"ax"
+.align  2
+9001:
+	sub	$r0, $r5, $r0
+	ret
+.previous
+ENDPROC(__arch_copy_to_user)
diff --git a/arch/nds32/lib/memcpy.S b/arch/nds32/lib/memcpy.S
new file mode 100644
index 0000000..a2345ea
--- /dev/null
+++ b/arch/nds32/lib/memcpy.S
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+
+
+.macro 	lbi1 dst, addr, adj
+lbi.bi	\dst, [\addr], \adj
+.endm
+
+.macro 	sbi1 src, addr, adj
+sbi.bi	\src, [\addr], \adj
+.endm
+
+.macro	lmw1 start_reg, addr, end_reg
+lmw.bim \start_reg, [\addr], \end_reg
+.endm
+
+.macro	smw1 start_reg, addr, end_reg
+smw.bim \start_reg, [\addr], \end_reg
+.endm
+
+.text
+ENTRY(memcpy)
+	move	$r5, $r0
+#include "copy_template.S"
+	move	$r0, $r5
+	ret
+
+ENDPROC(memcpy)
diff --git a/arch/nds32/lib/memmove.S b/arch/nds32/lib/memmove.S
new file mode 100644
index 0000000..c823aad
--- /dev/null
+++ b/arch/nds32/lib/memmove.S
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+
+/*
+  void *memmove(void *dst, const void *src, int n);
+
+  dst: $r0
+  src: $r1
+  n  : $r2
+  ret: $r0 - pointer to the memory area dst.
+*/
+	.text
+
+ENTRY(memmove)
+	move	$r5, $r0		! Set return value = det
+	beq	$r0, $r1, exit_memcpy	! Exit when det = src
+	beqz	$r2, exit_memcpy	! Exit when n = 0
+	pushm	$t0, $t1		! Save reg
+	srli	$p1, $r2, #2		! $p1 is how many words to copy
+
+	! Avoid data lost when memory overlap
+	! Copy data reversely when src < dst
+	slt	$p0, $r0, $r1		! check if $r0 < $r1
+	beqz	$p0, do_reverse		! branch if dst > src
+
+	! No reverse, dst < src
+	andi	$r2, $r2, #3		! How many bytes are less than a word
+	li	$t0, #1			! Determining copy direction in byte_cpy
+	beqz	$p1, byte_cpy		! When n is less than a word
+
+word_cpy:
+	lmw.bim	$p0, [$r1], $p0		! Read a word from src
+	addi	$p1, $p1, #-1		! How many words left to copy
+	smw.bim	$p0, [$r0], $p0		! Copy the word to det
+	bnez	$p1, word_cpy		! If remained words > 0
+	beqz	$r2, end_memcpy		! No left bytes to copy
+	b	byte_cpy
+
+do_reverse:
+	add	$r0, $r0, $r2		! Start with the end of $r0
+	add	$r1, $r1, $r2		! Start with the end of $r1
+	andi	$r2, $r2, #3		! How many bytes are less than a word
+	li	$t0, #-1		! Determining copy direction in byte_cpy
+	beqz	$p1, reverse_byte_cpy	! When n is less than a word
+
+reverse_word_cpy:
+	lmw.adm	$p0, [$r1], $p0		! Read a word from src
+	addi	$p1, $p1, #-1		! How many words left to copy
+	smw.adm	$p0, [$r0], $p0		! Copy the word to det
+	bnez	$p1, reverse_word_cpy	! If remained words > 0
+	beqz	$r2, end_memcpy		! No left bytes to copy
+
+reverse_byte_cpy:
+	addi	$r0, $r0, #-1
+	addi	$r1, $r1, #-1
+byte_cpy:				! Less than 4 bytes to copy now
+	lb.bi	$p0, [$r1], $t0		! Read a byte from src
+	addi	$r2, $r2, #-1		! How many bytes left to copy
+	sb.bi	$p0, [$r0], $t0		! copy the byte to det
+	bnez	$r2, byte_cpy		! If remained bytes > 0
+
+end_memcpy:
+	popm	$t0, $t1
+exit_memcpy:
+	move	$r0, $r5
+	ret
+
+ENDPROC(memmove)
diff --git a/arch/nds32/lib/memset.S b/arch/nds32/lib/memset.S
new file mode 100644
index 0000000..193cb6c
--- /dev/null
+++ b/arch/nds32/lib/memset.S
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+
+	.text
+ENTRY(memset)
+	move	$r5, $r0		! Return value
+	beqz	$r2, end_memset		! Exit when len = 0
+	srli	$p1, $r2, 2		! $p1 is how many words to copy
+	andi	$r2, $r2, 3		! How many bytes are less than a word
+	beqz	$p1, byte_set		! When n is less than a word
+
+	! set $r1 from ??????ab to abababab
+	andi	$r1, $r1, #0x00ff	! $r1 = 000000ab
+	slli	$p0, $r1, #8		! $p0 = 0000ab00
+	or	$r1, $r1, $p0		! $r1 = 0000abab
+	slli	$p0, $r1, #16		! $p0 = abab0000
+	or	$r1, $r1, $p0		! $r1 = abababab
+word_set:
+	addi	$p1, $p1, #-1		! How many words left to copy
+	smw.bim	$r1, [$r0], $r1		! Copy the word to det
+	bnez	$p1, word_set		! Still words to set, continue looping
+	beqz	$r2, end_memset		! No left byte to set
+byte_set:				! Less than 4 bytes left to set
+	addi	$r2, $r2, #-1		! Decrease len by 1
+	sbi.bi	$r1, [$r0], #1		! Set data of the next byte to $r1
+	bnez	$r2, byte_set		! Still bytes left to set
+end_memset:
+	move	$r0, $r5
+	ret
+
+ENDPROC(memset)
diff --git a/arch/nds32/lib/memzero.S b/arch/nds32/lib/memzero.S
new file mode 100644
index 0000000..f055972
--- /dev/null
+++ b/arch/nds32/lib/memzero.S
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+
+	.text
+ENTRY(memzero)
+	beqz	$r1, 1f
+	push	$lp
+	move    $r2, $r1
+	move    $r1, #0
+	push	$r0
+	bal     memset
+	pop	$r0
+	pop	$lp
+1:
+        ret
+ENDPROC(memzero)
-- 
1.7.9.5
