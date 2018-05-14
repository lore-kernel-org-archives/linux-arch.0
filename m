Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752474AbeENXce (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:32:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4ENOHvU122037
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:34 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hykjv96ku-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:33 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 14 May 2018 19:32:32 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 11/19] tools/memory-model: Flag "cumulativity" and "propagation" tests
Date: Mon, 14 May 2018 16:33:49 -0700
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Message-ID: <1526340837-12222-11-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180514233349.OviVHmWFyfl3mBKPmvBBPA-MczPvmD4BQUMwCtuc_DU@z>

This commit flags WRC+pooncerelease+rmbonceonce+Once.litmus
as being forbidden by smp_store_release() A-cumulativity and
IRIW+mbonceonces+OnceOnce.litmus as being forbidden by the LKMM
propagation rule.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Updated wording as suggested by Alan Stern. ]
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus | 2 +-
 tools/memory-model/litmus-tests/README                           | 9 ++++++---
 .../litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus       | 4 +++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
index 50d5db9ea983..98a3716efa37 100644
--- a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
@@ -7,7 +7,7 @@ C IRIW+mbonceonces+OnceOnce
  * between each pairs of reads.  In other words, is smp_mb() sufficient to
  * cause two different reading processes to agree on the order of a pair
  * of writes, where each write is to a different variable by a different
- * process?
+ * process?  This litmus test exercises LKMM's "propagation" rule.
  *)
 
 {}
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 6919909bbd0f..17eb9a8c222d 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -23,7 +23,8 @@ IRIW+mbonceonces+OnceOnce.litmus
 	between each pairs of reads.  In other words, is smp_mb()
 	sufficient to cause two different reading processes to agree on
 	the order of a pair of writes, where each write is to a different
-	variable by a different process?
+	variable by a different process?  This litmus test is forbidden
+	by LKMM's propagation rule.
 
 IRIW+poonceonces+OnceOnce.litmus
 	Test of independent reads from independent writes with nothing
@@ -119,8 +120,10 @@ S+wmbonceonce+poacquireonce.litmus
 
 WRC+poonceonces+Once.litmus
 WRC+pooncerelease+rmbonceonce+Once.litmus
-	These two are members of an extension of the MP litmus-test class
-	in which the first write is moved to a separate process.
+	These two are members of an extension of the MP litmus-test
+	class in which the first write is moved to a separate process.
+	The second is forbidden because smp_store_release() is
+	A-cumulative in LKMM.
 
 Z6.0+pooncelock+pooncelock+pombonce.litmus
 	Is the ordering provided by a spin_unlock() and a subsequent
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
index 97fcbffde9a0..ad3448b941e6 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
@@ -5,7 +5,9 @@ C WRC+pooncerelease+rmbonceonce+Once
  *
  * This litmus test is an extension of the message-passing pattern, where
  * the first write is moved to a separate process.  Because it features
- * a release and a read memory barrier, it should be forbidden.
+ * a release and a read memory barrier, it should be forbidden.  More
+ * specifically, this litmus test is forbidden because smp_store_release()
+ * is A-cumulative in LKMM.
  *)
 
 {}
-- 
2.5.2
