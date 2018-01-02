From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v5 14/39] nds32: Atomic operations
Date: Tue,  2 Jan 2018 16:24:46 +0800
Message-ID: <7f2b842dc182f3c042897cb6faf427ce0537a805.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1514874857.git.green.hu@gmail.com>
In-Reply-To: <cover.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch includes the atomic and futex operations. Many atomic operations use
the load-lock word(llw) and store-condition word(scw) operations.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/barrier.h |   15 ++++++
 arch/nds32/include/asm/futex.h   |  103 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 arch/nds32/include/asm/barrier.h
 create mode 100644 arch/nds32/include/asm/futex.h

diff --git a/arch/nds32/include/asm/barrier.h b/arch/nds32/include/asm/barrier.h
new file mode 100644
index 0000000..faafc37
--- /dev/null
+++ b/arch/nds32/include/asm/barrier.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __NDS32_ASM_BARRIER_H
+#define __NDS32_ASM_BARRIER_H
+
+#ifndef __ASSEMBLY__
+#define mb()		asm volatile("msync all":::"memory")
+#define rmb()		asm volatile("msync all":::"memory")
+#define wmb()		asm volatile("msync store":::"memory")
+#include <asm-generic/barrier.h>
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* __NDS32_ASM_BARRIER_H */
diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
new file mode 100644
index 0000000..eab5e84
--- /dev/null
+++ b/arch/nds32/include/asm/futex.h
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
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
-- 
1.7.9.5
