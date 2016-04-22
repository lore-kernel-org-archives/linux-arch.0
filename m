Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35019 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbcDVJm5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 05:42:57 -0400
Message-ID: <20160422093924.139774269@infradead.org>
Date: Fri, 22 Apr 2016 11:04:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 17/31] locking,parisc: Implement atomic{,64}_fetch_{add,sub,and,or,xor}()
References: <20160422090413.393652501@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-atomic-fetch-parisc.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
Message-ID: <20160422090430.8A-S1c32VLsnRRZuzJA2elfgDq-1tlGT0r_dAI3-U98@z>

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/parisc/include/asm/atomic.h |   65 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 8 deletions(-)

--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -121,16 +121,41 @@ static __inline__ int atomic_##op##_retu
 	return ret;							\
 }
 
-#define ATOMIC_OPS(op, c_op) ATOMIC_OP(op, c_op) ATOMIC_OP_RETURN(op, c_op)
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static __inline__ int atomic_fetch_##op(int i, atomic_t *v)		\
+{									\
+	unsigned long flags;						\
+	int ret;							\
+									\
+	_atomic_spin_lock_irqsave(v, flags);				\
+	ret = v->counter;						\
+	v->counter c_op i;						\
+	_atomic_spin_unlock_irqrestore(v, flags);			\
+									\
+	return ret;							\
+}
+
+#define ATOMIC_OPS(op, c_op)						\
+	ATOMIC_OP(op, c_op)						\
+	ATOMIC_OP_RETURN(op, c_op)					\
+	ATOMIC_FETCH_OP(op, c_op)
 
 ATOMIC_OPS(add, +=)
 ATOMIC_OPS(sub, -=)
 
-ATOMIC_OP(and, &=)
-ATOMIC_OP(or, |=)
-ATOMIC_OP(xor, ^=)
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, c_op)						\
+	ATOMIC_OP(op, c_op)						\
+	ATOMIC_FETCH_OP(op, c_op)
+
+#define atomic_fetch_or atomic_fetch_or
+
+ATOMIC_OPS(and, &=)
+ATOMIC_OPS(or, |=)
+ATOMIC_OPS(xor, ^=)
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
@@ -185,15 +210,39 @@ static __inline__ s64 atomic64_##op##_re
 	return ret;							\
 }
 
-#define ATOMIC64_OPS(op, c_op) ATOMIC64_OP(op, c_op) ATOMIC64_OP_RETURN(op, c_op)
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+static __inline__ s64 atomic64_fetch_##op(s64 i, atomic64_t *v)		\
+{									\
+	unsigned long flags;						\
+	s64 ret;							\
+									\
+	_atomic_spin_lock_irqsave(v, flags);				\
+	ret = v->counter;						\
+	v->counter c_op i;						\
+	_atomic_spin_unlock_irqrestore(v, flags);			\
+									\
+	return ret;							\
+}
+
+#define ATOMIC64_OPS(op, c_op)						\
+	ATOMIC64_OP(op, c_op)						\
+	ATOMIC64_OP_RETURN(op, c_op)					\
+	ATOMIC64_FETCH_OP(op, c_op)
 
 ATOMIC64_OPS(add, +=)
 ATOMIC64_OPS(sub, -=)
-ATOMIC64_OP(and, &=)
-ATOMIC64_OP(or, |=)
-ATOMIC64_OP(xor, ^=)
 
 #undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, c_op)						\
+	ATOMIC64_OP(op, c_op)						\
+	ATOMIC64_FETCH_OP(op, c_op)
+
+ATOMIC64_OPS(and, &=)
+ATOMIC64_OPS(or, |=)
+ATOMIC64_OPS(xor, ^=)
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 


