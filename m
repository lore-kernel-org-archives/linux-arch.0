From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 22/28] frv: Rewrite atomic implementation
Date: Thu, 16 Jul 2015 19:21:32 +0200
Message-ID: <20150716172926.058885334@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-frv-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Mostly complete rewrite of the FRV atomic implementation, instead of
using assembly files, use inline assembler.

The out-of-line CONFIG option makes a bit of a mess of things, but a
little CPP trickery gets that done too.

FRV already had the atomic logic ops but under a non standard name,
the reimplementation provides the generic names and provides the
intermediate form required for the bitops implementation.

The slightly inconsistent __atomic32_fetch_##op naming is because
__atomic_fetch_##op conlicts with GCC builtin functions.

The 64bit atomic ops use the inline assembly %Ln construct to access
the low word register (r+1), afaik this construct was not previously
used in the kernel and is completely undocumented, but I found it in
the FRV GCC code and it seems to work.

FRV had a non-standard definition of atomic_{clear,set}_mask() which
would work types other than atomic_t, the one user relying on that
(arch/frv/kernel/dma.c) got converted to use the new intermediate
form.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/frv/include/asm/atomic.h      |  119 ++++++++++++++-----------
 arch/frv/include/asm/atomic_defs.h |  172 +++++++++++++++++++++++++++++++++++++
 arch/frv/include/asm/bitops.h      |   99 ++-------------------
 arch/frv/kernel/dma.c              |    6 -
 arch/frv/kernel/frv_ksyms.c        |    5 -
 arch/frv/lib/Makefile              |    2 
 arch/frv/lib/atomic-lib.c          |    7 +
 arch/frv/lib/atomic-ops.S          |  110 -----------------------
 arch/frv/lib/atomic64-ops.S        |   94 --------------------
 9 files changed, 259 insertions(+), 355 deletions(-)

--- a/arch/frv/include/asm/atomic.h
+++ b/arch/frv/include/asm/atomic.h
@@ -15,7 +15,6 @@
 #define _ASM_ATOMIC_H
 
 #include <linux/types.h>
-#include <asm/spr-regs.h>
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
@@ -23,6 +22,8 @@
 #error not SMP safe
 #endif
 
+#include <asm/atomic_defs.h>
+
 /*
  * Atomic operations that C can't guarantee us.  Useful for
  * resource counting etc..
@@ -34,56 +35,26 @@
 #define atomic_read(v)		ACCESS_ONCE((v)->counter)
 #define atomic_set(v, i)	(((v)->counter) = (i))
 
-#ifndef CONFIG_FRV_OUTOFLINE_ATOMIC_OPS
-static inline int atomic_add_return(int i, atomic_t *v)
+static inline int atomic_inc_return(atomic_t *v)
 {
-	unsigned long val;
+	return __atomic_add_return(1, &v->counter);
+}
 
-	asm("0:						\n"
-	    "	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
-	    "	ckeq		icc3,cc7		\n"
-	    "	ld.p		%M0,%1			\n"	/* LD.P/ORCR must be atomic */
-	    "	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
-	    "	add%I2		%1,%2,%1		\n"
-	    "	cst.p		%1,%M0		,cc3,#1	\n"
-	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* clear ICC3.Z if store happens */
-	    "	beq		icc3,#0,0b		\n"
-	    : "+U"(v->counter), "=&r"(val)
-	    : "NPr"(i)
-	    : "memory", "cc7", "cc3", "icc3"
-	    );
+static inline int atomic_dec_return(atomic_t *v)
+{
+	return __atomic_sub_return(1, &v->counter);
+}
 
-	return val;
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	return __atomic_add_return(i, &v->counter);
 }
 
 static inline int atomic_sub_return(int i, atomic_t *v)
 {
-	unsigned long val;
-
-	asm("0:						\n"
-	    "	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
-	    "	ckeq		icc3,cc7		\n"
-	    "	ld.p		%M0,%1			\n"	/* LD.P/ORCR must be atomic */
-	    "	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
-	    "	sub%I2		%1,%2,%1		\n"
-	    "	cst.p		%1,%M0		,cc3,#1	\n"
-	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* clear ICC3.Z if store happens */
-	    "	beq		icc3,#0,0b		\n"
-	    : "+U"(v->counter), "=&r"(val)
-	    : "NPr"(i)
-	    : "memory", "cc7", "cc3", "icc3"
-	    );
-
-	return val;
+	return __atomic_sub_return(i, &v->counter);
 }
 
-#else
-
-extern int atomic_add_return(int i, atomic_t *v);
-extern int atomic_sub_return(int i, atomic_t *v);
-
-#endif
-
 static inline int atomic_add_negative(int i, atomic_t *v)
 {
 	return atomic_add_return(i, v) < 0;
@@ -101,17 +72,14 @@ static inline void atomic_sub(int i, ato
 
 static inline void atomic_inc(atomic_t *v)
 {
-	atomic_add_return(1, v);
+	atomic_inc_return(v);
 }
 
 static inline void atomic_dec(atomic_t *v)
 {
-	atomic_sub_return(1, v);
+	atomic_dec_return(v);
 }
 
-#define atomic_dec_return(v)		atomic_sub_return(1, (v))
-#define atomic_inc_return(v)		atomic_add_return(1, (v))
-
 #define atomic_sub_and_test(i,v)	(atomic_sub_return((i), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_sub_return(1, (v)) == 0)
 #define atomic_inc_and_test(v)		(atomic_add_return(1, (v)) == 0)
@@ -120,18 +88,19 @@ static inline void atomic_dec(atomic_t *
  * 64-bit atomic ops
  */
 typedef struct {
-	volatile long long counter;
+	long long counter;
 } atomic64_t;
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-static inline long long atomic64_read(atomic64_t *v)
+static inline long long atomic64_read(const atomic64_t *v)
 {
 	long long counter;
 
 	asm("ldd%I1 %M1,%0"
 	    : "=e"(counter)
 	    : "m"(v->counter));
+
 	return counter;
 }
 
@@ -142,10 +111,25 @@ static inline void atomic64_set(atomic64
 		     : "e"(i));
 }
 
-extern long long atomic64_inc_return(atomic64_t *v);
-extern long long atomic64_dec_return(atomic64_t *v);
-extern long long atomic64_add_return(long long i, atomic64_t *v);
-extern long long atomic64_sub_return(long long i, atomic64_t *v);
+static inline long long atomic64_inc_return(atomic64_t *v)
+{
+	return __atomic64_add_return(1, &v->counter);
+}
+
+static inline long long atomic64_dec_return(atomic64_t *v)
+{
+	return __atomic64_sub_return(1, &v->counter);
+}
+
+static inline long long atomic64_add_return(long long i, atomic64_t *v)
+{
+	return __atomic64_add_return(i, &v->counter);
+}
+
+static inline long long atomic64_sub_return(long long i, atomic64_t *v)
+{
+	return __atomic64_sub_return(i, &v->counter);
+}
 
 static inline long long atomic64_add_negative(long long i, atomic64_t *v)
 {
@@ -176,6 +160,7 @@ static inline void atomic64_dec(atomic64
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 #define atomic64_inc_and_test(v)	(atomic64_inc_return((v)) == 0)
 
+
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&(v)->counter, old, new))
 #define atomic_xchg(v, new)		(xchg(&(v)->counter, new))
 #define atomic64_cmpxchg(v, old, new)	(__cmpxchg_64(old, new, &(v)->counter))
@@ -196,5 +181,33 @@ static __inline__ int __atomic_add_unles
 	return c;
 }
 
+#define ATOMIC_OP(op)							\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	(void)__atomic32_fetch_##op(i, &v->counter);			\
+}									\
+									\
+static inline void atomic64_##op(long long i, atomic64_t *v)		\
+{									\
+	(void)__atomic64_fetch_##op(i, &v->counter);			\
+}
+
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+
+ATOMIC_OP(or)
+ATOMIC_OP(and)
+ATOMIC_OP(xor)
+
+#undef ATOMIC_OP
+
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_and(~mask, v);
+}
+
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_or(mask, v);
+}
 
 #endif /* _ASM_ATOMIC_H */
--- /dev/null
+++ b/arch/frv/include/asm/atomic_defs.h
@@ -0,0 +1,172 @@
+
+#include <asm/spr-regs.h>
+
+#ifdef __ATOMIC_LIB__
+
+#ifdef CONFIG_FRV_OUTOFLINE_ATOMIC_OPS
+
+#define ATOMIC_QUALS
+#define ATOMIC_EXPORT(x)	EXPORT_SYMBOL(x)
+
+#else /* !OUTOFLINE && LIB */
+
+#define ATOMIC_OP_RETURN(op)
+#define ATOMIC_FETCH_OP(op)
+
+#endif /* OUTOFLINE */
+
+#else /* !__ATOMIC_LIB__ */
+
+#define ATOMIC_EXPORT(x)
+
+#ifdef CONFIG_FRV_OUTOFLINE_ATOMIC_OPS
+
+#define ATOMIC_OP_RETURN(op)						\
+extern int __atomic_##op##_return(int i, int *v);			\
+extern long long __atomic64_##op##_return(long long i, long long *v);
+
+#define ATOMIC_FETCH_OP(op)						\
+extern int __atomic32_fetch_##op(int i, int *v);			\
+extern long long __atomic64_fetch_##op(long long i, long long *v);
+
+#else /* !OUTOFLINE && !LIB */
+
+#define ATOMIC_QUALS	static inline
+
+#endif /* OUTOFLINE */
+#endif /* __ATOMIC_LIB__ */
+
+
+/*
+ * Note on the 64 bit inline asm variants...
+ *
+ * CSTD is a conditional instruction and needs a constrained memory reference.
+ * Normally 'U' provides the correct constraints for conditional instructions
+ * and this is used for the 32 bit version, however 'U' does not appear to work
+ * for 64 bit values (gcc-4.9)
+ *
+ * The exact constraint is that conditional instructions cannot deal with an
+ * immediate displacement in the memory reference, so what we do is we read the
+ * address through a volatile cast into a local variable in order to insure we
+ * _have_ to compute the correct address without displacement. This allows us
+ * to use the regular 'm' for the memory address.
+ *
+ * Furthermore, the %Ln operand, which prints the low word register (r+1),
+ * really only works for registers, this means we cannot allow immediate values
+ * for the 64 bit versions -- like we do for the 32 bit ones.
+ *
+ */
+
+#ifndef ATOMIC_OP_RETURN
+#define ATOMIC_OP_RETURN(op)						\
+ATOMIC_QUALS int __atomic_##op##_return(int i, int *v)			\
+{									\
+	int val;							\
+									\
+	asm volatile(							\
+	    "0:						\n"		\
+	    "	orcc		gr0,gr0,gr0,icc3	\n"		\
+	    "	ckeq		icc3,cc7		\n"		\
+	    "	ld.p		%M0,%1			\n"		\
+	    "	orcr		cc7,cc7,cc3		\n"		\
+	    "   "#op"%I2	%1,%2,%1		\n"		\
+	    "	cst.p		%1,%M0		,cc3,#1	\n"		\
+	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"		\
+	    "	beq		icc3,#0,0b		\n"		\
+	    : "+U"(*v), "=&r"(val)					\
+	    : "NPr"(i)							\
+	    : "memory", "cc7", "cc3", "icc3"				\
+	    );								\
+									\
+	return val;							\
+}									\
+ATOMIC_EXPORT(__atomic_##op##_return);					\
+									\
+ATOMIC_QUALS long long __atomic64_##op##_return(long long i, long long *v)	\
+{									\
+	long long *__v = READ_ONCE(v);					\
+	long long val;							\
+									\
+	asm volatile(							\
+	    "0:						\n"		\
+	    "	orcc		gr0,gr0,gr0,icc3	\n"		\
+	    "	ckeq		icc3,cc7		\n"		\
+	    "	ldd.p		%M0,%1			\n"		\
+	    "	orcr		cc7,cc7,cc3		\n"		\
+	    "   "#op"cc		%L1,%L2,%L1,icc0	\n"		\
+	    "   "#op"x		%1,%2,%1,icc0		\n"		\
+	    "	cstd.p		%1,%M0		,cc3,#1	\n"		\
+	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"		\
+	    "	beq		icc3,#0,0b		\n"		\
+	    : "+m"(*__v), "=&e"(val)					\
+	    : "e"(i)							\
+	    : "memory", "cc7", "cc3", "icc0", "icc3"			\
+	    );								\
+									\
+	return val;							\
+}									\
+ATOMIC_EXPORT(__atomic64_##op##_return);
+#endif
+
+#ifndef ATOMIC_FETCH_OP
+#define ATOMIC_FETCH_OP(op)						\
+ATOMIC_QUALS int __atomic32_fetch_##op(int i, int *v)			\
+{									\
+	int old, tmp;							\
+									\
+	asm volatile(							\
+		"0:						\n"	\
+		"	orcc		gr0,gr0,gr0,icc3	\n"	\
+		"	ckeq		icc3,cc7		\n"	\
+		"	ld.p		%M0,%1			\n"	\
+		"	orcr		cc7,cc7,cc3		\n"	\
+		"	"#op"%I3	%1,%3,%2		\n"	\
+		"	cst.p		%2,%M0		,cc3,#1	\n"	\
+		"	corcc		gr29,gr29,gr0	,cc3,#1	\n"	\
+		"	beq		icc3,#0,0b		\n"	\
+		: "+U"(*v), "=&r"(old), "=r"(tmp)			\
+		: "NPr"(i)						\
+		: "memory", "cc7", "cc3", "icc3"			\
+		);							\
+									\
+	return old;							\
+}									\
+ATOMIC_EXPORT(__atomic32_fetch_##op);					\
+									\
+ATOMIC_QUALS long long __atomic64_fetch_##op(long long i, long long *v)	\
+{									\
+	long long *__v = READ_ONCE(v);					\
+	long long old, tmp;						\
+									\
+	asm volatile(							\
+		"0:						\n"	\
+		"	orcc		gr0,gr0,gr0,icc3	\n"	\
+		"	ckeq		icc3,cc7		\n"	\
+		"	ldd.p		%M0,%1			\n"	\
+		"	orcr		cc7,cc7,cc3		\n"	\
+		"	"#op"		%L1,%L3,%L2		\n"	\
+		"	"#op"		%1,%3,%2		\n"	\
+		"	cstd.p		%2,%M0		,cc3,#1	\n"	\
+		"	corcc		gr29,gr29,gr0	,cc3,#1	\n"	\
+		"	beq		icc3,#0,0b		\n"	\
+		: "+m"(*__v), "=&e"(old), "=e"(tmp)			\
+		: "e"(i)						\
+		: "memory", "cc7", "cc3", "icc3"			\
+		);							\
+									\
+	return old;							\
+}									\
+ATOMIC_EXPORT(__atomic64_fetch_##op);
+#endif
+
+ATOMIC_FETCH_OP(or)
+ATOMIC_FETCH_OP(and)
+ATOMIC_FETCH_OP(xor)
+
+ATOMIC_OP_RETURN(add)
+ATOMIC_OP_RETURN(sub)
+
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_QUALS
+#undef ATOMIC_EXPORT
--- a/arch/frv/include/asm/bitops.h
+++ b/arch/frv/include/asm/bitops.h
@@ -25,109 +25,30 @@
 
 #include <asm-generic/bitops/ffz.h>
 
-#ifndef CONFIG_FRV_OUTOFLINE_ATOMIC_OPS
-static inline
-unsigned long atomic_test_and_ANDNOT_mask(unsigned long mask, volatile unsigned long *v)
-{
-	unsigned long old, tmp;
-
-	asm volatile(
-		"0:						\n"
-		"	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
-		"	ckeq		icc3,cc7		\n"
-		"	ld.p		%M0,%1			\n"	/* LD.P/ORCR are atomic */
-		"	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
-		"	and%I3		%1,%3,%2		\n"
-		"	cst.p		%2,%M0		,cc3,#1	\n"	/* if store happens... */
-		"	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* ... clear ICC3.Z */
-		"	beq		icc3,#0,0b		\n"
-		: "+U"(*v), "=&r"(old), "=r"(tmp)
-		: "NPr"(~mask)
-		: "memory", "cc7", "cc3", "icc3"
-		);
-
-	return old;
-}
-
-static inline
-unsigned long atomic_test_and_OR_mask(unsigned long mask, volatile unsigned long *v)
-{
-	unsigned long old, tmp;
-
-	asm volatile(
-		"0:						\n"
-		"	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
-		"	ckeq		icc3,cc7		\n"
-		"	ld.p		%M0,%1			\n"	/* LD.P/ORCR are atomic */
-		"	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
-		"	or%I3		%1,%3,%2		\n"
-		"	cst.p		%2,%M0		,cc3,#1	\n"	/* if store happens... */
-		"	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* ... clear ICC3.Z */
-		"	beq		icc3,#0,0b		\n"
-		: "+U"(*v), "=&r"(old), "=r"(tmp)
-		: "NPr"(mask)
-		: "memory", "cc7", "cc3", "icc3"
-		);
-
-	return old;
-}
-
-static inline
-unsigned long atomic_test_and_XOR_mask(unsigned long mask, volatile unsigned long *v)
-{
-	unsigned long old, tmp;
-
-	asm volatile(
-		"0:						\n"
-		"	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
-		"	ckeq		icc3,cc7		\n"
-		"	ld.p		%M0,%1			\n"	/* LD.P/ORCR are atomic */
-		"	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
-		"	xor%I3		%1,%3,%2		\n"
-		"	cst.p		%2,%M0		,cc3,#1	\n"	/* if store happens... */
-		"	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* ... clear ICC3.Z */
-		"	beq		icc3,#0,0b		\n"
-		: "+U"(*v), "=&r"(old), "=r"(tmp)
-		: "NPr"(mask)
-		: "memory", "cc7", "cc3", "icc3"
-		);
-
-	return old;
-}
-
-#else
-
-extern unsigned long atomic_test_and_ANDNOT_mask(unsigned long mask, volatile unsigned long *v);
-extern unsigned long atomic_test_and_OR_mask(unsigned long mask, volatile unsigned long *v);
-extern unsigned long atomic_test_and_XOR_mask(unsigned long mask, volatile unsigned long *v);
-
-#endif
-
-#define atomic_clear_mask(mask, v)	atomic_test_and_ANDNOT_mask((mask), (v))
-#define atomic_set_mask(mask, v)	atomic_test_and_OR_mask((mask), (v))
+#include <asm/atomic.h>
 
 static inline int test_and_clear_bit(unsigned long nr, volatile void *addr)
 {
-	volatile unsigned long *ptr = addr;
-	unsigned long mask = 1UL << (nr & 31);
+	unsigned int *ptr = (void *)addr;
+	unsigned int mask = 1UL << (nr & 31);
 	ptr += nr >> 5;
-	return (atomic_test_and_ANDNOT_mask(mask, ptr) & mask) != 0;
+	return (__atomic32_fetch_and(~mask, ptr) & mask) != 0;
 }
 
 static inline int test_and_set_bit(unsigned long nr, volatile void *addr)
 {
-	volatile unsigned long *ptr = addr;
-	unsigned long mask = 1UL << (nr & 31);
+	unsigned int *ptr = (void *)addr;
+	unsigned int mask = 1UL << (nr & 31);
 	ptr += nr >> 5;
-	return (atomic_test_and_OR_mask(mask, ptr) & mask) != 0;
+	return (__atomic32_fetch_or(mask, ptr) & mask) != 0;
 }
 
 static inline int test_and_change_bit(unsigned long nr, volatile void *addr)
 {
-	volatile unsigned long *ptr = addr;
-	unsigned long mask = 1UL << (nr & 31);
+	unsigned int *ptr = (void *)addr;
+	unsigned int mask = 1UL << (nr & 31);
 	ptr += nr >> 5;
-	return (atomic_test_and_XOR_mask(mask, ptr) & mask) != 0;
+	return (__atomic32_fetch_xor(mask, ptr) & mask) != 0;
 }
 
 static inline void clear_bit(unsigned long nr, volatile void *addr)
--- a/arch/frv/kernel/dma.c
+++ b/arch/frv/kernel/dma.c
@@ -109,13 +109,13 @@ static struct frv_dma_channel frv_dma_ch
 
 static DEFINE_RWLOCK(frv_dma_channels_lock);
 
-unsigned long frv_dma_inprogress;
+unsigned int frv_dma_inprogress;
 
 #define frv_clear_dma_inprogress(channel) \
-	atomic_clear_mask(1 << (channel), &frv_dma_inprogress);
+	(void)__atomic32_fetch_and(~(1 << (channel)), &frv_dma_inprogress);
 
 #define frv_set_dma_inprogress(channel) \
-	atomic_set_mask(1 << (channel), &frv_dma_inprogress);
+	(void)__atomic32_fetch_or(1 << (channel), &frv_dma_inprogress);
 
 /*****************************************************************************/
 /*
--- a/arch/frv/kernel/frv_ksyms.c
+++ b/arch/frv/kernel/frv_ksyms.c
@@ -58,11 +58,6 @@ EXPORT_SYMBOL(__outsl_ns);
 EXPORT_SYMBOL(__insl_ns);
 
 #ifdef CONFIG_FRV_OUTOFLINE_ATOMIC_OPS
-EXPORT_SYMBOL(atomic_test_and_ANDNOT_mask);
-EXPORT_SYMBOL(atomic_test_and_OR_mask);
-EXPORT_SYMBOL(atomic_test_and_XOR_mask);
-EXPORT_SYMBOL(atomic_add_return);
-EXPORT_SYMBOL(atomic_sub_return);
 EXPORT_SYMBOL(__xchg_32);
 EXPORT_SYMBOL(__cmpxchg_32);
 #endif
--- a/arch/frv/lib/Makefile
+++ b/arch/frv/lib/Makefile
@@ -5,4 +5,4 @@
 lib-y := \
 	__ashldi3.o __lshrdi3.o __muldi3.o __ashrdi3.o __negdi2.o __ucmpdi2.o \
 	checksum.o memcpy.o memset.o atomic-ops.o atomic64-ops.o \
-	outsl_ns.o outsl_sw.o insl_ns.o insl_sw.o cache.o
+	outsl_ns.o outsl_sw.o insl_ns.o insl_sw.o cache.o atomic-lib.o
--- /dev/null
+++ b/arch/frv/lib/atomic-lib.c
@@ -0,0 +1,7 @@
+
+#include <linux/export.h>
+#include <asm/atomic.h>
+
+#define __ATOMIC_LIB__
+
+#include <asm/atomic_defs.h>
--- a/arch/frv/lib/atomic-ops.S
+++ b/arch/frv/lib/atomic-ops.S
@@ -19,116 +19,6 @@
 
 ###############################################################################
 #
-# unsigned long atomic_test_and_ANDNOT_mask(unsigned long mask, volatile unsigned long *v);
-#
-###############################################################################
-	.globl		atomic_test_and_ANDNOT_mask
-        .type		atomic_test_and_ANDNOT_mask,@function
-atomic_test_and_ANDNOT_mask:
-	not.p		gr8,gr10
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	and		gr8,gr10,gr11
-	cst.p		gr11,@(gr9,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		atomic_test_and_ANDNOT_mask, .-atomic_test_and_ANDNOT_mask
-
-###############################################################################
-#
-# unsigned long atomic_test_and_OR_mask(unsigned long mask, volatile unsigned long *v);
-#
-###############################################################################
-	.globl		atomic_test_and_OR_mask
-        .type		atomic_test_and_OR_mask,@function
-atomic_test_and_OR_mask:
-	or.p		gr8,gr8,gr10
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	or		gr8,gr10,gr11
-	cst.p		gr11,@(gr9,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		atomic_test_and_OR_mask, .-atomic_test_and_OR_mask
-
-###############################################################################
-#
-# unsigned long atomic_test_and_XOR_mask(unsigned long mask, volatile unsigned long *v);
-#
-###############################################################################
-	.globl		atomic_test_and_XOR_mask
-        .type		atomic_test_and_XOR_mask,@function
-atomic_test_and_XOR_mask:
-	or.p		gr8,gr8,gr10
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	xor		gr8,gr10,gr11
-	cst.p		gr11,@(gr9,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		atomic_test_and_XOR_mask, .-atomic_test_and_XOR_mask
-
-###############################################################################
-#
-# int atomic_add_return(int i, atomic_t *v)
-#
-###############################################################################
-	.globl		atomic_add_return
-        .type		atomic_add_return,@function
-atomic_add_return:
-	or.p		gr8,gr8,gr10
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	add		gr8,gr10,gr8
-	cst.p		gr8,@(gr9,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		atomic_add_return, .-atomic_add_return
-
-###############################################################################
-#
-# int atomic_sub_return(int i, atomic_t *v)
-#
-###############################################################################
-	.globl		atomic_sub_return
-        .type		atomic_sub_return,@function
-atomic_sub_return:
-	or.p		gr8,gr8,gr10
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	ld.p		@(gr9,gr0),gr8			/* LD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	sub		gr8,gr10,gr8
-	cst.p		gr8,@(gr9,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		atomic_sub_return, .-atomic_sub_return
-
-###############################################################################
-#
 # uint32_t __xchg_32(uint32_t i, uint32_t *v)
 #
 ###############################################################################
--- a/arch/frv/lib/atomic64-ops.S
+++ b/arch/frv/lib/atomic64-ops.S
@@ -20,100 +20,6 @@
 
 ###############################################################################
 #
-# long long atomic64_inc_return(atomic64_t *v)
-#
-###############################################################################
-	.globl		atomic64_inc_return
-        .type		atomic64_inc_return,@function
-atomic64_inc_return:
-	or.p		gr8,gr8,gr10
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	ldd.p		@(gr10,gr0),gr8			/* LDD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	addicc		gr9,#1,gr9,icc0
-	addxi		gr8,#0,gr8,icc0
-	cstd.p		gr8,@(gr10,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		atomic64_inc_return, .-atomic64_inc_return
-
-###############################################################################
-#
-# long long atomic64_dec_return(atomic64_t *v)
-#
-###############################################################################
-	.globl		atomic64_dec_return
-        .type		atomic64_dec_return,@function
-atomic64_dec_return:
-	or.p		gr8,gr8,gr10
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	ldd.p		@(gr10,gr0),gr8			/* LDD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	subicc		gr9,#1,gr9,icc0
-	subxi		gr8,#0,gr8,icc0
-	cstd.p		gr8,@(gr10,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		atomic64_dec_return, .-atomic64_dec_return
-
-###############################################################################
-#
-# long long atomic64_add_return(long long i, atomic64_t *v)
-#
-###############################################################################
-	.globl		atomic64_add_return
-        .type		atomic64_add_return,@function
-atomic64_add_return:
-	or.p		gr8,gr8,gr4
-	or		gr9,gr9,gr5
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	ldd.p		@(gr10,gr0),gr8			/* LDD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	addcc		gr9,gr5,gr9,icc0
-	addx		gr8,gr4,gr8,icc0
-	cstd.p		gr8,@(gr10,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		atomic64_add_return, .-atomic64_add_return
-
-###############################################################################
-#
-# long long atomic64_sub_return(long long i, atomic64_t *v)
-#
-###############################################################################
-	.globl		atomic64_sub_return
-        .type		atomic64_sub_return,@function
-atomic64_sub_return:
-	or.p		gr8,gr8,gr4
-	or		gr9,gr9,gr5
-0:
-	orcc		gr0,gr0,gr0,icc3		/* set ICC3.Z */
-	ckeq		icc3,cc7
-	ldd.p		@(gr10,gr0),gr8			/* LDD.P/ORCR must be atomic */
-	orcr		cc7,cc7,cc3			/* set CC3 to true */
-	subcc		gr9,gr5,gr9,icc0
-	subx		gr8,gr4,gr8,icc0
-	cstd.p		gr8,@(gr10,gr0)		,cc3,#1
-	corcc		gr29,gr29,gr0		,cc3,#1	/* clear ICC3.Z if store happens */
-	beq		icc3,#0,0b
-	bralr
-
-	.size		atomic64_sub_return, .-atomic64_sub_return
-
-###############################################################################
-#
 # uint64_t __xchg_64(uint64_t i, uint64_t *v)
 #
 ###############################################################################
