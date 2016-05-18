From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 10/15] x86: Use ISO atomics
Date: Wed, 18 May 2016 16:11:52 +0100
Message-ID: <146358431284.8596.8704799311171576095.stgit@warthog.procyon.org.uk>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49813 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932402AbcERPLz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 May 2016 11:11:55 -0400
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

Make x86 use the ISO intrinsic atomics.

This boots fine, however it can't NOP out the LOCK prefixes if the number
of online CPUs is 1.

Without this patch, according to size -A, .text for my test kernel is:

	.text                     6268981   18446744071578845184

with this patch:

	.text                     6268277   18446744071578845184

There are still some underoptimisations to be dealt with.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/atomic.h |  224 +----------------------------------------
 1 file changed, 4 insertions(+), 220 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 3e8674288198..bec5c111b82e 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -13,230 +13,14 @@
  * resource counting etc..
  */
 
-#define ATOMIC_INIT(i)	{ (i) }
-
-/**
- * atomic_read - read atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically reads the value of @v.
- */
-static __always_inline int atomic_read(const atomic_t *v)
-{
-	return READ_ONCE((v)->counter);
-}
-
-/**
- * atomic_set - set atomic variable
- * @v: pointer of type atomic_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
-static __always_inline void atomic_set(atomic_t *v, int i)
-{
-	WRITE_ONCE(v->counter, i);
-}
-
-/**
- * atomic_add - add integer to atomic variable
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v.
- */
-static __always_inline void atomic_add(int i, atomic_t *v)
-{
-	asm volatile(LOCK_PREFIX "addl %1,%0"
-		     : "+m" (v->counter)
-		     : "ir" (i));
-}
-
-/**
- * atomic_sub - subtract integer from atomic variable
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v.
- */
-static __always_inline void atomic_sub(int i, atomic_t *v)
-{
-	asm volatile(LOCK_PREFIX "subl %1,%0"
-		     : "+m" (v->counter)
-		     : "ir" (i));
-}
-
-/**
- * atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
-static __always_inline int atomic_sub_and_test(int i, atomic_t *v)
-{
-	GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, "er", i, "%0", "e");
-}
-
-/**
- * atomic_inc - increment atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1.
- */
-static __always_inline void atomic_inc(atomic_t *v)
-{
-	asm volatile(LOCK_PREFIX "incl %0"
-		     : "+m" (v->counter));
-}
-
-/**
- * atomic_dec - decrement atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1.
- */
-static __always_inline void atomic_dec(atomic_t *v)
-{
-	asm volatile(LOCK_PREFIX "decl %0"
-		     : "+m" (v->counter));
-}
-
-/**
- * atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-static __always_inline int atomic_dec_and_test(atomic_t *v)
-{
-	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", "e");
-}
-
-/**
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-static __always_inline int atomic_inc_and_test(atomic_t *v)
-{
-	GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, "%0", "e");
-}
-
-/**
- * atomic_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
-static __always_inline int atomic_add_negative(int i, atomic_t *v)
-{
-	GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, "er", i, "%0", "s");
-}
-
-/**
- * atomic_add_return - add integer and return
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns @i + @v
- */
-static __always_inline int atomic_add_return(int i, atomic_t *v)
-{
-	return i + xadd(&v->counter, i);
-}
-
-/**
- * atomic_sub_return - subtract integer and return
- * @v: pointer of type atomic_t
- * @i: integer value to subtract
- *
- * Atomically subtracts @i from @v and returns @v - @i
- */
-static __always_inline int atomic_sub_return(int i, atomic_t *v)
-{
-	return atomic_add_return(-i, v);
-}
-
-#define atomic_inc_return(v)  (atomic_add_return(1, v))
-#define atomic_dec_return(v)  (atomic_sub_return(1, v))
-
-static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
-{
-	return cmpxchg(&v->counter, old, new);
-}
-
-static inline int atomic_xchg(atomic_t *v, int new)
-{
-	return xchg(&v->counter, new);
-}
-
-#define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t *v)			\
-{									\
-	asm volatile(LOCK_PREFIX #op"l %1,%0"				\
-			: "+m" (v->counter)				\
-			: "ir" (i)					\
-			: "memory");					\
-}
-
-ATOMIC_OP(and)
-ATOMIC_OP(or)
-ATOMIC_OP(xor)
-
-#undef ATOMIC_OP
-
-/**
- * __atomic_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns the old value of @v.
- */
-static __always_inline int __atomic_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-	c = atomic_read(v);
-	for (;;) {
-		if (unlikely(c == (u)))
-			break;
-		old = atomic_cmpxchg((v), c, c + (a));
-		if (likely(old == c))
-			break;
-		c = old;
-	}
-	return c;
-}
-
-/**
- * atomic_inc_short - increment of a short integer
- * @v: pointer to type int
- *
- * Atomically adds 1 to @v
- * Returns the new value of @u
- */
-static __always_inline short int atomic_inc_short(short int *v)
-{
-	asm(LOCK_PREFIX "addw $1, %0" : "+m" (*v));
-	return *v;
-}
+#include <asm-generic/iso-atomic.h>
 
 #ifdef CONFIG_X86_32
 # include <asm/atomic64_32.h>
 #else
-# include <asm/atomic64_64.h>
+# include <asm-generic/iso-atomic64.h>
 #endif
 
+#include <asm-generic/iso-atomic-long.h>
+
 #endif /* _ASM_X86_ATOMIC_H */
