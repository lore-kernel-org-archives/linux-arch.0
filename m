From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 22/31] locking,tile: Implement atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Fri, 22 Apr 2016 11:04:35 +0200
Message-ID: <20160422093924.482859927@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-tile.patch
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

XXX please look at the tilegx (CONFIG_64BIT) atomics, I think we get
the barriers wrong (at the very least they're inconsistent).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/tile/include/asm/atomic.h    |    4 +
 arch/tile/include/asm/atomic_32.h |   60 +++++++++++++------
 arch/tile/include/asm/atomic_64.h |  117 +++++++++++++++++++++++++-------------
 arch/tile/include/asm/bitops_32.h |   18 ++---
 arch/tile/lib/atomic_32.c         |   42 ++++++-------
 arch/tile/lib/atomic_asm_32.S     |   14 ++--
 6 files changed, 161 insertions(+), 94 deletions(-)

--- a/arch/tile/include/asm/atomic.h
+++ b/arch/tile/include/asm/atomic.h
@@ -46,6 +46,10 @@ static inline int atomic_read(const atom
  */
 #define atomic_sub_return(i, v)		atomic_add_return((int)(-(i)), (v))
 
+#define atomic_fetch_sub(i, v)		atomic_fetch_add(-(int)(i), (v))
+
+#define atomic_fetch_or atomic_fetch_or
+
 /**
  * atomic_sub - subtract integer from atomic variable
  * @i: integer value to subtract
--- a/arch/tile/include/asm/atomic_32.h
+++ b/arch/tile/include/asm/atomic_32.h
@@ -34,18 +34,29 @@ static inline void atomic_add(int i, ato
 	_atomic_xchg_add(&v->counter, i);
 }
 
-#define ATOMIC_OP(op)							\
-unsigned long _atomic_##op(volatile unsigned long *p, unsigned long mask); \
+#define ATOMIC_OPS(op)							\
+unsigned long _atomic_fetch_##op(volatile unsigned long *p, unsigned long mask); \
 static inline void atomic_##op(int i, atomic_t *v)			\
 {									\
-	_atomic_##op((unsigned long *)&v->counter, i);			\
+	_atomic_fetch_##op((unsigned long *)&v->counter, i);		\
+}									\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	smp_mb();							\
+	return _atomic_fetch_##op((unsigned long *)&v->counter, i);	\
 }
 
-ATOMIC_OP(and)
-ATOMIC_OP(or)
-ATOMIC_OP(xor)
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+ATOMIC_OPS(xor)
+
+#undef ATOMIC_OPS
 
-#undef ATOMIC_OP
+static inline int atomic_fetch_add(int i, atomic_t *v)
+{
+	smp_mb();
+	return _atomic_xchg_add(&v->counter, i);
+}
 
 /**
  * atomic_add_return - add integer and return
@@ -126,17 +137,30 @@ static inline void atomic64_add(long lon
 	_atomic64_xchg_add(&v->counter, i);
 }
 
-#define ATOMIC64_OP(op)						\
-long long _atomic64_##op(long long *v, long long n);		\
+#define ATOMIC64_OPS(op)					\
+long long _atomic64_fetch_##op(long long *v, long long n);	\
+static inline void atomic64_##op(long long i, atomic64_t *v)	\
+{								\
+	_atomic64_fetch_##op(&v->counter, i);			\
+}								\
 static inline void atomic64_##op(long long i, atomic64_t *v)	\
 {								\
-	_atomic64_##op(&v->counter, i);				\
+	smp_mb();						\
+	return _atomic64_fetch_##op(&v->counter, i);		\
 }
 
 ATOMIC64_OP(and)
 ATOMIC64_OP(or)
 ATOMIC64_OP(xor)
 
+#undef ATOMIC64_OPS
+
+static inline long long atomic64_fetch_add(long long i, atomic64_t *v)
+{
+	smp_mb();
+	return _atomic64_xchg_add(&v->counter, i);
+}
+
 /**
  * atomic64_add_return - add integer and return
  * @v: pointer of type atomic64_t
@@ -186,6 +210,7 @@ static inline void atomic64_set(atomic64
 #define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
 #define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
 #define atomic64_sub_return(i, v)	atomic64_add_return(-(i), (v))
+#define atomic64_fetch_sub(i, v)	atomic64_fetch_add(-(i), (v))
 #define atomic64_sub_and_test(a, v)	(atomic64_sub_return((a), (v)) == 0)
 #define atomic64_sub(i, v)		atomic64_add(-(i), (v))
 #define atomic64_dec(v)			atomic64_sub(1LL, (v))
@@ -193,7 +218,6 @@ static inline void atomic64_set(atomic64
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 #define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
 
-
 #endif /* !__ASSEMBLY__ */
 
 /*
@@ -248,10 +272,10 @@ extern struct __get_user __atomic_xchg(v
 extern struct __get_user __atomic_xchg_add(volatile int *p, int *lock, int n);
 extern struct __get_user __atomic_xchg_add_unless(volatile int *p,
 						  int *lock, int o, int n);
-extern struct __get_user __atomic_or(volatile int *p, int *lock, int n);
-extern struct __get_user __atomic_and(volatile int *p, int *lock, int n);
-extern struct __get_user __atomic_andn(volatile int *p, int *lock, int n);
-extern struct __get_user __atomic_xor(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic_fetch_or(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic_fetch_and(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic_fetch_andn(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic_fetch_xor(volatile int *p, int *lock, int n);
 extern long long __atomic64_cmpxchg(volatile long long *p, int *lock,
 					long long o, long long n);
 extern long long __atomic64_xchg(volatile long long *p, int *lock, long long n);
@@ -259,9 +283,9 @@ extern long long __atomic64_xchg_add(vol
 					long long n);
 extern long long __atomic64_xchg_add_unless(volatile long long *p,
 					int *lock, long long o, long long n);
-extern long long __atomic64_and(volatile long long *p, int *lock, long long n);
-extern long long __atomic64_or(volatile long long *p, int *lock, long long n);
-extern long long __atomic64_xor(volatile long long *p, int *lock, long long n);
+extern long long __atomic64_fetch_and(volatile long long *p, int *lock, long long n);
+extern long long __atomic64_fetch_or(volatile long long *p, int *lock, long long n);
+extern long long __atomic64_fetch_xor(volatile long long *p, int *lock, long long n);
 
 /* Return failure from the atomic wrappers. */
 struct __get_user __atomic_bad_address(int __user *addr);
--- a/arch/tile/include/asm/atomic_64.h
+++ b/arch/tile/include/asm/atomic_64.h
@@ -32,42 +32,49 @@
  * on any routine which updates memory and returns a value.
  */
 
-static inline void atomic_add(int i, atomic_t *v)
-{
-	__insn_fetchadd4((void *)&v->counter, i);
-}
-
 static inline int atomic_add_return(int i, atomic_t *v)
 {
 	int val;
 	smp_mb();  /* barrier for proper semantics */
 	val = __insn_fetchadd4((void *)&v->counter, i) + i;
 	barrier();  /* the "+ i" above will wait on memory */
+	/* XXX smp_mb() instead, as per cmpxchg() ? */
 	return val;
 }
 
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+#define ATOMIC_OPS(op)							\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	int val;							\
+	smp_mb();							\
+	val = __insn_fetch##op##4((void *)&v->counter, i);		\
+	smp_mb();							\
+	return val;							\
+}									\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	__insn_fetch##op##4((void *)&v->counter, i);			\
+}
+
+ATOMIC_OPS(add)
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+
+#undef ATOMIC_OPS
+
+static inline int atomic_fetch_xor(int i, atomic_t *v)
 {
 	int guess, oldval = v->counter;
+	smp_mb();
 	do {
-		if (oldval == u)
-			break;
 		guess = oldval;
-		oldval = cmpxchg(&v->counter, guess, guess + a);
+		__insn_mtspr(SPR_CMPEXCH_VALUE, guess);
+		oldval = __insn_cmpexch4(&v->counter, guess ^ i);
 	} while (guess != oldval);
+	smp_mb();
 	return oldval;
 }
 
-static inline void atomic_and(int i, atomic_t *v)
-{
-	__insn_fetchand4((void *)&v->counter, i);
-}
-
-static inline void atomic_or(int i, atomic_t *v)
-{
-	__insn_fetchor4((void *)&v->counter, i);
-}
-
 static inline void atomic_xor(int i, atomic_t *v)
 {
 	int guess, oldval = v->counter;
@@ -78,6 +85,18 @@ static inline void atomic_xor(int i, ato
 	} while (guess != oldval);
 }
 
+static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int guess, oldval = v->counter;
+	do {
+		if (oldval == u)
+			break;
+		guess = oldval;
+		oldval = cmpxchg(&v->counter, guess, guess + a);
+	} while (guess != oldval);
+	return oldval;
+}
+
 /* Now the true 64-bit operations. */
 
 #define ATOMIC64_INIT(i)	{ (i) }
@@ -85,40 +104,47 @@ static inline void atomic_xor(int i, ato
 #define atomic64_read(v)	READ_ONCE((v)->counter)
 #define atomic64_set(v, i)	WRITE_ONCE((v)->counter, (i))
 
-static inline void atomic64_add(long i, atomic64_t *v)
-{
-	__insn_fetchadd((void *)&v->counter, i);
-}
-
 static inline long atomic64_add_return(long i, atomic64_t *v)
 {
 	int val;
 	smp_mb();  /* barrier for proper semantics */
 	val = __insn_fetchadd((void *)&v->counter, i) + i;
 	barrier();  /* the "+ i" above will wait on memory */
+	/* XXX smp_mb() */
 	return val;
 }
 
-static inline long atomic64_add_unless(atomic64_t *v, long a, long u)
+#define ATOMIC64_OPS(op)						\
+static inline long atomic64_fetch_##op(long i, atomic64_t *v)		\
+{									\
+	long val;							\
+	smp_mb();							\
+	val = __insn_fetch##op((void *)&v->counter, i);			\
+	smp_mb();							\
+	return val;							\
+}									\
+static inline void atomic64_##op(long i, atomic64_t *v)			\
+{									\
+	__insn_fetch##op((void *)&v->counter, i);			\
+}
+
+ATOMIC64_OPS(add)
+ATOMIC64_OPS(and)
+ATOMIC64_OPS(or)
+
+#undef ATOMIC64_OPS
+
+static inline long atomic64_fetch_xor(long i, atomic64_t *v)
 {
 	long guess, oldval = v->counter;
+	smp_mb();
 	do {
-		if (oldval == u)
-			break;
 		guess = oldval;
-		oldval = cmpxchg(&v->counter, guess, guess + a);
+		__insn_mtspr(SPR_CMPEXCH_VALUE, guess);
+		oldval = __insn_cmpexch(&v->counter, guess ^ i);
 	} while (guess != oldval);
-	return oldval != u;
-}
-
-static inline void atomic64_and(long i, atomic64_t *v)
-{
-	__insn_fetchand((void *)&v->counter, i);
-}
-
-static inline void atomic64_or(long i, atomic64_t *v)
-{
-	__insn_fetchor((void *)&v->counter, i);
+	smp_mb();
+	return oldval;
 }
 
 static inline void atomic64_xor(long i, atomic64_t *v)
@@ -131,7 +157,20 @@ static inline void atomic64_xor(long i,
 	} while (guess != oldval);
 }
 
+static inline long atomic64_add_unless(atomic64_t *v, long a, long u)
+{
+	long guess, oldval = v->counter;
+	do {
+		if (oldval == u)
+			break;
+		guess = oldval;
+		oldval = cmpxchg(&v->counter, guess, guess + a);
+	} while (guess != oldval);
+	return oldval != u;
+}
+
 #define atomic64_sub_return(i, v)	atomic64_add_return(-(i), (v))
+#define atomic64_fetch_sub(i, v)	atomic64_fetch_add(-(i), (v))
 #define atomic64_sub(i, v)		atomic64_add(-(i), (v))
 #define atomic64_inc_return(v)		atomic64_add_return(1, (v))
 #define atomic64_dec_return(v)		atomic64_sub_return(1, (v))
--- a/arch/tile/include/asm/bitops_32.h
+++ b/arch/tile/include/asm/bitops_32.h
@@ -19,9 +19,9 @@
 #include <asm/barrier.h>
 
 /* Tile-specific routines to support <asm/bitops.h>. */
-unsigned long _atomic_or(volatile unsigned long *p, unsigned long mask);
-unsigned long _atomic_andn(volatile unsigned long *p, unsigned long mask);
-unsigned long _atomic_xor(volatile unsigned long *p, unsigned long mask);
+unsigned long _atomic_fetch_or(volatile unsigned long *p, unsigned long mask);
+unsigned long _atomic_fetch_andn(volatile unsigned long *p, unsigned long mask);
+unsigned long _atomic_fetch_xor(volatile unsigned long *p, unsigned long mask);
 
 /**
  * set_bit - Atomically set a bit in memory
@@ -35,7 +35,7 @@ unsigned long _atomic_xor(volatile unsig
  */
 static inline void set_bit(unsigned nr, volatile unsigned long *addr)
 {
-	_atomic_or(addr + BIT_WORD(nr), BIT_MASK(nr));
+	_atomic_fetch_or(addr + BIT_WORD(nr), BIT_MASK(nr));
 }
 
 /**
@@ -54,7 +54,7 @@ static inline void set_bit(unsigned nr,
  */
 static inline void clear_bit(unsigned nr, volatile unsigned long *addr)
 {
-	_atomic_andn(addr + BIT_WORD(nr), BIT_MASK(nr));
+	_atomic_fetch_andn(addr + BIT_WORD(nr), BIT_MASK(nr));
 }
 
 /**
@@ -69,7 +69,7 @@ static inline void clear_bit(unsigned nr
  */
 static inline void change_bit(unsigned nr, volatile unsigned long *addr)
 {
-	_atomic_xor(addr + BIT_WORD(nr), BIT_MASK(nr));
+	_atomic_fetch_xor(addr + BIT_WORD(nr), BIT_MASK(nr));
 }
 
 /**
@@ -85,7 +85,7 @@ static inline int test_and_set_bit(unsig
 	unsigned long mask = BIT_MASK(nr);
 	addr += BIT_WORD(nr);
 	smp_mb();  /* barrier for proper semantics */
-	return (_atomic_or(addr, mask) & mask) != 0;
+	return (_atomic_fetch_or(addr, mask) & mask) != 0;
 }
 
 /**
@@ -101,7 +101,7 @@ static inline int test_and_clear_bit(uns
 	unsigned long mask = BIT_MASK(nr);
 	addr += BIT_WORD(nr);
 	smp_mb();  /* barrier for proper semantics */
-	return (_atomic_andn(addr, mask) & mask) != 0;
+	return (_atomic_fetch_andn(addr, mask) & mask) != 0;
 }
 
 /**
@@ -118,7 +118,7 @@ static inline int test_and_change_bit(un
 	unsigned long mask = BIT_MASK(nr);
 	addr += BIT_WORD(nr);
 	smp_mb();  /* barrier for proper semantics */
-	return (_atomic_xor(addr, mask) & mask) != 0;
+	return (_atomic_fetch_xor(addr, mask) & mask) != 0;
 }
 
 #include <asm-generic/bitops/ext2-atomic.h>
--- a/arch/tile/lib/atomic_32.c
+++ b/arch/tile/lib/atomic_32.c
@@ -88,29 +88,29 @@ int _atomic_cmpxchg(int *v, int o, int n
 }
 EXPORT_SYMBOL(_atomic_cmpxchg);
 
-unsigned long _atomic_or(volatile unsigned long *p, unsigned long mask)
+unsigned long _atomic_fetch_or(volatile unsigned long *p, unsigned long mask)
 {
-	return __atomic_or((int *)p, __atomic_setup(p), mask).val;
+	return __atomic_fetch_or((int *)p, __atomic_setup(p), mask).val;
 }
-EXPORT_SYMBOL(_atomic_or);
+EXPORT_SYMBOL(_atomic_fetch_or);
 
-unsigned long _atomic_and(volatile unsigned long *p, unsigned long mask)
+unsigned long _atomic_fetch_and(volatile unsigned long *p, unsigned long mask)
 {
-	return __atomic_and((int *)p, __atomic_setup(p), mask).val;
+	return __atomic_fetch_and((int *)p, __atomic_setup(p), mask).val;
 }
-EXPORT_SYMBOL(_atomic_and);
+EXPORT_SYMBOL(_atomic_fetch_and);
 
-unsigned long _atomic_andn(volatile unsigned long *p, unsigned long mask)
+unsigned long _atomic_fetch_andn(volatile unsigned long *p, unsigned long mask)
 {
-	return __atomic_andn((int *)p, __atomic_setup(p), mask).val;
+	return __atomic_fetch_andn((int *)p, __atomic_setup(p), mask).val;
 }
-EXPORT_SYMBOL(_atomic_andn);
+EXPORT_SYMBOL(_atomic_fetch_andn);
 
-unsigned long _atomic_xor(volatile unsigned long *p, unsigned long mask)
+unsigned long _atomic_fetch_xor(volatile unsigned long *p, unsigned long mask)
 {
-	return __atomic_xor((int *)p, __atomic_setup(p), mask).val;
+	return __atomic_fetch_xor((int *)p, __atomic_setup(p), mask).val;
 }
-EXPORT_SYMBOL(_atomic_xor);
+EXPORT_SYMBOL(_atomic_fetch_xor);
 
 
 long long _atomic64_xchg(long long *v, long long n)
@@ -142,23 +142,23 @@ long long _atomic64_cmpxchg(long long *v
 }
 EXPORT_SYMBOL(_atomic64_cmpxchg);
 
-long long _atomic64_and(long long *v, long long n)
+long long _atomic64_fetch_and(long long *v, long long n)
 {
-	return __atomic64_and(v, __atomic_setup(v), n);
+	return __atomic64_fetch_and(v, __atomic_setup(v), n);
 }
-EXPORT_SYMBOL(_atomic64_and);
+EXPORT_SYMBOL(_atomic64_fetch_and);
 
-long long _atomic64_or(long long *v, long long n)
+long long _atomic64_fetch_or(long long *v, long long n)
 {
-	return __atomic64_or(v, __atomic_setup(v), n);
+	return __atomic64_fetch_or(v, __atomic_setup(v), n);
 }
-EXPORT_SYMBOL(_atomic64_or);
+EXPORT_SYMBOL(_atomic64_fetch_or);
 
-long long _atomic64_xor(long long *v, long long n)
+long long _atomic64_fetch_xor(long long *v, long long n)
 {
-	return __atomic64_xor(v, __atomic_setup(v), n);
+	return __atomic64_fetch_xor(v, __atomic_setup(v), n);
 }
-EXPORT_SYMBOL(_atomic64_xor);
+EXPORT_SYMBOL(_atomic64_fetch_xor);
 
 /*
  * If any of the atomic or futex routines hit a bad address (not in
--- a/arch/tile/lib/atomic_asm_32.S
+++ b/arch/tile/lib/atomic_asm_32.S
@@ -177,10 +177,10 @@ atomic_op _xchg, 32, "move r24, r2"
 atomic_op _xchg_add, 32, "add r24, r22, r2"
 atomic_op _xchg_add_unless, 32, \
 	"sne r26, r22, r2; { bbns r26, 3f; add r24, r22, r3 }"
-atomic_op _or, 32, "or r24, r22, r2"
-atomic_op _and, 32, "and r24, r22, r2"
-atomic_op _andn, 32, "nor r2, r2, zero; and r24, r22, r2"
-atomic_op _xor, 32, "xor r24, r22, r2"
+atomic_op _fetch_or, 32, "or r24, r22, r2"
+atomic_op _fetch_and, 32, "and r24, r22, r2"
+atomic_op _fetch_andn, 32, "nor r2, r2, zero; and r24, r22, r2"
+atomic_op _fetch_xor, 32, "xor r24, r22, r2"
 
 atomic_op 64_cmpxchg, 64, "{ seq r26, r22, r2; seq r27, r23, r3 }; \
 	{ bbns r26, 3f; move r24, r4 }; { bbns r27, 3f; move r25, r5 }"
@@ -192,9 +192,9 @@ atomic_op 64_xchg_add_unless, 64, \
 	{ bbns r26, 3f; add r24, r22, r4 }; \
 	{ bbns r27, 3f; add r25, r23, r5 }; \
 	slt_u r26, r24, r22; add r25, r25, r26"
-atomic_op 64_or, 64, "{ or r24, r22, r2; or r25, r23, r3 }"
-atomic_op 64_and, 64, "{ and r24, r22, r2; and r25, r23, r3 }"
-atomic_op 64_xor, 64, "{ xor r24, r22, r2; xor r25, r23, r3 }"
+atomic_op 64_fetch_or, 64, "{ or r24, r22, r2; or r25, r23, r3 }"
+atomic_op 64_fetch_and, 64, "{ and r24, r22, r2; and r25, r23, r3 }"
+atomic_op 64_fetch_xor, 64, "{ xor r24, r22, r2; xor r25, r23, r3 }"
 
 	jrp     lr              /* happy backtracer */
 
