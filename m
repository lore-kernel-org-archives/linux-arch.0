From: Stafford Horne <shorne@gmail.com>
Subject: [PATCH v4 09/24] openrisc: add optimized atomic operations
Date: Fri, 24 Feb 2017 13:32:29 +0900
Message-ID: <e66970354310182a74334d3bc2181ad86f9e8524.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: linux@roeck-us.net, openrisc@lists.librecores.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

Using the l.lwa and l.swa atomic instruction pair.
Most openrisc processor cores provide these instructions now. If the
instructions are not available emulation is provided.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne@gmail.com: remove OPENRISC_HAVE_INST_LWA_SWA config suggesed by
Alan Cox https://lkml.org/lkml/2014/7/23/666]
[shorne@gmail.com: expand to implement all ops suggested by Peter
Zijlstra https://lkml.org/lkml/2017/2/20/317]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/Kbuild   |   1 -
 arch/openrisc/include/asm/atomic.h | 126 +++++++++++++++++++++++++++++++++++++
 include/asm-generic/atomic.h       |   2 +
 3 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/asm/atomic.h

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 15e6ed5..1cedd63 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 
 header-y += ucontext.h
 
-generic-y += atomic.h
 generic-y += auxvec.h
 generic-y += barrier.h
 generic-y += bitsperlong.h
diff --git a/arch/openrisc/include/asm/atomic.h b/arch/openrisc/include/asm/atomic.h
new file mode 100644
index 0000000..146e166
--- /dev/null
+++ b/arch/openrisc/include/asm/atomic.h
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_OPENRISC_ATOMIC_H
+#define __ASM_OPENRISC_ATOMIC_H
+
+#include <linux/types.h>
+
+/* Atomically perform op with v->counter and i */
+#define ATOMIC_OP(op)							\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	int tmp;							\
+									\
+	__asm__ __volatile__(						\
+		"1:	l.lwa	%0,0(%1)	\n"			\
+		"	l." #op " %0,%0,%2	\n"			\
+		"	l.swa	0(%1),%0	\n"			\
+		"	l.bnf	1b		\n"			\
+		"	 l.nop			\n"			\
+		: "=&r"(tmp)						\
+		: "r"(&v->counter), "r"(i)				\
+		: "cc", "memory");					\
+}
+
+/* Atomically perform op with v->counter and i, return the result */
+#define ATOMIC_OP_RETURN(op)						\
+static inline int atomic_##op##_return(int i, atomic_t *v)		\
+{									\
+	int tmp;							\
+									\
+	__asm__ __volatile__(						\
+		"1:	l.lwa	%0,0(%1)	\n"			\
+		"	l." #op " %0,%0,%2	\n"			\
+		"	l.swa	0(%1),%0	\n"			\
+		"	l.bnf	1b		\n"			\
+		"	 l.nop			\n"			\
+		: "=&r"(tmp)						\
+		: "r"(&v->counter), "r"(i)				\
+		: "cc", "memory");					\
+									\
+	return tmp;							\
+}
+
+/* Atomically perform op with v->counter and i, return orig v->counter */
+#define ATOMIC_FETCH_OP(op)						\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	int tmp, old;							\
+									\
+	__asm__ __volatile__(						\
+		"1:	l.lwa	%0,0(%2)	\n"			\
+		"	l." #op " %1,%0,%3	\n"			\
+		"	l.swa	0(%2),%1	\n"			\
+		"	l.bnf	1b		\n"			\
+		"	 l.nop			\n"			\
+		: "=&r"(old), "=&r"(tmp)				\
+		: "r"(&v->counter), "r"(i)				\
+		: "cc", "memory");					\
+									\
+	return old;							\
+}
+
+ATOMIC_OP_RETURN(add)
+ATOMIC_OP_RETURN(sub)
+
+ATOMIC_FETCH_OP(add)
+ATOMIC_FETCH_OP(sub)
+ATOMIC_FETCH_OP(and)
+ATOMIC_FETCH_OP(or)
+ATOMIC_FETCH_OP(xor)
+
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
+
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+#define atomic_add_return	atomic_add_return
+#define atomic_sub_return	atomic_sub_return
+#define atomic_fetch_add	atomic_fetch_add
+#define atomic_fetch_sub	atomic_fetch_sub
+#define atomic_fetch_and	atomic_fetch_and
+#define atomic_fetch_or		atomic_fetch_or
+#define atomic_fetch_xor	atomic_fetch_xor
+#define atomic_and	atomic_and
+#define atomic_or	atomic_or
+#define atomic_xor	atomic_xor
+
+/*
+ * Atomically add a to v->counter as long as v is not already u.
+ * Returns the original value at v->counter.
+ *
+ * This is often used through atomic_inc_not_zero()
+ */
+static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int old, tmp;
+
+	__asm__ __volatile__(
+		"1:	l.lwa %0, 0(%2)		\n"
+		"	l.sfeq %0, %4		\n"
+		"	l.bf 2f			\n"
+		"	 l.add %1, %0, %3	\n"
+		"	l.swa 0(%2), %1		\n"
+		"	l.bnf 1b		\n"
+		"	 l.nop			\n"
+		"2:				\n"
+		: "=&r"(old), "=&r" (tmp)
+		: "r"(&v->counter), "r"(a), "r"(u)
+		: "cc", "memory");
+
+	return old;
+}
+#define __atomic_add_unless	__atomic_add_unless
+
+#include <asm-generic/atomic.h>
+
+#endif /* __ASM_OPENRISC_ATOMIC_H */
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 9ed8b98..3f38eb0 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -223,6 +223,7 @@ static inline void atomic_dec(atomic_t *v)
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
 
+#ifndef __atomic_add_unless
 static inline int __atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
@@ -231,5 +232,6 @@ static inline int __atomic_add_unless(atomic_t *v, int a, int u)
 		c = old;
 	return c;
 }
+#endif
 
 #endif /* __ASM_GENERIC_ATOMIC_H */
-- 
2.9.3
