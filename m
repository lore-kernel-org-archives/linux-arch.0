From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 14/19] csky: User access
Date: Mon,  2 Jul 2018 01:30:17 +0800
Message-ID: <641ce1b36d6248e3c4c025f687d029208bda821c.1530465326.git.ren_guo@c-sky.com>
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
 arch/csky/include/asm/uaccess.h | 397 ++++++++++++++++++++++++++++++++++++++++
 arch/csky/lib/usercopy.c        | 271 +++++++++++++++++++++++++++
 2 files changed, 668 insertions(+)
 create mode 100644 arch/csky/include/asm/uaccess.h
 create mode 100644 arch/csky/lib/usercopy.c

diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
new file mode 100644
index 0000000..81063c3
--- /dev/null
+++ b/arch/csky/include/asm/uaccess.h
@@ -0,0 +1,397 @@
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
-- 
2.7.4
