Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbfAIVH6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 16:07:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Kn2o2012559
        for <linux-arch@vger.kernel.org>; Wed, 9 Jan 2019 16:07:57 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq4rm3wa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 16:07:57 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:07:56 -0000
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 4/7] tools/memory-model: Update README for addition of SRCU
Date: Wed,  9 Jan 2019 13:07:45 -0800
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
Message-ID: <20190109210748.29074-4-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190109210745.5LVjMOl3_-3dZnkAuPipCfDLEeLp5KVyDrsHcV65v_0@z>

This commit updates the section on LKMM limitations to no longer say
that SRCU is not modeled, but instead describe how LKMM's modeling of
SRCU departs from the Linux-kernel implementation.

TL;DR:  There is no known valid use case that cares about the Linux
kernel's ability to have partially overlapping SRCU read-side critical
sections.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/README | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 0f2c366518c6..9d7d4f23503f 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -221,8 +221,29 @@ The Linux-kernel memory model has the following limitations:
 		additional call_rcu() process to the site of the
 		emulated rcu-barrier().
 
-	e.	Sleepable RCU (SRCU) is not modeled.  It can be
-		emulated, but perhaps not simply.
+	e.	Although sleepable RCU (SRCU) is now modeled, there
+		are some subtle differences between its semantics and
+		those in the Linux kernel.  For example, the kernel
+		might interpret the following sequence as two partially
+		overlapping SRCU read-side critical sections:
+
+			 1  r1 = srcu_read_lock(&my_srcu);
+			 2  do_something_1();
+			 3  r2 = srcu_read_lock(&my_srcu);
+			 4  do_something_2();
+			 5  srcu_read_unlock(&my_srcu, r1);
+			 6  do_something_3();
+			 7  srcu_read_unlock(&my_srcu, r2);
+
+		In contrast, LKMM will interpret this as a nested pair of
+		SRCU read-side critical sections, with the outer critical
+		section spanning lines 1-7 and the inner critical section
+		spanning lines 3-5.
+
+		This difference would be more of a concern had anyone
+		identified a reasonable use case for partially overlapping
+		SRCU read-side critical sections.  For more information,
+		please see: https://paulmck.livejournal.com/40593.html
 
 	f.	Reader-writer locking is not modeled.  It can be
 		emulated in litmus tests using atomic read-modify-write
-- 
2.17.1
