From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH 18/31] nds32: Library functions
Date: Wed,  8 Nov 2017 13:55:06 +0800
Message-ID: <ea57a25c0aceab45d36951fed44cfbecfe1540b8.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/string.h  |   30 +++
 arch/nds32/include/asm/swab.h    |   48 +++++
 arch/nds32/include/asm/uaccess.h |  385 ++++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/nds32_ksyms.c  |   54 ++++++
 arch/nds32/lib/Makefile          |    4 +
 arch/nds32/lib/getuser.S         |   57 ++++++
 arch/nds32/lib/memcpy.S          |   93 +++++++++
 arch/nds32/lib/memmove.S         |   83 ++++++++
 arch/nds32/lib/memset.S          |   46 +++++
 arch/nds32/lib/memzero.S         |   31 +++
 arch/nds32/lib/putuser.S         |   53 ++++++
 arch/nds32/lib/uaccess.S         |  160 ++++++++++++++++
 12 files changed, 1044 insertions(+)
 create mode 100644 arch/nds32/include/asm/string.h
 create mode 100644 arch/nds32/include/asm/swab.h
 create mode 100644 arch/nds32/include/asm/uaccess.h
 create mode 100644 arch/nds32/kernel/nds32_ksyms.c
 create mode 100644 arch/nds32/lib/Makefile
 create mode 100644 arch/nds32/lib/getuser.S
 create mode 100644 arch/nds32/lib/memcpy.S
 create mode 100644 arch/nds32/lib/memmove.S
 create mode 100644 arch/nds32/lib/memset.S
 create mode 100644 arch/nds32/lib/memzero.S
 create mode 100644 arch/nds32/lib/putuser.S
 create mode 100644 arch/nds32/lib/uaccess.S

diff --git a/arch/nds32/include/asm/string.h b/arch/nds32/include/asm/string.h
new file mode 100644
index 0000000..cf4d4b8
--- /dev/null
+++ b/arch/nds32/include/asm/string.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
index 0000000..4815d6a
--- /dev/null
+++ b/arch/nds32/include/asm/swab.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
index 0000000..b87a41a
--- /dev/null
+++ b/arch/nds32/include/asm/uaccess.h
@@ -0,0 +1,385 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#define KERNEL_DS ((mm_segment_t) { ~0UL })
+#define USER_DS     ((mm_segment_t) {TASK_SIZE - 1})
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
+extern int __get_user_1(void *);
+extern int __get_user_2(void *);
+extern int __get_user_4(void *);
+extern int __get_user_8(void *);
+extern int __get_user_bad(void);
+
+#define __get_user_x(__r2,__p,__e,__s,__i...)				\
+	   __asm__ __volatile__ (					\
+		__asmeq("%0", "$r0") __asmeq("%1", "$r2")		\
+		"bal	__get_user_" #__s				\
+		: "=&r" (__e), "=r" (__r2)				\
+		: "0" (__p)						\
+		: __i, "cc")
+
+#define get_user(x,p)							\
+	({								\
+		const register typeof(*(p)) __user *__p asm("$r0") = (p);\
+		register unsigned long __r2 asm("$r2");			\
+		register int __e asm("$r0");				\
+		switch (sizeof(*(__p))) {				\
+		case 1:							\
+			__get_user_x(__r2, __p, __e, 1, "$lp");		\
+			break;						\
+		case 2:							\
+			__get_user_x(__r2, __p, __e, 2, "$lp");		\
+			break;						\
+		case 4:							\
+			__get_user_x(__r2, __p, __e, 4, "$lp");		\
+			break;						\
+		case 8:							\
+			__get_user_x(__r2, __p, __e, 8, "$r3", "$lp");	\
+			break;						\
+		default: __e = __get_user_bad(); break;			\
+		}							\
+		x = (typeof(*(p))) __r2;	\
+		__e;							\
+	})
+
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
+	case 1:	__get_user_asm_byte(__gu_val,__gu_addr,err);	break;	\
+	case 2:	__get_user_asm_half(__gu_val,__gu_addr,err);	break;	\
+	case 4:	__get_user_asm_word(__gu_val,__gu_addr,err);	break;	\
+	default: (__gu_val) = __get_user_bad();				\
+	}								\
+	(x) = (__typeof__(*(ptr)))__gu_val;				\
+} while (0)
+
+#define __get_user_asm_byte(x,addr,err)				\
+	__asm__ __volatile__(					\
+	"1:	lbi	%1,[%2]\n"				\
+	"2:\n"							\
+	"	.section .fixup,\"ax\"\n"			\
+	"	.align	2\n"					\
+	"3:	move %0, %3\n"				\
+	"	move %1, #0\n"				\
+	"	b	2b\n"					\
+	"	.previous\n"					\
+	"	.section __ex_table,\"a\"\n"			\
+	"	.align	3\n"					\
+	"	.long	1b, 3b\n"				\
+	"	.previous"					\
+	: "+r" (err), "=&r" (x)					\
+	: "r" (addr), "i" (-EFAULT)				\
+	: "cc")
+
+#ifndef __NDS32_EB__
+#define __get_user_asm_half(x,__gu_addr,err)			\
+({								\
+	unsigned long __b1, __b2;				\
+	__get_user_asm_byte(__b1, __gu_addr, err);		\
+	__get_user_asm_byte(__b2, __gu_addr + 1, err);		\
+	(x) = __b1 | (__b2 << 8);				\
+})
+#else
+#define __get_user_asm_half(x,__gu_addr,err)			\
+({								\
+	unsigned long __b1, __b2;				\
+	__get_user_asm_byte(__b1, __gu_addr, err);		\
+	__get_user_asm_byte(__b2, __gu_addr + 1, err);		\
+	(x) = (__b1 << 8) | __b2;				\
+})
+#endif
+
+#define __get_user_asm_word(x,addr,err)				\
+	__asm__ __volatile__(					\
+	"1:	lwi	%1,[%2]\n"				\
+	"2:\n"							\
+	"	.section .fixup,\"ax\"\n"			\
+	"	.align	2\n"					\
+	"3:	move	%0, %3\n"				\
+	"	move	%1, #0\n"				\
+	"	b	2b\n"					\
+	"	.previous\n"					\
+	"	.section __ex_table,\"a\"\n"			\
+	"	.align	3\n"					\
+	"	.long	1b, 3b\n"				\
+	"	.previous"					\
+	: "+r" (err), "=&r" (x)					\
+	: "r" (addr), "i" (-EFAULT)				\
+	: "cc")
+
+extern int __put_user_1(void *, unsigned int);
+extern int __put_user_2(void *, unsigned int);
+extern int __put_user_4(void *, unsigned int);
+extern int __put_user_8(void *, unsigned long long);
+extern int __put_user_bad(void);
+
+#define __put_user_x(__r2,__p,__e,__s,__i)				\
+	   __asm__ __volatile__ (					\
+		__asmeq("%0", "$r0") __asmeq("%2", "$r2")		\
+		"bal	__put_user_" #__s				\
+		: "=&r" (__e)						\
+		: "0" (__p), "r" (__r2)					\
+		: __i, "cc")
+
+#define put_user(x,p)							\
+	({								\
+		const register typeof(*(p)) __r2 asm("$r2") = (x);	\
+		const register typeof(*(p)) __user *__p asm("$r0") = (p);\
+		register int __e asm("$r0");				\
+		switch (sizeof(*(__p))) {				\
+		case 1:							\
+			__put_user_x(__r2, __p, __e, 1, "$lp");		\
+			break;						\
+		case 2:							\
+			__put_user_x(__r2, __p, __e, 2, "$lp");		\
+			break;						\
+		case 4:							\
+			__put_user_x(__r2, __p, __e, 4, "$lp");		\
+			break;						\
+		case 8:							\
+			__put_user_x(__r2, __p, __e, 8, "$lp");		\
+			break;						\
+		default: __e = __put_user_bad(); break;			\
+		}							\
+		__e;							\
+	})
+
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
+	case 1: __put_user_asm_byte(__pu_val,__pu_addr,err);	break;	\
+	case 2: __put_user_asm_half(__pu_val,__pu_addr,err);	break;	\
+	case 4: __put_user_asm_word(__pu_val,__pu_addr,err);	break;	\
+	case 8:	__put_user_asm_dword(__pu_val,__pu_addr,err);	break;	\
+	default: __put_user_bad();					\
+	}								\
+} while (0)
+
+#define __put_user_asm_byte(x,__pu_addr,err)			\
+	__asm__ __volatile__(					\
+	"1:	sbi	%1,[%2]\n"				\
+	"2:\n"							\
+	"	.section .fixup,\"ax\"\n"			\
+	"	.align	2\n"					\
+	"3:	move	%0, %3\n"				\
+	"	b	2b\n"					\
+	"	.previous\n"					\
+	"	.section __ex_table,\"a\"\n"			\
+	"	.align	3\n"					\
+	"	.long	1b, 3b\n"				\
+	"	.previous"					\
+	: "+r" (err)						\
+	: "r" (x), "r" (__pu_addr), "i" (-EFAULT)		\
+	: "cc")
+
+#ifndef __NDS32_EB__
+#define __put_user_asm_half(x,__pu_addr,err)			\
+({								\
+	unsigned long __temp = (unsigned long)(x);		\
+	__put_user_asm_byte(__temp, __pu_addr, err);		\
+	__put_user_asm_byte(__temp >> 8, __pu_addr + 1, err);	\
+})
+#else
+#define __put_user_asm_half(x,__pu_addr,err)			\
+({								\
+	unsigned long __temp = (unsigned long)(x);		\
+	__put_user_asm_byte(__temp >> 8, __pu_addr, err);	\
+	__put_user_asm_byte(__temp, __pu_addr + 1, err);	\
+})
+#endif
+
+#define __put_user_asm_word(x,__pu_addr,err)			\
+	__asm__ __volatile__(					\
+	"1:	swi	%1,[%2]\n"				\
+	"2:\n"							\
+	"	.section .fixup,\"ax\"\n"			\
+	"	.align	2\n"					\
+	"3:	move	%0, %3\n"				\
+	"	b	2b\n"					\
+	"	.previous\n"					\
+	"	.section __ex_table,\"a\"\n"			\
+	"	.align	3\n"					\
+	"	.long	1b, 3b\n"				\
+	"	.previous"					\
+	: "+r" (err)						\
+	: "r" (x), "r" (__pu_addr), "i" (-EFAULT)		\
+	: "cc")
+
+#ifdef __NDS32_EB__
+#define __reg_oper0 "%H2"
+#define __reg_oper1 "%L2"
+#else
+#define __reg_oper0 "%L2"
+#define __reg_oper1 "%H2"
+#endif
+
+#define __put_user_asm_dword(x, __pu_addr, __pu_err) \
+	__asm__ __volatile__ (			    \
+	"\n1:\tswi " __reg_oper0 ",[%1]\n"	\
+	"\n2:\tswi " __reg_oper1 ",[%1+4]\n"	\
+	"3:\n"					\
+	"	.section .fixup,\"ax\"\n"	\
+	"	.align	2\n"			\
+	"4:	move	%0, %3\n"		\
+	"	b	3b\n"			\
+	"	.previous\n"			\
+	"	.section __ex_table,\"a\"\n"	\
+	"	.align	3\n"			\
+	"	.long	1b, 4b\n"		\
+	"	.long	2b, 4b\n"		\
+	"	.previous"			\
+	: "+r"(__pu_err)                \
+	: "r"(__pu_addr), "r"(x), "i"(-EFAULT) \
+	: "cc")
+extern unsigned long __arch_copy_from_user(void *to, const void __user * from,
+					   unsigned long n);
+extern unsigned long __arch_copy_to_user(void __user * to, const void *from,
+					 unsigned long n);
+extern unsigned long __arch_clear_user(void __user * addr, unsigned long n);
+extern long strncpy_from_user(char *dest, const char __user * src, long count);
+extern __must_check long strlen_user(const char __user * str);
+extern __must_check long strnlen_user(const char __user * str, long n);
+static inline unsigned long raw_copy_from_user(void *to,
+					       const void __user * from,
+					       unsigned long n)
+{
+	return __arch_copy_from_user(to, from, n);
+}
+
+static inline unsigned long raw_copy_to_user(void __user * to, const void *from,
+					     unsigned long n)
+{
+	return __arch_copy_to_user(to, from, n);
+}
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
index 0000000..3f8f29f
--- /dev/null
+++ b/arch/nds32/kernel/nds32_ksyms.c
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/in6.h>
+#include <linux/syscalls.h>
+
+#include <asm/checksum.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
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
+EXPORT_SYMBOL(__get_user_1);
+EXPORT_SYMBOL(__get_user_2);
+EXPORT_SYMBOL(__get_user_4);
+EXPORT_SYMBOL(__get_user_8);
+
+EXPORT_SYMBOL(__put_user_1);
+EXPORT_SYMBOL(__put_user_2);
+EXPORT_SYMBOL(__put_user_4);
+EXPORT_SYMBOL(__put_user_8);
+
+/* cache handling */
+EXPORT_SYMBOL(cpu_icache_inval_all);
+EXPORT_SYMBOL(cpu_dcache_wbinval_all);
+EXPORT_SYMBOL(cpu_dma_inval_range);
+EXPORT_SYMBOL(cpu_dma_wb_range);
diff --git a/arch/nds32/lib/Makefile b/arch/nds32/lib/Makefile
new file mode 100644
index 0000000..4c53eb8
--- /dev/null
+++ b/arch/nds32/lib/Makefile
@@ -0,0 +1,4 @@
+lib-y		:= copy_page.o memcpy.o memmove.o   \
+		   memset.o memzero.o \
+		   uaccess.o getuser.o \
+		   putuser.o
diff --git a/arch/nds32/lib/getuser.S b/arch/nds32/lib/getuser.S
new file mode 100644
index 0000000..d3e9108
--- /dev/null
+++ b/arch/nds32/lib/getuser.S
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/errno.h>
+#include <linux/linkage.h>
+
+
+ENTRY(__get_user_1)
+1:	lbi	$r2, [$r0]
+	move	$r0, #0
+	ret
+
+ENTRY(__get_user_2)
+2:	lhi	$r2, [$r0]
+	move	$r0, #0
+	ret
+
+ENTRY(__get_user_4)
+3:	lwi	$r2, [$r0]
+	move	$r0, #0
+	ret
+
+ENTRY(__get_user_8)
+4:	lwi.bi	$r2, [$r0], #4
+5:	lwi	$r3, [$r0]
+	move	$r0, #0
+	ret
+
+__get_user_bad_8:
+	move	$r3, #0
+__get_user_bad:
+	move	$r2, #0
+	move	$r0, #-EFAULT
+	ret
+
+.section __ex_table, "a"
+	.long	1b, __get_user_bad
+	.long	2b, __get_user_bad
+	.long	3b, __get_user_bad
+	.long	4b, __get_user_bad_8
+	.long	5b, __get_user_bad_8
+.previous
diff --git a/arch/nds32/lib/memcpy.S b/arch/nds32/lib/memcpy.S
new file mode 100644
index 0000000..e809fd6
--- /dev/null
+++ b/arch/nds32/lib/memcpy.S
@@ -0,0 +1,93 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+	.text
+
+ENTRY(memcpy)
+	move	$r5, $r0
+	beq	$r0, $r1, quit_memcpy
+	beqz	$r2, quit_memcpy
+	srli    $r3, $r2, #5	 ! check if len < cache-line size 32
+	beqz	$r3, word_copy_entry
+	andi	$r4, $r0, #0x3	! check byte-align
+	beqz	$r4, unalign_word_copy_entry
+
+	addi	$r4, $r4,#-4
+	abs	$r4, $r4		! check how many un-align byte to copy
+	sub	$r2, $r2, $r4	! update $R2
+
+unalign_byte_copy:
+	lbi.bi	$r3, [$r1], #1
+	addi	$r4, $r4, #-1
+	sbi.bi	$r3, [$r0], #1
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
+	lmw.bim	$r4, [$r1], $r4
+	addi	$r3, $r3, #-4
+	smw.bim	$r4, [$r0], $r4
+	bnez	$r3, unalign_word_copy
+	beqz	$r2, quit_memcpy
+
+	addi	$r3, $r2, #-32	! to check $r2< cache_line , than go to word_copy
+	bltz	$r3, word_copy_entry
+cache_copy:
+	srli	$r3, $r2, #5
+	beqz	$r3, word_copy_entry
+	pushm	$r6, $r13
+3:
+	lmw.bim	$r6, [$r1], $r13
+	addi	$r3, $r3, #-1
+	smw.bim	$r6, [$r0], $r13
+	bnez	$r3, 3b
+	popm	$r6, $r13
+
+word_copy_entry:
+	andi	$r2, $r2, #31
+
+	beqz	$r2, quit_memcpy
+5:
+	srli	$r3, $r2, #2
+	beqz	$r3, byte_copy
+word_copy:
+	lmw.bim	$r4, [$r1], $r4
+	addi	$r3, $r3, #-1
+	smw.bim	$r4, [$r0], $r4
+	bnez	$r3, word_copy
+	andi	$r2, $r2, #3
+	beqz	$r2, quit_memcpy
+byte_copy:
+	lbi.bi	$r3, [$r1], #1
+	addi	$r2, $r2, #-1
+
+	sbi.bi	$r3, [$r0], #1
+	bnez	$r2, byte_copy
+quit_memcpy:
+	move	$r0, $r5
+	ret
+
+ENDPROC(memcpy)
diff --git a/arch/nds32/lib/memmove.S b/arch/nds32/lib/memmove.S
new file mode 100644
index 0000000..0c54350
--- /dev/null
+++ b/arch/nds32/lib/memmove.S
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
index 0000000..05ec352
--- /dev/null
+++ b/arch/nds32/lib/memset.S
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
index 0000000..00c9996
--- /dev/null
+++ b/arch/nds32/lib/memzero.S
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+	.text
+ENTRY(memzero)
+	beqz	$r1, 1f
+	push	$lp
+        move    $r2, $r1
+        move    $r1, #0
+	push	$r0
+        bal     memset
+	pop	$r0
+	pop	$lp
+1:
+        ret
+ENDPROC(memzero)
diff --git a/arch/nds32/lib/putuser.S b/arch/nds32/lib/putuser.S
new file mode 100644
index 0000000..2f8a20f
--- /dev/null
+++ b/arch/nds32/lib/putuser.S
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#include <asm/errno.h>
+#include <linux/linkage.h>
+
+	.text
+
+ENTRY(__put_user_1)
+1:	sb	$r2, [$r0]
+	move	$r0, #0
+	ret
+
+ENTRY(__put_user_2)
+2:	shi	$r2, [$r0]	! Store input halfword
+	move	$r0, #0
+	ret
+
+ENTRY(__put_user_4)
+3:	sw	$r2, [$r0]
+	move	$r0, #0
+	ret
+
+ENTRY(__put_user_8)
+4:	swi.bi	$r2, [$r0], #4
+5:	sw	$r3, [$r0]
+	move	$r0, #0
+	ret
+
+__put_user_bad:
+	move	$r0, #-EFAULT
+	ret
+
+.section __ex_table, "a"
+	.long	1b, __put_user_bad
+	.long	2b, __put_user_bad
+	.long	3b, __put_user_bad
+	.long	4b, __put_user_bad
+	.long	5b, __put_user_bad
+.previous
diff --git a/arch/nds32/lib/uaccess.S b/arch/nds32/lib/uaccess.S
new file mode 100644
index 0000000..dc2583e
--- /dev/null
+++ b/arch/nds32/lib/uaccess.S
@@ -0,0 +1,160 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#include <asm/assembler.h>
+#include <asm/errno.h>
+
+	.text
+
+/* Prototype: int __arch_copy_to_user(void *to, const char *from, size_t n)
+ * Purpose  : copy a block to user memory from kernel memory
+ * Params   : to   - user memory
+ *          : from - kernel memory
+ *          : n    - number of bytes to copy
+ * Returns  : Number of bytes NOT copied.
+ */
+
+ENTRY(__arch_copy_to_user)
+	push	$r0
+	push	$r2
+	beqz	$r2, ctu_exit
+	srli	$p0, $r2, #2		! $p0 = number of word to clear
+	andi	$r2, $r2, #3		! Bytes less than a word to copy
+	beqz	$p0, byte_ctu		! Only less than a word to copy
+word_ctu:
+	lmw.bim	$p1, [$r1], $p1		! Load the next word
+USER(	smw.bim,$p1, [$r0], $p1)	! Store the next word
+	addi	$p0, $p0, #-1		! Decrease word count
+	bnez	$p0, word_ctu		! Continue looping to copy all words
+	beqz	$r2, ctu_exit		! No left bytes to copy
+byte_ctu:
+	lbi.bi	$p1, [$r1], #1		! Load the next byte
+USER(	sbi.bi,	$p1, [$r0], #1)		! Store the next byte
+	addi	$r2, $r2, #-1		! Decrease byte count
+	bnez	$r2, byte_ctu		! Continue looping to clear all left bytes
+ctu_exit:
+	move	$r0, $r2		! Set return value
+	pop	$r2
+	pop	$r2			! Pop saved $r0 to $r2 to not corrupt return value
+	ret
+
+	.section .fixup,"ax"
+	.align	0
+9001:
+	pop	$p1			! Original $r2, n
+	pop	$p0			! Original $r0, void *to
+	sub	$r1, $r0, $p0		! Bytes copied
+	sub	$r2, $p1, $r1		! Bytes left to copy
+	push	$lp
+	move	$r0, $p0
+	bal	memzero			! Clean up the memory
+	pop	$lp
+	move	$r0, $r2
+	ret
+	.previous
+ENDPROC(__arch_copy_to_user)
+
+/* Prototype: unsigned long __arch_copy_from_user(void *to,const void *from,unsigned long n);
+ * Purpose  : copy a block from user memory to kernel memory
+ * Params   : to   - kernel memory
+ *          : from - user memory
+ *          : n    - number of bytes to copy
+ * Returns  : Number of bytes NOT copied.
+ */
+
+
+ENTRY(__arch_copy_from_user)
+	push	$r1
+	push	$r2
+	beqz	$r2, cfu_exit
+	srli	$p0, $r2, #2		! $p0 = number of word to clear
+	andi	$r2, $r2, #3		! Bytes less than a word to copy
+	beqz	$p0, byte_cfu		! Only less than a word to copy
+word_cfu:
+USER(	lmw.bim,$p1, [$r1], $p1)	! Load the next word
+	smw.bim	$p1, [$r0], $p1		! Store the next word
+	addi	$p0, $p0, #-1		! Decrease word count
+	bnez	$p0, word_cfu		! Continue looping to copy all words
+	beqz	$r2, cfu_exit		! No left bytes to copy
+byte_cfu:
+USER(	lbi.bi,	$p1, [$r1], #1)		! Load the next byte
+	sbi.bi	$p1, [$r0], #1		! Store the next byte
+	addi	$r2, $r2, #-1		! Decrease byte count
+	bnez	$r2, byte_cfu		! Continue looping to clear all left bytes
+cfu_exit:
+	move	$r0, $r2		! Set return value
+	pop	$r2
+	pop	$r1
+	ret
+
+	.section .fixup,"ax"
+	.align	0
+	/*
+	 * We took an exception.  $r0 contains a pointer to
+	 * the byte not copied.
+	 */
+9001:
+	pop	$p1			! Original $r2, n
+	pop	$p0			! Original $r0, void *to
+	sub	$r1, $r1, $p0		! Bytes copied
+	sub	$r2, $p1, $r1		! Bytes left to copy
+	push	$lp
+	bal	memzero			! Clean up the memory
+	pop	$lp
+	move	$r0, $r2
+	ret
+	.previous
+ENDPROC(__arch_copy_from_user)
+
+/* Prototype: int __arch_clear_user(void *addr, size_t sz)
+ * Purpose  : clear some user memory
+ * Params   : addr - user memory address to clear
+ *          : sz   - number of bytes to clear
+ * Returns  : number of bytes NOT cleared
+ */
+	.align	5
+ENTRY(__arch_clear_user)
+	pushm	$r0, $r1
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
+	pop	$r1
+	pop	$r1			! Pop saved $r0 to $r1 to not corrupt return value
+	ret
+
+	.section .fixup,"ax"
+	.align	0
+9001:
+	popm	$p0, $p1		! $p0 = original $r0, *addr, $p1 = original $r1, n
+	sub	$p0, $r0, $p0		! Bytes copied
+	sub	$r0, $p1, $p0		! Bytes left to copy
+	ret
+	.previous
+ENDPROC(__arch_clear_user)
-- 
1.7.9.5
