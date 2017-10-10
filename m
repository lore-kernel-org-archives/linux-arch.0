From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 05/15] percpu: READ_ONCE() now implies smp_read_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:39 -0700
Message-ID: <1507594969-8347-5-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
List-Id: linux-arch.vger.kernel.org

Because READ_ONCE() now implies smp_read_barrier_depends(), this commit
removes the now-redundant smp_read_barrier_depends() following the
READ_ONCE() in __ref_is_percpu().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
---
 include/linux/percpu-refcount.h | 6 +++---
 lib/percpu-refcount.c           | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index c13dceb87b60..1d0c18c59304 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -138,12 +138,12 @@ static inline bool __ref_is_percpu(struct percpu_ref *ref,
 	 * when using it as a pointer, __PERCPU_REF_ATOMIC may be set in
 	 * between contaminating the pointer value, meaning that
 	 * READ_ONCE() is required when fetching it.
+	 *
+	 * The smp_read_barrier_depends() implied by READ_ONCE() pairs
+	 * with smp_store_release() in __percpu_ref_switch_to_percpu().
 	 */
 	percpu_ptr = READ_ONCE(ref->percpu_count_ptr);
 
-	/* paired with smp_store_release() in __percpu_ref_switch_to_percpu() */
-	smp_read_barrier_depends();
-
 	/*
 	 * Theoretically, the following could test just ATOMIC; however,
 	 * then we'd have to mask off DEAD separately as DEAD may be
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index fe03c6d52761..30e7dd88148b 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -197,10 +197,10 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
 
 	/*
-	 * Restore per-cpu operation.  smp_store_release() is paired with
-	 * smp_read_barrier_depends() in __ref_is_percpu() and guarantees
-	 * that the zeroing is visible to all percpu accesses which can see
-	 * the following __PERCPU_REF_ATOMIC clearing.
+	 * Restore per-cpu operation.  smp_store_release() is paired
+	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
+	 * zeroing is visible to all percpu accesses which can see the
+	 * following __PERCPU_REF_ATOMIC clearing.
 	 */
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(percpu_count, cpu) = 0;
-- 
2.5.2
