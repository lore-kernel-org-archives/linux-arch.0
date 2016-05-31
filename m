From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 25/33] locking,xtensa: Implement atomic_fetch_{add,sub,and,or,xor}()
Date: Tue, 31 May 2016 12:19:50 +0200
Message-ID: <20160531102643.017585955@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43393 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbcEaK3y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2016 06:29:54 -0400
Content-Disposition: inline; filename=peterz-atomic-fetch-xtensa.patch
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
 arch/xtensa/include/asm/atomic.h |   54 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -98,6 +98,26 @@ static inline int atomic_##op##_return(i
 	return result;							\
 }
 
+#define ATOMIC_FETCH_OP(op)						\
+static inline int atomic_fetch_##op(int i, atomic_t * v)		\
+{									\
+	unsigned long tmp;						\
+	int result;							\
+									\
+	__asm__ __volatile__(						\
+			"1:     l32i    %1, %3, 0\n"			\
+			"       wsr     %1, scompare1\n"		\
+			"       " #op " %0, %1, %2\n"			\
+			"       s32c1i  %0, %3, 0\n"			\
+			"       bne     %0, %1, 1b\n"			\
+			: "=&a" (result), "=&a" (tmp)			\
+			: "a" (i), "a" (v)				\
+			: "memory"					\
+			);						\
+									\
+	return result;							\
+}
+
 #else /* XCHAL_HAVE_S32C1I */
 
 #define ATOMIC_OP(op)							\
@@ -138,18 +158,44 @@ static inline int atomic_##op##_return(i
 	return vval;							\
 }
 
+#define ATOMIC_FETCH_OP(op)						\
+static inline int atomic_fetch_##op(int i, atomic_t * v)		\
+{									\
+	unsigned int tmp, vval;						\
+									\
+	__asm__ __volatile__(						\
+			"       rsil    a15,"__stringify(TOPLEVEL)"\n"	\
+			"       l32i    %0, %3, 0\n"			\
+			"       " #op " %1, %0, %2\n"			\
+			"       s32i    %1, %3, 0\n"			\
+			"       wsr     a15, ps\n"			\
+			"       rsync\n"				\
+			: "=&a" (vval), "=&a" (tmp)			\
+			: "a" (i), "a" (v)				\
+			: "a15", "memory"				\
+			);						\
+									\
+	return vval;							\
+}
+
 #endif /* XCHAL_HAVE_S32C1I */
 
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op) ATOMIC_OP_RETURN(op)
 
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
 
