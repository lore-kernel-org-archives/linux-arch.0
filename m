From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 19/28] xtensa: Provide atomic_{or,xor,and}
Date: Thu, 16 Jul 2015 19:21:29 +0200
Message-ID: <20150716172925.770646411@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-xtensa-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/xtensa/include/asm/atomic.h |   85 +++++++--------------------------------
 1 file changed, 16 insertions(+), 69 deletions(-)

--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -145,10 +145,26 @@ static inline int atomic_##op##_return(i
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
 
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_or(mask, v);
+}
+
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_and(~mask, v);
+}
+
 /**
  * atomic_sub_and_test - subtract value from variable and test result
  * @i: integer value to subtract
@@ -250,75 +266,6 @@ static __inline__ int __atomic_add_unles
 	return c;
 }
 
-
-static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-#if XCHAL_HAVE_S32C1I
-	unsigned long tmp;
-	int result;
-
-	__asm__ __volatile__(
-			"1:     l32i    %1, %3, 0\n"
-			"       wsr     %1, scompare1\n"
-			"       and     %0, %1, %2\n"
-			"       s32c1i  %0, %3, 0\n"
-			"       bne     %0, %1, 1b\n"
-			: "=&a" (result), "=&a" (tmp)
-			: "a" (~mask), "a" (v)
-			: "memory"
-			);
-#else
-	unsigned int all_f = -1;
-	unsigned int vval;
-
-	__asm__ __volatile__(
-			"       rsil    a15,"__stringify(LOCKLEVEL)"\n"
-			"       l32i    %0, %2, 0\n"
-			"       xor     %1, %4, %3\n"
-			"       and     %0, %0, %4\n"
-			"       s32i    %0, %2, 0\n"
-			"       wsr     a15, ps\n"
-			"       rsync\n"
-			: "=&a" (vval), "=a" (mask)
-			: "a" (v), "a" (all_f), "1" (mask)
-			: "a15", "memory"
-			);
-#endif
-}
-
-static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-#if XCHAL_HAVE_S32C1I
-	unsigned long tmp;
-	int result;
-
-	__asm__ __volatile__(
-			"1:     l32i    %1, %3, 0\n"
-			"       wsr     %1, scompare1\n"
-			"       or      %0, %1, %2\n"
-			"       s32c1i  %0, %3, 0\n"
-			"       bne     %0, %1, 1b\n"
-			: "=&a" (result), "=&a" (tmp)
-			: "a" (mask), "a" (v)
-			: "memory"
-			);
-#else
-	unsigned int vval;
-
-	__asm__ __volatile__(
-			"       rsil    a15,"__stringify(LOCKLEVEL)"\n"
-			"       l32i    %0, %2, 0\n"
-			"       or      %0, %0, %1\n"
-			"       s32i    %0, %2, 0\n"
-			"       wsr     a15, ps\n"
-			"       rsync\n"
-			: "=&a" (vval)
-			: "a" (mask), "a" (v)
-			: "a15", "memory"
-			);
-#endif
-}
-
 #endif /* __KERNEL__ */
 
 #endif /* _XTENSA_ATOMIC_H */
