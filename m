Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <432595D5.1090502@yahoo.com.au>
Date: Tue, 13 Sep 2005 00:51:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: [PATCH 1/3][RFC] atomic_cmpxchg, atomic_inc_not_zero
Content-Type: multipart/mixed;
 boundary="------------000209030401070408060301"
To: Dipankar Sarma <dipankar@in.ibm.com>, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000209030401070408060301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The recent file_table RCU work introduced a new rcuref.h thing,
which is just begging to be atomic.h. Basically it uses atomic_t,
digs into the atomic_t type, and also defines its own table of
spinlocks if the arch doesn't have cmpxchg() thus rendering it
unsafe for any other atomic_xxx operation to be performed on it.

Anyway, as it turns out, my lockless pagecache patches have the
exact same requirement, and so I am proposing to implement two
new atomic_ primitives that should be useful.

Only one is actually needed, atomic_inc_not_zero being the exact
fit for both, however I did atomic_cmpxchg first and it can stay
around because hopefully will be a generally useful primitive.

Now atomic_inc_not_zero is not really anything to do with RCU other
than an RCU protected refcounted structure being an obvious user to
take a reference on the read side where there is nothing to pin it.

1/3 is atomic_cmpxchg, not guaranteed to even compile on most.

-- 
SUSE Labs, Novell Inc.


--------------000209030401070408060301
Content-Type: text/plain;
 name="atomic_cmpxchg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic_cmpxchg.patch"

Introduce an atomic_cmpxchg operation. Implement this for i386 and ppc64.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/asm-i386/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-i386/atomic.h
+++ linux-2.6/include/asm-i386/atomic.h
@@ -215,6 +215,8 @@ static __inline__ int atomic_sub_return(
 	return atomic_add_return(-i,v);
 }
 
+#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
Index: linux-2.6/include/asm-ppc64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ppc64/atomic.h
+++ linux-2.6/include/asm-ppc64/atomic.h
@@ -162,6 +162,8 @@ static __inline__ int atomic_dec_return(
 	return t;
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
 
Index: linux-2.6/include/asm-ia64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/atomic.h
+++ linux-2.6/include/asm-ia64/atomic.h
@@ -88,6 +88,8 @@ ia64_atomic64_sub (__s64 i, atomic64_t *
 	return new;
 }
 
+#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+
 #define atomic_add_return(i,v)						\
 ({									\
 	int __ia64_aar_i = (i);						\
Index: linux-2.6/include/asm-x86_64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/atomic.h
+++ linux-2.6/include/asm-x86_64/atomic.h
@@ -360,6 +360,8 @@ static __inline__ int atomic_sub_return(
 	return atomic_add_return(-i,v);
 }
 
+#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
Index: linux-2.6/Documentation/atomic_ops.txt
===================================================================
--- linux-2.6.orig/Documentation/atomic_ops.txt
+++ linux-2.6/Documentation/atomic_ops.txt
@@ -115,6 +115,21 @@ boolean is return which indicates whethe
 is negative.  It requires explicit memory barrier semantics around the
 operation.
 
+Finally:
+
+	int atomic_cmpxchg(atomic_t *v, int old, int new);
+
+This performs an atomic compare exchange operation on the atomic value v,
+with the given old and new values. Like all atomic_xxx operations,
+atomic_cmpxchg will only satisfy its atomicity semantics as long as all
+other accesses of *v are performed through atomic_xxx operations.
+
+atomic_cmpxchg requires explicit memory barriers around the operation.
+
+The semantics for atomic_cmpxchg are the same as those defined for 'cas'
+below.
+
+
 If a caller requires memory barrier semantics around an atomic_t
 operation which does not return a value, a set of interfaces are
 defined which accomplish this:
Index: linux-2.6/arch/sparc/lib/atomic32.c
===================================================================
--- linux-2.6.orig/arch/sparc/lib/atomic32.c
+++ linux-2.6/arch/sparc/lib/atomic32.c
@@ -38,6 +38,20 @@ int __atomic_add_return(int i, atomic_t 
 	return ret;
 }
 
+int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(ATOMIC_HASH(v), flags);
+
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+
+	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
+	return ret;
+}
+
 void atomic_set(atomic_t *v, int i)
 {
 	unsigned long flags;
Index: linux-2.6/include/asm-sparc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/atomic.h
+++ linux-2.6/include/asm-sparc/atomic.h
@@ -19,6 +19,7 @@ typedef struct { volatile int counter; }
 #define ATOMIC_INIT(i)  { (i) }
 
 extern int __atomic_add_return(int, atomic_t *);
+extern int atomic_cmpxchg(atomic_t *, int, int);
 extern void atomic_set(atomic_t *, int);
 
 #define atomic_read(v)          ((v)->counter)
Index: linux-2.6/include/asm-alpha/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/atomic.h
+++ linux-2.6/include/asm-alpha/atomic.h
@@ -171,6 +171,8 @@ static __inline__ long atomic64_sub_retu
 	return result;
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic64_dec_return(v) atomic64_sub_return(1,(v))
 
Index: linux-2.6/include/asm-m68k/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/atomic.h
+++ linux-2.6/include/asm-m68k/atomic.h
@@ -139,6 +139,8 @@ static inline void atomic_set_mask(unsig
 	__asm__ __volatile__("orl %1,%0" : "+m" (*v) : "id" (mask));
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6/include/asm-m68knommu/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/atomic.h
+++ linux-2.6/include/asm-m68knommu/atomic.h
@@ -128,6 +128,8 @@ extern __inline__ int atomic_sub_return(
 	return temp;
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 
Index: linux-2.6/include/asm-mips/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-mips/atomic.h
+++ linux-2.6/include/asm-mips/atomic.h
@@ -267,6 +267,8 @@ static __inline__ int atomic_sub_if_posi
 	return result;
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 
Index: linux-2.6/include/asm-parisc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/atomic.h
+++ linux-2.6/include/asm-parisc/atomic.h
@@ -164,6 +164,7 @@ static __inline__ int atomic_read(const 
 }
 
 /* exported interface */
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
 #define atomic_add(i,v)	((void)(__atomic_add_return( ((int)i),(v))))
 #define atomic_sub(i,v)	((void)(__atomic_add_return(-((int)i),(v))))
Index: linux-2.6/include/asm-ppc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/atomic.h
+++ linux-2.6/include/asm-ppc/atomic.h
@@ -177,6 +177,8 @@ static __inline__ int atomic_dec_return(
 	return t;
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
 
Index: linux-2.6/include/asm-s390/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-s390/atomic.h
+++ linux-2.6/include/asm-s390/atomic.h
@@ -198,6 +198,8 @@ atomic_compare_and_swap(int expected_old
         return retval;
 }
 
+#define atomic_cmpxchg(v, o, n) (atomic_compare_and_swap((o), (n), &((v)->counter)))
+
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
 #define smp_mb__before_atomic_inc()	smp_mb()
Index: linux-2.6/include/asm-sparc64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/atomic.h
+++ linux-2.6/include/asm-sparc64/atomic.h
@@ -70,6 +70,8 @@ extern int atomic64_sub_ret(int, atomic6
 #define atomic_add_negative(i, v) (atomic_add_ret(i, v) < 0)
 #define atomic64_add_negative(i, v) (atomic64_add_ret(i, v) < 0)
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 /* Atomic operations are already serializing */
 #ifdef CONFIG_SMP
 #define smp_mb__before_atomic_dec()	membar_storeload_loadload();

--------------000209030401070408060301--
Send instant messages to your online friends http://au.messenger.yahoo.com 
