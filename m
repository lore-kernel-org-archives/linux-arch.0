From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 1/8] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Mon, 3 Aug 2015 19:21:34 +0100
Message-ID: <20150803182134.GL10501@arm.com>
References: <1438621351-15912-1-git-send-email-will.deacon@arm.com>
 <1438621351-15912-2-git-send-email-will.deacon@arm.com>
 <20150803172658.GX25159@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54924 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754599AbbHCSVi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Aug 2015 14:21:38 -0400
Content-Disposition: inline
In-Reply-To: <20150803172658.GX25159@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "mingo@kernel.org" <mingo@kernel.org>

On Mon, Aug 03, 2015 at 06:26:58PM +0100, Peter Zijlstra wrote:
> On Mon, Aug 03, 2015 at 06:02:24PM +0100, Will Deacon wrote:
> > +/*
> > + * The idea here is to build acquire/release variants by adding explicit
> > + * barriers on top of the relaxed variant. In the case where the relaxed
> > + * variant is already fully ordered, no additional barriers are needed.
> > + */
> > +#define __atomic_op_acquire(ret_t, op, ...)				\
> > +({									\
> > +	ret_t __ret = op##_relaxed(__VA_ARGS__);			\
> 
> Do you really need ret_t? Can't we use typeof() on the expression?

*gulp*! I was slightly worried about this from the GNU docs:

 `The operand of typeof is evaluated for its side effects if and only if
  it is an expression of variably modified type or the name of such a
  type.'

but since none of our atomic functions return "variably modified types",
then there shouldn't be anything to worry about. It also means I can
slightly simplify the xchg/cmpxchg wrappers where we were previously
passing through the typeof(*ptr).

Incremental diff below (I'll post a v5 when the build testing comes back
clean).

Will

--->8

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index d2515c05e7c8..41ea776052be 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -35,26 +35,24 @@
  * barriers on top of the relaxed variant. In the case where the relaxed
  * variant is already fully ordered, no additional barriers are needed.
  */
-#define __atomic_op_acquire(ret_t, op, ...)				\
+#define __atomic_op_acquire(op, args...)				\
 ({									\
-	ret_t __ret = op##_relaxed(__VA_ARGS__);			\
+	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
 	smp_mb__after_atomic();						\
 	__ret;								\
 })
 
-#define __atomic_op_release(ret_t, op, ...)				\
+#define __atomic_op_release(op, args...)				\
 ({									\
-	ret_t __ret;							\
 	smp_mb__before_atomic();					\
-	__ret = op##_relaxed(__VA_ARGS__);				\
-	__ret;								\
+	op##_relaxed(args);						\
 })
 
-#define __atomic_op_fence(ret_t, op, ...)				\
+#define __atomic_op_fence(op, args...)					\
 ({									\
-	ret_t __ret;							\
+	typeof(op##_relaxed(args)) __ret;				\
 	smp_mb__before_atomic();					\
-	__ret = op##_relaxed(__VA_ARGS__);				\
+	__ret = op##_relaxed(args);					\
 	smp_mb__after_atomic();						\
 	__ret;								\
 })
@@ -69,17 +67,17 @@
 
 #ifndef atomic_add_return_acquire
 #define  atomic_add_return_acquire(...)					\
-	__atomic_op_acquire(int, atomic_add_return, __VA_ARGS__)
+	__atomic_op_acquire(atomic_add_return, __VA_ARGS__)
 #endif
 
 #ifndef atomic_add_return_release
 #define  atomic_add_return_release(...)					\
-	__atomic_op_release(int, atomic_add_return, __VA_ARGS__)
+	__atomic_op_release(atomic_add_return, __VA_ARGS__)
 #endif
 
 #ifndef atomic_add_return
 #define  atomic_add_return(...)						\
-	__atomic_op_fence(int, atomic_add_return, __VA_ARGS__)
+	__atomic_op_fence(atomic_add_return, __VA_ARGS__)
 #endif
 #endif /* atomic_add_return_relaxed */
 
@@ -93,17 +91,17 @@
 
 #ifndef atomic_sub_return_acquire
 #define  atomic_sub_return_acquire(...)					\
-	__atomic_op_acquire(int, atomic_sub_return, __VA_ARGS__)
+	__atomic_op_acquire(atomic_sub_return, __VA_ARGS__)
 #endif
 
 #ifndef atomic_sub_return_release
 #define  atomic_sub_return_release(...)					\
-	__atomic_op_release(int, atomic_sub_return, __VA_ARGS__)
+	__atomic_op_release(atomic_sub_return, __VA_ARGS__)
 #endif
 
 #ifndef atomic_sub_return
 #define  atomic_sub_return(...)						\
-	__atomic_op_fence(int, atomic_sub_return, __VA_ARGS__)
+	__atomic_op_fence(atomic_sub_return, __VA_ARGS__)
 #endif
 #endif /* atomic_sub_return_relaxed */
 
@@ -117,17 +115,17 @@
 
 #ifndef atomic_xchg_acquire
 #define  atomic_xchg_acquire(...)					\
-	__atomic_op_acquire(int, atomic_xchg, __VA_ARGS__)
+	__atomic_op_acquire(atomic_xchg, __VA_ARGS__)
 #endif
 
 #ifndef atomic_xchg_release
 #define  atomic_xchg_release(...)					\
-	__atomic_op_release(int, atomic_xchg, __VA_ARGS__)
+	__atomic_op_release(atomic_xchg, __VA_ARGS__)
 #endif
 
 #ifndef atomic_xchg
 #define  atomic_xchg(...)						\
-	__atomic_op_fence(int, atomic_xchg, __VA_ARGS__)
+	__atomic_op_fence(atomic_xchg, __VA_ARGS__)
 #endif
 #endif /* atomic_xchg_relaxed */
 
@@ -141,17 +139,17 @@
 
 #ifndef atomic_cmpxchg_acquire
 #define  atomic_cmpxchg_acquire(...)					\
-	__atomic_op_acquire(int, atomic_cmpxchg, __VA_ARGS__)
+	__atomic_op_acquire(atomic_cmpxchg, __VA_ARGS__)
 #endif
 
 #ifndef atomic_cmpxchg_release
 #define  atomic_cmpxchg_release(...)					\
-	__atomic_op_release(int, atomic_cmpxchg, __VA_ARGS__)
+	__atomic_op_release(atomic_cmpxchg, __VA_ARGS__)
 #endif
 
 #ifndef atomic_cmpxchg
 #define  atomic_cmpxchg(...)						\
-	__atomic_op_fence(int, atomic_cmpxchg, __VA_ARGS__)
+	__atomic_op_fence(atomic_cmpxchg, __VA_ARGS__)
 #endif
 #endif /* atomic_cmpxchg_relaxed */
 
@@ -173,17 +171,17 @@
 
 #ifndef atomic64_add_return_acquire
 #define  atomic64_add_return_acquire(...)				\
-	__atomic_op_acquire(long long, atomic64_add_return, __VA_ARGS__)
+	__atomic_op_acquire(atomic64_add_return, __VA_ARGS__)
 #endif
 
 #ifndef atomic64_add_return_release
 #define  atomic64_add_return_release(...)				\
-	__atomic_op_release(long long, atomic64_add_return, __VA_ARGS__)
+	__atomic_op_release(atomic64_add_return, __VA_ARGS__)
 #endif
 
 #ifndef atomic64_add_return
 #define  atomic64_add_return(...)					\
-	__atomic_op_fence(long long, atomic64_add_return, __VA_ARGS__)
+	__atomic_op_fence(atomic64_add_return, __VA_ARGS__)
 #endif
 #endif /* atomic64_add_return_relaxed */
 
@@ -197,17 +195,17 @@
 
 #ifndef atomic64_sub_return_acquire
 #define  atomic64_sub_return_acquire(...)				\
-	__atomic_op_acquire(long long, atomic64_sub_return, __VA_ARGS__)
+	__atomic_op_acquire(atomic64_sub_return, __VA_ARGS__)
 #endif
 
 #ifndef atomic64_sub_return_release
 #define  atomic64_sub_return_release(...)				\
-	__atomic_op_release(long long, atomic64_sub_return, __VA_ARGS__)
+	__atomic_op_release(atomic64_sub_return, __VA_ARGS__)
 #endif
 
 #ifndef atomic64_sub_return
 #define  atomic64_sub_return(...)					\
-	__atomic_op_fence(long long, atomic64_sub_return, __VA_ARGS__)
+	__atomic_op_fence(atomic64_sub_return, __VA_ARGS__)
 #endif
 #endif /* atomic64_sub_return_relaxed */
 
@@ -221,17 +219,17 @@
 
 #ifndef atomic64_xchg_acquire
 #define  atomic64_xchg_acquire(...)					\
-	__atomic_op_acquire(long long, atomic64_xchg, __VA_ARGS__)
+	__atomic_op_acquire(atomic64_xchg, __VA_ARGS__)
 #endif
 
 #ifndef atomic64_xchg_release
 #define  atomic64_xchg_release(...)					\
-	__atomic_op_release(long long, atomic64_xchg, __VA_ARGS__)
+	__atomic_op_release(atomic64_xchg, __VA_ARGS__)
 #endif
 
 #ifndef atomic64_xchg
 #define  atomic64_xchg(...)						\
-	__atomic_op_fence(long long, atomic64_xchg, __VA_ARGS__)
+	__atomic_op_fence(atomic64_xchg, __VA_ARGS__)
 #endif
 #endif /* atomic64_xchg_relaxed */
 
@@ -245,17 +243,17 @@
 
 #ifndef atomic64_cmpxchg_acquire
 #define  atomic64_cmpxchg_acquire(...)					\
-	__atomic_op_acquire(long long, atomic64_cmpxchg, __VA_ARGS__)
+	__atomic_op_acquire(atomic64_cmpxchg, __VA_ARGS__)
 #endif
 
 #ifndef atomic64_cmpxchg_release
 #define  atomic64_cmpxchg_release(...)					\
-	__atomic_op_release(long long, atomic64_cmpxchg, __VA_ARGS__)
+	__atomic_op_release(atomic64_cmpxchg, __VA_ARGS__)
 #endif
 
 #ifndef atomic64_cmpxchg
 #define  atomic64_cmpxchg(...)						\
-	__atomic_op_fence(long long, atomic64_cmpxchg, __VA_ARGS__)
+	__atomic_op_fence(atomic64_cmpxchg, __VA_ARGS__)
 #endif
 #endif /* atomic64_cmpxchg_relaxed */
 
@@ -268,18 +266,18 @@
 #else /* cmpxchg_relaxed */
 
 #ifndef cmpxchg_acquire
-#define  cmpxchg_acquire(ptr, ...)					\
-	__atomic_op_acquire(__typeof__(*ptr), cmpxchg, ptr, __VA_ARGS__)
+#define  cmpxchg_acquire(...)						\
+	__atomic_op_acquire(cmpxchg, __VA_ARGS__)
 #endif
 
 #ifndef cmpxchg_release
-#define  cmpxchg_release(ptr, ...)					\
-	__atomic_op_release(__typeof__(*ptr), cmpxchg, ptr, __VA_ARGS__)
+#define  cmpxchg_release(...)						\
+	__atomic_op_release(cmpxchg, __VA_ARGS__)
 #endif
 
 #ifndef cmpxchg
-#define  cmpxchg(ptr, ...)						\
-	__atomic_op_fence(__typeof__(*ptr), cmpxchg, ptr, __VA_ARGS__)
+#define  cmpxchg(...)							\
+	__atomic_op_fence(cmpxchg, __VA_ARGS__)
 #endif
 #endif /* cmpxchg_relaxed */
 
@@ -292,18 +290,18 @@
 #else /* cmpxchg64_relaxed */
 
 #ifndef cmpxchg64_acquire
-#define  cmpxchg64_acquire(ptr, ...)					\
-	__atomic_op_acquire(__typeof__(*ptr), cmpxchg64, ptr, __VA_ARGS__)
+#define  cmpxchg64_acquire(...)						\
+	__atomic_op_acquire(cmpxchg64, __VA_ARGS__)
 #endif
 
 #ifndef cmpxchg64_release
-#define  cmpxchg64_release(ptr, ...)					\
-	__atomic_op_release(__typeof__(*ptr), cmpxchg64, ptr, __VA_ARGS__)
+#define  cmpxchg64_release(...)						\
+	__atomic_op_release(cmpxchg64, __VA_ARGS__)
 #endif
 
 #ifndef cmpxchg64
-#define  cmpxchg64(ptr, ...)						\
-	__atomic_op_fence(__typeof__(*ptr), cmpxchg64, ptr, __VA_ARGS__)
+#define  cmpxchg64(...)							\
+	__atomic_op_fence(cmpxchg64, __VA_ARGS__)
 #endif
 #endif /* cmpxchg64_relaxed */
 
@@ -316,18 +314,15 @@
 #else /* xchg_relaxed */
 
 #ifndef xchg_acquire
-#define  xchg_acquire(ptr, ...)						\
-	__atomic_op_acquire(__typeof__(*ptr), xchg, ptr, __VA_ARGS__)
+#define  xchg_acquire(...)		__atomic_op_acquire(xchg, __VA_ARGS__)
 #endif
 
 #ifndef xchg_release
-#define  xchg_release(ptr, ...)						\
-	__atomic_op_release(__typeof__(*ptr), xchg, ptr, __VA_ARGS__)
+#define  xchg_release(...)		__atomic_op_release(xchg, __VA_ARGS__)
 #endif
 
 #ifndef xchg
-#define  xchg(ptr, ...)							\
-	__atomic_op_fence(__typeof__(*ptr), xchg, ptr, __VA_ARGS__)
+#define  xchg(...)			__atomic_op_fence(xchg, __VA_ARGS__)
 #endif
 #endif /* xchg_relaxed */
 
