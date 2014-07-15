Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2lp0210.outbound.protection.outlook.com ([207.46.163.210]:14570
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758396AbaGOIsp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jul 2014 04:48:45 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v2 21/29] nios2: Futex operations
Date: Tue, 15 Jul 2014 16:45:48 +0800
Message-ID: <1405413956-2772-22-git-send-email-lftan@altera.com>
In-Reply-To: <1405413956-2772-1-git-send-email-lftan@altera.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140715084548.VyB4clT0Tgi2wRMkUQvFj4p4nFUZY27Q_SO846KcDlo@z>

This patch introduces the futex operation.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/nios2/include/asm/futex-irq.h | 130 +++++++++++++++++++++++++++++++++++++
 arch/nios2/include/asm/futex.h     | 110 +++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 arch/nios2/include/asm/futex-irq.h
 create mode 100644 arch/nios2/include/asm/futex.h

diff --git a/arch/nios2/include/asm/futex-irq.h b/arch/nios2/include/asm/futex-irq.h
new file mode 100644
index 0000000..ade9296
--- /dev/null
+++ b/arch/nios2/include/asm/futex-irq.h
@@ -0,0 +1,130 @@
+/*
+ *  Copyright (C) 2013 Altera Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Based on asm/futex.h from sh platform.
+ *
+ */
+
+#ifndef __ASM_NIOS2_FUTEX_IRQ_H
+#define __ASM_NIOS2_FUTEX_IRQ_H
+
+
+static inline int atomic_futex_op_xchg_set(int oparg, u32 __user *uaddr,
+					   int *oldval)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+
+	ret = get_user(*oldval, uaddr);
+	if (!ret)
+		ret = put_user(oparg, uaddr);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static inline int atomic_futex_op_xchg_add(int oparg, u32 __user *uaddr,
+					   int *oldval)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+
+	ret = get_user(*oldval, uaddr);
+	if (!ret)
+		ret = put_user(*oldval + oparg, uaddr);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static inline int atomic_futex_op_xchg_or(int oparg, u32 __user *uaddr,
+					  int *oldval)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+
+	ret = get_user(*oldval, uaddr);
+	if (!ret)
+		ret = put_user(*oldval | oparg, uaddr);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static inline int atomic_futex_op_xchg_and(int oparg, u32 __user *uaddr,
+					   int *oldval)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+
+	ret = get_user(*oldval, uaddr);
+	if (!ret)
+		ret = put_user(*oldval & oparg, uaddr);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static inline int atomic_futex_op_xchg_xor(int oparg, u32 __user *uaddr,
+					   int *oldval)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+
+	ret = get_user(*oldval, uaddr);
+	if (!ret)
+		ret = put_user(*oldval ^ oparg, uaddr);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static inline int atomic_futex_op_cmpxchg_inatomic(u32 *uval,
+						u32 __user *uaddr,
+						u32 oldval, u32 newval)
+{
+	unsigned long flags;
+	int ret;
+	u32 prev = 0;
+
+	local_irq_save(flags);
+
+	ret = get_user(prev, uaddr);
+	if (!ret && oldval == prev)
+		ret = put_user(newval, uaddr);
+
+	local_irq_restore(flags);
+
+	*uval = prev;
+	return ret;
+}
+
+#endif /* __ASM_NIOS2_FUTEX_IRQ_H */
diff --git a/arch/nios2/include/asm/futex.h b/arch/nios2/include/asm/futex.h
new file mode 100644
index 0000000..52b2fa9
--- /dev/null
+++ b/arch/nios2/include/asm/futex.h
@@ -0,0 +1,110 @@
+/*
+ *  Copyright (C) 2013 Altera Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Based on asm/futex.h from sh platform.
+ *
+ */
+
+#ifndef __ASM_NIOS2_FUTEX_H
+#define __ASM_NIOS2_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <linux/errno.h>
+
+#include <asm/futex-irq.h>
+
+static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret;
+
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		ret = atomic_futex_op_xchg_set(oparg, uaddr, &oldval);
+		break;
+	case FUTEX_OP_ADD:
+		ret = atomic_futex_op_xchg_add(oparg, uaddr, &oldval);
+		break;
+	case FUTEX_OP_OR:
+		ret = atomic_futex_op_xchg_or(oparg, uaddr, &oldval);
+		break;
+	case FUTEX_OP_ANDN:
+		ret = atomic_futex_op_xchg_and(~oparg, uaddr, &oldval);
+		break;
+	case FUTEX_OP_XOR:
+		ret = atomic_futex_op_xchg_xor(oparg, uaddr, &oldval);
+		break;
+	default:
+		ret = -ENOSYS;
+		break;
+	}
+
+	pagefault_enable();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ:
+			ret = (oldval == cmparg);
+			break;
+		case FUTEX_OP_CMP_NE:
+			ret = (oldval != cmparg);
+			break;
+		case FUTEX_OP_CMP_LT:
+			ret = (oldval < cmparg);
+			break;
+		case FUTEX_OP_CMP_GE:
+			ret = (oldval >= cmparg);
+			break;
+		case FUTEX_OP_CMP_LE:
+			ret = (oldval <= cmparg);
+			break;
+		case FUTEX_OP_CMP_GT:
+			ret = (oldval > cmparg);
+			break;
+		default:
+			ret = -ENOSYS;
+		}
+	}
+
+	return ret;
+}
+
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+				u32 oldval, u32 newval)
+{
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	return atomic_futex_op_cmpxchg_inatomic(uval, uaddr, oldval, newval);
+}
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_NIOS2_FUTEX_H */
-- 
1.8.2.1

