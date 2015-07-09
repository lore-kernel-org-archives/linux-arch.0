From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: [PATCH] tile: Provide atomic_{or,xor,and}
Date: Thu, 9 Jul 2015 16:38:17 -0400
Message-ID: <1436474297-32187-1-git-send-email-cmetcalf@ezchip.com>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150709172855.564686637@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, peterz@infradead.org
Cc: Chris Metcalf <cmetcalf@ezchip.com>, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

For tilegx, these are relatively straightforward; the architecture
provides atomic "or" and "and", both 32-bit and 64-bit.  To support
xor we provide a loop using "cmpexch".

For the older 32-bit tilepro architecture, we have to extend
the set of low-level assembly routines to include 32-bit "and",
as well as all three 64-bit routines.  Somewhat confusingly,
some 32-bit versions are already used by the bitops inlines, with
parameter types appropriate for bitops, so we have to do a bit of
casting to match "int" to "unsigned long".

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
Peter, I'm guessing you should just take this into your series,
rather than my pushing it through the tile tree.

 arch/tile/include/asm/atomic_32.h | 28 +++++++++++++++++++++++++++
 arch/tile/include/asm/atomic_64.h | 40 +++++++++++++++++++++++++++++++++++++++
 arch/tile/lib/atomic_32.c         | 23 ++++++++++++++++++++++
 arch/tile/lib/atomic_asm_32.S     |  4 ++++
 4 files changed, 95 insertions(+)

diff --git a/arch/tile/include/asm/atomic_32.h b/arch/tile/include/asm/atomic_32.h
index 1b109fad9fff..d320ce253d86 100644
--- a/arch/tile/include/asm/atomic_32.h
+++ b/arch/tile/include/asm/atomic_32.h
@@ -34,6 +34,19 @@ static inline void atomic_add(int i, atomic_t *v)
 	_atomic_xchg_add(&v->counter, i);
 }
 
+#define ATOMIC_OP(op)							\
+unsigned long _atomic_##op(volatile unsigned long *p, unsigned long mask); \
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	_atomic_##op((unsigned long *)&v->counter, i);			\
+}
+
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
+
+#undef ATOMIC_OP
+
 /**
  * atomic_add_return - add integer and return
  * @v: pointer of type atomic_t
@@ -113,6 +126,17 @@ static inline void atomic64_add(long long i, atomic64_t *v)
 	_atomic64_xchg_add(&v->counter, i);
 }
 
+#define ATOMIC64_OP(op)						\
+long long _atomic64_##op(long long *v, long long n);		\
+static inline void atomic64_##op(long long i, atomic64_t *v)	\
+{								\
+	_atomic64_##op(&v->counter, i);				\
+}
+
+ATOMIC64_OP(and)
+ATOMIC64_OP(or)
+ATOMIC64_OP(xor)
+
 /**
  * atomic64_add_return - add integer and return
  * @v: pointer of type atomic64_t
@@ -225,6 +249,7 @@ extern struct __get_user __atomic_xchg_add(volatile int *p, int *lock, int n);
 extern struct __get_user __atomic_xchg_add_unless(volatile int *p,
 						  int *lock, int o, int n);
 extern struct __get_user __atomic_or(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic_and(volatile int *p, int *lock, int n);
 extern struct __get_user __atomic_andn(volatile int *p, int *lock, int n);
 extern struct __get_user __atomic_xor(volatile int *p, int *lock, int n);
 extern long long __atomic64_cmpxchg(volatile long long *p, int *lock,
@@ -234,6 +259,9 @@ extern long long __atomic64_xchg_add(volatile long long *p, int *lock,
 					long long n);
 extern long long __atomic64_xchg_add_unless(volatile long long *p,
 					int *lock, long long o, long long n);
+extern long long __atomic64_and(volatile long long *p, int *lock, long long n);
+extern long long __atomic64_or(volatile long long *p, int *lock, long long n);
+extern long long __atomic64_xor(volatile long long *p, int *lock, long long n);
 
 /* Return failure from the atomic wrappers. */
 struct __get_user __atomic_bad_address(int __user *addr);
diff --git a/arch/tile/include/asm/atomic_64.h b/arch/tile/include/asm/atomic_64.h
index 0496970cef82..096a56d6ead4 100644
--- a/arch/tile/include/asm/atomic_64.h
+++ b/arch/tile/include/asm/atomic_64.h
@@ -58,6 +58,26 @@ static inline int __atomic_add_unless(atomic_t *v, int a, int u)
 	return oldval;
 }
 
+static inline void atomic_and(int i, atomic_t *v)
+{
+	__insn_fetchand4((void *)&v->counter, i);
+}
+
+static inline void atomic_or(int i, atomic_t *v)
+{
+	__insn_fetchor4((void *)&v->counter, i);
+}
+
+static inline void atomic_xor(int i, atomic_t *v)
+{
+	int guess, oldval = v->counter;
+	do {
+		guess = oldval;
+		__insn_mtspr(SPR_CMPEXCH_VALUE, guess);
+		oldval = __insn_cmpexch4(&v->counter, guess ^ i);
+	} while (guess != oldval);
+}
+
 /* Now the true 64-bit operations. */
 
 #define ATOMIC64_INIT(i)	{ (i) }
@@ -91,6 +111,26 @@ static inline long atomic64_add_unless(atomic64_t *v, long a, long u)
 	return oldval != u;
 }
 
+static inline void atomic64_and(long i, atomic64_t *v)
+{
+	__insn_fetchand((void *)&v->counter, i);
+}
+
+static inline void atomic64_or(long i, atomic64_t *v)
+{
+	__insn_fetchor((void *)&v->counter, i);
+}
+
+static inline void atomic64_xor(long i, atomic64_t *v)
+{
+	long guess, oldval = v->counter;
+	do {
+		guess = oldval;
+		__insn_mtspr(SPR_CMPEXCH_VALUE, guess);
+		oldval = __insn_cmpexch(&v->counter, guess ^ i);
+	} while (guess != oldval);
+}
+
 #define atomic64_sub_return(i, v)	atomic64_add_return(-(i), (v))
 #define atomic64_sub(i, v)		atomic64_add(-(i), (v))
 #define atomic64_inc_return(v)		atomic64_add_return(1, (v))
diff --git a/arch/tile/lib/atomic_32.c b/arch/tile/lib/atomic_32.c
index c89b211fd9e7..298df1e9912a 100644
--- a/arch/tile/lib/atomic_32.c
+++ b/arch/tile/lib/atomic_32.c
@@ -94,6 +94,12 @@ unsigned long _atomic_or(volatile unsigned long *p, unsigned long mask)
 }
 EXPORT_SYMBOL(_atomic_or);
 
+unsigned long _atomic_and(volatile unsigned long *p, unsigned long mask)
+{
+	return __atomic_and((int *)p, __atomic_setup(p), mask).val;
+}
+EXPORT_SYMBOL(_atomic_and);
+
 unsigned long _atomic_andn(volatile unsigned long *p, unsigned long mask)
 {
 	return __atomic_andn((int *)p, __atomic_setup(p), mask).val;
@@ -136,6 +142,23 @@ long long _atomic64_cmpxchg(long long *v, long long o, long long n)
 }
 EXPORT_SYMBOL(_atomic64_cmpxchg);
 
+long long _atomic64_and(long long *v, long long n)
+{
+	return __atomic64_and(v, __atomic_setup(v), n);
+}
+EXPORT_SYMBOL(_atomic64_and);
+
+long long _atomic64_or(long long *v, long long n)
+{
+	return __atomic64_or(v, __atomic_setup(v), n);
+}
+EXPORT_SYMBOL(_atomic64_or);
+
+long long _atomic64_xor(long long *v, long long n)
+{
+	return __atomic64_xor(v, __atomic_setup(v), n);
+}
+EXPORT_SYMBOL(_atomic64_xor);
 
 /*
  * If any of the atomic or futex routines hit a bad address (not in
diff --git a/arch/tile/lib/atomic_asm_32.S b/arch/tile/lib/atomic_asm_32.S
index 6bda3132cd61..f611265633d6 100644
--- a/arch/tile/lib/atomic_asm_32.S
+++ b/arch/tile/lib/atomic_asm_32.S
@@ -178,6 +178,7 @@ atomic_op _xchg_add, 32, "add r24, r22, r2"
 atomic_op _xchg_add_unless, 32, \
 	"sne r26, r22, r2; { bbns r26, 3f; add r24, r22, r3 }"
 atomic_op _or, 32, "or r24, r22, r2"
+atomic_op _and, 32, "and r24, r22, r2"
 atomic_op _andn, 32, "nor r2, r2, zero; and r24, r22, r2"
 atomic_op _xor, 32, "xor r24, r22, r2"
 
@@ -191,6 +192,9 @@ atomic_op 64_xchg_add_unless, 64, \
 	{ bbns r26, 3f; add r24, r22, r4 }; \
 	{ bbns r27, 3f; add r25, r23, r5 }; \
 	slt_u r26, r24, r22; add r25, r25, r26"
+atomic_op 64_or, 64, "{ or r24, r22, r2; or r25, r23, r3 }"
+atomic_op 64_and, 64, "{ and r24, r22, r2; and r25, r23, r3 }"
+atomic_op 64_xor, 64, "{ xor r24, r22, r2; xor r25, r23, r3 }"
 
 	jrp     lr              /* happy backtracer */
 
-- 
2.1.2
