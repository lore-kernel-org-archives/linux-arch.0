From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 13/33] locking,m32r: Implement atomic_fetch_{add,sub,and,or,xor}()
Date: Tue, 31 May 2016 12:19:38 +0200
Message-ID: <20160531102642.272816115@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-m32r.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m32r/include/asm/atomic.h |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

--- a/arch/m32r/include/asm/atomic.h
+++ b/arch/m32r/include/asm/atomic.h
@@ -89,16 +89,46 @@ static __inline__ int atomic_##op##_retu
 	return result;							\
 }
 
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
+#define ATOMIC_FETCH_OP(op)						\
+static __inline__ int atomic_fetch_##op(int i, atomic_t *v)		\
+{									\
+	unsigned long flags;						\
+	int result, val;						\
+									\
+	local_irq_save(flags);						\
+	__asm__ __volatile__ (						\
+		"# atomic_fetch_" #op "		\n\t"			\
+		DCACHE_CLEAR("%0", "r4", "%2")				\
+		M32R_LOCK" %1, @%2;		\n\t"			\
+		"mv %0, %1			\n\t" 			\
+		#op " %1, %3;			\n\t"			\
+		M32R_UNLOCK" %1, @%2;		\n\t"			\
+		: "=&r" (result), "=&r" (val)				\
+		: "r" (&v->counter), "r" (i)				\
+		: "memory"						\
+		__ATOMIC_CLOBBER					\
+	);								\
+	local_irq_restore(flags);					\
+									\
+	return result;							\
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
 
