From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/5] atomics: add acquire/release/relaxed variants of some atomic operations
Date: Mon, 13 Jul 2015 13:31:23 +0100
Message-ID: <1436790687-11984-2-git-send-email-will.deacon@arm.com>
References: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:58508 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751267AbbGMMdC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jul 2015 08:33:02 -0400
In-Reply-To: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>

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
variants, which has the interested side-effect of a failed cmpxchg_acquire
having no memory ordering guarantees.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/atomic_ops.txt |   4 +-
 include/linux/atomic.h       | 140 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/Documentation/atomic_ops.txt b/Documentation/atomic_ops.txt
index dab6da3382d9..b19fc34efdb1 100644
--- a/Documentation/atomic_ops.txt
+++ b/Documentation/atomic_ops.txt
@@ -266,7 +266,9 @@ with the given old and new values. Like all atomic_xxx operations,
 atomic_cmpxchg will only satisfy its atomicity semantics as long as all
 other accesses of *v are performed through atomic_xxx operations.
 
-atomic_cmpxchg must provide explicit memory barriers around the operation.
+atomic_cmpxchg must provide explicit memory barriers around the operation,
+although if the comparison fails then no memory ordering guarantees are
+required.
 
 The semantics for atomic_cmpxchg are the same as those defined for 'cas'
 below.
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 5b08a8540ecf..a78c3704cd51 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -128,4 +128,144 @@ static inline void atomic_or(int i, atomic_t *v)
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
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
+#ifndef atomic_add_return_relaxed
+#define  atomic_add_return_relaxed	atomic_add_return
+#endif
+#ifndef atomic_add_return_acquire
+#define  atomic_add_return_acquire	atomic_add_return
+#endif
+#ifndef atomic_add_return_release
+#define  atomic_add_return_release	atomic_add_return
+#endif
+
+#ifndef atomic_sub_return_relaxed
+#define  atomic_sub_return_relaxed	atomic_sub_return
+#endif
+#ifndef atomic_sub_return_acquire
+#define  atomic_sub_return_acquire	atomic_sub_return
+#endif
+#ifndef atomic_sub_return_release
+#define  atomic_sub_return_release	atomic_sub_return
+#endif
+
+#ifndef atomic_xchg_relaxed
+#define  atomic_xchg_relaxed		atomic_xchg
+#endif
+#ifndef atomic_xchg_acquire
+#define  atomic_xchg_acquire		atomic_xchg
+#endif
+#ifndef atomic_xchg_release
+#define  atomic_xchg_release		atomic_xchg
+#endif
+
+#ifndef atomic_cmpxchg_relaxed
+#define  atomic_cmpxchg_relaxed		atomic_cmpxchg
+#endif
+#ifndef atomic_cmpxchg_acquire
+#define  atomic_cmpxchg_acquire		atomic_cmpxchg
+#endif
+#ifndef atomic_cmpxchg_release
+#define  atomic_cmpxchg_release		atomic_cmpxchg
+#endif
+
+#ifndef atomic64_read_acquire
+#define  atomic64_read_acquire(v)	smp_load_acquire(&(v)->counter)
+#endif
+
+#ifndef atomic64_set_release
+#define  atomic64_set_release(v, i)	smp_store_release(&(v)->counter, (i))
+#endif
+
+#ifndef atomic64_add_return_relaxed
+#define  atomic64_add_return_relaxed	atomic64_add_return
+#endif
+#ifndef atomic64_add_return_acquire
+#define  atomic64_add_return_acquire	atomic64_add_return
+#endif
+#ifndef atomic64_add_return_release
+#define  atomic64_add_return_release	atomic64_add_return
+#endif
+
+#ifndef atomic64_sub_return_relaxed
+#define  atomic64_sub_return_relaxed	atomic64_sub_return
+#endif
+#ifndef atomic64_sub_return_acquire
+#define  atomic64_sub_return_acquire	atomic64_sub_return
+#endif
+#ifndef atomic64_sub_return_release
+#define  atomic64_sub_return_release	atomic64_sub_return
+#endif
+
+#ifndef atomic64_xchg_relaxed
+#define  atomic64_xchg_relaxed		atomic64_xchg
+#endif
+#ifndef atomic64_xchg_acquire
+#define  atomic64_xchg_acquire		atomic64_xchg
+#endif
+#ifndef atomic64_xchg_release
+#define  atomic64_xchg_release		atomic64_xchg
+#endif
+
+#ifndef atomic64_cmpxchg_relaxed
+#define  atomic64_cmpxchg_relaxed	atomic64_cmpxchg
+#endif
+#ifndef atomic64_cmpxchg_acquire
+#define  atomic64_cmpxchg_acquire	atomic64_cmpxchg
+#endif
+#ifndef atomic64_cmpxchg_release
+#define  atomic64_cmpxchg_release	atomic64_cmpxchg
+#endif
+
+#ifndef cmpxchg_relaxed
+#define  cmpxchg_relaxed		cmpxchg
+#endif
+#ifndef cmpxchg_acquire
+#define  cmpxchg_acquire		cmpxchg
+#endif
+#ifndef cmpxchg_release
+#define  cmpxchg_release		cmpxchg
+#endif
+
+#ifndef cmpxchg64_relaxed
+#define  cmpxchg64_relaxed		cmpxchg64
+#endif
+#ifndef cmpxchg64_acquire
+#define  cmpxchg64_acquire		cmpxchg64
+#endif
+#ifndef cmpxchg64_release
+#define  cmpxchg64_release		cmpxchg64
+#endif
+
+#ifndef xchg_relaxed
+#define  xchg_relaxed			xchg
+#endif
+#ifndef xchg_acquire
+#define  xchg_acquire			xchg
+#endif
+#ifndef xchg_release
+#define  xchg_release			xchg
+#endif
+
 #endif /* _LINUX_ATOMIC_H */
-- 
2.1.4
