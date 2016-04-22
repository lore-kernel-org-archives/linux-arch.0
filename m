From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 10/31] locking,hexagon: Implement atomic_fetch_{add,sub,and,or,xor}()
Date: Fri, 22 Apr 2016 11:04:23 +0200
Message-ID: <20160422093923.685243711@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:34968 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbcDVJmy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 05:42:54 -0400
Content-Disposition: inline; filename=peterz-atomic-fetch-hexagon.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/hexagon/include/asm/atomic.h |   33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -110,7 +110,7 @@ static inline void atomic_##op(int i, at
 	);								\
 }									\
 
-#define ATOMIC_OP_RETURN(op)							\
+#define ATOMIC_OP_RETURN(op)						\
 static inline int atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	int output;							\
@@ -127,16 +127,39 @@ static inline int atomic_##op##_return(i
 	return output;							\
 }
 
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
+#define ATOMIC_FETCH_OP(op)						\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	int output, val;						\
+									\
+	__asm__ __volatile__ (						\
+		"1:	%0 = memw_locked(%2);\n"			\
+		"	%1 = "#op "(%0,%3);\n"				\
+		"	memw_locked(%2,P3)=%0;\n"			\
+		"	if !P3 jump 1b;\n"				\
+		: "=&r" (output), "=&r" (val)				\
+		: "r" (&v->counter), "r" (i)				\
+		: "memory", "p3"					\
+	);								\
+	return output;							\
+}
+
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-ATOMIC_OP(and)
-ATOMIC_OP(or)
-ATOMIC_OP(xor)
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
+
+#define atomic_fetch_or atomic_fetch_or
+
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+ATOMIC_OPS(xor)
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
