From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 20:28:44 +0200
Message-ID: <20160621182844.GT30927@twins.programming.kicks-ass.net>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
 <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <20160621124247.GM30921@twins.programming.kicks-ass.net>
 <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
 <20160621140408.GE3704@worktop>
 <20160621141435.GB7381@worktop>
 <94270f5c-1a28-f9d7-2b5a-eb874dc35398@mellanox.com>
 <20160621170607.GQ30154@twins.programming.kicks-ass.net>
 <20160621172918.GS30927@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:46137 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbcFUS2t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 14:28:49 -0400
Content-Disposition: inline
In-Reply-To: <20160621172918.GS30927@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Jun 21, 2016 at 07:29:18PM +0200, Peter Zijlstra wrote:

> OK, I seem to have a tilepro-linux-gcc-6.1.1 build done. Lets see if I
> can build me a kernel with it.

The below, much larger than desired, patch seems to make it go again.

I had to s/__atomic_fetch/__atomic32_fetch/ to avoid a namespace clash
with the builtin C11 atomic primitives.

You want me to rename them all to regain consistent naming?

---
 arch/tile/include/asm/atomic_32.h |   16 ++++++++--------
 arch/tile/include/asm/futex.h     |    6 +++---
 arch/tile/lib/atomic_32.c         |    8 ++++----
 arch/tile/lib/atomic_asm_32.S     |    8 ++++----
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/tile/include/asm/atomic_32.h b/arch/tile/include/asm/atomic_32.h
index da8eb4e..e063825 100644
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
 
@@ -272,10 +272,10 @@ extern struct __get_user __atomic_xchg(volatile int *p, int *lock, int n);
 extern struct __get_user __atomic_xchg_add(volatile int *p, int *lock, int n);
 extern struct __get_user __atomic_xchg_add_unless(volatile int *p,
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
index 1a6ef1b..479b28b 100644
--- a/arch/tile/include/asm/futex.h
+++ b/arch/tile/include/asm/futex.h
@@ -82,9 +82,9 @@
 
 #define __futex_set() __futex_call(__atomic_xchg)
 #define __futex_add() __futex_call(__atomic_xchg_add)
-#define __futex_or() __futex_call(__atomic_or)
-#define __futex_andn() __futex_call(__atomic_andn)
-#define __futex_xor() __futex_call(__atomic_xor)
+#define __futex_or() __futex_call(__atomic32_fetch_or)
+#define __futex_andn() __futex_call(__atomic32_fetch_andn)
+#define __futex_xor() __futex_call(__atomic32_fetch_xor)
 
 #define __futex_cmpxchg()						\
 	{								\
diff --git a/arch/tile/lib/atomic_32.c b/arch/tile/lib/atomic_32.c
index 5b6bd93..64d12fa 100644
--- a/arch/tile/lib/atomic_32.c
+++ b/arch/tile/lib/atomic_32.c
@@ -90,25 +90,25 @@ EXPORT_SYMBOL(_atomic_cmpxchg);
 
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
index 507abdd..e78fed0 100644
--- a/arch/tile/lib/atomic_asm_32.S
+++ b/arch/tile/lib/atomic_asm_32.S
@@ -177,10 +177,10 @@ atomic_op _xchg, 32, "move r24, r2"
 atomic_op _xchg_add, 32, "add r24, r22, r2"
 atomic_op _xchg_add_unless, 32, \
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
