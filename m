From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 13/19] csky: User access
Date: Mon, 19 Mar 2018 03:51:35 +0800
Message-ID: <c1fe5da543aeee4b64b6fdcb6defe8772ea3fdba.1521399976.git.ren_guo@c-sky.com>
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
 arch/csky/include/asm/uaccess.h | 408 ++++++++++++++++++++++++++++++++++++++++
 arch/csky/include/asm/user.h    | 102 ++++++++++
 2 files changed, 510 insertions(+)
 create mode 100644 arch/csky/include/asm/uaccess.h
 create mode 100644 arch/csky/include/asm/user.h

diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
new file mode 100644
index 0000000..b3c3599
--- /dev/null
+++ b/arch/csky/include/asm/uaccess.h
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_UACCESS_H
+#define __ASM_CSKY_UACCESS_H
+
+/*
+ * User space memory access functions
+ */
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/version.h>
+#include <asm/segment.h>
+
+#define VERIFY_READ	0
+#define VERIFY_WRITE	1
+
+static inline int access_ok(int type, const void * addr, unsigned long size)
+{
+    return (((unsigned long)addr < current_thread_info()->addr_limit.seg) &&
+              ((unsigned long)(addr + size) < current_thread_info()->addr_limit.seg));
+}
+
+static inline int verify_area(int type, const void * addr, unsigned long size)
+{
+    return access_ok(type, addr, size) ? 0 : -EFAULT;
+}
+
+#define __addr_ok(addr) (access_ok(VERIFY_READ, addr,0))
+
+extern int __put_user_bad(void);
+
+/*
+ * Tell gcc we read from memory instead of writing: this is because
+ * we do not write to any memory gcc knows about, so there are no
+ * aliasing issues.
+ */
+
+/*
+ * These are the main single-value transfer routines.  They automatically
+ * use the right size if we just have the right pointer type.
+ *
+ * This gets kind of ugly. We want to return _two_ values in "get_user()"
+ * and yet we don't want to do any pointers, because that is too much
+ * of a performance impact. Thus we have a few rather ugly macros here,
+ * and hide all the ugliness from the user.
+ *
+ * The "__xxx" versions of the user access functions are versions that
+ * do not verify the address space, that must have been done previously
+ * with a separate "access_ok()" call (this is used when we do multiple
+ * accesses to the same area of user memory).
+ *
+ * As we use the same address space for kernel and user data on
+ * Ckcore, we can just do these as direct assignments.  (Of course, the
+ * exception handling means that it's no longer "just"...)
+ */
+
+#define put_user(x,ptr) \
+  __put_user_check((x), (ptr), sizeof(*(ptr)))
+
+#define __put_user(x,ptr) \
+  __put_user_nocheck((x), (ptr), sizeof(*(ptr)))
+
+#define __ptr(x) ((unsigned long *)(x))
+
+#define get_user(x,ptr) \
+  __get_user_check((x), (ptr), sizeof(*(ptr)))
+
+#define __get_user(x,ptr) \
+  __get_user_nocheck((x), (ptr), sizeof(*(ptr)))
+
+#define __put_user_nocheck(x, ptr, size)                                \
+({                                                                      \
+	long __pu_err=0;                                                \
+	typeof(*(ptr)) *__pu_addr = (ptr);                              \
+	typeof(*(ptr)) __pu_val = (typeof(*(ptr)))(x);                  \
+	if(__pu_addr){                                                  \
+	    __put_user_size(__pu_val, (__pu_addr), (size), __pu_err);   \
+	}                                                               \
+	__pu_err;                                                       \
+})
+
+#define __put_user_check(x,ptr,size)                                    \
+({                                                                      \
+	long __pu_err = -EFAULT;                                        \
+	typeof(*(ptr)) *__pu_addr = (ptr);                              \
+	typeof(*(ptr)) __pu_val = (typeof(*(ptr)))(x);                  \
+	if (access_ok(VERIFY_WRITE, __pu_addr, size) && __pu_addr)      \
+		__put_user_size(__pu_val, __pu_addr, (size), __pu_err); \
+	__pu_err;                                                       \
+})
+
+#define __put_user_size(x,ptr,size,retval)                              \
+do {                                                                    \
+	retval = 0;                                                     \
+	switch (size) {                                                 \
+		case 1: __put_user_asm_b(x, ptr, retval); break;        \
+		case 2: __put_user_asm_h(x, ptr, retval); break;        \
+		case 4: __put_user_asm_w(x, ptr, retval); break;        \
+		case 8: __put_user_asm_64(x, ptr, retval); break;       \
+		default: __put_user_bad();                              \
+	}	                                                        \
+} while (0)
+
+/*
+ * We don't tell gcc that we are accessing memory, but this is OK
+ * because we do not write to any memory gcc knows about, so there
+ * are no aliasing issues.
+ *
+ * Note that PC at a fault is the address *after* the faulting
+ * instruction.
+ */
+#define __put_user_asm_b(x, ptr, err)                           \
+do{                                                             \
+	int errcode;                                            \
+	asm volatile(                                           \
+	         "1:     stb   %1, (%2,0)        \n"            \
+	         "       br    3f                \n"            \
+	         "2:     mov   %0, %3            \n"            \
+	         "       br    3f                \n"            \
+	         ".section __ex_table,\"a\"      \n"            \
+	         ".align   2                     \n"            \
+	         ".long    1b,2b                 \n"            \
+	         ".previous                      \n"            \
+	          "3:                            \n"            \
+	         : "=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode) \
+	         : "0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)     \
+	         : "memory");                                   \
+}while(0)
+
+#define __put_user_asm_h(x, ptr, err)                           \
+do{                                                             \
+	int errcode;                                            \
+	asm volatile(                                           \
+	         "1:     sth   %1, (%2,0)        \n"            \
+	         "       br    3f                \n"            \
+	         "2:     mov   %0, %3            \n"            \
+	         "       br    3f                \n"            \
+	         ".section __ex_table,\"a\"      \n"            \
+	         ".align   2                     \n"            \
+	         ".long    1b,2b                 \n"            \
+	         ".previous                      \n"            \
+	          "3:                            \n"            \
+	         :"=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode)  \
+	         :"0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)      \
+	         : "memory");                                   \
+}while(0)
+
+#define __put_user_asm_w(x, ptr, err)                           \
+do{                                                             \
+	int errcode;                                            \
+	asm volatile(                                           \
+	         "1:     stw   %1, (%2,0)        \n"            \
+	         "       br    3f                \n"            \
+	         "2:     mov   %0, %3            \n"            \
+	         "       br    3f                \n"            \
+	         ".section __ex_table,\"a\"      \n"            \
+	         ".align   2                     \n"            \
+	         ".long    1b,2b                 \n"            \
+	         ".previous                      \n"            \
+	          "3:                            \n"            \
+	         :"=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode)  \
+	         :"0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)      \
+	         : "memory");                                   \
+}while(0)
+
+
+#define __put_user_asm_64(x, ptr, err)                          \
+do{                                                             \
+	int tmp;                                                \
+	int errcode;                                            \
+	typeof(*(ptr)) src = ( typeof(*(ptr)))x;                \
+	typeof(*(ptr)) *psrc = &src;                            \
+	                                                        \
+	asm volatile(                                           \
+	        "     ldw     %3, (%1, 0)     \n"               \
+	        "1:   stw     %3, (%2, 0)     \n"               \
+	        "     ldw     %3, (%1, 4)     \n"               \
+	        "2:   stw     %3, (%2, 4)     \n"               \
+	        "     br      4f              \n"               \
+	        "3:   mov     %0, %4          \n"               \
+	        "     br      4f              \n"               \
+	        ".section __ex_table, \"a\"   \n"               \
+	        ".align   2                   \n"               \
+	        ".long    1b, 3b              \n"               \
+	        ".long    2b, 3b              \n"               \
+	        ".previous                    \n"               \
+	        "4:                           \n"               \
+	        :"=r"(err),"=r"(psrc),"=r"(ptr),"=r"(tmp),"=r"(errcode) \
+	        : "0"(err), "1"(psrc), "2"(ptr), "3"(0), "4"(-EFAULT) \
+	        : "memory" );                                   \
+}while (0)
+
+#define __get_user_nocheck(x, ptr, size)                        \
+({                                                              \
+	long  __gu_err;	                                        \
+	__get_user_size(x, (ptr), (size), __gu_err);            \
+	__gu_err;                                               \
+})
+
+#define __get_user_check(x, ptr, size)                          \
+({                                                              \
+	int __gu_err = -EFAULT;	                                \
+	const __typeof__(*(ptr)) __user * __gu_ptr = (ptr);     \
+	if (access_ok(VERIFY_READ, __gu_ptr, size) && __gu_ptr) \
+		__get_user_size(x, __gu_ptr, (size), __gu_err); \
+	__gu_err;                                               \
+})
+
+#define __get_user_size(x, ptr, size, retval)                   \
+do {                                                            \
+	switch (size) {                                         \
+		case 1: __get_user_asm_common((x),ptr,"ldb",retval); break; \
+		case 2: __get_user_asm_common((x),ptr,"ldh",retval); break; \
+		case 4: __get_user_asm_common((x),ptr,"ldw",retval); break; \
+		default:                                        \
+			x=0;                                    \
+			(retval) = __get_user_bad();            \
+	}                                                       \
+} while (0)
+
+#define __get_user_asm_common(x, ptr, ins, err)                 \
+do{                                                             \
+	int errcode;                                            \
+	asm volatile(                                           \
+	        "1:   " ins "   %1, (%4,0)      \n"             \
+	        "       br    3f                \n"             \
+	        /* Fix up codes */                              \
+	        "2:     mov   %0, %2            \n"             \
+	        "       movi  %1, 0             \n"             \
+	        "       br    3f                \n"             \
+	        ".section __ex_table,\"a\"      \n"             \
+	        ".align   2                     \n"             \
+	        ".long    1b,2b                 \n"             \
+	        ".previous                      \n"             \
+	        "3:                            \n"              \
+	        :"=r"(err), "=r"(x), "=r"(errcode)              \
+	        :"0"(0), "r"(ptr), "2"(-EFAULT)                 \
+	        : "memory");                                    \
+}while(0)
+
+extern int __get_user_bad(void);
+
+#define __copy_user(to, from, n)                                \
+do{                                                             \
+	int w0, w1, w2, w3;                                     \
+	asm volatile(                                           \
+		"0:     cmpnei  %1, 0           \n"             \
+		"       bf      8f              \n"             \
+		"       mov     %3, %1          \n"             \
+		"       or      %3, %2          \n"             \
+		"       andi    %3, 3           \n"             \
+		"       cmpnei  %3, 0           \n"             \
+		"       bf      1f              \n"             \
+		"       br      5f              \n"             \
+		"1:     cmplti  %0, 16          \n"   /* 4W */  \
+		"       bt      3f              \n"             \
+		"       ldw     %3, (%2, 0)     \n"             \
+		"       ldw     %4, (%2, 4)     \n"             \
+		"       ldw     %5, (%2, 8)     \n"             \
+		"       ldw     %6, (%2, 12)    \n"             \
+		"2:     stw     %3, (%1, 0)     \n"             \
+		"9:     stw     %4, (%1, 4)     \n"             \
+		"10:    stw     %5, (%1, 8)     \n"             \
+		"11:    stw     %6, (%1, 12)    \n"             \
+		"       addi    %2, 16          \n"             \
+		"       addi    %1, 16          \n"             \
+		"       subi    %0, 16          \n"             \
+		"       br      1b              \n"             \
+		"3:     cmplti  %0, 4           \n"  /* 1W */   \
+		"       bt      5f              \n"             \
+		"       ldw     %3, (%2, 0)     \n"             \
+		"4:     stw     %3, (%1, 0)     \n"             \
+		"       addi    %2, 4           \n"             \
+		"       addi    %1, 4           \n"             \
+		"       subi    %0, 4           \n"             \
+		"       br      3b              \n"             \
+		"5:     cmpnei  %0, 0           \n"  /* 1B */   \
+		"       bf      8f              \n"             \
+		"       ldb     %3, (%2, 0)     \n"             \
+		"6:     stb     %3, (%1, 0)     \n"             \
+		"       addi    %2,  1          \n"             \
+		"       addi    %1,  1          \n"             \
+		"       subi    %0,  1          \n"             \
+		"       br      5b              \n"             \
+		"7:     br      8f              \n"             \
+		".section __ex_table, \"a\"     \n"             \
+		".align   2                     \n"             \
+		".long    2b, 7b                \n"             \
+		".long    9b, 7b                \n"             \
+		".long   10b, 7b                \n"             \
+		".long   11b, 7b                \n"             \
+		".long    4b, 7b                \n"             \
+		".long    6b, 7b                \n"             \
+		".previous                      \n"             \
+		"8:                             \n"             \
+	        : "=r"(n), "=r"(to), "=r"(from), "=r"(w0), "=r"(w1), "=r"(w2), "=r"(w3)   \
+		: "0"(n), "1"(to), "2"(from)                    \
+		: "memory" );                                   \
+} while (0)
+
+#define __copy_user_zeroing(to, from, n) \
+do{                                                             \
+	int tmp;                                                \
+	int nsave;                                              \
+	asm volatile(                                           \
+		"0:     cmpnei  %1, 0           \n"             \
+		"       bf      7f              \n"             \
+		"       mov     %3, %1          \n"             \
+		"       or      %3, %2          \n"             \
+		"       andi    %3, 3           \n"             \
+		"       cmpnei  %3, 0           \n"             \
+		"       bf      1f              \n"             \
+		"       br      5f              \n"             \
+		"1:     cmplti  %0, 16          \n"   /* 4W */  \
+		"       bt      3f              \n"             \
+		"2:     ldw     %3, (%2, 0)     \n"             \
+		"10:    ldw     %4, (%2, 4)     \n"             \
+		"       stw     %3, (%1, 0)     \n"             \
+		"       stw     %4, (%1, 4)     \n"             \
+		"11:    ldw     %3, (%2, 8)     \n"             \
+		"12:    ldw     %4, (%2, 12)    \n"             \
+		"       stw     %3, (%1, 8)     \n"             \
+		"       stw     %4, (%1, 12)    \n"             \
+		"       addi    %2, 16          \n"             \
+		"       addi    %1, 16          \n"             \
+		"       subi    %0, 16          \n"             \
+		"       br      1b              \n"             \
+		"3:     cmplti  %0, 4           \n"  /* 1W */   \
+		"       bt      5f              \n"             \
+		"4:     ldw     %3, (%2, 0)     \n"             \
+		"       stw     %3, (%1, 0)     \n"             \
+		"       addi    %2, 4           \n"             \
+		"       addi    %1, 4           \n"             \
+		"       subi    %0, 4           \n"             \
+		"       br      3b              \n"             \
+		"5:     cmpnei  %0, 0           \n"  /* 1B */   \
+		"       bf      7f              \n"             \
+		"6:     ldb     %3, (%2, 0)     \n"             \
+		"       stb     %3, (%1, 0)     \n"             \
+		"       addi    %2,  1          \n"             \
+		"       addi    %1,  1          \n"             \
+		"       subi    %0,  1          \n"             \
+		"       br      5b              \n"             \
+		"8:     mov     %3, %0          \n" /* zero */  \
+		"       movi    %4, 0           \n"             \
+		"9:     stb     %4, (%1, 0)     \n"             \
+		"       addi    %1, 1           \n"             \
+		"       subi    %3, 1           \n"             \
+		"       cmpnei  %3, 0           \n"             \
+		"       bt      9b              \n"             \
+		"       br      7f              \n"             \
+		".section __ex_table, \"a\"     \n"             \
+		".align   2                     \n"             \
+		".long    2b, 8b                \n"             \
+		".long   10b, 8b                \n"             \
+		".long   11b, 8b                \n"             \
+		".long   12b, 8b                \n"             \
+		".long    4b, 8b                \n"             \
+		".long    6b, 8b                \n"             \
+		".previous                      \n"             \
+		"7:                             \n"             \
+		: "=r"(n), "=r"(to), "=r"(from), "=r"(nsave), "=r"(tmp)   \
+		: "0"(n), "1"(to), "2"(from)                    \
+		: "memory" );                                   \
+} while (0)
+
+unsigned long raw_copy_from_user(void *to, const void *from, unsigned long n);
+unsigned long raw_copy_to_user(void *to, const void *from, unsigned long n);
+
+#ifdef COMPAT_KERNEL_4_9
+#define __copy_from_user(to, from, n) raw_copy_from_user(to, from, n)
+#define __copy_to_user(to, from, n) raw_copy_to_user(to, from, n)
+
+#define __copy_from_user_inatomic	__copy_from_user
+#define __copy_to_user_inatomic		__copy_to_user
+
+#define copy_from_user			__copy_from_user
+#define copy_to_user			__copy_to_user
+#endif
+
+unsigned long clear_user(void *to, unsigned long n);
+unsigned long __clear_user(void __user *to, unsigned long n);
+
+long strncpy_from_user(char *dst, const char *src, long count);
+long __strncpy_from_user(char *dst, const char *src, long count);
+
+/*
+ * Return the size of a string (including the ending 0)
+ *
+ * Return 0 on exception, a value greater than N if too long
+ */
+long strnlen_user(const char *src, long n);
+
+#define strlen_user(str) strnlen_user(str, 32767)
+
+struct exception_table_entry
+{
+	unsigned long insn;
+	unsigned long nextinsn;
+};
+
+extern int fixup_exception(struct pt_regs *regs);
+
+#endif /* __ASM_CSKY_UACCESS_H */
diff --git a/arch/csky/include/asm/user.h b/arch/csky/include/asm/user.h
new file mode 100644
index 0000000..8ca8a12
--- /dev/null
+++ b/arch/csky/include/asm/user.h
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_USER_H
+#define __ASM_CSKY_USER_H
+
+#include <asm/page.h>
+#include <asm/ptrace.h>
+/*
+ *  Core file format: The core file is written in such a way that gdb
+ *  can understand it and provide useful information to the user (under
+ *  linux we use the 'trad-core' bfd).  There are quite a number of
+ *  obstacles to being able to view the contents of the floating point
+ *  registers, and until these are solved you will not be able to view the
+ *  contents of them.  Actually, you can read in the core file and look at
+ *  the contents of the user struct to find out what the floating point
+ *  registers contain.
+ *  The actual file contents are as follows:
+ *  UPAGE: 1 page consisting of a user struct that tells gdb what is present
+ *  in the file.  Directly after this is a copy of the task_struct, which
+ *  is currently not used by gdb, but it may come in useful at some point.
+ *  All of the registers are stored as part of the upage.  The upage should
+ *  always be only one page.
+ *  DATA: The data area is stored.  We use current->end_text to
+ *  current->brk to pick up all of the user variables, plus any memory
+ *  that may have been malloced.  No attempt is made to determine if a page
+ *  is demand-zero or if a page is totally unused, we just cover the entire
+ *  range.  All of the addresses are rounded in such a way that an integral
+ *  number of pages is written.
+ *  STACK: We need the stack information in order to get a meaningful
+ *  backtrace.  We need to write the data from (esp) to
+ *  current->start_stack, so we round each of these off in order to be able
+ *  to write an integer number of pages.
+ *  The minimum core file size is 3 pages, or 12288 bytes.
+ */
+
+struct user_cskyfp_struct {
+	unsigned long  fcr;         /* fpu control reg */
+	unsigned long  fsr;         /* fpu status reg, nothing in CPU_CSKYV2 */
+	unsigned long  fesr;        /* fpu exception status reg */
+	unsigned long  fp[32];      /* fpu general regs */
+};
+
+/*
+ * This is the old layout of "struct pt_regs" as of Linux 1.x, and
+ * is still the layout used by user (the new pt_regs doesn't have
+ * all registers).
+ *
+ * In this struct, both ABIV1 & ABIV2 have the same general regs:
+ * CSKY ABIv1: r0 ~ r31, psr, pc, hi, lo
+ * CSKY ABIv2: r0 ~ r31, psr, pc, hi, lo
+ * but in CSKY ABIV1, r16 ~ r31 don't exist, so in ABIV1, they are zero.
+ */
+struct user_regs_struct {
+      unsigned long	gregs[32];  // ABIV1, usp = r0; ABIV2, usp = r14
+      unsigned long	psr;
+      unsigned long	pc;
+      unsigned long	hi;
+      unsigned long	lo;
+};
+
+/* user_regs_struct->gregs[REG_WHY].
+ * flag: 0: enter system call
+ *       1: leave system call
+ */
+#define REG_WHY  9
+
+/*
+ * When the kernel dumps core, it starts by dumping the user struct -
+ * this will be used by gdb to figure out where the data and stack segments
+ * are within the file, and what virtual addresses to use.
+ */
+struct user{
+/* We start with the registers, to mimic the way that "memory" is returned
+   from the ptrace(3,...) function.  */
+	struct user_regs_struct  regs;	/* Where the registers are actually stored */
+	int                 u_fpvalid;  /* True if math co-processor being used. */
+
+/* The rest of this junk is to help gdb figure out what goes where */
+	unsigned long int   u_tsize;	/* Text segment size (pages). */
+	unsigned long int   u_dsize;	/* Data segment size (pages). */
+	unsigned long int   u_ssize;	/* Stack segment size (pages). */
+	unsigned long       start_code; /* Starting virtual address of text. */
+	unsigned long       start_stack;/* Starting virtual address of stack area.
+				   					   This is actually the bottom of the stack,
+				      				   the top of the stack is always found in
+									    the esp register.  */
+	long int            signal;     /* Signal that caused the core dump. */
+	int                 reserved;	/* No longer used */
+	unsigned long       u_ar0;		/* Used by gdb to help find the values
+										for the registers. */
+	unsigned long       magic;		/* To uniquely identify a core file */
+	char                u_comm[32];	/* User command that was responsible */
+	struct user_cskyfp_struct  u_fp;   /* Floating point registers */
+	struct user_cskyfp_struct* u_fpstate;	/* Math Co-processor pointer. */
+};
+
+#define NBPG 4096
+#define UPAGES 1
+#define HOST_TEXT_START_ADDR (u.start_code)
+#define HOST_STACK_END_ADDR (u.start_stack + u.u_ssize * NBPG)
+
+#endif /* __ASM_CSKY_USER_H */
-- 
2.7.4
