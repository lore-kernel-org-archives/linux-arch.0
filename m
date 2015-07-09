From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 21/24] atomic: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:16 +0200
Message-ID: <20150709175310.025970572@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35425 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbbGIR4G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:56:06 -0400
Content-Disposition: inline; filename=peterz-generic-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h  |    2 --
 include/asm-generic/atomic.h   |   21 ++++++++++++++++-----
 include/asm-generic/atomic64.h |    3 +++
 include/linux/atomic.h         |   13 -------------
 lib/atomic64.c                 |    3 +++
 5 files changed, 22 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -195,8 +195,6 @@ ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 #undef ATOMIC_OP
 
 /**
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -98,20 +98,31 @@ ATOMIC_OP_RETURN(add, +)
 ATOMIC_OP_RETURN(sub, -)
 #endif
 
-#ifndef atomic_clear_mask
+#ifndef atomic_and
 ATOMIC_OP(and, &)
-#define atomic_clear_mask(i, v) atomic_and(~(i), (v))
 #endif
 
-#ifndef atomic_set_mask
-#define CONFIG_ARCH_HAS_ATOMIC_OR
+#ifndef atomic_or
 ATOMIC_OP(or, |)
-#define atomic_set_mask(i, v)	atomic_or((i), (v))
+#endif
+
+#ifndef atomic_xor
+ATOMIC_OP(xor, ^)
 #endif
 
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_and(~mask, v);
+}
+
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_or(mask, v);
+}
+
 /*
  * Atomic operations that C can't guarantee us.  Useful for
  * resource counting etc..
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -31,6 +31,9 @@ extern long long atomic64_##op##_return(
 
 ATOMIC64_OPS(add)
 ATOMIC64_OPS(sub)
+ATOMIC64_OP(and)
+ATOMIC64_OP(or)
+ATOMIC64_OP(xor)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -111,19 +111,6 @@ static inline int atomic_dec_if_positive
 }
 #endif
 
-#ifndef CONFIG_ARCH_HAS_ATOMIC_OR
-static inline void atomic_or(int i, atomic_t *v)
-{
-	int old;
-	int new;
-
-	do {
-		old = atomic_read(v);
-		new = old | i;
-	} while (atomic_cmpxchg(v, old, new) != old);
-}
-#endif /* #ifndef CONFIG_ARCH_HAS_ATOMIC_OR */
-
 #include <asm-generic/atomic-long.h>
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -102,6 +102,9 @@ EXPORT_SYMBOL(atomic64_##op##_return);
 
 ATOMIC64_OPS(add, +=)
 ATOMIC64_OPS(sub, -=)
+ATOMIC64_OP(and, &=)
+ATOMIC64_OP(or, |=)
+ATOMIC64_OP(xor, ^=)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
