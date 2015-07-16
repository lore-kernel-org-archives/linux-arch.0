From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 12/28] metag: Provide atomic_{or,xor,and}
Date: Thu, 16 Jul 2015 19:21:22 +0200
Message-ID: <20150716172925.241515353@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-metag-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/metag/include/asm/atomic_lnkget.h |   38 ++++++++-------------------------
 arch/metag/include/asm/atomic_lock1.h  |   21 ++++++------------
 2 files changed, 17 insertions(+), 42 deletions(-)

--- a/arch/metag/include/asm/atomic_lnkget.h
+++ b/arch/metag/include/asm/atomic_lnkget.h
@@ -74,42 +74,24 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
+
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
-	int temp;
-
-	asm volatile (
-		"1:	LNKGETD %0, [%1]\n"
-		"	AND	%0, %0, %2\n"
-		"	LNKSETD	[%1] %0\n"
-		"	DEFR	%0, TXSTAT\n"
-		"	ANDT	%0, %0, #HI(0x3f000000)\n"
-		"	CMPT	%0, #HI(0x02000000)\n"
-		"	BNZ	1b\n"
-		: "=&d" (temp)
-		: "da" (&v->counter), "bd" (~mask)
-		: "cc");
+	atomic_and(~mask, v);
 }
 
-static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
 {
-	int temp;
-
-	asm volatile (
-		"1:	LNKGETD %0, [%1]\n"
-		"	OR	%0, %0, %2\n"
-		"	LNKSETD	[%1], %0\n"
-		"	DEFR	%0, TXSTAT\n"
-		"	ANDT	%0, %0, #HI(0x3f000000)\n"
-		"	CMPT	%0, #HI(0x02000000)\n"
-		"	BNZ	1b\n"
-		: "=&d" (temp)
-		: "da" (&v->counter), "bd" (mask)
-		: "cc");
+	atomic_or(mask, v);
 }
 
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
--- a/arch/metag/include/asm/atomic_lock1.h
+++ b/arch/metag/include/asm/atomic_lock1.h
@@ -68,29 +68,22 @@ static inline int atomic_##op##_return(i
 
 ATOMIC_OPS(add, +=)
 ATOMIC_OPS(sub, -=)
+ATOMIC_OP(and, &=)
+ATOMIC_OP(or, |=)
+ATOMIC_OP(xor, ^=)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
-	unsigned long flags;
-
-	__global_lock1(flags);
-	fence();
-	v->counter &= ~mask;
-	__global_unlock1(flags);
+	atomic_and(~mask, v);
 }
 
-static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
 {
-	unsigned long flags;
-
-	__global_lock1(flags);
-	fence();
-	v->counter |= mask;
-	__global_unlock1(flags);
+	atomic_or(mask, v);
 }
 
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
