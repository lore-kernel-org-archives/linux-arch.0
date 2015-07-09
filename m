From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 20/24] x86: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:15 +0200
Message-ID: <20150709175309.916576499@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35449 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbbGIR4G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:56:06 -0400
Content-Disposition: inline; filename=peterz-x86-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h      |   35 ++++++++++++++++++++++++++---------
 arch/x86/include/asm/atomic64_32.h |   14 ++++++++++++++
 arch/x86/include/asm/atomic64_64.h |   15 +++++++++++++++
 3 files changed, 55 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -182,6 +182,23 @@ static inline int atomic_xchg(atomic_t *
 	return xchg(&v->counter, new);
 }
 
+#define ATOMIC_OP(op)							\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	asm volatile(LOCK_PREFIX #op"l %1,%0"				\
+			: "+m" (v->counter)				\
+			: "ir" (i)					\
+			: "memory");					\
+}
+
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
+
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+
+#undef ATOMIC_OP
+
 /**
  * __atomic_add_unless - add unless the number is already a given value
  * @v: pointer of type atomic_t
@@ -219,15 +236,15 @@ static __always_inline short int atomic_
 	return *v;
 }
 
-/* These are x86-specific, used by some header files */
-#define atomic_clear_mask(mask, addr)				\
-	asm volatile(LOCK_PREFIX "andl %0,%1"			\
-		     : : "r" (~(mask)), "m" (*(addr)) : "memory")
-
-#define atomic_set_mask(mask, addr)				\
-	asm volatile(LOCK_PREFIX "orl %0,%1"			\
-		     : : "r" ((unsigned)(mask)), "m" (*(addr))	\
-		     : "memory")
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_and(~mask, v);
+}
+
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_or(mask, v);
+}
 
 #ifdef CONFIG_X86_32
 # include <asm/atomic64_32.h>
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -313,4 +313,18 @@ static inline long long atomic64_dec_if_
 #undef alternative_atomic64
 #undef __alternative_atomic64
 
+#define ATOMIC64_OP(op, c_op)						\
+static inline void atomic64_##op(long long i, atomic64_t *v)		\
+{									\
+	long long old, c = 0;						\
+	while ((old = atomic64_cmpxchg(v, c, c c_op i)) != c)		\
+		c = old;						\
+}
+
+ATOMIC64_OP(and, &)
+ATOMIC64_OP(or, |)
+ATOMIC64_OP(xor, ^)
+
+#undef ATOMIC64_OP
+
 #endif /* _ASM_X86_ATOMIC64_32_H */
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -220,4 +220,19 @@ static inline long atomic64_dec_if_posit
 	return dec;
 }
 
+#define ATOMIC64_OP(op)							\
+static inline void atomic64_##op(long i, atomic64_t *v)			\
+{									\
+	asm volatile(LOCK_PREFIX #op"q %1,%0"				\
+			: "+m" (v->counter)				\
+			: "ir" (i)					\
+			: "memory");					\
+}
+
+ATOMIC64_OP(and)
+ATOMIC64_OP(or)
+ATOMIC64_OP(xor)
+
+#undef ATOMIC64_OP
+
 #endif /* _ASM_X86_ATOMIC64_64_H */
