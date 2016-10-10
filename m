Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:49976 "EHLO
        6.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbcJJAK0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Oct 2016 20:10:26 -0400
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 64FE43A642
        for <linux-arch@vger.kernel.org>; Mon, 10 Oct 2016 02:04:16 +0200 (CEST)
From: Joel Porquet <joel@porquet.org>
Subject: [PATCH 1/2] asm-generic/futex.h: code refactoring
Date: Sun,  9 Oct 2016 17:03:07 -0700
Message-ID: <20161010000308.13212-2-joel@porquet.org>
In-Reply-To: <20161010000308.13212-1-joel@porquet.org>
References: <20161010000308.13212-1-joel@porquet.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joel Porquet <joel@porquet.org>
Message-ID: <20161010000307.CKcAChTNqUJgQ--H1l2mUKQXVB09ZtCnrRpcrjLAZXI@z>

The generic header "asm-generic/futex.h" defines the implementations of
atomic functions "futex_atomic_op_inuser()" and
"futex_atomic_cmpxchg_inatomic()". Currently, each of these functions is
actually defined twice: once for uniprocessor machines and once for
multiprocessor machines.

However, these {smp,!smp} implementations, especially for
"futex_atomic_op_inuser()", have some code in common that could be
refactored. Furthermore, most the arch ports usually redefine their own
"asm/futex.h" header completely, instead of using the generic header
even though a good chunk of the code is shared (once again, especially
for 'futex_atomic_op_inuser()').

This patch refactors the uniprocessor and multiprocessor implementations
of both functions into a single implementation, making the
machine-specific part a customizable macro.

As a (hopefully good) side-effect, this makes it possible for arch ports
to start including this generic header, instead of redefining it
completely, and only overload the macros with arch-specific routines.

Signed-off-by: Joel Porquet <joel@porquet.org>
---
 include/asm-generic/futex.h | 219 ++++++++++++++++++++++----------------------
 1 file changed, 112 insertions(+), 107 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index bf2d34c..a72b36b 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -6,12 +6,114 @@
 #include <asm/errno.h>
 
 #ifndef CONFIG_SMP
+
 /*
- * The following implementation only for uniprocessor machines.
- * It relies on preempt_disable() ensuring mutual exclusion.
- *
+ * The following implementations are for uniprocessor machines.
+ * They rely on preempt_disable() to ensure mutual exclusion.
  */
 
+#ifndef __futex_atomic_op_inuser
+#define __futex_atomic_op_inuser(op, oldval, uaddr, oparg)	\
+({								\
+	int __ret;						\
+	u32 tmp;						\
+								\
+	preempt_disable();					\
+	pagefault_disable();					\
+								\
+	__ret = -EFAULT;					\
+	if (unlikely(get_user(oldval, uaddr) != 0))		\
+		goto out_pagefault_enable;			\
+								\
+	__ret = 0;						\
+	tmp = oldval;						\
+								\
+	switch (op) {						\
+	case FUTEX_OP_SET:					\
+		tmp = oparg;					\
+		break;						\
+	case FUTEX_OP_ADD:					\
+		tmp += oparg;					\
+		break;						\
+	case FUTEX_OP_OR:					\
+		tmp |= oparg;					\
+		break;						\
+	case FUTEX_OP_ANDN:					\
+		tmp &= ~oparg;					\
+		break;						\
+	case FUTEX_OP_XOR:					\
+		tmp ^= oparg;					\
+		break;						\
+	default:						\
+		__ret = -ENOSYS;				\
+	}							\
+								\
+	if (__ret == 0 && unlikely(put_user(tmp, uaddr) != 0))	\
+		__ret = -EFAULT;				\
+								\
+out_pagefault_enable:						\
+	pagefault_enable();					\
+	preempt_enable();					\
+								\
+	__ret;							\
+})
+#endif
+
+#ifndef __futex_atomic_cmpxchg_inatomic
+#define __futex_atomic_cmpxchg_inatomic(uval, uaddr, oldval, newval)	\
+({									\
+	int __ret = 0;							\
+	u32 tmp;							\
+									\
+	preempt_disable();						\
+	if (unlikely(get_user(tmp, uaddr) != 0))			\
+		__ret = -EFAULT;					\
+									\
+	if (__ret == 0 && tmp == oldval &&				\
+			unlikely(put_user(newval, uaddr) != 0))		\
+		__ret = -EFAULT;					\
+									\
+	*uval = tmp;							\
+	preempt_enable();						\
+									\
+	__ret;								\
+})
+#endif
+
+#else
+
+/*
+ * For multiprocessor machines, these macro should be overloaded with
+ * implementations based on arch-specific atomic instructions to ensure proper
+ * mutual exclusion
+ */
+#ifndef __futex_atomic_op_inuser
+#define __futex_atomic_op_inuser(op, oldval, uaddr, oparg)	\
+({								\
+	int __ret;						\
+	switch (op) {						\
+	case FUTEX_OP_SET:					\
+	case FUTEX_OP_ADD:					\
+	case FUTEX_OP_OR:					\
+	case FUTEX_OP_ANDN:					\
+	case FUTEX_OP_XOR:					\
+	default:						\
+		__ret = -ENOSYS;				\
+	}							\
+	__ret;							\
+})
+#endif
+
+#ifndef __futex_atomic_cmpxchg_inatomic
+#define __futex_atomic_cmpxchg_inatomic(uval, uaddr, oldval, newval)	\
+({									\
+	int __ret = -ENOSYS;						\
+	__ret;								\
+})
+#endif
+
+#endif
+
 /**
  * futex_atomic_op_inuser() - Atomic arithmetic operation with constant
  *			  argument and comparison of the previous
@@ -31,48 +133,15 @@ futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval, ret;
-	u32 tmp;
+	int oldval = 0, ret;
 
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
-	preempt_disable();
-	pagefault_disable();
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+		return -EFAULT;
 
-	ret = -EFAULT;
-	if (unlikely(get_user(oldval, uaddr) != 0))
-		goto out_pagefault_enable;
-
-	ret = 0;
-	tmp = oldval;
-
-	switch (op) {
-	case FUTEX_OP_SET:
-		tmp = oparg;
-		break;
-	case FUTEX_OP_ADD:
-		tmp += oparg;
-		break;
-	case FUTEX_OP_OR:
-		tmp |= oparg;
-		break;
-	case FUTEX_OP_ANDN:
-		tmp &= ~oparg;
-		break;
-	case FUTEX_OP_XOR:
-		tmp ^= oparg;
-		break;
-	default:
-		ret = -ENOSYS;
-	}
-
-	if (ret == 0 && unlikely(put_user(tmp, uaddr) != 0))
-		ret = -EFAULT;
-
-out_pagefault_enable:
-	pagefault_enable();
-	preempt_enable();
+	ret = __futex_atomic_op_inuser(op, oldval, uaddr, oparg);
 
 	if (ret == 0) {
 		switch (cmp) {
@@ -103,76 +172,12 @@ futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
  */
 static inline int
 futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
-			      u32 oldval, u32 newval)
+		u32 oldval, u32 newval)
 {
-	u32 val;
-
-	preempt_disable();
-	if (unlikely(get_user(val, uaddr) != 0)) {
-		preempt_enable();
-		return -EFAULT;
-	}
-
-	if (val == oldval && unlikely(put_user(newval, uaddr) != 0)) {
-		preempt_enable();
-		return -EFAULT;
-	}
-
-	*uval = val;
-	preempt_enable();
-
-	return 0;
-}
-
-#else
-static inline int
-futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(u32)))
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
-	pagefault_disable();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	pagefault_enable();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-static inline int
-futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
-			      u32 oldval, u32 newval)
-{
-	return -ENOSYS;
+	return __futex_atomic_cmpxchg_inatomic(uval, uaddr, oldval, newval);
 }
 
-#endif /* CONFIG_SMP */
 #endif
-- 
2.10.0

