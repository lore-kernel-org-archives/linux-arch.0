From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 25/31] locking: Fix atomic64_relaxed bits
Date: Fri, 22 Apr 2016 11:04:38 +0200
Message-ID: <20160422093924.678568669@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic64-relaxed-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

We should only expand the atomic64 relaxed bits once we've included
all relevant headers. So move it down until after we potentially
include asm-generic/atomic64.h.

In practise this will not have made a difference so far, since the
generic bits will not define _relaxed versions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/atomic.h |  306 ++++++++++++++++++++++++-------------------------
 1 file changed, 153 insertions(+), 153 deletions(-)

--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -211,159 +211,6 @@
 #endif
 #endif /* atomic_cmpxchg_relaxed */
 
-#ifndef atomic64_read_acquire
-#define  atomic64_read_acquire(v)	smp_load_acquire(&(v)->counter)
-#endif
-
-#ifndef atomic64_set_release
-#define  atomic64_set_release(v, i)	smp_store_release(&(v)->counter, (i))
-#endif
-
-/* atomic64_add_return_relaxed */
-#ifndef atomic64_add_return_relaxed
-#define  atomic64_add_return_relaxed	atomic64_add_return
-#define  atomic64_add_return_acquire	atomic64_add_return
-#define  atomic64_add_return_release	atomic64_add_return
-
-#else /* atomic64_add_return_relaxed */
-
-#ifndef atomic64_add_return_acquire
-#define  atomic64_add_return_acquire(...)				\
-	__atomic_op_acquire(atomic64_add_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_add_return_release
-#define  atomic64_add_return_release(...)				\
-	__atomic_op_release(atomic64_add_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_add_return
-#define  atomic64_add_return(...)					\
-	__atomic_op_fence(atomic64_add_return, __VA_ARGS__)
-#endif
-#endif /* atomic64_add_return_relaxed */
-
-/* atomic64_inc_return_relaxed */
-#ifndef atomic64_inc_return_relaxed
-#define  atomic64_inc_return_relaxed	atomic64_inc_return
-#define  atomic64_inc_return_acquire	atomic64_inc_return
-#define  atomic64_inc_return_release	atomic64_inc_return
-
-#else /* atomic64_inc_return_relaxed */
-
-#ifndef atomic64_inc_return_acquire
-#define  atomic64_inc_return_acquire(...)				\
-	__atomic_op_acquire(atomic64_inc_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_inc_return_release
-#define  atomic64_inc_return_release(...)				\
-	__atomic_op_release(atomic64_inc_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_inc_return
-#define  atomic64_inc_return(...)					\
-	__atomic_op_fence(atomic64_inc_return, __VA_ARGS__)
-#endif
-#endif /* atomic64_inc_return_relaxed */
-
-
-/* atomic64_sub_return_relaxed */
-#ifndef atomic64_sub_return_relaxed
-#define  atomic64_sub_return_relaxed	atomic64_sub_return
-#define  atomic64_sub_return_acquire	atomic64_sub_return
-#define  atomic64_sub_return_release	atomic64_sub_return
-
-#else /* atomic64_sub_return_relaxed */
-
-#ifndef atomic64_sub_return_acquire
-#define  atomic64_sub_return_acquire(...)				\
-	__atomic_op_acquire(atomic64_sub_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_sub_return_release
-#define  atomic64_sub_return_release(...)				\
-	__atomic_op_release(atomic64_sub_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_sub_return
-#define  atomic64_sub_return(...)					\
-	__atomic_op_fence(atomic64_sub_return, __VA_ARGS__)
-#endif
-#endif /* atomic64_sub_return_relaxed */
-
-/* atomic64_dec_return_relaxed */
-#ifndef atomic64_dec_return_relaxed
-#define  atomic64_dec_return_relaxed	atomic64_dec_return
-#define  atomic64_dec_return_acquire	atomic64_dec_return
-#define  atomic64_dec_return_release	atomic64_dec_return
-
-#else /* atomic64_dec_return_relaxed */
-
-#ifndef atomic64_dec_return_acquire
-#define  atomic64_dec_return_acquire(...)				\
-	__atomic_op_acquire(atomic64_dec_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_dec_return_release
-#define  atomic64_dec_return_release(...)				\
-	__atomic_op_release(atomic64_dec_return, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_dec_return
-#define  atomic64_dec_return(...)					\
-	__atomic_op_fence(atomic64_dec_return, __VA_ARGS__)
-#endif
-#endif /* atomic64_dec_return_relaxed */
-
-/* atomic64_xchg_relaxed */
-#ifndef atomic64_xchg_relaxed
-#define  atomic64_xchg_relaxed		atomic64_xchg
-#define  atomic64_xchg_acquire		atomic64_xchg
-#define  atomic64_xchg_release		atomic64_xchg
-
-#else /* atomic64_xchg_relaxed */
-
-#ifndef atomic64_xchg_acquire
-#define  atomic64_xchg_acquire(...)					\
-	__atomic_op_acquire(atomic64_xchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_xchg_release
-#define  atomic64_xchg_release(...)					\
-	__atomic_op_release(atomic64_xchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_xchg
-#define  atomic64_xchg(...)						\
-	__atomic_op_fence(atomic64_xchg, __VA_ARGS__)
-#endif
-#endif /* atomic64_xchg_relaxed */
-
-/* atomic64_cmpxchg_relaxed */
-#ifndef atomic64_cmpxchg_relaxed
-#define  atomic64_cmpxchg_relaxed	atomic64_cmpxchg
-#define  atomic64_cmpxchg_acquire	atomic64_cmpxchg
-#define  atomic64_cmpxchg_release	atomic64_cmpxchg
-
-#else /* atomic64_cmpxchg_relaxed */
-
-#ifndef atomic64_cmpxchg_acquire
-#define  atomic64_cmpxchg_acquire(...)					\
-	__atomic_op_acquire(atomic64_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_cmpxchg_release
-#define  atomic64_cmpxchg_release(...)					\
-	__atomic_op_release(atomic64_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef atomic64_cmpxchg
-#define  atomic64_cmpxchg(...)						\
-	__atomic_op_fence(atomic64_cmpxchg, __VA_ARGS__)
-#endif
-#endif /* atomic64_cmpxchg_relaxed */
-
 /* cmpxchg_relaxed */
 #ifndef cmpxchg_relaxed
 #define  cmpxchg_relaxed		cmpxchg
@@ -583,6 +430,159 @@ static inline int atomic_fetch_or(atomic
 #include <asm-generic/atomic64.h>
 #endif
 
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
+	__atomic_op_acquire(atomic64_add_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_add_return_release
+#define  atomic64_add_return_release(...)				\
+	__atomic_op_release(atomic64_add_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_add_return
+#define  atomic64_add_return(...)					\
+	__atomic_op_fence(atomic64_add_return, __VA_ARGS__)
+#endif
+#endif /* atomic64_add_return_relaxed */
+
+/* atomic64_inc_return_relaxed */
+#ifndef atomic64_inc_return_relaxed
+#define  atomic64_inc_return_relaxed	atomic64_inc_return
+#define  atomic64_inc_return_acquire	atomic64_inc_return
+#define  atomic64_inc_return_release	atomic64_inc_return
+
+#else /* atomic64_inc_return_relaxed */
+
+#ifndef atomic64_inc_return_acquire
+#define  atomic64_inc_return_acquire(...)				\
+	__atomic_op_acquire(atomic64_inc_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_inc_return_release
+#define  atomic64_inc_return_release(...)				\
+	__atomic_op_release(atomic64_inc_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_inc_return
+#define  atomic64_inc_return(...)					\
+	__atomic_op_fence(atomic64_inc_return, __VA_ARGS__)
+#endif
+#endif /* atomic64_inc_return_relaxed */
+
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
+	__atomic_op_acquire(atomic64_sub_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_sub_return_release
+#define  atomic64_sub_return_release(...)				\
+	__atomic_op_release(atomic64_sub_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_sub_return
+#define  atomic64_sub_return(...)					\
+	__atomic_op_fence(atomic64_sub_return, __VA_ARGS__)
+#endif
+#endif /* atomic64_sub_return_relaxed */
+
+/* atomic64_dec_return_relaxed */
+#ifndef atomic64_dec_return_relaxed
+#define  atomic64_dec_return_relaxed	atomic64_dec_return
+#define  atomic64_dec_return_acquire	atomic64_dec_return
+#define  atomic64_dec_return_release	atomic64_dec_return
+
+#else /* atomic64_dec_return_relaxed */
+
+#ifndef atomic64_dec_return_acquire
+#define  atomic64_dec_return_acquire(...)				\
+	__atomic_op_acquire(atomic64_dec_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_dec_return_release
+#define  atomic64_dec_return_release(...)				\
+	__atomic_op_release(atomic64_dec_return, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_dec_return
+#define  atomic64_dec_return(...)					\
+	__atomic_op_fence(atomic64_dec_return, __VA_ARGS__)
+#endif
+#endif /* atomic64_dec_return_relaxed */
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
+	__atomic_op_acquire(atomic64_xchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_xchg_release
+#define  atomic64_xchg_release(...)					\
+	__atomic_op_release(atomic64_xchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_xchg
+#define  atomic64_xchg(...)						\
+	__atomic_op_fence(atomic64_xchg, __VA_ARGS__)
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
+	__atomic_op_acquire(atomic64_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_cmpxchg_release
+#define  atomic64_cmpxchg_release(...)					\
+	__atomic_op_release(atomic64_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_cmpxchg
+#define  atomic64_cmpxchg(...)						\
+	__atomic_op_fence(atomic64_cmpxchg, __VA_ARGS__)
+#endif
+#endif /* atomic64_cmpxchg_relaxed */
+
 #ifndef atomic64_andnot
 static inline void atomic64_andnot(long long i, atomic64_t *v)
 {
