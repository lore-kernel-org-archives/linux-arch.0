From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 26/28] atomic: Collapse all atomic_{set,clear}_mask definitions
Date: Thu, 16 Jul 2015 19:21:36 +0200
Message-ID: <20150716172926.486243342@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-linux-ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Move the now generic definitions of atomic_{set,clear}_mask() into
linux/atomic.h to avoid endless and pointless repetition.

Also, provide an atomic_andnot() wrapper for those few archs that can
implement that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arc/include/asm/atomic.h          |   10 ----------
 arch/blackfin/include/asm/atomic.h     |   10 ----------
 arch/frv/include/asm/atomic.h          |   10 ----------
 arch/h8300/include/asm/atomic.h        |   10 ----------
 arch/m32r/include/asm/atomic.h         |   11 -----------
 arch/m68k/include/asm/atomic.h         |   10 ----------
 arch/metag/include/asm/atomic_lnkget.h |   10 ----------
 arch/metag/include/asm/atomic_lock1.h  |   10 ----------
 arch/mn10300/include/asm/atomic.h      |   24 ------------------------
 arch/powerpc/kernel/misc_32.S          |   19 -------------------
 arch/s390/include/asm/atomic.h         |   10 ----------
 arch/sh/include/asm/atomic.h           |   10 ----------
 arch/x86/include/asm/atomic.h          |   10 ----------
 arch/xtensa/include/asm/atomic.h       |   10 ----------
 include/asm-generic/atomic.h           |   10 ----------
 include/linux/atomic.h                 |   25 +++++++++++++++++++++++++
 16 files changed, 25 insertions(+), 174 deletions(-)

--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -155,16 +155,6 @@ ATOMIC_OP(xor, ^=, xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 /**
  * __atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
--- a/arch/blackfin/include/asm/atomic.h
+++ b/arch/blackfin/include/asm/atomic.h
@@ -32,16 +32,6 @@ asmlinkage int __raw_atomic_test_asm(con
 #define atomic_and(i, v) (void)__raw_atomic_and_asm(&(v)->counter, i)
 #define atomic_xor(i, v) (void)__raw_atomic_xor_asm(&(v)->counter, i)
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 #endif
 
 #include <asm-generic/atomic.h>
--- a/arch/frv/include/asm/atomic.h
+++ b/arch/frv/include/asm/atomic.h
@@ -198,14 +198,4 @@ ATOMIC_OP(xor)
 
 #undef ATOMIC_OP
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 #endif /* _ASM_ATOMIC_H */
--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -89,14 +89,4 @@ static inline int __atomic_add_unless(at
 	return ret;
 }
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 #endif /* __ARCH_H8300_ATOMIC __ */
--- a/arch/m32r/include/asm/atomic.h
+++ b/arch/m32r/include/asm/atomic.h
@@ -243,15 +243,4 @@ static __inline__ int __atomic_add_unles
 	return c;
 }
 
-
-static __inline__ __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static __inline__ __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 #endif	/* _ASM_M32R_ATOMIC_H */
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -174,16 +174,6 @@ static inline int atomic_add_negative(in
 	return c != 0;
 }
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
--- a/arch/metag/include/asm/atomic_lnkget.h
+++ b/arch/metag/include/asm/atomic_lnkget.h
@@ -82,16 +82,6 @@ ATOMIC_OP(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int result, temp;
--- a/arch/metag/include/asm/atomic_lock1.h
+++ b/arch/metag/include/asm/atomic_lock1.h
@@ -76,16 +76,6 @@ ATOMIC_OP(xor, ^=)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
--- a/arch/mn10300/include/asm/atomic.h
+++ b/arch/mn10300/include/asm/atomic.h
@@ -131,30 +131,6 @@ static inline void atomic_dec(atomic_t *
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
 
-/**
- * atomic_clear_mask - Atomically clear bits in memory
- * @mask: Mask of the bits to be cleared
- * @v: pointer to word in memory
- *
- * Atomically clears the bits set in mask from the memory word specified.
- */
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-/**
- * atomic_set_mask - Atomically set bits in memory
- * @mask: Mask of the bits to be set
- * @v: pointer to word in memory
- *
- * Atomically sets the bits set in mask from the memory word specified.
- */
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 #endif /* __KERNEL__ */
 #endif /* CONFIG_SMP */
 #endif /* _ASM_ATOMIC_H */
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -596,25 +596,6 @@ _GLOBAL(copy_page)
 	b	2b
 
 /*
- * void atomic_clear_mask(atomic_t mask, atomic_t *addr)
- * void atomic_set_mask(atomic_t mask, atomic_t *addr);
- */
-_GLOBAL(atomic_clear_mask)
-10:	lwarx	r5,0,r4
-	andc	r5,r5,r3
-	PPC405_ERR77(0,r4)
-	stwcx.	r5,0,r4
-	bne-	10b
-	blr
-_GLOBAL(atomic_set_mask)
-10:	lwarx	r5,0,r4
-	or	r5,r5,r3
-	PPC405_ERR77(0,r4)
-	stwcx.	r5,0,r4
-	bne-	10b
-	blr
-
-/*
  * Extended precision shifts.
  *
  * Updated to be valid for shift counts from 0 to 63 inclusive.
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -132,16 +132,6 @@ ATOMIC_OP(xor, XOR)
 
 #undef ATOMIC_OP
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -25,16 +25,6 @@
 #include <asm/atomic-irq.h>
 #endif
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
 #define atomic_inc_return(v)		atomic_add_return(1, (v))
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -234,16 +234,6 @@ static __always_inline short int atomic_
 	return *v;
 }
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 #ifdef CONFIG_X86_32
 # include <asm/atomic64_32.h>
 #else
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -153,16 +153,6 @@ ATOMIC_OP(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
 /**
  * atomic_sub_and_test - subtract value from variable and test result
  * @i: integer value to subtract
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -113,16 +113,6 @@ ATOMIC_OP(xor, ^)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_and(~mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 /*
  * Atomic operations that C can't guarantee us.  Useful for
  * resource counting etc..
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -28,6 +28,23 @@ static inline int atomic_add_unless(atom
 #define atomic_inc_not_zero(v)		atomic_add_unless((v), 1, 0)
 #endif
 
+#ifndef atomic_andnot
+static inline void atomic_andnot(int i, atomic_t *v)
+{
+	atomic_and(~i, v);
+}
+#endif
+
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_andnot(mask, v);
+}
+
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_or(mask, v);
+}
+
 /**
  * atomic_inc_not_zero_hint - increment if not null
  * @v: pointer of type atomic_t
@@ -115,4 +132,12 @@ static inline int atomic_dec_if_positive
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
+
+#ifndef atomic64_andnot
+static inline void atomic64_andnot(long long i, atomic64_t *v)
+{
+	atomic64_and(~i, v);
+}
+#endif
+
 #endif /* _LINUX_ATOMIC_H */
