Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2on0097.outbound.protection.outlook.com ([65.55.169.97]:7328
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755217AbaJHJaS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Oct 2014 05:30:18 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v4 01/29] asm-generic: add generic futex for !CONFIG_SMP
Date: Wed, 8 Oct 2014 17:29:27 +0800
Message-ID: <1412760595-3935-2-git-send-email-lftan@altera.com>
In-Reply-To: <1412760595-3935-1-git-send-email-lftan@altera.com>
References: <1412760595-3935-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20141008092927.eF9opm4ieyMcJZiciw_POdbeW_p3uXIdZ8yCi-ltSK0@z>

Follow m68k futex implementation for !CONFIG_SMP.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/futex.h |   82 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 01f227e..f5650a5 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -5,6 +5,87 @@
 #include <linux/uaccess.h>
 #include <asm/errno.h>
 
+#ifndef CONFIG_SMP
+static inline int
+futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval, ret;
+	u32 tmp;
+
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	pagefault_disable();	/* implies preempt_disable() */
+
+	ret = -EFAULT;
+	if (unlikely(get_user(oldval, uaddr) != 0))
+		goto out_pagefault_enable;
+
+	ret = 0;
+	tmp = oldval;
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		tmp = oparg;
+		break;
+	case FUTEX_OP_ADD:
+		tmp += oparg;
+		break;
+	case FUTEX_OP_OR:
+		tmp |= oparg;
+		break;
+	case FUTEX_OP_ANDN:
+		tmp &= ~oparg;
+		break;
+	case FUTEX_OP_XOR:
+		tmp ^= oparg;
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	if (ret == 0 && unlikely(put_user(tmp, uaddr) != 0))
+		ret = -EFAULT;
+
+out_pagefault_enable:
+	pagefault_enable();	/* subsumes preempt_enable() */
+
+	if (ret == 0) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+			      u32 oldval, u32 newval)
+{
+	u32 val;
+
+	if (unlikely(get_user(val, uaddr) != 0))
+		return -EFAULT;
+
+	if (val == oldval && unlikely(put_user(newval, uaddr) != 0))
+		return -EFAULT;
+
+	*uval = val;
+
+	return 0;
+}
+
+#else
 static inline int
 futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
 {
@@ -54,4 +135,5 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	return -ENOSYS;
 }
 
+#endif /* CONFIG_SMP */
 #endif
-- 
1.7.7.4

