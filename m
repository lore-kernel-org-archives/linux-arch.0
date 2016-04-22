Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40700 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbcDVJnH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 05:43:07 -0400
Message-ID: <20160422093923.611687541@infradead.org>
Date: Fri, 22 Apr 2016 11:04:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 09/31] locking,h8300: Implement atomic_fetch_{add,sub,and,or,xor}()
References: <20160422090413.393652501@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-atomic-fetch-h8300.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
Message-ID: <20160422090422.2WIXhKjDsXLe_p4KBvIpCOYKPW4_Ze2bw6JVmZDhl2Q@z>

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/h8300/include/asm/atomic.h |   31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -28,6 +28,19 @@ static inline int atomic_##op##_return(i
 	return ret;						\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t *v)		\
+{								\
+	h8300flags flags;					\
+	int ret;						\
+								\
+	flags = arch_local_irq_save();				\
+	ret = v->counter;					\
+       	v->counter c_op i;					\
+	arch_local_irq_restore(flags);				\
+	return ret;						\
+}
+
 #define ATOMIC_OP(op, c_op)					\
 static inline void atomic_##op(int i, atomic_t *v)		\
 {								\
@@ -41,17 +54,23 @@ static inline void atomic_##op(int i, at
 ATOMIC_OP_RETURN(add, +=)
 ATOMIC_OP_RETURN(sub, -=)
 
-ATOMIC_OP(and, &=)
-ATOMIC_OP(or,  |=)
-ATOMIC_OP(xor, ^=)
+#define atomic_fetch_or atomic_fetch_or
 
+#define ATOMIC_OPS(op, c_op)					\
+	ATOMIC_OP(op, c_op)					\
+	ATOMIC_FETCH_OP(op, c_op)
+
+ATOMIC_OPS(and, &=)
+ATOMIC_OPS(or,  |=)
+ATOMIC_OPS(xor, ^=)
+ATOMIC_OPS(add, +=)
+ATOMIC_OPS(sub, -=)
+
+#undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_add(i, v)		(void)atomic_add_return(i, v)
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
-
-#define atomic_sub(i, v)		(void)atomic_sub_return(i, v)
 #define atomic_sub_and_test(i, v)	(atomic_sub_return(i, v) == 0)
 
 #define atomic_inc_return(v)		atomic_add_return(1, v)


