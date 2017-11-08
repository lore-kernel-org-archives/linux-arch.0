From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH 11/31] nds32: Atomic operations
Date: Wed,  8 Nov 2017 13:54:59 +0800
Message-ID: <b13577a068afb71e87e21598f59733f127814f37.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/futex.h    |  116 ++++++++++++++++++++++++
 arch/nds32/include/asm/spinlock.h |  178 +++++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+)
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
index 0000000..dd5fc71
--- /dev/null
+++ b/arch/nds32/include/asm/spinlock.h
@@ -0,0 +1,178 @@
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
+#define arch_spin_unlock_wait(lock) \
+	do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
+
+#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
+
+static inline void arch_spin_lock(arch_spinlock_t * lock)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__("1:\n"
+			     "\tllw\t%0, [%1]\n"
+			     "\tbnez\t%0, 1b\n"
+			     "\tmovi\t%0, #0x1\n"
+			     "\tscw\t%0, [%1]\n"
+			     "\tbeqz\t%0, 1b\n"
+			     :"=&r"(tmp)
+			     :"r"(&lock->lock)
+			     :"memory");
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t * lock)
+{
+	unsigned long ret, tmp;
+
+	__asm__ __volatile__("1:\n"
+			     "\tllw\t%0, [%2]\n"
+			     "\tmovi\t%1, #0x1\n"
+			     "\tscw\t%1, [%2]\n"
+			     "\tbeqz\t%1, 1b\n"
+			     :"=&r"(ret), "=&r"(tmp)
+			     :"r"(&lock->lock)
+			     :"memory");
+
+	return ret == 0;
+}
+
+static inline void arch_spin_unlock(arch_spinlock_t * lock)
+{
+	__asm__ __volatile__("xor\t$r15,  $r15, $r15\n"
+			     "\tswi\t$r15, [%0]\n"
+			     :
+			     :"r"(&lock->lock)
+			     :"memory");
+}
+
+static inline void arch_write_lock(arch_rwlock_t * rw)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__("1:\n"
+			     "\tllw\t%0, [%1]\n"
+			     "\tbnez\t%0, 1b\n"
+			     "\tsethi\t%0, 0x80000\n"
+			     "\tscw\t%0, [%1]\n"
+			     "\tbeqz\t%0, 1b\n"
+			     :"=&r"(tmp)
+			     :"r"(&rw->lock)
+			     :"memory");
+}
+
+static inline void arch_write_unlock(arch_rwlock_t * rw)
+{
+	__asm__ __volatile__("xor\t$r15, $r15, $r15\n"
+			     "\tswi\t$r15, [%0]\n"
+			     :
+			     :"r"(&rw->lock)
+			     :"memory","$r15");
+}
+
+#define arch_write_can_lock(x)		((x)->lock == 0)
+static inline void arch_read_lock(arch_rwlock_t * rw)
+{
+	int tmp;
+
+	__asm__ __volatile__("1:\n"
+			     "\tllw\t%0, [%1]\n"
+			     "\tbltz\t%0, 1b\n"
+			     "\taddi\t%0, %0, #1\n"
+			     "\tscw\t%0, [%1]\n"
+			     "\tbeqz\t%0, 1b\n"
+			     :"=&r"(tmp)
+			     :"r"(&rw->lock)
+			     :"memory");
+}
+
+static inline void arch_read_unlock(arch_rwlock_t * rw)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__("1:\n"
+			     "\tllw\t%0, [%1]\n"
+			     "\taddi\t%0, %0, #-1\n"
+			     "\tscw\t%0, [%1]\n"
+			     "\tbeqz\t%0, 1b\n"
+			     :"=&r"(tmp)
+			     :"r"(&rw->lock)
+			     :"memory");
+}
+
+static inline int arch_read_trylock(arch_rwlock_t * rw)
+{
+	unsigned long ret, tmp;
+
+	__asm__ __volatile__("\tmovi\t%0, #0x0\n"
+			     "1:\n"
+			     "\tllw\t%1, [%2]\n"
+			     "\tbltz\t%1, 2f\n"
+			     "\taddi\t%1, %1, #1\n"
+			     "\tscw\t%1, [%2]\n"
+			     "\tbeqz\t%1, 1b\n"
+			     "\tmovi\t%0, #0x1\n"
+			     "\tj\t3f\n"
+			     "2:\n"
+			     "\tscw\t%1, [%2]\n"
+			     "3:\n"
+			     :"=&r"(ret), "=&r"(tmp)
+			     :"r"(&rw->lock)
+			     :"memory");
+
+	return ret;
+}
+
+static inline int arch_write_trylock(arch_rwlock_t * rw)
+{
+	unsigned long ret, tmp;
+
+	__asm__ __volatile__("\tmovi\t%0, #0x0\n"
+			     "1:\n"
+			     "\tllw\t%1, [%2]\n"
+			     "\tbnez\t%1, 2f\n"
+			     "\tsethi\t%1, 0x80000\n"
+			     "\tscw\t%1, [%2]\n"
+			     "\tbeqz\t%1, 1b\n"
+			     "\tmovi\t%0, #0x1\n"
+			     "\tj\t3f\n"
+			     "2:\n"
+			     "\tscw\t%1, [%2]\n"
+			     "3:\n"
+			     :"=&r"(ret), "=&r"(tmp)
+			     :"r"(&rw->lock)
+			     :"memory");
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
