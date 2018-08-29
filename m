Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729084AbeH3BJp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 21:09:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TL97Tn108384
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 17:11:04 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m60fgph74-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 17:11:04 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:11:02 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC LKMM 3/7] EXP tools/memory-model: Add more LKMM limitations
Date: Wed, 29 Aug 2018 14:10:49 -0700
In-Reply-To: <20180829211018.GA19646@linux.vnet.ibm.com>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
Message-ID: <20180829211053.20531-3-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180829211049.4gkmWXxKF9CjMvajxEUFt_pGg8yQne7dSR3IGByAWNY@z>

This commit adds more detail about compiler optimizations and
not-yet-modeled Linux-kernel APIs.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/README | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index ee987ce20aae..acf9077cffaa 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -171,6 +171,12 @@ The Linux-kernel memory model has the following limitations:
 	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
 	and "A WARNING" sections).
 
+	Note that this limitation in turn limits LKMM's ability to
+	accurately model address, control, and data dependencies.
+	For example, if the compiler can deduce the value of some variable
+	carrying a dependency, then the compiler can break that dependency
+	by substituting a constant of that value.
+
 2.	Multiple access sizes for a single variable are not supported,
 	and neither are misaligned or partially overlapping accesses.
 
@@ -190,6 +196,36 @@ The Linux-kernel memory model has the following limitations:
 	However, a substantial amount of support is provided for these
 	operations, as shown in the linux-kernel.def file.
 
+	a.	When rcu_assign_pointer() is passed NULL, the Linux
+		kernel provides no ordering, but LKMM models this
+		case as a store release.
+
+	b.	The "unless" RMW operations are not currently modeled:
+		atomic_long_add_unless(), atomic_add_unless(),
+		atomic_inc_unless_negative(), and
+		atomic_dec_unless_positive().  These can be emulated
+		in litmus tests, for example, by using atomic_cmpxchg().
+
+	c.	The call_rcu() function is not modeled.  It can be
+		emulated in litmus tests by adding another process that
+		invokes synchronize_rcu() and the body of the callback
+		function, with (for example) a release-acquire from
+		the site of the emulated call_rcu() to the beginning
+		of the additional process.
+
+	d.	The rcu_barrier() function is not modeled.  It can be
+		emulated in litmus tests emulating call_rcu() via
+		(for example) a release-acquire from the end of each
+		additional call_rcu() process to the site of the
+		emulated rcu-barrier().
+
+	e.	Sleepable RCU (SRCU) is not modeled.  It can be
+		emulated, but perhaps not simply.
+
+	f.	Reader-writer locking is not modeled.  It can be
+		emulated in litmus tests using atomic read-modify-write
+		operations.
+
 The "herd7" tool has some additional limitations of its own, apart from
 the memory model:
 
@@ -204,3 +240,6 @@ the memory model:
 Some of these limitations may be overcome in the future, but others are
 more likely to be addressed by incorporating the Linux-kernel memory model
 into other tools.
+
+Finally, please note that LKMM is subject to change as hardware, use cases,
+and compilers evolve.
-- 
2.17.1
