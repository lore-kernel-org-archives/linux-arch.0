From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 20/33] locking,s390: Implement atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Tue, 31 May 2016 12:19:45 +0200
Message-ID: <20160531102642.710572226@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43370 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbcEaK3v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2016 06:29:51 -0400
Content-Disposition: inline; filename=peterz-atomic-fetch-s390.patch
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

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/include/asm/atomic.h |   42 +++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -93,6 +93,11 @@ static inline int atomic_add_return(int
 	return __ATOMIC_LOOP(v, i, __ATOMIC_ADD, __ATOMIC_BARRIER) + i;
 }
 
+static inline int atomic_fetch_add(int i, atomic_t *v)
+{
+	return __ATOMIC_LOOP(v, i, __ATOMIC_ADD, __ATOMIC_BARRIER);
+}
+
 static inline void atomic_add(int i, atomic_t *v)
 {
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
@@ -114,22 +119,29 @@ static inline void atomic_add(int i, ato
 #define atomic_inc_and_test(_v)		(atomic_add_return(1, _v) == 0)
 #define atomic_sub(_i, _v)		atomic_add(-(int)(_i), _v)
 #define atomic_sub_return(_i, _v)	atomic_add_return(-(int)(_i), _v)
+#define atomic_fetch_sub(_i, _v)	atomic_fetch_add(-(int)(_i), _v)
 #define atomic_sub_and_test(_i, _v)	(atomic_sub_return(_i, _v) == 0)
 #define atomic_dec(_v)			atomic_sub(1, _v)
 #define atomic_dec_return(_v)		atomic_sub_return(1, _v)
 #define atomic_dec_and_test(_v)		(atomic_sub_return(1, _v) == 0)
 
-#define ATOMIC_OP(op, OP)						\
+#define ATOMIC_OPS(op, OP)						\
 static inline void atomic_##op(int i, atomic_t *v)			\
 {									\
 	__ATOMIC_LOOP(v, i, __ATOMIC_##OP, __ATOMIC_NO_BARRIER);	\
+}									\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	return __ATOMIC_LOOP(v, i, __ATOMIC_##OP, __ATOMIC_BARRIER);	\
 }
 
-ATOMIC_OP(and, AND)
-ATOMIC_OP(or, OR)
-ATOMIC_OP(xor, XOR)
+#define atomic_fetch_or atomic_fetch_or
+
+ATOMIC_OPS(and, AND)
+ATOMIC_OPS(or, OR)
+ATOMIC_OPS(xor, XOR)
 
-#undef ATOMIC_OP
+#undef ATOMIC_OPS
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
@@ -236,6 +248,11 @@ static inline long long atomic64_add_ret
 	return __ATOMIC64_LOOP(v, i, __ATOMIC64_ADD, __ATOMIC64_BARRIER) + i;
 }
 
+static inline long long atomic64_fetch_add(long long i, atomic64_t *v)
+{
+	return __ATOMIC64_LOOP(v, i, __ATOMIC64_ADD, __ATOMIC64_BARRIER);
+}
+
 static inline void atomic64_add(long long i, atomic64_t *v)
 {
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
@@ -264,17 +281,21 @@ static inline long long atomic64_cmpxchg
 	return old;
 }
 
-#define ATOMIC64_OP(op, OP)						\
+#define ATOMIC64_OPS(op, OP)						\
 static inline void atomic64_##op(long i, atomic64_t *v)			\
 {									\
 	__ATOMIC64_LOOP(v, i, __ATOMIC64_##OP, __ATOMIC64_NO_BARRIER);	\
+}									\
+static inline long atomic64_fetch_##op(long i, atomic64_t *v)		\
+{									\
+	return __ATOMIC64_LOOP(v, i, __ATOMIC64_##OP, __ATOMIC64_BARRIER); \
 }
 
-ATOMIC64_OP(and, AND)
-ATOMIC64_OP(or, OR)
-ATOMIC64_OP(xor, XOR)
+ATOMIC64_OPS(and, AND)
+ATOMIC64_OPS(or, OR)
+ATOMIC64_OPS(xor, XOR)
 
-#undef ATOMIC64_OP
+#undef ATOMIC64_OPS
 #undef __ATOMIC64_LOOP
 
 static inline int atomic64_add_unless(atomic64_t *v, long long i, long long u)
@@ -315,6 +336,7 @@ static inline long long atomic64_dec_if_
 #define atomic64_inc_return(_v)		atomic64_add_return(1, _v)
 #define atomic64_inc_and_test(_v)	(atomic64_add_return(1, _v) == 0)
 #define atomic64_sub_return(_i, _v)	atomic64_add_return(-(long long)(_i), _v)
+#define atomic64_fetch_sub(_i, _v)	atomic64_fetch_add(-(long long)(_i), _v)
 #define atomic64_sub(_i, _v)		atomic64_add(-(long long)(_i), _v)
 #define atomic64_sub_and_test(_i, _v)	(atomic64_sub_return(_i, _v) == 0)
 #define atomic64_dec(_v)		atomic64_sub(1, _v)
