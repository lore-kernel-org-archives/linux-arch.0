Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755830AbdJJAW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0JR2p118532
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:56 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dgg5d0smx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:55 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:54 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 05/15] percpu: READ_ONCE() now implies smp_read_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:39 -0700
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Message-ID: <1507594969-8347-5-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Message-ID: <20171010002239.AxQ9jU0IaxAGIXQ0TqCURWsu1a9_bbgiC5Pry37prqA@z>

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
