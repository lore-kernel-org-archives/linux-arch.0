From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 10/35] nds32: Atomic operations
Date: Mon, 27 Nov 2017 20:27:57 +0800
Message-ID: <56a24fae3cec68f80c41eebd98fcceb9b137ac64.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>

This patch includes the atomic and futex operations. Many atomic operations use
the load-lock word(llw) and store-condition word(scw) operations.

Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
---
 arch/nds32/include/asm/futex.h    |  116 +++++++++++++++++++++++
 arch/nds32/include/asm/spinlock.h |  184 +++++++++++++++++++++++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 arch/nds32/include/asm/futex.h
 create mode 100644 arch/nds32/include/asm/spinlock.h

diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
new file mode 100644
index 0000000..5aa107c
--- /dev/null
+++ b/arch/nds32/include/asm/futex.h
@@ -0,0 +1,116 @@
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
+#ifndef __NDS32_FUTEX_H__
+#define __NDS32_FUTEX_H__
+
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <asm/errno.h>
+
+#define __futex_atomic_ex_table(err_reg)			\
+	"	.pushsection __ex_table,\"a\"\n"		\
+	"	.align	3\n"					\
+	"	.long	1b, 4f\n"				\
+	"	.long	2b, 4f\n"				\
+	"	.popsection\n"					\
+	"	.pushsection .fixup,\"ax\"\n"			\
+	"4:	move	%0, " err_reg "\n"			\
+	"	j	3b\n"					\
+	"	.popsection"
+
+#define __futex_atomic_op(insn, ret, oldval, tmp, uaddr, oparg)	\
+	smp_mb();						\
+	asm volatile(					\
+	"	movi	$ta, #0\n"				\
+	"1:	llw	%1, [%2+$ta]\n"				\
+	"	" insn "\n"					\
+	"2:	scw	%0, [%2+$ta]\n"				\
+	"	beqz	%0, 1b\n"				\
+	"	movi	%0, #0\n"				\
+	"3:\n"							\
+	__futex_atomic_ex_table("%4")				\
+	: "=&r" (ret), "=&r" (oldval)				\
+	: "r" (uaddr), "r" (oparg), "i" (-EFAULT)		\
+	: "cc", "memory")
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 * uval, u32 __user * uaddr,
+			      u32 oldval, u32 newval)
+{
+	int ret = 0;
+	u32 val, tmp, flags;
+
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	smp_mb();
+	asm volatile ("       movi    $ta, #0\n"
+		      "1:     llw     %1, [%6 + $ta]\n"
+		      "       sub     %3, %1, %4\n"
+		      "       cmovz   %2, %5, %3\n"
+		      "       cmovn   %2, %1, %3\n"
+		      "2:     scw     %2, [%6 + $ta]\n"
+		      "       beqz    %2, 1b\n"
+		      "3:\n                   " __futex_atomic_ex_table("%7")
+		      :"+&r"(ret), "=&r"(val), "=&r"(tmp), "=&r"(flags)
+		      :"r"(oldval), "r"(newval), "r"(uaddr), "i"(-EFAULT)
+		      :"$ta", "memory");
+	smp_mb();
+
+	*uval = val;
+	return ret;
+}
+
+static inline int
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
+{
+	int oldval = 0, ret;
+
+
+	pagefault_disable();
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op("move	%0, %3", ret, oldval, tmp, uaddr,
+				  oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("add	%0, %1, %3", ret, oldval, tmp, uaddr,
+				  oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("or	%0, %1, %3", ret, oldval, tmp, uaddr,
+				  oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("and	%0, %1, %3", ret, oldval, tmp, uaddr,
+				  ~oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xor	%0, %1, %3", ret, oldval, tmp, uaddr,
+				  oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	pagefault_enable();
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+#endif /* __NDS32_FUTEX_H__ */
diff --git a/arch/nds32/include/asm/spinlock.h b/arch/nds32/include/asm/spinlock.h
new file mode 100644
index 0000000..ca70437
--- /dev/null
+++ b/arch/nds32/include/asm/spinlock.h
@@ -0,0 +1,184 @@
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
+#ifndef __ASM_SPINLOCK_H
+#define __ASM_SPINLOCK_H
+
+#include <asm/processor.h>
+
+#define arch_spin_is_locked(x)		((x)->lock != 0)
+
+#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
+
+static inline void arch_spin_lock(arch_spinlock_t * lock)
+{
+	unsigned long tmp;
+
+	asm volatile(
+		"1:\n"
+		"llw	%0, [%1]\n"
+		"bnez	%0, 1b\n"
+		"movi	%0, #0x1\n"
+		"scw	%0, [%1]\n"
+		"beqz	%0, 1b\n"
+		:"=&r"(tmp)
+		:"r"(&lock->lock)
+		:"memory");
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t * lock)
+{
+	unsigned long ret, tmp;
+
+	asm volatile(
+		"1:\n"
+		"llw	%0, [%2]\n"
+		"movi	%1, #0x1\n"
+		"scw	%1, [%2]\n"
+		"beqz	%1, 1b\n"
+		:"=&r"(ret), "=&r"(tmp)
+		:"r"(&lock->lock)
+		:"memory");
+
+	return ret == 0;
+}
+
+static inline void arch_spin_unlock(arch_spinlock_t * lock)
+{
+	asm volatile(
+		"xor	$r15,  $r15, $r15\n"
+		"swi	$r15, [%0]\n"
+		:
+		:"r"(&lock->lock)
+		:"memory");
+}
+
+static inline void arch_write_lock(arch_rwlock_t * rw)
+{
+	unsigned long tmp;
+
+	asm volatile(
+		"1:\n"
+		"llw	%0, [%1]\n"
+		"bnez	%0, 1b\n"
+		"sethi	%0, 0x80000\n"
+		"scw	%0, [%1]\n"
+		"beqz	%0, 1b\n"
+		:"=&r"(tmp)
+		:"r"(&rw->lock)
+		:"memory");
+}
+
+static inline void arch_write_unlock(arch_rwlock_t * rw)
+{
+	asm volatile(
+		"xor	$r15, $r15, $r15\n"
+		"swi	$r15, [%0]\n"
+		:
+		:"r"(&rw->lock)
+		:"memory","$r15");
+}
+
+#define arch_write_can_lock(x)		((x)->lock == 0)
+static inline void arch_read_lock(arch_rwlock_t * rw)
+{
+	int tmp;
+
+	asm volatile(
+		"1:\n"
+		"llw	%0, [%1]\n"
+		"bltz	%0, 1b\n"
+		"addi	%0, %0, #1\n"
+		"scw	%0, [%1]\n"
+		"beqz	%0, 1b\n"
+		:"=&r"(tmp)
+		:"r"(&rw->lock)
+		:"memory");
+}
+
+static inline void arch_read_unlock(arch_rwlock_t * rw)
+{
+	unsigned long tmp;
+
+	asm volatile(
+		"1:\n"
+		"llw	%0, [%1]\n"
+		"addi	%0, %0, #-1\n"
+		"scw	%0, [%1]\n"
+		"beqz	%0, 1b\n"
+		:"=&r"(tmp)
+		:"r"(&rw->lock)
+		:"memory");
+}
+
+static inline int arch_read_trylock(arch_rwlock_t * rw)
+{
+	unsigned long ret, tmp;
+
+	asm volatile(
+		"movi	%0, #0x0\n"
+		"1:\n"
+		"llw	%1, [%2]\n"
+		"bltz	%1, 2f\n"
+		"addi	%1, %1, #1\n"
+		"scw	%1, [%2]\n"
+		"beqz	%1, 1b\n"
+		"movi	%0, #0x1\n"
+		"j	3f\n"
+		"2:\n"
+		"scw	%1, [%2]\n"
+		"3:\n"
+		:"=&r"(ret), "=&r"(tmp)
+		:"r"(&rw->lock)
+		:"memory");
+
+	return ret;
+}
+
+static inline int arch_write_trylock(arch_rwlock_t * rw)
+{
+	unsigned long ret, tmp;
+
+	asm volatile(
+		"movi	%0, #0x0\n"
+		"1:\n"
+		"llw	%1, [%2]\n"
+		"bnez	%1, 2f\n"
+		"sethi	%1, 0x80000\n"
+		"scw	%1, [%2]\n"
+		"beqz	%1, 1b\n"
+		"movi	%0, #0x1\n"
+		"j	3f\n"
+		"2:\n"
+		"scw	%1, [%2]\n"
+		"3:\n"
+		:"=&r"(ret), "=&r"(tmp)
+		:"r"(&rw->lock)
+		:"memory");
+
+	return ret;
+}
+
+#define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
+#define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
+
+#define arch_read_can_lock(x)	((x)->lock < 0x80000000)
+
+#define arch_spin_relax(lock)	cpu_relax()
+#define arch_read_relax(lock)	cpu_relax()
+#define arch_write_relax(lock)	cpu_relax()
+
+#endif /* __ASM_SPINLOCK_H */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
