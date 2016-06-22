From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jun 21
Date: Wed, 22 Jun 2016 11:16:49 +0200
Message-ID: <20160622091649.GB30154@twins.programming.kicks-ass.net>
References: <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <20160621124247.GM30921@twins.programming.kicks-ass.net>
 <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
 <20160621140408.GE3704@worktop>
 <20160621141435.GB7381@worktop>
 <94270f5c-1a28-f9d7-2b5a-eb874dc35398@mellanox.com>
 <20160621170607.GQ30154@twins.programming.kicks-ass.net>
 <20160621172918.GS30927@twins.programming.kicks-ass.net>
 <20160621182844.GT30927@twins.programming.kicks-ass.net>
 <ff97cde6-44e2-e25d-7bd2-78dbf344fc7b@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ff97cde6-44e2-e25d-7bd2-78dbf344fc7b@mellanox.com>
Sender: linux-next-owner@vger.kernel.org
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 21, 2016 at 02:36:34PM -0400, Chris Metcalf wrote:
> On 6/21/2016 2:28 PM, Peter Zijlstra wrote:
> >On Tue, Jun 21, 2016 at 07:29:18PM +0200, Peter Zijlstra wrote:
> >
> >>>OK, I seem to have a tilepro-linux-gcc-6.1.1 build done. Lets see if I
> >>>can build me a kernel with it.
> >The below, much larger than desired, patch seems to make it go again.
> >
> >I had to s/__atomic_fetch/__atomic32_fetch/ to avoid a namespace clash
> >with the builtin C11 atomic primitives.
> >
> >You want me to rename them all to regain consistent naming?
> 
> Yes, it's probably the right thing to do.  All the internal routines with "atomic32"
> or "atomic64" I assume you mean?

Something like so then?

---
 arch/tile/include/asm/atomic_32.h |   24 ++++++++++++------------
 arch/tile/include/asm/futex.h     |   14 +++++++-------
 arch/tile/lib/atomic_32.c         |   16 ++++++++--------
 arch/tile/lib/atomic_asm_32.S     |   21 +++++++++++++--------
 4 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/arch/tile/include/asm/atomic_32.h b/arch/tile/include/asm/atomic_32.h
index da8eb4e..a937742 100644
--- a/arch/tile/include/asm/atomic_32.h
+++ b/arch/tile/include/asm/atomic_32.h
@@ -143,15 +143,15 @@ static inline void atomic64_##op(long long i, atomic64_t *v)	\
 {								\
 	_atomic64_fetch_##op(&v->counter, i);			\
 }								\
-static inline void atomic64_##op(long long i, atomic64_t *v)	\
+static inline long long atomic64_fetch_##op(long long i, atomic64_t *v)	\
 {								\
 	smp_mb();						\
 	return _atomic64_fetch_##op(&v->counter, i);		\
 }
 
-ATOMIC64_OP(and)
-ATOMIC64_OP(or)
-ATOMIC64_OP(xor)
+ATOMIC64_OPS(and)
+ATOMIC64_OPS(or)
+ATOMIC64_OPS(xor)
 
 #undef ATOMIC64_OPS
 
@@ -266,16 +266,16 @@ struct __get_user {
 	unsigned long val;
 	int err;
 };
-extern struct __get_user __atomic_cmpxchg(volatile int *p,
+extern struct __get_user __atomic32_cmpxchg(volatile int *p,
 					  int *lock, int o, int n);
-extern struct __get_user __atomic_xchg(volatile int *p, int *lock, int n);
-extern struct __get_user __atomic_xchg_add(volatile int *p, int *lock, int n);
-extern struct __get_user __atomic_xchg_add_unless(volatile int *p,
+extern struct __get_user __atomic32_xchg(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic32_xchg_add(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic32_xchg_add_unless(volatile int *p,
 						  int *lock, int o, int n);
-extern struct __get_user __atomic_fetch_or(volatile int *p, int *lock, int n);
-extern struct __get_user __atomic_fetch_and(volatile int *p, int *lock, int n);
-extern struct __get_user __atomic_fetch_andn(volatile int *p, int *lock, int n);
-extern struct __get_user __atomic_fetch_xor(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic32_fetch_or(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic32_fetch_and(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic32_fetch_andn(volatile int *p, int *lock, int n);
+extern struct __get_user __atomic32_fetch_xor(volatile int *p, int *lock, int n);
 extern long long __atomic64_cmpxchg(volatile long long *p, int *lock,
 					long long o, long long n);
 extern long long __atomic64_xchg(volatile long long *p, int *lock, long long n);
diff --git a/arch/tile/include/asm/futex.h b/arch/tile/include/asm/futex.h
index 1a6ef1b..e64a1b7 100644
--- a/arch/tile/include/asm/futex.h
+++ b/arch/tile/include/asm/futex.h
@@ -80,16 +80,16 @@
 		ret = gu.err;						\
 	}
 
-#define __futex_set() __futex_call(__atomic_xchg)
-#define __futex_add() __futex_call(__atomic_xchg_add)
-#define __futex_or() __futex_call(__atomic_or)
-#define __futex_andn() __futex_call(__atomic_andn)
-#define __futex_xor() __futex_call(__atomic_xor)
+#define __futex_set() __futex_call(__atomic32_xchg)
+#define __futex_add() __futex_call(__atomic32_xchg_add)
+#define __futex_or() __futex_call(__atomic32_fetch_or)
+#define __futex_andn() __futex_call(__atomic32_fetch_andn)
+#define __futex_xor() __futex_call(__atomic32_fetch_xor)
 
 #define __futex_cmpxchg()						\
 	{								\
-		struct __get_user gu = __atomic_cmpxchg((u32 __force *)uaddr, \
-							lock, oldval, oparg); \
+		struct __get_user gu = __atomic32_cmpxchg((u32 __force *)uaddr, \
+							  lock, oldval, oparg); \
 		val = gu.val;						\
 		ret = gu.err;						\
 	}
diff --git a/arch/tile/lib/atomic_32.c b/arch/tile/lib/atomic_32.c
index 5b6bd93..f812880 100644
--- a/arch/tile/lib/atomic_32.c
+++ b/arch/tile/lib/atomic_32.c
@@ -61,13 +61,13 @@ static inline int *__atomic_setup(volatile void *v)
 
 int _atomic_xchg(int *v, int n)
 {
-	return __atomic_xchg(v, __atomic_setup(v), n).val;
+	return __atomic32_xchg(v, __atomic_setup(v), n).val;
 }
 EXPORT_SYMBOL(_atomic_xchg);
 
 int _atomic_xchg_add(int *v, int i)
 {
-	return __atomic_xchg_add(v, __atomic_setup(v), i).val;
+	return __atomic32_xchg_add(v, __atomic_setup(v), i).val;
 }
 EXPORT_SYMBOL(_atomic_xchg_add);
 
@@ -78,37 +78,37 @@ int _atomic_xchg_add_unless(int *v, int a, int u)
 	 * to use the first argument consistently as the "old value"
 	 * in the assembly, as is done for _atomic_cmpxchg().
 	 */
-	return __atomic_xchg_add_unless(v, __atomic_setup(v), u, a).val;
+	return __atomic32_xchg_add_unless(v, __atomic_setup(v), u, a).val;
 }
 EXPORT_SYMBOL(_atomic_xchg_add_unless);
 
 int _atomic_cmpxchg(int *v, int o, int n)
 {
-	return __atomic_cmpxchg(v, __atomic_setup(v), o, n).val;
+	return __atomic32_cmpxchg(v, __atomic_setup(v), o, n).val;
 }
 EXPORT_SYMBOL(_atomic_cmpxchg);
 
 unsigned long _atomic_fetch_or(volatile unsigned long *p, unsigned long mask)
 {
-	return __atomic_fetch_or((int *)p, __atomic_setup(p), mask).val;
+	return __atomic32_fetch_or((int *)p, __atomic_setup(p), mask).val;
 }
 EXPORT_SYMBOL(_atomic_fetch_or);
 
 unsigned long _atomic_fetch_and(volatile unsigned long *p, unsigned long mask)
 {
-	return __atomic_fetch_and((int *)p, __atomic_setup(p), mask).val;
+	return __atomic32_fetch_and((int *)p, __atomic_setup(p), mask).val;
 }
 EXPORT_SYMBOL(_atomic_fetch_and);
 
 unsigned long _atomic_fetch_andn(volatile unsigned long *p, unsigned long mask)
 {
-	return __atomic_fetch_andn((int *)p, __atomic_setup(p), mask).val;
+	return __atomic32_fetch_andn((int *)p, __atomic_setup(p), mask).val;
 }
 EXPORT_SYMBOL(_atomic_fetch_andn);
 
 unsigned long _atomic_fetch_xor(volatile unsigned long *p, unsigned long mask)
 {
-	return __atomic_fetch_xor((int *)p, __atomic_setup(p), mask).val;
+	return __atomic32_fetch_xor((int *)p, __atomic_setup(p), mask).val;
 }
 EXPORT_SYMBOL(_atomic_fetch_xor);
 
diff --git a/arch/tile/lib/atomic_asm_32.S b/arch/tile/lib/atomic_asm_32.S
index 507abdd..1a70e6c 100644
--- a/arch/tile/lib/atomic_asm_32.S
+++ b/arch/tile/lib/atomic_asm_32.S
@@ -172,15 +172,20 @@ STD_ENTRY_SECTION(__atomic\name, .text.atomic)
 	.endif
 	.endm
 
-atomic_op _cmpxchg, 32, "seq r26, r22, r2; { bbns r26, 3f; move r24, r3 }"
-atomic_op _xchg, 32, "move r24, r2"
-atomic_op _xchg_add, 32, "add r24, r22, r2"
-atomic_op _xchg_add_unless, 32, \
+
+/*
+ * Use __atomic32 prefix to avoid collisions with GCC builtin __atomic functions.
+ */
+
+atomic_op 32_cmpxchg, 32, "seq r26, r22, r2; { bbns r26, 3f; move r24, r3 }"
+atomic_op 32_xchg, 32, "move r24, r2"
+atomic_op 32_xchg_add, 32, "add r24, r22, r2"
+atomic_op 32_xchg_add_unless, 32, \
 	"sne r26, r22, r2; { bbns r26, 3f; add r24, r22, r3 }"
-atomic_op _fetch_or, 32, "or r24, r22, r2"
-atomic_op _fetch_and, 32, "and r24, r22, r2"
-atomic_op _fetch_andn, 32, "nor r2, r2, zero; and r24, r22, r2"
-atomic_op _fetch_xor, 32, "xor r24, r22, r2"
+atomic_op 32_fetch_or, 32, "or r24, r22, r2"
+atomic_op 32_fetch_and, 32, "and r24, r22, r2"
+atomic_op 32_fetch_andn, 32, "nor r2, r2, zero; and r24, r22, r2"
+atomic_op 32_fetch_xor, 32, "xor r24, r22, r2"
 
 atomic_op 64_cmpxchg, 64, "{ seq r26, r22, r2; seq r27, r23, r3 }; \
 	{ bbns r26, 3f; move r24, r4 }; { bbns r27, 3f; move r25, r5 }"
