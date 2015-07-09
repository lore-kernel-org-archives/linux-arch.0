From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 19/24] s390: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:14 +0200
Message-ID: <20150709175309.831326362@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60125 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbGIR5Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:57:24 -0400
Content-Disposition: inline; filename=peterz-s390-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/include/asm/atomic.h |   45 ++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -28,6 +28,7 @@
 #define __ATOMIC_AND	"lan"
 #define __ATOMIC_ADD	"laa"
 #define __ATOMIC_BARRIER "bcr	14,0\n"
+#define __ATOMIC_XOR	"lax"
 
 #define __ATOMIC_LOOP(ptr, op_val, op_string, __barrier)		\
 ({									\
@@ -50,6 +51,7 @@
 #define __ATOMIC_AND	"nr"
 #define __ATOMIC_ADD	"ar"
 #define __ATOMIC_BARRIER "\n"
+#define __ATOMIC_XOR	"xr"
 
 #define __ATOMIC_LOOP(ptr, op_val, op_string, __barrier)		\
 ({									\
@@ -118,14 +120,26 @@ static inline void atomic_add(int i, ato
 #define atomic_dec_return(_v)		atomic_sub_return(1, _v)
 #define atomic_dec_and_test(_v)		(atomic_sub_return(1, _v) == 0)
 
-static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
+#define ATOMIC_OP(op, OP)						\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	__ATOMIC_LOOP(v, i, __ATOMIC_##OP, __ATOMIC_NO_BARRIER);	\
+}
+
+ATOMIC_OP(and, AND)
+ATOMIC_OP(or, OR)
+ATOMIC_OP(xor, XOR)
+
+#undef ATOMIC_OP
+
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
-	__ATOMIC_LOOP(v, ~mask, __ATOMIC_AND, __ATOMIC_NO_BARRIER);
+	atomic_and(~mask, v);
 }
 
-static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
 {
-	__ATOMIC_LOOP(v, mask, __ATOMIC_OR, __ATOMIC_NO_BARRIER);
+	atomic_or(mask, v);
 }
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
@@ -167,6 +181,7 @@ static inline int __atomic_add_unless(at
 #define __ATOMIC64_OR	"laog"
 #define __ATOMIC64_AND	"lang"
 #define __ATOMIC64_ADD	"laag"
+#define __ATOMIC64_XOR	"laxg"
 #define __ATOMIC64_BARRIER "bcr	14,0\n"
 
 #define __ATOMIC64_LOOP(ptr, op_val, op_string, __barrier)		\
@@ -189,6 +204,7 @@ static inline int __atomic_add_unless(at
 #define __ATOMIC64_OR	"ogr"
 #define __ATOMIC64_AND	"ngr"
 #define __ATOMIC64_ADD	"agr"
+#define __ATOMIC64_XOR	"xgr"
 #define __ATOMIC64_BARRIER "\n"
 
 #define __ATOMIC64_LOOP(ptr, op_val, op_string, __barrier)		\
@@ -247,16 +263,6 @@ static inline void atomic64_add(long lon
 	__ATOMIC64_LOOP(v, i, __ATOMIC64_ADD, __ATOMIC64_NO_BARRIER);
 }
 
-static inline void atomic64_clear_mask(unsigned long mask, atomic64_t *v)
-{
-	__ATOMIC64_LOOP(v, ~mask, __ATOMIC64_AND, __ATOMIC64_NO_BARRIER);
-}
-
-static inline void atomic64_set_mask(unsigned long mask, atomic64_t *v)
-{
-	__ATOMIC64_LOOP(v, mask, __ATOMIC64_OR, __ATOMIC64_NO_BARRIER);
-}
-
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
 static inline long long atomic64_cmpxchg(atomic64_t *v,
@@ -270,6 +276,17 @@ static inline long long atomic64_cmpxchg
 	return old;
 }
 
+#define ATOMIC64_OP(op, OP)						\
+static inline void atomic64_##op(long i, atomic64_t *v)			\
+{									\
+	__ATOMIC64_LOOP(v, i, __ATOMIC64_##OP, __ATOMIC64_NO_BARRIER);	\
+}
+
+ATOMIC64_OP(and, AND)
+ATOMIC64_OP(or, OR)
+ATOMIC64_OP(xor, XOR)
+
+#undef ATOMIC64_OP
 #undef __ATOMIC64_LOOP
 
 static inline int atomic64_add_unless(atomic64_t *v, long long i, long long u)
