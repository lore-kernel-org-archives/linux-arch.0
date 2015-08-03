From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 1/8] atomics: add acquire/release/relaxed variants of some atomic operations
Date: Mon,  3 Aug 2015 18:02:24 +0100
Message-ID: <1438621351-15912-2-git-send-email-will.deacon@arm.com>
References: <1438621351-15912-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438621351-15912-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Whilst porting the generic qrwlock code over to arm64, it became
apparent that any portable locking code needs finer-grained control of
the memory-ordering guarantees provided by our atomic routines.

In particular: xchg, cmpxchg, {add,sub}_return are often used in
situations where full barrier semantics (currently the only option
available) are not required. For example, when a reader increments a
reader count to obtain a lock, checking the old value to see if a writer
was present, only acquire semantics are strictly needed.

This patch introduces three new ordering semantics for these operations:

  - *_relaxed: No ordering guarantees. This is similar to what we have
               already for the non-return atomics (e.g. atomic_add).

  - *_acquire: ACQUIRE semantics, similar to smp_load_acquire.

  - *_release: RELEASE semantics, similar to smp_store_release.

In memory-ordering speak, this means that the acquire/release semantics
are RCpc as opposed to RCsc. Consequently a RELEASE followed by an
ACQUIRE does not imply a full barrier, as already documented in
memory-barriers.txt.

Currently, all the new macros are conditionally mapped to the full-mb
variants, however if the *_relaxed version is provided by the
architecture, then the acquire/release variants are constructed by
supplementing the relaxed routine with an explicit barrier.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/atomic.h | 328 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 328 insertions(+)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 5b08a8540ecf..d2515c05e7c8 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -2,6 +2,334 @@
 #ifndef _LINUX_ATOMIC_H
 #define _LINUX_ATOMIC_H
 #include <asm/atomic.h>
+#include <asm/barrier.h>
+
+/*
+ * Relaxed variants of xchg, cmpxchg and some atomic operations.
+ *
+ * We support four variants:
+ *
+ * - Fully ordered: The default implementation, no suffix required.
+ * - Acquire: Provides ACQUIRE semantics, _acquire suffix.
+ * - Release: Provides RELEASE semantics, _release suffix.
+ * - Relaxed: No ordering guarantees, _relaxed suffix.
+ *
+ * For compound atomics performing both a load and a store, ACQUIRE
+ * semantics apply only to the load and RELEASE semantics only to the
+ * store portion of the operation. Note that a failed cmpxchg_acquire
+ * does -not- imply any memory ordering constraints.
+ *
+ * See Documentation/memory-barriers.txt for ACQUIRE/RELEASE definitions.
+ */
+
+#ifndef atomic_read_acquire
+#define  atomic_read_acquire(v)		smp_load_acquire(&(v)->counter)
+#endif
+
+#ifndef atomic_set_release
+#define  atomic_set_release(v, i)	smp_store_release(&(v)->counter, (i))
+#endif
+
+/*
+ * The idea here is to build acquire/release variants by adding explicit
+ * barriers on top of the relaxed variant. In the case where the relaxed
+ * variant is already fully ordered, no additional barriers are needed.
+ */
+#define __atomic_op_acquire(ret_t, op, ...)				\
+({									\
+	ret_t __ret = op##_relaxed(__VA_ARGS__);			\
+	smp_mb__after_atomic();						\
+	__ret;								\
+})
+
+#define __atomic_op_release(ret_t, op, ...)				\
+({									\
+	ret_t __ret;							\
+	smp_mb__before_atomic();					\
+	__ret = op##_relaxed(__VA_ARGS__);				\
+	__ret;								\
+})
+
+#define __atomic_op_fence(ret_t, op, ...)				\
+({									\
+	ret_t __ret;							\
+	smp_mb__before_atomic();					\
+	__ret = op##_relaxed(__VA_ARGS__);				\
+	smp_mb__after_atomic();						\
+	__ret;								\
+})
+
+/* atomic_add_return_relaxed */
+#ifndef atomic_add_return_relaxed
+#define  atomic_add_return_relaxed	atomic_add_return
+#define  atomic_add_return_acquire	atomic_add_return
+#define  atomic_add_return_release	atomic_add_return
+
+#else /* atomic_add_return_relaxed */
+
+#ifndef atomic_add_return_acquire
+#define  atomic_add_return_acquire(...)					\
+	__atomic_op_acquire(int, atomic_add_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic_add_return_release
+#define  atomic_add_return_release(...)					\
+	__atomic_op_release(int, atomic_add_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic_add_return
+#define  atomic_add_return(...)						\
+	__atomic_op_fence(int, atomic_add_return, __VA_ARGS__)
+#endif
+#endif /* atomic_add_return_relaxed */
+
+/* atomic_sub_return_relaxed */
+#ifndef atomic_sub_return_relaxed
+#define  atomic_sub_return_relaxed	atomic_sub_return
+#define  atomic_sub_return_acquire	atomic_sub_return
+#define  atomic_sub_return_release	atomic_sub_return
+
+#else /* atomic_sub_return_relaxed */
+
+#ifndef atomic_sub_return_acquire
+#define  atomic_sub_return_acquire(...)					\
+	__atomic_op_acquire(int, atomic_sub_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic_sub_return_release
+#define  atomic_sub_return_release(...)					\
+	__atomic_op_release(int, atomic_sub_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic_sub_return
+#define  atomic_sub_return(...)						\
+	__atomic_op_fence(int, atomic_sub_return, __VA_ARGS__)
+#endif
+#endif /* atomic_sub_return_relaxed */
+
+/* atomic_xchg_relaxed */
+#ifndef atomic_xchg_relaxed
+#define  atomic_xchg_relaxed		atomic_xchg
+#define  atomic_xchg_acquire		atomic_xchg
+#define  atomic_xchg_release		atomic_xchg
+
+#else /* atomic_xchg_relaxed */
+
+#ifndef atomic_xchg_acquire
+#define  atomic_xchg_acquire(...)					\
+	__atomic_op_acquire(int, atomic_xchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic_xchg_release
+#define  atomic_xchg_release(...)					\
+	__atomic_op_release(int, atomic_xchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic_xchg
+#define  atomic_xchg(...)						\
+	__atomic_op_fence(int, atomic_xchg, __VA_ARGS__)
+#endif
+#endif /* atomic_xchg_relaxed */
+
+/* atomic_cmpxchg_relaxed */
+#ifndef atomic_cmpxchg_relaxed
+#define  atomic_cmpxchg_relaxed		atomic_cmpxchg
+#define  atomic_cmpxchg_acquire		atomic_cmpxchg
+#define  atomic_cmpxchg_release		atomic_cmpxchg
+
+#else /* atomic_cmpxchg_relaxed */
+
+#ifndef atomic_cmpxchg_acquire
+#define  atomic_cmpxchg_acquire(...)					\
+	__atomic_op_acquire(int, atomic_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic_cmpxchg_release
+#define  atomic_cmpxchg_release(...)					\
+	__atomic_op_release(int, atomic_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic_cmpxchg
+#define  atomic_cmpxchg(...)						\
+	__atomic_op_fence(int, atomic_cmpxchg, __VA_ARGS__)
+#endif
+#endif /* atomic_cmpxchg_relaxed */
+
+#ifndef atomic64_read_acquire
+#define  atomic64_read_acquire(v)	smp_load_acquire(&(v)->counter)
+#endif
+
+#ifndef atomic64_set_release
+#define  atomic64_set_release(v, i)	smp_store_release(&(v)->counter, (i))
+#endif
+
+/* atomic64_add_return_relaxed */
+#ifndef atomic64_add_return_relaxed
+#define  atomic64_add_return_relaxed	atomic64_add_return
+#define  atomic64_add_return_acquire	atomic64_add_return
+#define  atomic64_add_return_release	atomic64_add_return
+
+#else /* atomic64_add_return_relaxed */
+
+#ifndef atomic64_add_return_acquire
+#define  atomic64_add_return_acquire(...)				\
+	__atomic_op_acquire(long long, atomic64_add_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_add_return_release
+#define  atomic64_add_return_release(...)				\
+	__atomic_op_release(long long, atomic64_add_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_add_return
+#define  atomic64_add_return(...)					\
+	__atomic_op_fence(long long, atomic64_add_return, __VA_ARGS__)
+#endif
+#endif /* atomic64_add_return_relaxed */
+
+/* atomic64_sub_return_relaxed */
+#ifndef atomic64_sub_return_relaxed
+#define  atomic64_sub_return_relaxed	atomic64_sub_return
+#define  atomic64_sub_return_acquire	atomic64_sub_return
+#define  atomic64_sub_return_release	atomic64_sub_return
+
+#else /* atomic64_sub_return_relaxed */
+
+#ifndef atomic64_sub_return_acquire
+#define  atomic64_sub_return_acquire(...)				\
+	__atomic_op_acquire(long long, atomic64_sub_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_sub_return_release
+#define  atomic64_sub_return_release(...)				\
+	__atomic_op_release(long long, atomic64_sub_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_sub_return
+#define  atomic64_sub_return(...)					\
+	__atomic_op_fence(long long, atomic64_sub_return, __VA_ARGS__)
+#endif
+#endif /* atomic64_sub_return_relaxed */
+
+/* atomic64_xchg_relaxed */
+#ifndef atomic64_xchg_relaxed
+#define  atomic64_xchg_relaxed		atomic64_xchg
+#define  atomic64_xchg_acquire		atomic64_xchg
+#define  atomic64_xchg_release		atomic64_xchg
+
+#else /* atomic64_xchg_relaxed */
+
+#ifndef atomic64_xchg_acquire
+#define  atomic64_xchg_acquire(...)					\
+	__atomic_op_acquire(long long, atomic64_xchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_xchg_release
+#define  atomic64_xchg_release(...)					\
+	__atomic_op_release(long long, atomic64_xchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_xchg
+#define  atomic64_xchg(...)						\
+	__atomic_op_fence(long long, atomic64_xchg, __VA_ARGS__)
+#endif
+#endif /* atomic64_xchg_relaxed */
+
+/* atomic64_cmpxchg_relaxed */
+#ifndef atomic64_cmpxchg_relaxed
+#define  atomic64_cmpxchg_relaxed	atomic64_cmpxchg
+#define  atomic64_cmpxchg_acquire	atomic64_cmpxchg
+#define  atomic64_cmpxchg_release	atomic64_cmpxchg
+
+#else /* atomic64_cmpxchg_relaxed */
+
+#ifndef atomic64_cmpxchg_acquire
+#define  atomic64_cmpxchg_acquire(...)					\
+	__atomic_op_acquire(long long, atomic64_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_cmpxchg_release
+#define  atomic64_cmpxchg_release(...)					\
+	__atomic_op_release(long long, atomic64_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_cmpxchg
+#define  atomic64_cmpxchg(...)						\
+	__atomic_op_fence(long long, atomic64_cmpxchg, __VA_ARGS__)
+#endif
+#endif /* atomic64_cmpxchg_relaxed */
+
+/* cmpxchg_relaxed */
+#ifndef cmpxchg_relaxed
+#define  cmpxchg_relaxed		cmpxchg
+#define  cmpxchg_acquire		cmpxchg
+#define  cmpxchg_release		cmpxchg
+
+#else /* cmpxchg_relaxed */
+
+#ifndef cmpxchg_acquire
+#define  cmpxchg_acquire(ptr, ...)					\
+	__atomic_op_acquire(__typeof__(*ptr), cmpxchg, ptr, __VA_ARGS__)
+#endif
+
+#ifndef cmpxchg_release
+#define  cmpxchg_release(ptr, ...)					\
+	__atomic_op_release(__typeof__(*ptr), cmpxchg, ptr, __VA_ARGS__)
+#endif
+
+#ifndef cmpxchg
+#define  cmpxchg(ptr, ...)						\
+	__atomic_op_fence(__typeof__(*ptr), cmpxchg, ptr, __VA_ARGS__)
+#endif
+#endif /* cmpxchg_relaxed */
+
+/* cmpxchg64_relaxed */
+#ifndef cmpxchg64_relaxed
+#define  cmpxchg64_relaxed		cmpxchg64
+#define  cmpxchg64_acquire		cmpxchg64
+#define  cmpxchg64_release		cmpxchg64
+
+#else /* cmpxchg64_relaxed */
+
+#ifndef cmpxchg64_acquire
+#define  cmpxchg64_acquire(ptr, ...)					\
+	__atomic_op_acquire(__typeof__(*ptr), cmpxchg64, ptr, __VA_ARGS__)
+#endif
+
+#ifndef cmpxchg64_release
+#define  cmpxchg64_release(ptr, ...)					\
+	__atomic_op_release(__typeof__(*ptr), cmpxchg64, ptr, __VA_ARGS__)
+#endif
+
+#ifndef cmpxchg64
+#define  cmpxchg64(ptr, ...)						\
+	__atomic_op_fence(__typeof__(*ptr), cmpxchg64, ptr, __VA_ARGS__)
+#endif
+#endif /* cmpxchg64_relaxed */
+
+/* xchg_relaxed */
+#ifndef xchg_relaxed
+#define  xchg_relaxed			xchg
+#define  xchg_acquire			xchg
+#define  xchg_release			xchg
+
+#else /* xchg_relaxed */
+
+#ifndef xchg_acquire
+#define  xchg_acquire(ptr, ...)						\
+	__atomic_op_acquire(__typeof__(*ptr), xchg, ptr, __VA_ARGS__)
+#endif
+
+#ifndef xchg_release
+#define  xchg_release(ptr, ...)						\
+	__atomic_op_release(__typeof__(*ptr), xchg, ptr, __VA_ARGS__)
+#endif
+
+#ifndef xchg
+#define  xchg(ptr, ...)							\
+	__atomic_op_fence(__typeof__(*ptr), xchg, ptr, __VA_ARGS__)
+#endif
+#endif /* xchg_relaxed */
 
 /**
  * atomic_add_unless - add unless the number is already a given value
-- 
2.1.4
