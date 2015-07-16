From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 11/28] m68k: Provide atomic_{or,xor,and}
Date: Thu, 16 Jul 2015 19:21:21 +0200
Message-ID: <20150716172925.160457233@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-m68k-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/include/asm/atomic.h |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -77,6 +77,12 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+
+ATOMIC_OP(and, &=, and)
+ATOMIC_OP(or, |=, or)
+ATOMIC_OP(xor, ^=, eor)
+
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
@@ -170,14 +176,14 @@ static inline int atomic_add_negative(in
 	return c != 0;
 }
 
-static inline void atomic_clear_mask(unsigned long mask, unsigned long *v)
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
-	__asm__ __volatile__("andl %1,%0" : "+m" (*v) : ASM_DI (~(mask)));
+	atomic_and(~mask, v);
 }
 
-static inline void atomic_set_mask(unsigned long mask, unsigned long *v)
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
 {
-	__asm__ __volatile__("orl %1,%0" : "+m" (*v) : ASM_DI (mask));
+	atomic_or(mask, v);
 }
 
 static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
