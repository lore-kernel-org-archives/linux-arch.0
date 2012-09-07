Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34699 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab2IGQ17 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:59 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 26/31] arm64: Miscellaneous library functions
Date: Fri,  7 Sep 2012 17:27:01 +0100
Message-ID: <1347035226-18649-27-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162701.2QuIoKF2E25n9nvzEKe5vzsZBoMpDOwfjIkzGERSl0w@z>

From: Marc Zyngier <marc.zyngier@arm.com>

This patch adds udelay, memory and bit operations together with the
ksyms exports.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/bitops.h  |   74 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/syscall.h |  101 ++++++++++++++++++++++++++++++++++=
++++
 arch/arm64/kernel/arm64ksyms.c   |   46 +++++++++++++++++
 arch/arm64/lib/Makefile          |    4 ++
 arch/arm64/lib/bitops.c          |   25 +++++++++
 arch/arm64/lib/clear_page.S      |   39 +++++++++++++++
 arch/arm64/lib/copy_page.S       |   46 +++++++++++++++++
 arch/arm64/lib/delay.c           |   55 ++++++++++++++++++++
 8 files changed, 390 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/bitops.h
 create mode 100644 arch/arm64/include/asm/syscall.h
 create mode 100644 arch/arm64/kernel/arm64ksyms.c
 create mode 100644 arch/arm64/lib/Makefile
 create mode 100644 arch/arm64/lib/bitops.c
 create mode 100644 arch/arm64/lib/clear_page.S
 create mode 100644 arch/arm64/lib/copy_page.S
 create mode 100644 arch/arm64/lib/delay.c

diff --git a/arch/arm64/include/asm/bitops.h b/arch/arm64/include/asm/bitop=
s.h
new file mode 100644
index 0000000..67df4d2
--- /dev/null
+++ b/arch/arm64/include/asm/bitops.h
@@ -0,0 +1,74 @@
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
+#ifndef __ASM_BITOPS_H
+#define __ASM_BITOPS_H
+
+#include <linux/compiler.h>
+
+#include <asm/barrier.h>
+
+/*
+ * clear_bit may not imply a memory barrier
+ */
+#ifndef smp_mb__before_clear_bit
+#define smp_mb__before_clear_bit()=09smp_mb()
+#define smp_mb__after_clear_bit()=09smp_mb()
+#endif
+
+/*
+ * Use compiler builtins for simple inline operations.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+=09return __builtin_ffsl(word) - 1;
+}
+
+static inline int ffs(int x)
+{
+=09return __builtin_ffs(x);
+}
+
+static inline unsigned long __fls(unsigned long word)
+{
+=09return BITS_PER_LONG - 1 - __builtin_clzl(word);
+}
+
+static inline int fls(int x)
+{
+=09return x ? sizeof(x) * BITS_PER_BYTE - __builtin_clz(x) : 0;
+}
+
+/*
+ * Mainly use the generic routines for now.
+ */
+#ifndef _LINUX_BITOPS_H
+#error only <linux/bitops.h> can be included directly
+#endif
+
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/find.h>
+
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
+
+#include <asm-generic/bitops/atomic.h>
+#include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+
+#endif /* __ASM_BITOPS_H */
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/sysc=
all.h
new file mode 100644
index 0000000..89c047f
--- /dev/null
+++ b/arch/arm64/include/asm/syscall.h
@@ -0,0 +1,101 @@
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
+#ifndef __ASM_SYSCALL_H
+#define __ASM_SYSCALL_H
+
+#include <linux/err.h>
+
+
+static inline int syscall_get_nr(struct task_struct *task,
+=09=09=09=09 struct pt_regs *regs)
+{
+=09return regs->syscallno;
+}
+
+static inline void syscall_rollback(struct task_struct *task,
+=09=09=09=09    struct pt_regs *regs)
+{
+=09regs->regs[0] =3D regs->orig_x0;
+}
+
+
+static inline long syscall_get_error(struct task_struct *task,
+=09=09=09=09     struct pt_regs *regs)
+{
+=09unsigned long error =3D regs->regs[0];
+=09return IS_ERR_VALUE(error) ? error : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+=09=09=09=09=09    struct pt_regs *regs)
+{
+=09return regs->regs[0];
+}
+
+static inline void syscall_set_return_value(struct task_struct *task,
+=09=09=09=09=09    struct pt_regs *regs,
+=09=09=09=09=09    int error, long val)
+{
+=09regs->regs[0] =3D (long) error ? error : val;
+}
+
+#define SYSCALL_MAX_ARGS 6
+
+static inline void syscall_get_arguments(struct task_struct *task,
+=09=09=09=09=09 struct pt_regs *regs,
+=09=09=09=09=09 unsigned int i, unsigned int n,
+=09=09=09=09=09 unsigned long *args)
+{
+=09if (i + n > SYSCALL_MAX_ARGS) {
+=09=09unsigned long *args_bad =3D args + SYSCALL_MAX_ARGS - i;
+=09=09unsigned int n_bad =3D n + i - SYSCALL_MAX_ARGS;
+=09=09pr_warning("%s called with max args %d, handling only %d\n",
+=09=09=09   __func__, i + n, SYSCALL_MAX_ARGS);
+=09=09memset(args_bad, 0, n_bad * sizeof(args[0]));
+=09}
+
+=09if (i =3D=3D 0) {
+=09=09args[0] =3D regs->orig_x0;
+=09=09args++;
+=09=09i++;
+=09=09n--;
+=09}
+
+=09memcpy(args, &regs->regs[i], n * sizeof(args[0]));
+}
+
+static inline void syscall_set_arguments(struct task_struct *task,
+=09=09=09=09=09 struct pt_regs *regs,
+=09=09=09=09=09 unsigned int i, unsigned int n,
+=09=09=09=09=09 const unsigned long *args)
+{
+=09if (i + n > SYSCALL_MAX_ARGS) {
+=09=09pr_warning("%s called with max args %d, handling only %d\n",
+=09=09=09   __func__, i + n, SYSCALL_MAX_ARGS);
+=09=09n =3D SYSCALL_MAX_ARGS - i;
+=09}
+
+=09if (i =3D=3D 0) {
+=09=09regs->orig_x0 =3D args[0];
+=09=09args++;
+=09=09i++;
+=09=09n--;
+=09}
+
+=09memcpy(&regs->regs[i], args, n * sizeof(args[0]));
+}
+
+#endif=09/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.=
c
new file mode 100644
index 0000000..cef3925
--- /dev/null
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -0,0 +1,46 @@
+/*
+ * Based on arch/arm/kernel/armksyms.c
+ *
+ * Copyright (C) 2000 Russell King
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
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/cryptohash.h>
+#include <linux/delay.h>
+#include <linux/in6.h>
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
+
+#include <asm/checksum.h>
+
+=09/* user mem (segment) */
+EXPORT_SYMBOL(__strnlen_user);
+EXPORT_SYMBOL(__strncpy_from_user);
+
+EXPORT_SYMBOL(copy_page);
+
+EXPORT_SYMBOL(__copy_from_user);
+EXPORT_SYMBOL(__copy_to_user);
+EXPORT_SYMBOL(__clear_user);
+
+=09/* bitops */
+EXPORT_SYMBOL(__atomic_hash);
+
+=09/* physical memory */
+EXPORT_SYMBOL(memstart_addr);
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
new file mode 100644
index 0000000..2fb7f60
--- /dev/null
+++ b/arch/arm64/lib/Makefile
@@ -0,0 +1,4 @@
+lib-y=09=09:=3D bitops.o delay.o=09=09=09=09=09\
+=09=09   strncpy_from_user.o strnlen_user.o clear_user.o=09\
+=09=09   copy_from_user.o copy_to_user.o copy_in_user.o=09\
+=09=09   copy_page.o clear_page.o
diff --git a/arch/arm64/lib/bitops.c b/arch/arm64/lib/bitops.c
new file mode 100644
index 0000000..aa4965e
--- /dev/null
+++ b/arch/arm64/lib/bitops.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2012 ARM Limited
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
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/atomic.h>
+
+#ifdef CONFIG_SMP
+arch_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned =3D {
+       [0 ... (ATOMIC_HASH_SIZE-1)]  =3D __ARCH_SPIN_LOCK_UNLOCKED
+};
+#endif
diff --git a/arch/arm64/lib/clear_page.S b/arch/arm64/lib/clear_page.S
new file mode 100644
index 0000000..ef08e90
--- /dev/null
+++ b/arch/arm64/lib/clear_page.S
@@ -0,0 +1,39 @@
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
+#include <linux/const.h>
+#include <asm/assembler.h>
+#include <asm/page.h>
+
+/*
+ * Clear page @dest
+ *
+ * Parameters:
+ *=09x0 - dest
+ */
+ENTRY(clear_page)
+=09mrs=09x1, dczid_el0
+=09and=09w1, w1, #0xf
+=09mov=09x2, #4
+=09lsl=09x1, x2, x1
+
+1:=09dc=09zva, x0
+=09add=09x0, x0, x1
+=09tst=09x0, #(PAGE_SIZE - 1)
+=09b.ne=091b
+=09ret
+ENDPROC(clear_page)
diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
new file mode 100644
index 0000000..512b9a7
--- /dev/null
+++ b/arch/arm64/lib/copy_page.S
@@ -0,0 +1,46 @@
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
+#include <linux/const.h>
+#include <asm/assembler.h>
+#include <asm/page.h>
+
+/*
+ * Copy a page from src to dest (both are page aligned)
+ *
+ * Parameters:
+ *=09x0 - dest
+ *=09x1 - src
+ */
+ENTRY(copy_page)
+=09/* Assume cache line size is 64 bytes. */
+=09prfm=09pldl1strm, [x1, #64]
+1:=09ldp=09x2, x3, [x1]
+=09ldp=09x4, x5, [x1, #16]
+=09ldp=09x6, x7, [x1, #32]
+=09ldp=09x8, x9, [x1, #48]
+=09add=09x1, x1, #64
+=09prfm=09pldl1strm, [x1, #64]
+=09stnp=09x2, x3, [x0]
+=09stnp=09x4, x5, [x0, #16]
+=09stnp=09x6, x7, [x0, #32]
+=09stnp=09x8, x9, [x0, #48]
+=09add=09x0, x0, #64
+=09tst=09x1, #(PAGE_SIZE - 1)
+=09b.ne=091b
+=09ret
+ENDPROC(copy_page)
diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
new file mode 100644
index 0000000..dad4ec9
--- /dev/null
+++ b/arch/arm64/lib/delay.c
@@ -0,0 +1,55 @@
+/*
+ * Delay loops based on the OpenRISC implementation.
+ *
+ * Copyright (C) 2012 ARM Limited
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
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/timex.h>
+
+void __delay(unsigned long cycles)
+{
+=09cycles_t start =3D get_cycles();
+
+=09while ((get_cycles() - start) < cycles)
+=09=09cpu_relax();
+}
+EXPORT_SYMBOL(__delay);
+
+inline void __const_udelay(unsigned long xloops)
+{
+=09unsigned long loops;
+
+=09loops =3D xloops * loops_per_jiffy * HZ;
+=09__delay(loops >> 32);
+}
+EXPORT_SYMBOL(__const_udelay);
+
+void __udelay(unsigned long usecs)
+{
+=09__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+}
+EXPORT_SYMBOL(__udelay);
+
+void __ndelay(unsigned long nsecs)
+{
+=09__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+}
+EXPORT_SYMBOL(__ndelay);

