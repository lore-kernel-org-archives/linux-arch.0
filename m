From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 18/19] alpha: atomics: Add smp_read_barrier_depends() to release/relaxed atomics
Date: Mon, 23 Oct 2017 14:07:28 -0700
Message-ID: <1508792849-3115-18-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751635AbdJWVHn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL7A9P067795
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:42 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dspxqtnna-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:42 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:42 -0400
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

From: Will Deacon <will.deacon@arm.com>

As part of the fight against smp_read_barrier_depends(), we require
dependency ordering to be preserved when a dependency is headed by a load
performed using an atomic operation.

This patch adds smp_read_barrier_depends() to the _release and _relaxed
atomics on alpha, which otherwise lack anything to enforce dependency
ordering.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/alpha/include/asm/atomic.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 498933a7df97..16961a3f45ba 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -13,6 +13,15 @@
  * than regular operations.
  */
 
+/*
+ * To ensure dependency ordering is preserved for the _relaxed and
+ * _release atomics, an smp_read_barrier_depends() is unconditionally
+ * inserted into the _relaxed variants, which are used to build the
+ * barriered versions. To avoid redundant back-to-back fences, we can
+ * define the _acquire and _fence versions explicitly.
+ */
+#define __atomic_op_acquire(op, args...)	op##_relaxed(args)
+#define __atomic_op_fence			__atomic_op_release
 
 #define ATOMIC_INIT(i)		{ (i) }
 #define ATOMIC64_INIT(i)	{ (i) }
@@ -60,6 +69,7 @@ static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
+	smp_read_barrier_depends();					\
 	return result;							\
 }
 
@@ -77,6 +87,7 @@ static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
+	smp_read_barrier_depends();					\
 	return result;							\
 }
 
@@ -111,6 +122,7 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v)	\
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
+	smp_read_barrier_depends();					\
 	return result;							\
 }
 
@@ -128,6 +140,7 @@ static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)	\
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
+	smp_read_barrier_depends();					\
 	return result;							\
 }
 
-- 
2.5.2
