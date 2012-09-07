Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34547 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab2IGQ15 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:57 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 20/31] arm64: User access library functions
Date: Fri,  7 Sep 2012 17:26:55 +0100
Message-ID: <1347035226-18649-21-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162655.BSExotUtDXj4aqjAZ1bk8U3e2sVQhKegPveU7EETb8k@z>

This patch add support for various user access functions. These
functions use the standard LDR/STR instructions and not the LDRT/STRT
variants in order to allow kernel addresses (after set_fs(KERNEL_DS)).

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/uaccess.h   |  297 ++++++++++++++++++++++++++++++++=
++++
 arch/arm64/lib/clear_user.S        |   58 +++++++
 arch/arm64/lib/copy_from_user.S    |   66 ++++++++
 arch/arm64/lib/copy_in_user.S      |   63 ++++++++
 arch/arm64/lib/copy_to_user.S      |   61 ++++++++
 arch/arm64/lib/strncpy_from_user.S |   50 ++++++
 arch/arm64/lib/strnlen_user.S      |   47 ++++++
 7 files changed, 642 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/uaccess.h
 create mode 100644 arch/arm64/lib/clear_user.S
 create mode 100644 arch/arm64/lib/copy_from_user.S
 create mode 100644 arch/arm64/lib/copy_in_user.S
 create mode 100644 arch/arm64/lib/copy_to_user.S
 create mode 100644 arch/arm64/lib/strncpy_from_user.S
 create mode 100644 arch/arm64/lib/strnlen_user.S

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uacc=
ess.h
new file mode 100644
index 0000000..008f848
--- /dev/null
+++ b/arch/arm64/include/asm/uaccess.h
@@ -0,0 +1,297 @@
+/*
+ * Based on arch/arm/include/asm/uaccess.h
+ *
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
+#ifndef __ASM_UACCESS_H
+#define __ASM_UACCESS_H
+
+/*
+ * User space memory access functions
+ */
+#include <linux/string.h>
+#include <linux/thread_info.h>
+
+#include <asm/ptrace.h>
+#include <asm/errno.h>
+#include <asm/memory.h>
+#include <asm/compiler.h>
+
+#define VERIFY_READ 0
+#define VERIFY_WRITE 1
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
+struct exception_table_entry
+{
+=09unsigned long insn, fixup;
+};
+
+extern int fixup_exception(struct pt_regs *regs);
+
+#define KERNEL_DS=09(-1UL)
+#define get_ds()=09(KERNEL_DS)
+
+#define USER_DS=09=09TASK_SIZE_64
+#define get_fs()=09(current_thread_info()->addr_limit)
+
+static inline void set_fs(mm_segment_t fs)
+{
+=09current_thread_info()->addr_limit =3D fs;
+}
+
+#define segment_eq(a,b)=09((a) =3D=3D (b))
+
+/*
+ * Return 1 if addr < current->addr_limit, 0 otherwise.
+ */
+#define __addr_ok(addr)=09=09=09=09=09=09=09\
+({=09=09=09=09=09=09=09=09=09\
+=09unsigned long flag;=09=09=09=09=09=09\
+=09asm("cmp %1, %0; cset %0, lo"=09=09=09=09=09\
+=09=09: "=3D&r" (flag)=09=09=09=09=09=09\
+=09=09: "r" (addr), "0" (current_thread_info()->addr_limit)=09\
+=09=09: "cc");=09=09=09=09=09=09\
+=09flag;=09=09=09=09=09=09=09=09\
+})
+
+/*
+ * Test whether a block of memory is a valid user space address.
+ * Returns 1 if the range is valid, 0 otherwise.
+ *
+ * This is equivalent to the following test:
+ * (u65)addr + (u65)size < (u65)current->addr_limit
+ *
+ * This needs 65-bit arithmetic.
+ */
+#define __range_ok(addr, size)=09=09=09=09=09=09\
+({=09=09=09=09=09=09=09=09=09\
+=09unsigned long flag, roksum;=09=09=09=09=09\
+=09__chk_user_ptr(addr);=09=09=09=09=09=09\
+=09asm("adds %1, %1, %3; ccmp %1, %4, #2, cc; cset %0, cc"=09=09\
+=09=09: "=3D&r" (flag), "=3D&r" (roksum)=09=09=09=09\
+=09=09: "1" (addr), "Ir" (size),=09=09=09=09\
+=09=09  "r" (current_thread_info()->addr_limit)=09=09\
+=09=09: "cc");=09=09=09=09=09=09\
+=09flag;=09=09=09=09=09=09=09=09\
+})
+
+#define access_ok(type, addr, size)=09__range_ok(addr, size)
+
+/*
+ * The "__xxx" versions of the user access functions do not verify the add=
ress
+ * space - it must have been done previously with a separate "access_ok()"
+ * call.
+ *
+ * The "__xxx_error" versions set the third argument to -EFAULT if an erro=
r
+ * occurs, and leave it unchanged on success.
+ */
+#define __get_user_asm(instr, reg, x, addr, err)=09=09=09\
+=09asm volatile(=09=09=09=09=09=09=09\
+=09"1:=09" instr "=09" reg "1, [%2]\n"=09=09=09\
+=09"2:\n"=09=09=09=09=09=09=09=09\
+=09"=09.section .fixup, \"ax\"\n"=09=09=09=09\
+=09"=09.align=092\n"=09=09=09=09=09=09\
+=09"3:=09mov=09%w0, %3\n"=09=09=09=09=09\
+=09"=09mov=09%1, #0\n"=09=09=09=09=09\
+=09"=09b=092b\n"=09=09=09=09=09=09\
+=09"=09.previous\n"=09=09=09=09=09=09\
+=09"=09.section __ex_table,\"a\"\n"=09=09=09=09\
+=09"=09.align=093\n"=09=09=09=09=09=09\
+=09"=09.quad=091b, 3b\n"=09=09=09=09=09\
+=09"=09.previous"=09=09=09=09=09=09\
+=09: "+r" (err), "=3D&r" (x)=09=09=09=09=09=09\
+=09: "r" (addr), "i" (-EFAULT))
+
+#define __get_user_err(x, ptr, err)=09=09=09=09=09\
+do {=09=09=09=09=09=09=09=09=09\
+=09unsigned long __gu_val;=09=09=09=09=09=09\
+=09__chk_user_ptr(ptr);=09=09=09=09=09=09\
+=09switch (sizeof(*(ptr))) {=09=09=09=09=09\
+=09case 1:=09=09=09=09=09=09=09=09\
+=09=09__get_user_asm("ldrb", "%w", __gu_val, (ptr), (err));=09\
+=09=09break;=09=09=09=09=09=09=09\
+=09case 2:=09=09=09=09=09=09=09=09\
+=09=09__get_user_asm("ldrh", "%w", __gu_val, (ptr), (err));=09\
+=09=09break;=09=09=09=09=09=09=09\
+=09case 4:=09=09=09=09=09=09=09=09\
+=09=09__get_user_asm("ldr", "%w", __gu_val, (ptr), (err));=09\
+=09=09break;=09=09=09=09=09=09=09\
+=09case 8:=09=09=09=09=09=09=09=09\
+=09=09__get_user_asm("ldr", "%",  __gu_val, (ptr), (err));=09\
+=09=09break;=09=09=09=09=09=09=09\
+=09default:=09=09=09=09=09=09=09\
+=09=09BUILD_BUG();=09=09=09=09=09=09\
+=09}=09=09=09=09=09=09=09=09\
+=09(x) =3D (__typeof__(*(ptr)))__gu_val;=09=09=09=09\
+} while (0)
+
+#define __get_user(x, ptr)=09=09=09=09=09=09\
+({=09=09=09=09=09=09=09=09=09\
+=09int __gu_err =3D 0;=09=09=09=09=09=09\
+=09__get_user_err((x), (ptr), __gu_err);=09=09=09=09\
+=09__gu_err;=09=09=09=09=09=09=09\
+})
+
+#define __get_user_error(x, ptr, err)=09=09=09=09=09\
+({=09=09=09=09=09=09=09=09=09\
+=09__get_user_err((x), (ptr), (err));=09=09=09=09\
+=09(void)0;=09=09=09=09=09=09=09\
+})
+
+#define __get_user_unaligned __get_user
+
+#define get_user(x, ptr)=09=09=09=09=09=09\
+({=09=09=09=09=09=09=09=09=09\
+=09might_sleep();=09=09=09=09=09=09=09\
+=09access_ok(VERIFY_READ, (ptr), sizeof(*(ptr))) ?=09=09=09\
+=09=09__get_user((x), (ptr)) :=09=09=09=09\
+=09=09((x) =3D 0, -EFAULT);=09=09=09=09=09\
+})
+
+#define __put_user_asm(instr, reg, x, addr, err)=09=09=09\
+=09asm volatile(=09=09=09=09=09=09=09\
+=09"1:=09" instr "=09" reg "1, [%2]\n"=09=09=09\
+=09"2:\n"=09=09=09=09=09=09=09=09\
+=09"=09.section .fixup,\"ax\"\n"=09=09=09=09\
+=09"=09.align=092\n"=09=09=09=09=09=09\
+=09"3:=09mov=09%w0, %3\n"=09=09=09=09=09\
+=09"=09b=092b\n"=09=09=09=09=09=09\
+=09"=09.previous\n"=09=09=09=09=09=09\
+=09"=09.section __ex_table,\"a\"\n"=09=09=09=09\
+=09"=09.align=093\n"=09=09=09=09=09=09\
+=09"=09.quad=091b, 3b\n"=09=09=09=09=09\
+=09"=09.previous"=09=09=09=09=09=09\
+=09: "+r" (err)=09=09=09=09=09=09=09\
+=09: "r" (x), "r" (addr), "i" (-EFAULT))
+
+#define __put_user_err(x, ptr, err)=09=09=09=09=09\
+do {=09=09=09=09=09=09=09=09=09\
+=09__typeof__(*(ptr)) __pu_val =3D (x);=09=09=09=09\
+=09__chk_user_ptr(ptr);=09=09=09=09=09=09\
+=09switch (sizeof(*(ptr))) {=09=09=09=09=09\
+=09case 1:=09=09=09=09=09=09=09=09\
+=09=09__put_user_asm("strb", "%w", __pu_val, (ptr), (err));=09\
+=09=09break;=09=09=09=09=09=09=09\
+=09case 2:=09=09=09=09=09=09=09=09\
+=09=09__put_user_asm("strh", "%w", __pu_val, (ptr), (err));=09\
+=09=09break;=09=09=09=09=09=09=09\
+=09case 4:=09=09=09=09=09=09=09=09\
+=09=09__put_user_asm("str",  "%w", __pu_val, (ptr), (err));=09\
+=09=09break;=09=09=09=09=09=09=09\
+=09case 8:=09=09=09=09=09=09=09=09\
+=09=09__put_user_asm("str",  "%", __pu_val, (ptr), (err));=09\
+=09=09break;=09=09=09=09=09=09=09\
+=09default:=09=09=09=09=09=09=09\
+=09=09BUILD_BUG();=09=09=09=09=09=09\
+=09}=09=09=09=09=09=09=09=09\
+} while (0)
+
+#define __put_user(x, ptr)=09=09=09=09=09=09\
+({=09=09=09=09=09=09=09=09=09\
+=09int __pu_err =3D 0;=09=09=09=09=09=09\
+=09__put_user_err((x), (ptr), __pu_err);=09=09=09=09\
+=09__pu_err;=09=09=09=09=09=09=09\
+})
+
+#define __put_user_error(x, ptr, err)=09=09=09=09=09\
+({=09=09=09=09=09=09=09=09=09\
+=09__put_user_err((x), (ptr), (err));=09=09=09=09\
+=09(void)0;=09=09=09=09=09=09=09\
+})
+
+#define __put_user_unaligned __put_user
+
+#define put_user(x, ptr)=09=09=09=09=09=09\
+({=09=09=09=09=09=09=09=09=09\
+=09might_sleep();=09=09=09=09=09=09=09\
+=09access_ok(VERIFY_WRITE, (ptr), sizeof(*(ptr))) ?=09=09\
+=09=09__put_user((x), (ptr)) :=09=09=09=09\
+=09=09-EFAULT;=09=09=09=09=09=09\
+})
+
+extern unsigned long __must_check __copy_from_user(void *to, const void __=
user *from, unsigned long n);
+extern unsigned long __must_check __copy_to_user(void __user *to, const vo=
id *from, unsigned long n);
+extern unsigned long __must_check __copy_in_user(void __user *to, const vo=
id __user *from, unsigned long n);
+extern unsigned long __must_check __clear_user(void __user *addr, unsigned=
 long n);
+
+extern unsigned long __must_check __strncpy_from_user(char *to, const char=
 __user *from, unsigned long count);
+extern unsigned long __must_check __strnlen_user(const char __user *s, lon=
g n);
+
+static inline unsigned long __must_check copy_from_user(void *to, const vo=
id __user *from, unsigned long n)
+{
+=09if (access_ok(VERIFY_READ, from, n))
+=09=09n =3D __copy_from_user(to, from, n);
+=09else /* security hole - plug it */
+=09=09memset(to, 0, n);
+=09return n;
+}
+
+static inline unsigned long __must_check copy_to_user(void __user *to, con=
st void *from, unsigned long n)
+{
+=09if (access_ok(VERIFY_WRITE, to, n))
+=09=09n =3D __copy_to_user(to, from, n);
+=09return n;
+}
+
+static inline unsigned long __must_check copy_in_user(void __user *to, con=
st void __user *from, unsigned long n)
+{
+=09if (access_ok(VERIFY_READ, from, n) && access_ok(VERIFY_WRITE, to, n))
+=09=09n =3D __copy_in_user(to, from, n);
+=09return n;
+}
+
+#define __copy_to_user_inatomic __copy_to_user
+#define __copy_from_user_inatomic __copy_from_user
+
+static inline unsigned long __must_check clear_user(void __user *to, unsig=
ned long n)
+{
+=09if (access_ok(VERIFY_WRITE, to, n))
+=09=09n =3D __clear_user(to, n);
+=09return n;
+}
+
+static inline long __must_check strncpy_from_user(char *dst, const char __=
user *src, long count)
+{
+=09long res =3D -EFAULT;
+=09if (access_ok(VERIFY_READ, src, 1))
+=09=09res =3D __strncpy_from_user(dst, src, count);
+=09return res;
+}
+
+#define strlen_user(s)=09strnlen_user(s, ~0UL >> 1)
+
+static inline long __must_check strnlen_user(const char __user *s, long n)
+{
+=09unsigned long res =3D 0;
+
+=09if (__addr_ok(s))
+=09=09res =3D __strnlen_user(s, n);
+
+=09return res;
+}
+
+#endif /* __ASM_UACCESS_H */
diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
new file mode 100644
index 0000000..6e0ed93
--- /dev/null
+++ b/arch/arm64/lib/clear_user.S
@@ -0,0 +1,58 @@
+/*
+ * Based on arch/arm/lib/clear_user.S
+ *
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
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+=09.text
+
+/* Prototype: int __clear_user(void *addr, size_t sz)
+ * Purpose  : clear some user memory
+ * Params   : addr - user memory address to clear
+ *          : sz   - number of bytes to clear
+ * Returns  : number of bytes NOT cleared
+ *
+ * Alignment fixed up by hardware.
+ */
+ENTRY(__clear_user)
+=09mov=09x2, x1=09=09=09// save the size for fixup return
+=09subs=09x1, x1, #8
+=09b.mi=092f
+1:
+USER(9f, str=09xzr, [x0], #8=09)
+=09subs=09x1, x1, #8
+=09b.pl=091b
+2:=09adds=09x1, x1, #4
+=09b.mi=093f
+USER(9f, str=09wzr, [x0], #4=09)
+=09sub=09x1, x1, #4
+3:=09adds=09x1, x1, #2
+=09b.mi=094f
+USER(9f, strh=09wzr, [x0], #2=09)
+=09sub=09x1, x1, #2
+4:=09adds=09x1, x1, #1
+=09b.mi=095f
+=09strb=09wzr, [x0]
+5:=09mov=09x0, #0
+=09ret
+ENDPROC(__clear_user)
+
+=09.section .fixup,"ax"
+=09.align=092
+9:=09mov=09x0, x2=09=09=09// return the original size
+=09ret
+=09.previous
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_use=
r.S
new file mode 100644
index 0000000..5e27add
--- /dev/null
+++ b/arch/arm64/lib/copy_from_user.S
@@ -0,0 +1,66 @@
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
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/*
+ * Copy from user space to a kernel buffer (alignment handled by the hardw=
are)
+ *
+ * Parameters:
+ *=09x0 - to
+ *=09x1 - from
+ *=09x2 - n
+ * Returns:
+ *=09x0 - bytes not copied
+ */
+ENTRY(__copy_from_user)
+=09add=09x4, x1, x2=09=09=09// upper user buffer boundary
+=09subs=09x2, x2, #8
+=09b.mi=092f
+1:
+USER(9f, ldr=09x3, [x1], #8=09)
+=09subs=09x2, x2, #8
+=09str=09x3, [x0], #8
+=09b.pl=091b
+2:=09adds=09x2, x2, #4
+=09b.mi=093f
+USER(9f, ldr=09w3, [x1], #4=09)
+=09sub=09x2, x2, #4
+=09str=09w3, [x0], #4
+3:=09adds=09x2, x2, #2
+=09b.mi=094f
+USER(9f, ldrh=09w3, [x1], #2=09)
+=09sub=09x2, x2, #2
+=09strh=09w3, [x0], #2
+4:=09adds=09x2, x2, #1
+=09b.mi=095f
+USER(9f, ldrb=09w3, [x1]=09)
+=09strb=09w3, [x0]
+5:=09mov=09x0, #0
+=09ret
+ENDPROC(__copy_from_user)
+
+=09.section .fixup,"ax"
+=09.align=092
+9:=09sub=09x2, x4, x1
+=09mov=09x3, x2
+10:=09strb=09wzr, [x0], #1=09=09=09// zero remaining buffer space
+=09subs=09x3, x3, #1
+=09b.ne=0910b
+=09mov=09x0, x2=09=09=09=09// bytes not copied
+=09ret
+=09.previous
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
new file mode 100644
index 0000000..84b6c9b
--- /dev/null
+++ b/arch/arm64/lib/copy_in_user.S
@@ -0,0 +1,63 @@
+/*
+ * Copy from user space to user space
+ *
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
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/*
+ * Copy from user space to user space (alignment handled by the hardware)
+ *
+ * Parameters:
+ *=09x0 - to
+ *=09x1 - from
+ *=09x2 - n
+ * Returns:
+ *=09x0 - bytes not copied
+ */
+ENTRY(__copy_in_user)
+=09add=09x4, x0, x2=09=09=09// upper user buffer boundary
+=09subs=09x2, x2, #8
+=09b.mi=092f
+1:
+USER(9f, ldr=09x3, [x1], #8=09)
+=09subs=09x2, x2, #8
+USER(9f, str=09x3, [x0], #8=09)
+=09b.pl=091b
+2:=09adds=09x2, x2, #4
+=09b.mi=093f
+USER(9f, ldr=09w3, [x1], #4=09)
+=09sub=09x2, x2, #4
+USER(9f, str=09w3, [x0], #4=09)
+3:=09adds=09x2, x2, #2
+=09b.mi=094f
+USER(9f, ldrh=09w3, [x1], #2=09)
+=09sub=09x2, x2, #2
+USER(9f, strh=09w3, [x0], #2=09)
+4:=09adds=09x2, x2, #1
+=09b.mi=095f
+USER(9f, ldrb=09w3, [x1]=09)
+USER(9f, strb=09w3, [x0]=09)
+5:=09mov=09x0, #0
+=09ret
+ENDPROC(__copy_in_user)
+
+=09.section .fixup,"ax"
+=09.align=092
+9:=09sub=09x0, x4, x0=09=09=09// bytes not copied
+=09ret
+=09.previous
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
new file mode 100644
index 0000000..a0aeeb9
--- /dev/null
+++ b/arch/arm64/lib/copy_to_user.S
@@ -0,0 +1,61 @@
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
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/*
+ * Copy to user space from a kernel buffer (alignment handled by the hardw=
are)
+ *
+ * Parameters:
+ *=09x0 - to
+ *=09x1 - from
+ *=09x2 - n
+ * Returns:
+ *=09x0 - bytes not copied
+ */
+ENTRY(__copy_to_user)
+=09add=09x4, x0, x2=09=09=09// upper user buffer boundary
+=09subs=09x2, x2, #8
+=09b.mi=092f
+1:
+=09ldr=09x3, [x1], #8
+=09subs=09x2, x2, #8
+USER(9f, str=09x3, [x0], #8=09)
+=09b.pl=091b
+2:=09adds=09x2, x2, #4
+=09b.mi=093f
+=09ldr=09w3, [x1], #4
+=09sub=09x2, x2, #4
+USER(9f, str=09w3, [x0], #4=09)
+3:=09adds=09x2, x2, #2
+=09b.mi=094f
+=09ldrh=09w3, [x1], #2
+=09sub=09x2, x2, #2
+USER(9f, strh=09w3, [x0], #2=09)
+4:=09adds=09x2, x2, #1
+=09b.mi=095f
+=09ldrb=09w3, [x1]
+USER(9f, strb=09w3, [x0]=09)
+5:=09mov=09x0, #0
+=09ret
+ENDPROC(__copy_to_user)
+
+=09.section .fixup,"ax"
+=09.align=092
+9:=09sub=09x0, x4, x0=09=09=09// bytes not copied
+=09ret
+=09.previous
diff --git a/arch/arm64/lib/strncpy_from_user.S b/arch/arm64/lib/strncpy_fr=
om_user.S
new file mode 100644
index 0000000..56e448a
--- /dev/null
+++ b/arch/arm64/lib/strncpy_from_user.S
@@ -0,0 +1,50 @@
+/*
+ * Based on arch/arm/lib/strncpy_from_user.S
+ *
+ * Copyright (C) 1995-2000 Russell King
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
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/errno.h>
+
+=09.text
+=09.align=095
+
+/*
+ * Copy a string from user space to kernel space.
+ *  x0 =3D dst, x1 =3D src, x2 =3D byte length
+ * returns the number of characters copied (strlen of copied string),
+ *  -EFAULT on exception, or "len" if we fill the whole buffer
+ */
+ENTRY(__strncpy_from_user)
+=09mov=09x4, x1
+1:=09subs=09x2, x2, #1
+=09bmi=092f
+USER(9f, ldrb=09w3, [x1], #1=09)
+=09strb=09w3, [x0], #1
+=09cbnz=09w3, 1b
+=09sub=09x1, x1, #1=09// take NUL character out of count
+2:=09sub=09x0, x1, x4
+=09ret
+ENDPROC(__strncpy_from_user)
+
+=09.section .fixup,"ax"
+=09.align=090
+9:=09strb=09wzr, [x0]=09// null terminate
+=09mov=09x0, #-EFAULT
+=09ret
+=09.previous
diff --git a/arch/arm64/lib/strnlen_user.S b/arch/arm64/lib/strnlen_user.S
new file mode 100644
index 0000000..7f7b176
--- /dev/null
+++ b/arch/arm64/lib/strnlen_user.S
@@ -0,0 +1,47 @@
+/*
+ * Based on arch/arm/lib/strnlen_user.S
+ *
+ * Copyright (C) 1995-2000 Russell King
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
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/errno.h>
+
+=09.text
+=09.align=095
+
+/* Prototype: unsigned long __strnlen_user(const char *str, long n)
+ * Purpose  : get length of a string in user memory
+ * Params   : str - address of string in user memory
+ * Returns  : length of string *including terminator*
+ *=09      or zero on exception, or n if too long
+ */
+ENTRY(__strnlen_user)
+=09mov=09x2, x0
+1:=09subs=09x1, x1, #1
+=09b.mi=092f
+USER(9f, ldrb=09w3, [x0], #1=09)
+=09cbnz=09w3, 1b
+2:=09sub=09x0, x0, x2
+=09ret
+ENDPROC(__strnlen_user)
+
+=09.section .fixup,"ax"
+=09.align=090
+9:=09mov=09x0, #0
+=09ret
+=09.previous

