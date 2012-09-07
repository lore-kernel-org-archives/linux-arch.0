Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34842 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab2IGQ2B (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:28:01 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 29/31] arm64: Miscellaneous header files
Date: Fri,  7 Sep 2012 17:27:04 +0100
Message-ID: <1347035226-18649-30-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162704.z-POEl_bczixf8kqdr-iBNHWcMHdAWU9a5cKKokbMMw@z>

This patch introduces a few AArch64-specific header files together with
Kbuild entries for generic headers.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/Kbuild        |   51 ++++++++++
 arch/arm64/include/asm/barrier.h     |   52 ++++++++++
 arch/arm64/include/asm/bitsperlong.h |   23 +++++
 arch/arm64/include/asm/byteorder.h   |   21 ++++
 arch/arm64/include/asm/cmpxchg.h     |  173 ++++++++++++++++++++++++++++++=
++++
 arch/arm64/include/asm/compiler.h    |   30 ++++++
 arch/arm64/include/asm/exception.h   |   23 +++++
 arch/arm64/include/asm/exec.h        |   23 +++++
 arch/arm64/include/asm/fcntl.h       |   29 ++++++
 arch/arm64/include/asm/system_misc.h |   54 +++++++++++
 10 files changed, 479 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/Kbuild
 create mode 100644 arch/arm64/include/asm/barrier.h
 create mode 100644 arch/arm64/include/asm/bitsperlong.h
 create mode 100644 arch/arm64/include/asm/byteorder.h
 create mode 100644 arch/arm64/include/asm/cmpxchg.h
 create mode 100644 arch/arm64/include/asm/compiler.h
 create mode 100644 arch/arm64/include/asm/exception.h
 create mode 100644 arch/arm64/include/asm/exec.h
 create mode 100644 arch/arm64/include/asm/fcntl.h
 create mode 100644 arch/arm64/include/asm/system_misc.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
new file mode 100644
index 0000000..35924a5
--- /dev/null
+++ b/arch/arm64/include/asm/Kbuild
@@ -0,0 +1,51 @@
+include include/asm-generic/Kbuild.asm
+
+header-y +=3D hwcap.h
+
+generic-y +=3D bug.h
+generic-y +=3D bugs.h
+generic-y +=3D checksum.h
+generic-y +=3D cputime.h
+generic-y +=3D current.h
+generic-y +=3D delay.h
+generic-y +=3D div64.h
+generic-y +=3D dma.h
+generic-y +=3D emergency-restart.h
+generic-y +=3D errno.h
+generic-y +=3D ftrace.h
+generic-y +=3D hw_irq.h
+generic-y +=3D ioctl.h
+generic-y +=3D ioctls.h
+generic-y +=3D ipcbuf.h
+generic-y +=3D irq_regs.h
+generic-y +=3D kdebug.h
+generic-y +=3D kmap_types.h
+generic-y +=3D linkage.h
+generic-y +=3D local.h
+generic-y +=3D local64.h
+generic-y +=3D mman.h
+generic-y +=3D msgbuf.h
+generic-y +=3D mutex.h
+generic-y +=3D pci.h
+generic-y +=3D percpu.h
+generic-y +=3D poll.h
+generic-y +=3D posix_types.h
+generic-y +=3D resource.h
+generic-y +=3D scatterlist.h
+generic-y +=3D sections.h
+generic-y +=3D segment.h
+generic-y +=3D sembuf.h
+generic-y +=3D serial.h
+generic-y +=3D shmbuf.h
+generic-y +=3D sizes.h
+generic-y +=3D socket.h
+generic-y +=3D sockios.h
+generic-y +=3D string.h
+generic-y +=3D switch_to.h
+generic-y +=3D swab.h
+generic-y +=3D termbits.h
+generic-y +=3D termios.h
+generic-y +=3D topology.h
+generic-y +=3D types.h
+generic-y +=3D unaligned.h
+generic-y +=3D user.h
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barr=
ier.h
new file mode 100644
index 0000000..d4a6333
--- /dev/null
+++ b/arch/arm64/include/asm/barrier.h
@@ -0,0 +1,52 @@
+/*
+ * Based on arch/arm/include/asm/barrier.h
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
+#ifndef __ASM_BARRIER_H
+#define __ASM_BARRIER_H
+
+#ifndef __ASSEMBLY__
+
+#define sev()=09=09asm volatile("sev" : : : "memory")
+#define wfe()=09=09asm volatile("wfe" : : : "memory")
+#define wfi()=09=09asm volatile("wfi" : : : "memory")
+
+#define isb()=09=09asm volatile("isb" : : : "memory")
+#define dsb()=09=09asm volatile("dsb sy" : : : "memory")
+
+#define mb()=09=09dsb()
+#define rmb()=09=09asm volatile("dsb ld" : : : "memory")
+#define wmb()=09=09asm volatile("dsb st" : : : "memory")
+
+#ifndef CONFIG_SMP
+#define smp_mb()=09barrier()
+#define smp_rmb()=09barrier()
+#define smp_wmb()=09barrier()
+#else
+#define smp_mb()=09asm volatile("dmb ish" : : : "memory")
+#define smp_rmb()=09asm volatile("dmb ishld" : : : "memory")
+#define smp_wmb()=09asm volatile("dmb ishst" : : : "memory")
+#endif
+
+#define read_barrier_depends()=09=09do { } while(0)
+#define smp_read_barrier_depends()=09do { } while(0)
+
+#define set_mb(var, value)=09do { var =3D value; smp_mb(); } while (0)
+#define nop()=09=09asm volatile("nop");
+
+#endif=09/* __ASSEMBLY__ */
+
+#endif=09/* __ASM_BARRIER_H */
diff --git a/arch/arm64/include/asm/bitsperlong.h b/arch/arm64/include/asm/=
bitsperlong.h
new file mode 100644
index 0000000..fce9c29
--- /dev/null
+++ b/arch/arm64/include/asm/bitsperlong.h
@@ -0,0 +1,23 @@
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
+#ifndef __ASM_BITSPERLONG_H
+#define __ASM_BITSPERLONG_H
+
+#define __BITS_PER_LONG 64
+
+#include <asm-generic/bitsperlong.h>
+
+#endif=09/* __ASM_BITSPERLONG_H */
diff --git a/arch/arm64/include/asm/byteorder.h b/arch/arm64/include/asm/by=
teorder.h
new file mode 100644
index 0000000..2b92046
--- /dev/null
+++ b/arch/arm64/include/asm/byteorder.h
@@ -0,0 +1,21 @@
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
+#ifndef __ASM_BYTEORDER_H
+#define __ASM_BYTEORDER_H
+
+#include <linux/byteorder/little_endian.h>
+
+#endif=09/* __ASM_BYTEORDER_H */
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpx=
chg.h
new file mode 100644
index 0000000..e0e65b0
--- /dev/null
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -0,0 +1,173 @@
+/*
+ * Based on arch/arm/include/asm/cmpxchg.h
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
+#ifndef __ASM_CMPXCHG_H
+#define __ASM_CMPXCHG_H
+
+#include <linux/bug.h>
+
+#include <asm/barrier.h>
+
+static inline unsigned long __xchg(unsigned long x, volatile void *ptr, in=
t size)
+{
+=09unsigned long ret, tmp;
+
+=09switch (size) {
+=09case 1:
+=09=09asm volatile("//=09__xchg1\n"
+=09=09"1:=09ldaxrb=09%w0, [%3]\n"
+=09=09"=09stlxrb=09%w1, %w2, [%3]\n"
+=09=09"=09cbnz=09%w1, 1b\n"
+=09=09=09: "=3D&r" (ret), "=3D&r" (tmp)
+=09=09=09: "r" (x), "r" (ptr)
+=09=09=09: "memory", "cc");
+=09=09break;
+=09case 2:
+=09=09asm volatile("//=09__xchg2\n"
+=09=09"1:=09ldaxrh=09%w0, [%3]\n"
+=09=09"=09stlxrh=09%w1, %w2, [%3]\n"
+=09=09"=09cbnz=09%w1, 1b\n"
+=09=09=09: "=3D&r" (ret), "=3D&r" (tmp)
+=09=09=09: "r" (x), "r" (ptr)
+=09=09=09: "memory", "cc");
+=09=09break;
+=09case 4:
+=09=09asm volatile("//=09__xchg4\n"
+=09=09"1:=09ldaxr=09%w0, [%3]\n"
+=09=09"=09stlxr=09%w1, %w2, [%3]\n"
+=09=09"=09cbnz=09%w1, 1b\n"
+=09=09=09: "=3D&r" (ret), "=3D&r" (tmp)
+=09=09=09: "r" (x), "r" (ptr)
+=09=09=09: "memory", "cc");
+=09=09break;
+=09case 8:
+=09=09asm volatile("//=09__xchg8\n"
+=09=09"1:=09ldaxr=09%0, [%3]\n"
+=09=09"=09stlxr=09%w1, %2, [%3]\n"
+=09=09"=09cbnz=09%w1, 1b\n"
+=09=09=09: "=3D&r" (ret), "=3D&r" (tmp)
+=09=09=09: "r" (x), "r" (ptr)
+=09=09=09: "memory", "cc");
+=09=09break;
+=09default:
+=09=09BUILD_BUG();
+=09}
+
+=09return ret;
+}
+
+#define xchg(ptr,x) \
+=09((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
+
+static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long ol=
d,
+=09=09=09=09      unsigned long new, int size)
+{
+=09unsigned long oldval =3D 0, res;
+
+=09switch (size) {
+=09case 1:
+=09=09do {
+=09=09=09asm volatile("// __cmpxchg1\n"
+=09=09=09"=09ldxrb=09%w1, [%2]\n"
+=09=09=09"=09mov=09%w0, #0\n"
+=09=09=09"=09cmp=09%w1, %w3\n"
+=09=09=09"=09b.ne=091f\n"
+=09=09=09"=09stxrb=09%w0, %w4, [%2]\n"
+=09=09=09"1:\n"
+=09=09=09=09: "=3D&r" (res), "=3D&r" (oldval)
+=09=09=09=09: "r" (ptr), "Ir" (old), "r" (new)
+=09=09=09=09: "cc");
+=09=09} while (res);
+=09=09break;
+
+=09case 2:
+=09=09do {
+=09=09=09asm volatile("// __cmpxchg2\n"
+=09=09=09"=09ldxrh=09%w1, [%2]\n"
+=09=09=09"=09mov=09%w0, #0\n"
+=09=09=09"=09cmp=09%w1, %w3\n"
+=09=09=09"=09b.ne=091f\n"
+=09=09=09"=09stxrh=09%w0, %w4, [%2]\n"
+=09=09=09"1:\n"
+=09=09=09=09: "=3D&r" (res), "=3D&r" (oldval)
+=09=09=09=09: "r" (ptr), "Ir" (old), "r" (new)
+=09=09=09=09: "memory", "cc");
+=09=09} while (res);
+=09=09break;
+
+=09case 4:
+=09=09do {
+=09=09=09asm volatile("// __cmpxchg4\n"
+=09=09=09"=09ldxr=09%w1, [%2]\n"
+=09=09=09"=09mov=09%w0, #0\n"
+=09=09=09"=09cmp=09%w1, %w3\n"
+=09=09=09"=09b.ne=091f\n"
+=09=09=09"=09stxr=09%w0, %w4, [%2]\n"
+=09=09=09"1:\n"
+=09=09=09=09: "=3D&r" (res), "=3D&r" (oldval)
+=09=09=09=09: "r" (ptr), "Ir" (old), "r" (new)
+=09=09=09=09: "cc");
+=09=09} while (res);
+=09=09break;
+
+=09case 8:
+=09=09do {
+=09=09=09asm volatile("// __cmpxchg8\n"
+=09=09=09"=09ldxr=09%1, [%2]\n"
+=09=09=09"=09mov=09%w0, #0\n"
+=09=09=09"=09cmp=09%1, %3\n"
+=09=09=09"=09b.ne=091f\n"
+=09=09=09"=09stxr=09%w0, %4, [%2]\n"
+=09=09=09"1:\n"
+=09=09=09=09: "=3D&r" (res), "=3D&r" (oldval)
+=09=09=09=09: "r" (ptr), "Ir" (old), "r" (new)
+=09=09=09=09: "cc");
+=09=09} while (res);
+=09=09break;
+
+=09default:
+=09=09BUILD_BUG();
+=09}
+
+=09return oldval;
+}
+
+static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long=
 old,
+=09=09=09=09=09 unsigned long new, int size)
+{
+=09unsigned long ret;
+
+=09smp_mb();
+=09ret =3D __cmpxchg(ptr, old, new, size);
+=09smp_mb();
+
+=09return ret;
+}
+
+#define cmpxchg(ptr,o,n)=09=09=09=09=09=09\
+=09((__typeof__(*(ptr)))__cmpxchg_mb((ptr),=09=09=09\
+=09=09=09=09=09  (unsigned long)(o),=09=09\
+=09=09=09=09=09  (unsigned long)(n),=09=09\
+=09=09=09=09=09  sizeof(*(ptr))))
+
+#define cmpxchg_local(ptr,o,n)=09=09=09=09=09=09\
+=09((__typeof__(*(ptr)))__cmpxchg((ptr),=09=09=09=09\
+=09=09=09=09       (unsigned long)(o),=09=09\
+=09=09=09=09       (unsigned long)(n),=09=09\
+=09=09=09=09       sizeof(*(ptr))))
+
+#endif=09/* __ASM_CMPXCHG_H */
diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/com=
piler.h
new file mode 100644
index 0000000..ee35fd0
--- /dev/null
+++ b/arch/arm64/include/asm/compiler.h
@@ -0,0 +1,30 @@
+/*
+ * Based on arch/arm/include/asm/compiler.h
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
+#ifndef __ASM_COMPILER_H
+#define __ASM_COMPILER_H
+
+/*
+ * This is used to ensure the compiler did actually allocate the register =
we
+ * asked it for some inline assembly sequences.  Apparently we can't trust=
 the
+ * compiler from one version to another so a bit of paranoia won't hurt.  =
This
+ * string is meant to be concatenated with the inline asm string and will
+ * cause compilation to stop on mismatch.  (for details, see gcc PR 15089)
+ */
+#define __asmeq(x, y)  ".ifnc " x "," y " ; .err ; .endif\n\t"
+
+#endif=09/* __ASM_COMPILER_H */
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/ex=
ception.h
new file mode 100644
index 0000000..ac63519
--- /dev/null
+++ b/arch/arm64/include/asm/exception.h
@@ -0,0 +1,23 @@
+/*
+ * Based on arch/arm/include/asm/exception.h
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
+#ifndef __ASM_EXCEPTION_H
+#define __ASM_EXCEPTION_H
+
+#define __exception=09__attribute__((section(".exception.text")))
+
+#endif=09/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/include/asm/exec.h b/arch/arm64/include/asm/exec.h
new file mode 100644
index 0000000..db0563c
--- /dev/null
+++ b/arch/arm64/include/asm/exec.h
@@ -0,0 +1,23 @@
+/*
+ * Based on arch/arm/include/asm/exec.h
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
+#ifndef __ASM_EXEC_H
+#define __ASM_EXEC_H
+
+extern unsigned long arch_align_stack(unsigned long sp);
+
+#endif=09/* __ASM_EXEC_H */
diff --git a/arch/arm64/include/asm/fcntl.h b/arch/arm64/include/asm/fcntl.=
h
new file mode 100644
index 0000000..cd2e630
--- /dev/null
+++ b/arch/arm64/include/asm/fcntl.h
@@ -0,0 +1,29 @@
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
+#ifndef __ASM_FCNTL_H
+#define __ASM_FCNTL_H
+
+/*
+ * Using our own definitions for AArch32 (compat) support.
+ */
+#define O_DIRECTORY=09 040000=09/* must be a directory */
+#define O_NOFOLLOW=090100000=09/* don't follow links */
+#define O_DIRECT=090200000=09/* direct disk access hint - currently ignore=
d */
+#define O_LARGEFILE=090400000
+
+#include <asm-generic/fcntl.h>
+
+#endif
diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/=
system_misc.h
new file mode 100644
index 0000000..95e4072
--- /dev/null
+++ b/arch/arm64/include/asm/system_misc.h
@@ -0,0 +1,54 @@
+/*
+ * Based on arch/arm/include/asm/system_misc.h
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
+#ifndef __ASM_SYSTEM_MISC_H
+#define __ASM_SYSTEM_MISC_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <linux/irqflags.h>
+
+struct pt_regs;
+
+void die(const char *msg, struct pt_regs *regs, int err);
+
+struct siginfo;
+void arm64_notify_die(const char *str, struct pt_regs *regs,
+=09=09      struct siginfo *info, int err);
+
+void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
+=09=09=09=09=09     struct pt_regs *),
+=09=09=09   int sig, int code, const char *name);
+
+struct mm_struct;
+extern void show_pte(struct mm_struct *mm, unsigned long addr);
+extern void __show_regs(struct pt_regs *);
+
+void soft_restart(unsigned long);
+extern void (*pm_restart)(const char *cmd);
+
+#define UDBG_UNDEFINED=09(1 << 0)
+#define UDBG_SYSCALL=09(1 << 1)
+#define UDBG_BADABORT=09(1 << 2)
+#define UDBG_SEGV=09(1 << 3)
+#define UDBG_BUS=09(1 << 4)
+
+#endif=09/* __ASSEMBLY__ */
+
+#endif=09/* __ASM_SYSTEM_MISC_H */

