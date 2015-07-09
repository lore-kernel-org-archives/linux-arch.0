From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 08/24] ia64: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:03 +0200
Message-ID: <20150709175308.732475129@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35496 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbbGIR4H (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:56:07 -0400
Content-Disposition: inline; filename=peterz-ia64-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/ia64/include/asm/atomic.h |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -45,8 +45,6 @@ ia64_atomic_##op (int i, atomic_t *v)
 ATOMIC_OP(add, +)
 ATOMIC_OP(sub, -)
 
-#undef ATOMIC_OP
-
 #define atomic_add_return(i,v)						\
 ({									\
 	int __ia64_aar_i = (i);						\
@@ -71,6 +69,16 @@ ATOMIC_OP(sub, -)
 		: ia64_atomic_sub(__ia64_asr_i, v);			\
 })
 
+ATOMIC_OP(and, &)
+ATOMIC_OP(or, |)
+ATOMIC_OP(xor, ^)
+
+#define atomic_and(i,v)	(void)ia64_atomic_and(i,v)
+#define atomic_or(i,v)	(void)ia64_atomic_or(i,v)
+#define atomic_xor(i,v)	(void)ia64_atomic_xor(i,v)
+
+#undef ATOMIC_OP
+
 #define ATOMIC64_OP(op, c_op)						\
 static __inline__ long							\
 ia64_atomic64_##op (__s64 i, atomic64_t *v)				\
@@ -89,8 +97,6 @@ ia64_atomic64_##op (__s64 i, atomic64_t
 ATOMIC64_OP(add, +)
 ATOMIC64_OP(sub, -)
 
-#undef ATOMIC64_OP
-
 #define atomic64_add_return(i,v)					\
 ({									\
 	long __ia64_aar_i = (i);					\
@@ -115,6 +121,16 @@ ATOMIC64_OP(sub, -)
 		: ia64_atomic64_sub(__ia64_asr_i, v);			\
 })
 
+ATOMIC64_OP(and, &)
+ATOMIC64_OP(or, |)
+ATOMIC64_OP(xor, ^)
+
+#define atomic64_and(i,v)	(void)ia64_atomic64_and(i,v)
+#define atomic64_or(i,v)	(void)ia64_atomic64_or(i,v)
+#define atomic64_xor(i,v)	(void)ia64_atomic64_xor(i,v)
+
+#undef ATOMIC64_OP
+
 #define atomic_cmpxchg(v, old, new) (cmpxchg(&((v)->counter), old, new))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
