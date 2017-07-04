From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 3/9] RISC-V: Generic library routines and assembly
Date: Tue,  4 Jul 2017 12:50:56 -0700
Message-ID: <20170704195102.3974-4-palmer@dabbelt.com>
References: <20170704195102.3974-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34140 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbdGDTvd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2017 15:51:33 -0400
Received: by mail-pf0-f193.google.com with SMTP id c24so17192915pfe.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Jul 2017 12:51:33 -0700 (PDT)
In-Reply-To: <20170704195102.3974-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>

This patch contains code that is more specific to the RISC-V ISA than it
is to Linux.  It contains string and math operations, C wrappers for
various assembly instructions, stack walking code, and uaccess.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/asm.h            |  76 ++++++
 arch/riscv/include/asm/bitops.h         |   4 -
 arch/riscv/include/asm/csr.h            | 125 +++++++++
 arch/riscv/include/asm/linkage.h        |  20 ++
 arch/riscv/include/asm/string.h         |  26 ++
 arch/riscv/include/asm/uaccess.h        | 441 ++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/word-at-a-time.h |  55 ++++
 arch/riscv/kernel/stacktrace.c          | 177 +++++++++++++
 arch/riscv/lib/memcpy.S                 | 100 ++++++++
 arch/riscv/lib/memset.S                 | 120 +++++++++
 arch/riscv/lib/uaccess.S                | 127 +++++++++
 arch/riscv/lib/udivdi3.S                |  38 +++
 12 files changed, 1305 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/include/asm/asm.h
 create mode 100644 arch/riscv/include/asm/csr.h
 create mode 100644 arch/riscv/include/asm/linkage.h
 create mode 100644 arch/riscv/include/asm/string.h
 create mode 100644 arch/riscv/include/asm/uaccess.h
 create mode 100644 arch/riscv/include/asm/word-at-a-time.h
 create mode 100644 arch/riscv/kernel/stacktrace.c
 create mode 100644 arch/riscv/lib/memcpy.S
 create mode 100644 arch/riscv/lib/memset.S
 create mode 100644 arch/riscv/lib/uaccess.S
 create mode 100644 arch/riscv/lib/udivdi3.S

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
new file mode 100644
index 000000000000..6cbbb6a68d76
--- /dev/null
+++ b/arch/riscv/include/asm/asm.h
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
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
+#ifndef _ASM_RISCV_ASM_H
+#define _ASM_RISCV_ASM_H
+
+#ifdef __ASSEMBLY__
+#define __ASM_STR(x)	x
+#else
+#define __ASM_STR(x)	#x
+#endif
+
+#if __riscv_xlen == 64
+#define __REG_SEL(a, b)	__ASM_STR(a)
+#elif __riscv_xlen == 32
+#define __REG_SEL(a, b)	__ASM_STR(b)
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
+#define REG_L		__REG_SEL(ld, lw)
+#define REG_S		__REG_SEL(sd, sw)
+#define SZREG		__REG_SEL(8, 4)
+#define LGREG		__REG_SEL(3, 2)
+
+#if __SIZEOF_POINTER__ == 8
+#ifdef __ASSEMBLY__
+#define RISCV_PTR		.dword
+#define RISCV_SZPTR		8
+#define RISCV_LGPTR		3
+#else
+#define RISCV_PTR		".dword"
+#define RISCV_SZPTR		"8"
+#define RISCV_LGPTR		"3"
+#endif
+#elif __SIZEOF_POINTER__ == 4
+#ifdef __ASSEMBLY__
+#define RISCV_PTR		.word
+#define RISCV_SZPTR		4
+#define RISCV_LGPTR		2
+#else
+#define RISCV_PTR		".word"
+#define RISCV_SZPTR		"4"
+#define RISCV_LGPTR		"2"
+#endif
+#else
+#error "Unexpected __SIZEOF_POINTER__"
+#endif
+
+#if (__SIZEOF_INT__ == 4)
+#define INT		__ASM_STR(.word)
+#define SZINT		__ASM_STR(4)
+#define LGINT		__ASM_STR(2)
+#else
+#error "Unexpected __SIZEOF_INT__"
+#endif
+
+#if (__SIZEOF_SHORT__ == 2)
+#define SHORT		__ASM_STR(.half)
+#define SZSHORT		__ASM_STR(2)
+#define LGSHORT		__ASM_STR(1)
+#else
+#error "Unexpected __SIZEOF_SHORT__"
+#endif
+
+#endif /* _ASM_RISCV_ASM_H */
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 27e47858c6b1..d4f1c9c66e4d 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -18,8 +18,6 @@
 #error "Only <linux/bitops.h> can be included directly"
 #endif /* _LINUX_BITOPS_H */
 
-#ifdef __KERNEL__
-
 #include <linux/compiler.h>
 #include <linux/irqflags.h>
 #include <asm/barrier.h>
@@ -223,6 +221,4 @@ static inline void __clear_bit_unlock(
 
 #endif /* CONFIG_ISA_A */
 
-#endif /* __KERNEL__ */
-
 #endif /* _ASM_RISCV_BITOPS_H */
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
new file mode 100644
index 000000000000..387d0dbf0073
--- /dev/null
+++ b/arch/riscv/include/asm/csr.h
@@ -0,0 +1,125 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
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
+#ifndef _ASM_RISCV_CSR_H
+#define _ASM_RISCV_CSR_H
+
+#include <linux/const.h>
+
+/* Status register flags */
+#define SR_IE   _AC(0x00000002, UL) /* Interrupt Enable */
+#define SR_PIE  _AC(0x00000020, UL) /* Previous IE */
+#define SR_PS   _AC(0x00000100, UL) /* Previously Supervisor */
+#define SR_SUM  _AC(0x00040000, UL) /* Supervisor may access User Memory */
+
+#define SR_FS           _AC(0x00006000, UL) /* Floating-point Status */
+#define SR_FS_OFF       _AC(0x00000000, UL)
+#define SR_FS_INITIAL   _AC(0x00002000, UL)
+#define SR_FS_CLEAN     _AC(0x00004000, UL)
+#define SR_FS_DIRTY     _AC(0x00006000, UL)
+
+#define SR_XS           _AC(0x00018000, UL) /* Extension Status */
+#define SR_XS_OFF       _AC(0x00000000, UL)
+#define SR_XS_INITIAL   _AC(0x00008000, UL)
+#define SR_XS_CLEAN     _AC(0x00010000, UL)
+#define SR_XS_DIRTY     _AC(0x00018000, UL)
+
+#ifndef CONFIG_64BIT
+#define SR_SD   _AC(0x80000000, UL) /* FS/XS dirty */
+#else
+#define SR_SD   _AC(0x8000000000000000, UL) /* FS/XS dirty */
+#endif
+
+/* SPTBR flags */
+#if __riscv_xlen == 32
+#define SPTBR_PPN     _AC(0x003FFFFF, UL)
+#define SPTBR_MODE_32 _AC(0x80000000, UL)
+#define SPTBR_MODE    SPTBR_MODE_32
+#else
+#define SPTBR_PPN     _AC(0x00000FFFFFFFFFFF, UL)
+#define SPTBR_MODE_39 _AC(0x8000000000000000, UL)
+#define SPTBR_MODE    SPTBR_MODE_39
+#endif
+
+/* Interrupt Enable and Interrupt Pending flags */
+#define SIE_SSIE _AC(0x00000002, UL) /* Software Interrupt Enable */
+#define SIE_STIE _AC(0x00000020, UL) /* Timer Interrupt Enable */
+
+#define EXC_INST_MISALIGNED     0
+#define EXC_INST_ACCESS         1
+#define EXC_BREAKPOINT          3
+#define EXC_LOAD_ACCESS         5
+#define EXC_STORE_ACCESS        7
+#define EXC_SYSCALL             8
+#define EXC_INST_PAGE_FAULT     12
+#define EXC_LOAD_PAGE_FAULT     13
+#define EXC_STORE_PAGE_FAULT    15
+
+#ifndef __ASSEMBLY__
+
+#define csr_swap(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrrw %0, " #csr ", %1"		\
+			      : "=r" (__v) : "rK" (__v));	\
+	__v;							\
+})
+
+#define csr_read(csr)						\
+({								\
+	register unsigned long __v;				\
+	__asm__ __volatile__ ("csrr %0, " #csr			\
+			      : "=r" (__v));			\
+	__v;							\
+})
+
+#define csr_write(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrw " #csr ", %0"		\
+			      : : "rK" (__v));			\
+})
+
+#define csr_read_set(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrrs %0, " #csr ", %1"		\
+			      : "=r" (__v) : "rK" (__v));	\
+	__v;							\
+})
+
+#define csr_set(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrs " #csr ", %0"		\
+			      : : "rK" (__v));			\
+})
+
+#define csr_read_clear(csr, val)				\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrrc %0, " #csr ", %1"		\
+			      : "=r" (__v) : "rK" (__v));	\
+	__v;							\
+})
+
+#define csr_clear(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrc " #csr ", %0"		\
+			      : : "rK" (__v));			\
+})
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_CSR_H */
diff --git a/arch/riscv/include/asm/linkage.h b/arch/riscv/include/asm/linkage.h
new file mode 100644
index 000000000000..b7b304ca89c4
--- /dev/null
+++ b/arch/riscv/include/asm/linkage.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
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
+#ifndef _ASM_RISCV_LINKAGE_H
+#define _ASM_RISCV_LINKAGE_H
+
+#define __ALIGN		.balign 4
+#define __ALIGN_STR	".balign 4"
+
+#endif /* _ASM_RISCV_LINKAGE_H */
diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
new file mode 100644
index 000000000000..9210fcf4ff52
--- /dev/null
+++ b/arch/riscv/include/asm/string.h
@@ -0,0 +1,26 @@
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
+#ifndef _ASM_RISCV_STRING_H
+#define _ASM_RISCV_STRING_H
+
+#include <linux/types.h>
+#include <linux/linkage.h>
+
+#define __HAVE_ARCH_MEMSET
+extern asmlinkage void *memset(void *, int, size_t);
+
+#define __HAVE_ARCH_MEMCPY
+extern asmlinkage void *memcpy(void *, const void *, size_t);
+
+#endif /* _ASM_RISCV_STRING_H */
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
new file mode 100644
index 000000000000..647a060090f1
--- /dev/null
+++ b/arch/riscv/include/asm/uaccess.h
@@ -0,0 +1,441 @@
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
+ *
+ * This file was copied from include/asm-generic/uaccess.h
+ */
+
+#ifndef _ASM_RISCV_UACCESS_H
+#define _ASM_RISCV_UACCESS_H
+
+/*
+ * User space memory access functions
+ */
+#include <linux/errno.h>
+#include <linux/compiler.h>
+#include <linux/thread_info.h>
+#include <asm/byteorder.h>
+#include <asm/asm.h>
+
+#ifdef CONFIG_RV_PUM
+#define __enable_user_access()							\
+	__asm__ __volatile__ ("csrs sstatus, %0" : : "r" (SR_SUM) : "memory")
+#define __disable_user_access()							\
+	__asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : "memory")
+#else
+#define __enable_user_access()
+#define __disable_user_access()
+#endif
+
+/*
+ * The fs value determines whether argument validity checking should be
+ * performed or not.  If get_fs() == USER_DS, checking is performed, with
+ * get_fs() == KERNEL_DS, checking is bypassed.
+ *
+ * For historical reasons, these macros are grossly misnamed.
+ */
+
+#define KERNEL_DS	(~0UL)
+#define USER_DS		(TASK_SIZE)
+
+#define get_ds()	(KERNEL_DS)
+#define get_fs()	(current_thread_info()->addr_limit)
+
+static inline void set_fs(mm_segment_t fs)
+{
+	current_thread_info()->addr_limit = fs;
+}
+
+#define segment_eq(a, b) ((a) == (b))
+
+#define user_addr_max()	(get_fs())
+
+
+#define VERIFY_READ	0
+#define VERIFY_WRITE	1
+
+/**
+ * access_ok: - Checks if a user space pointer is valid
+ * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
+ *        %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
+ *        to write to a block, it is always safe to read from it.
+ * @addr: User space pointer to start of block to check
+ * @size: Size of block to check
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Checks if a pointer to a block of memory in user space is valid.
+ *
+ * Returns true (nonzero) if the memory block may be valid, false (zero)
+ * if it is definitely invalid.
+ *
+ * Note that, depending on architecture, this function probably just
+ * checks that the pointer is in the user space range - after calling
+ * this function, memory access functions may still return -EFAULT.
+ */
+#define access_ok(type, addr, size) ({					\
+	__chk_user_ptr(addr);						\
+	likely(__access_ok((unsigned long __force)(addr), (size)));	\
+})
+
+/*
+ * Ensure that the range [addr, addr+size) is within the process's
+ * address space
+ */
+static inline int __access_ok(unsigned long addr, unsigned long size)
+{
+	const mm_segment_t fs = get_fs();
+
+	return (size <= fs) && (addr <= (fs - size));
+}
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
+extern int fixup_exception(struct pt_regs *state);
+
+#if defined(__LITTLE_ENDIAN)
+#define __MSW	1
+#define __LSW	0
+#elif defined(__BIG_ENDIAN)
+#define __MSW	0
+#define	__LSW	1
+#else
+#error "Unknown endianness"
+#endif
+
+/*
+ * The "__xxx" versions of the user access functions do not verify the address
+ * space - it must have been done previously with a separate "access_ok()"
+ * call.
+ */
+
+#ifdef CONFIG_MMU
+#define __get_user_asm(insn, x, ptr, err)			\
+do {								\
+	uintptr_t __tmp;					\
+	__typeof__(x) __x;					\
+	__enable_user_access();					\
+	__asm__ __volatile__ (					\
+		"1:\n"						\
+		"	" insn " %1, %3\n"			\
+		"2:\n"						\
+		"	.section .fixup,\"ax\"\n"		\
+		"	.balign 4\n"				\
+		"3:\n"						\
+		"	li %0, %4\n"				\
+		"	li %1, 0\n"				\
+		"	jump 2b, %2\n"				\
+		"	.previous\n"				\
+		"	.section __ex_table,\"a\"\n"		\
+		"	.balign " RISCV_SZPTR "\n"			\
+		"	" RISCV_PTR " 1b, 3b\n"			\
+		"	.previous"				\
+		: "+r" (err), "=&r" (__x), "=r" (__tmp)		\
+		: "m" (*(ptr)), "i" (-EFAULT));			\
+	__disable_user_access();				\
+	(x) = __x;						\
+} while (0)
+#endif /* CONFIG_MMU */
+
+#ifdef CONFIG_64BIT
+#define __get_user_8(x, ptr, err) \
+	__get_user_asm("ld", x, ptr, err)
+#else /* !CONFIG_64BIT */
+#ifdef CONFIG_MMU
+#define __get_user_8(x, ptr, err)				\
+do {								\
+	u32 __user *__ptr = (u32 __user *)(ptr);		\
+	u32 __lo, __hi;						\
+	uintptr_t __tmp;					\
+	__enable_user_access();					\
+	__asm__ __volatile__ (					\
+		"1:\n"						\
+		"	lw %1, %4\n"				\
+		"2:\n"						\
+		"	lw %2, %5\n"				\
+		"3:\n"						\
+		"	.section .fixup,\"ax\"\n"		\
+		"	.balign 4\n"				\
+		"4:\n"						\
+		"	li %0, %6\n"				\
+		"	li %1, 0\n"				\
+		"	li %2, 0\n"				\
+		"	jump 3b, %3\n"				\
+		"	.previous\n"				\
+		"	.section __ex_table,\"a\"\n"		\
+		"	.balign " RISCV_SZPTR "\n"			\
+		"	" RISCV_PTR " 1b, 4b\n"			\
+		"	" RISCV_PTR " 2b, 4b\n"			\
+		"	.previous"				\
+		: "+r" (err), "=&r" (__lo), "=r" (__hi),	\
+			"=r" (__tmp)				\
+		: "m" (__ptr[__LSW]), "m" (__ptr[__MSW]),	\
+			"i" (-EFAULT));				\
+	__disable_user_access();				\
+	(x) = (__typeof__(x))((__typeof__((x)-(x)))(		\
+		(((u64)__hi << 32) | __lo)));			\
+} while (0)
+#endif /* CONFIG_MMU */
+#endif /* CONFIG_64BIT */
+
+
+/**
+ * __get_user: - Get a simple variable from user space, with less checking.
+ * @x:   Variable to store result.
+ * @ptr: Source address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple variable from user space to kernel
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and the result of
+ * dereferencing @ptr must be assignable to @x without a cast.
+ *
+ * Caller must check the pointer with access_ok() before calling this
+ * function.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ * On error, the variable @x is set to zero.
+ */
+#define __get_user(x, ptr)					\
+({								\
+	register long __gu_err = 0;				\
+	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
+	__chk_user_ptr(__gu_ptr);				\
+	switch (sizeof(*__gu_ptr)) {				\
+	case 1:							\
+		__get_user_asm("lb", (x), __gu_ptr, __gu_err);	\
+		break;						\
+	case 2:							\
+		__get_user_asm("lh", (x), __gu_ptr, __gu_err);	\
+		break;						\
+	case 4:							\
+		__get_user_asm("lw", (x), __gu_ptr, __gu_err);	\
+		break;						\
+	case 8:							\
+		__get_user_8((x), __gu_ptr, __gu_err);	\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
+	}							\
+	__gu_err;						\
+})
+
+/**
+ * get_user: - Get a simple variable from user space.
+ * @x:   Variable to store result.
+ * @ptr: Source address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple variable from user space to kernel
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and the result of
+ * dereferencing @ptr must be assignable to @x without a cast.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ * On error, the variable @x is set to zero.
+ */
+#define get_user(x, ptr)					\
+({								\
+	const __typeof__(*(ptr)) __user *__p = (ptr);		\
+	might_fault();						\
+	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?		\
+		__get_user((x), __p) :				\
+		((x) = 0, -EFAULT);				\
+})
+
+
+#ifdef CONFIG_MMU
+#define __put_user_asm(insn, x, ptr, err)			\
+do {								\
+	uintptr_t __tmp;					\
+	__typeof__(*(ptr)) __x = x;				\
+	__enable_user_access();					\
+	__asm__ __volatile__ (					\
+		"1:\n"						\
+		"	" insn " %z3, %2\n"			\
+		"2:\n"						\
+		"	.section .fixup,\"ax\"\n"		\
+		"	.balign 4\n"				\
+		"3:\n"						\
+		"	li %0, %4\n"				\
+		"	jump 2b, %1\n"				\
+		"	.previous\n"				\
+		"	.section __ex_table,\"a\"\n"		\
+		"	.balign " RISCV_SZPTR "\n"			\
+		"	" RISCV_PTR " 1b, 3b\n"			\
+		"	.previous"				\
+		: "+r" (err), "=r" (__tmp), "=m" (*(ptr))	\
+		: "rJ" (__x), "i" (-EFAULT));			\
+	__disable_user_access();				\
+} while (0)
+#endif /* CONFIG_MMU */
+
+
+#ifdef CONFIG_64BIT
+#define __put_user_8(x, ptr, err) \
+	__put_user_asm("sd", x, ptr, err)
+#else /* !CONFIG_64BIT */
+#ifdef CONFIG_MMU
+#define __put_user_8(x, ptr, err)				\
+do {								\
+	u32 __user *__ptr = (u32 __user *)(ptr);		\
+	u64 __x = (__typeof__((x)-(x)))(x);			\
+	uintptr_t __tmp;					\
+	__enable_user_access();					\
+	__asm__ __volatile__ (					\
+		"1:\n"						\
+		"	sw %z4, %2\n"				\
+		"2:\n"						\
+		"	sw %z5, %3\n"				\
+		"3:\n"						\
+		"	.section .fixup,\"ax\"\n"		\
+		"	.balign 4\n"				\
+		"4:\n"						\
+		"	li %0, %6\n"				\
+		"	jump 2b, %1\n"				\
+		"	.previous\n"				\
+		"	.section __ex_table,\"a\"\n"		\
+		"	.balign " RISCV_SZPTR "\n"			\
+		"	" RISCV_PTR " 1b, 4b\n"			\
+		"	" RISCV_PTR " 2b, 4b\n"			\
+		"	.previous"				\
+		: "+r" (err), "=r" (__tmp),			\
+			"=m" (__ptr[__LSW]),			\
+			"=m" (__ptr[__MSW])			\
+		: "rJ" (__x), "rJ" (__x >> 32), "i" (-EFAULT));	\
+	__disable_user_access();				\
+} while (0)
+#endif /* CONFIG_MMU */
+#endif /* CONFIG_64BIT */
+
+
+/**
+ * __put_user: - Write a simple value into user space, with less checking.
+ * @x:   Value to copy to user space.
+ * @ptr: Destination address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple value from kernel space to user
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and @x must be assignable
+ * to the result of dereferencing @ptr.
+ *
+ * Caller must check the pointer with access_ok() before calling this
+ * function.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ */
+#define __put_user(x, ptr)					\
+({								\
+	register long __pu_err = 0;				\
+	__typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
+	__chk_user_ptr(__gu_ptr);				\
+	switch (sizeof(*__gu_ptr)) {				\
+	case 1:							\
+		__put_user_asm("sb", (x), __gu_ptr, __pu_err);	\
+		break;						\
+	case 2:							\
+		__put_user_asm("sh", (x), __gu_ptr, __pu_err);	\
+		break;						\
+	case 4:							\
+		__put_user_asm("sw", (x), __gu_ptr, __pu_err);	\
+		break;						\
+	case 8:							\
+		__put_user_8((x), __gu_ptr, __pu_err);	\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
+	}							\
+	__pu_err;						\
+})
+
+/**
+ * put_user: - Write a simple value into user space.
+ * @x:   Value to copy to user space.
+ * @ptr: Destination address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple value from kernel space to user
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and @x must be assignable
+ * to the result of dereferencing @ptr.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ */
+#define put_user(x, ptr)					\
+({								\
+	__typeof__(*(ptr)) __user *__p = (ptr);			\
+	might_fault();						\
+	access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?		\
+		__put_user((x), __p) :				\
+		-EFAULT;					\
+})
+
+
+extern unsigned long __must_check __copy_user(void __user *to,
+	const void __user *from, unsigned long n);
+
+static inline unsigned long
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return __copy_user(to, from, n);
+}
+
+static inline unsigned long
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return __copy_user(to, from, n);
+}
+
+extern long strncpy_from_user(char *dest, const char __user *src, long count);
+
+extern long __must_check strlen_user(const char __user *str);
+extern long __must_check strnlen_user(const char __user *str, long n);
+
+extern
+unsigned long __must_check __clear_user(void __user *addr, unsigned long n);
+
+static inline
+unsigned long __must_check clear_user(void __user *to, unsigned long n)
+{
+	might_fault();
+	return access_ok(VERIFY_WRITE, to, n) ?
+		__clear_user(to, n) : n;
+}
+
+#endif /* _ASM_RISCV_UACCESS_H */
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
new file mode 100644
index 000000000000..aa6238791d3e
--- /dev/null
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -0,0 +1,55 @@
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
+ * Derived from arch/x86/include/asm/word-at-a-time.h
+ */
+
+#ifndef _ASM_RISCV_WORD_AT_A_TIME_H
+#define _ASM_RISCV_WORD_AT_A_TIME_H
+
+
+#include <linux/kernel.h>
+
+struct word_at_a_time {
+	const unsigned long one_bits, high_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+
+static inline unsigned long has_zero(unsigned long val,
+	unsigned long *bits, const struct word_at_a_time *c)
+{
+	unsigned long mask = ((val - c->one_bits) & ~val) & c->high_bits;
+	*bits = mask;
+	return mask;
+}
+
+static inline unsigned long prep_zero_mask(unsigned long val,
+	unsigned long bits, const struct word_at_a_time *c)
+{
+	return bits;
+}
+
+static inline unsigned long create_zero_mask(unsigned long bits)
+{
+	bits = (bits - 1) & ~bits;
+	return bits >> 7;
+}
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+	return fls64(mask) >> 3;
+}
+
+/* The mask we created is directly usable as a bytemask */
+#define zero_bytemask(mask) (mask)
+
+#endif /* _ASM_RISCV_WORD_AT_A_TIME_H */
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
new file mode 100644
index 000000000000..559aae781154
--- /dev/null
+++ b/arch/riscv/kernel/stacktrace.c
@@ -0,0 +1,177 @@
+/*
+ * Copyright (C) 2008 ARM Limited
+ * Copyright (C) 2014 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/export.h>
+#include <linux/kallsyms.h>
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
+#include <linux/stacktrace.h>
+
+#ifdef CONFIG_FRAME_POINTER
+
+struct stackframe {
+	unsigned long fp;
+	unsigned long ra;
+};
+
+static void notrace walk_stackframe(struct task_struct *task,
+	struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg)
+{
+	unsigned long fp, sp, pc;
+
+	if (regs) {
+		fp = GET_FP(regs);
+		sp = GET_USP(regs);
+		pc = GET_IP(regs);
+	} else if (task == NULL || task == current) {
+		const register unsigned long current_sp __asm__ ("sp");
+		fp = (unsigned long)__builtin_frame_address(0);
+		sp = current_sp;
+		pc = (unsigned long)walk_stackframe;
+	} else {
+		/* task blocked in __switch_to */
+		fp = task->thread.s[0];
+		sp = task->thread.sp;
+		pc = task->thread.ra;
+	}
+
+	for (;;) {
+		unsigned long low, high;
+		struct stackframe *frame;
+
+		if (unlikely(!__kernel_text_address(pc) || fn(pc, arg)))
+			break;
+
+		/* Validate frame pointer */
+		low = sp + sizeof(struct stackframe);
+		high = ALIGN(sp, THREAD_SIZE);
+		if (unlikely(fp < low || fp > high || fp & 0x7))
+			break;
+		/* Unwind stack frame */
+		frame = (struct stackframe *)fp - 1;
+		sp = fp;
+		fp = frame->fp;
+		pc = frame->ra - 0x4;
+	}
+}
+
+#else /* !CONFIG_FRAME_POINTER */
+
+static void notrace walk_stackframe(struct task_struct *task,
+	struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg)
+{
+	unsigned long sp, pc;
+	unsigned long *ksp;
+
+	if (regs) {
+		sp = GET_USP(regs);
+		pc = GET_IP(regs);
+	} else if (task == NULL || task == current) {
+		const register unsigned long current_sp __asm__ ("sp");
+		sp = current_sp;
+		pc = (unsigned long)walk_stackframe;
+	} else {
+		/* task blocked in __switch_to */
+		sp = task->thread.sp;
+		pc = task->thread.ra;
+	}
+
+	if (unlikely(sp & 0x7))
+		return;
+
+	ksp = (unsigned long *)sp;
+	while (!kstack_end(ksp)) {
+		if (__kernel_text_address(pc) && unlikely(fn(pc, arg)))
+			break;
+		pc = (*ksp++) - 0x4;
+	}
+}
+
+#endif /* CONFIG_FRAME_POINTER */
+
+
+static bool print_trace_address(unsigned long pc, void *arg)
+{
+	print_ip_sym(pc);
+	return false;
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	pr_cont("Call Trace:\n");
+	walk_stackframe(task, NULL, print_trace_address, NULL);
+}
+
+
+static bool save_wchan(unsigned long pc, void *arg)
+{
+	if (!in_sched_functions(pc)) {
+		unsigned long *p = arg;
+		*p = pc;
+		return true;
+	}
+	return false;
+}
+
+unsigned long get_wchan(struct task_struct *task)
+{
+	unsigned long pc = 0;
+
+	if (likely(task && task != current && task->state != TASK_RUNNING))
+		walk_stackframe(task, NULL, save_wchan, &pc);
+	return pc;
+}
+
+
+#ifdef CONFIG_STACKTRACE
+
+static bool __save_trace(unsigned long pc, void *arg, bool nosched)
+{
+	struct stack_trace *trace = arg;
+
+	if (unlikely(nosched && in_sched_functions(pc)))
+		return false;
+	if (unlikely(trace->skip > 0)) {
+		trace->skip--;
+		return false;
+	}
+
+	trace->entries[trace->nr_entries++] = pc;
+	return (trace->nr_entries >= trace->max_entries);
+}
+
+static bool save_trace(unsigned long pc, void *arg)
+{
+	return __save_trace(pc, arg, false);
+}
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ */
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	walk_stackframe(tsk, NULL, save_trace, trace);
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
+
+void save_stack_trace(struct stack_trace *trace)
+{
+	save_stack_trace_tsk(NULL, trace);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace);
+
+#endif /* CONFIG_STACKTRACE */
diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
new file mode 100644
index 000000000000..3605b55c68fa
--- /dev/null
+++ b/arch/riscv/lib/memcpy.S
@@ -0,0 +1,100 @@
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
+	/*
+	 * Round to nearest double word-aligned address
+	 * greater than or equal to start address
+	 */
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
index 000000000000..a790107cf4c9
--- /dev/null
+++ b/arch/riscv/lib/memset.S
@@ -0,0 +1,120 @@
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
+	/*
+	 * Round to nearest XLEN-aligned address
+	 * greater than or equal to start address
+	 */
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
index 000000000000..c36917fcd33d
--- /dev/null
+++ b/arch/riscv/lib/uaccess.S
@@ -0,0 +1,127 @@
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
+	/*
+	 * a3: terminal address of source region
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
+	/*
+	 * a3: terminal address of target region
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
index 000000000000..cb01ae5b181a
--- /dev/null
+++ b/arch/riscv/lib/udivdi3.S
@@ -0,0 +1,38 @@
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
-- 
2.13.0
