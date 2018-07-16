Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728558AbeGPScV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jul 2018 14:32:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GHxFfp044881
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:50 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8w190t76-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:49 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 14:03:48 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 01/14] tools/memory-model: Add litmus test for full multicopy atomicity
Date: Mon, 16 Jul 2018 11:05:52 -0700
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Message-ID: <20180716180605.16115-1-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180716180552.M_4rWl7t8f2OfKjPVZSQSRFNawJSbe9T1c4XPLoC0xs@z>

This commit adds a litmus test suggested by Alan Stern that is forbidden
on fully multicopy atomic systems, but allowed on other-multicopy and
on non-multicopy atomic systems.  For reference, s390 is fully multicopy
atomic, x86 and ARMv8 are other-multicopy atomic, and ARMv7 and powerpc
are non-multicopy atomic.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/litmus-tests/README        |  9 ++++++
 .../SB+rfionceonce-poonceonces.litmus         | 32 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 17eb9a8c222d..00140aaf58b7 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -111,6 +111,15 @@ SB+mbonceonces.litmus
 SB+poonceonces.litmus
 	As above, but without the smp_mb() invocations.
 
+SB+rfionceonce-poonceonces.litmus
+	This litmus test demonstrates that LKMM is not fully multicopy
+	atomic.  (Neither is it other multicopy atomic.)  This litmus test
+	also demonstrates the "locations" debugging aid, which designates
+	additional registers and locations to be printed out in the dump
+	of final states in the herd7 output.  Without the "locations"
+	statement, only those registers and locations mentioned in the
+	"exists" clause will be printed.
+
 S+poonceonces.litmus
 	As below, but without the smp_wmb() and acquire load.
 
diff --git a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
new file mode 100644
index 000000000000..04a16603660b
--- /dev/null
+++ b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
@@ -0,0 +1,32 @@
+C SB+rfionceonce-poonceonces
+
+(*
+ * Result: Sometimes
+ *
+ * This litmus test demonstrates that LKMM is not fully multicopy atomic.
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	r1 = READ_ONCE(*x);
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y)
+{
+	int r3;
+	int r4;
+
+	WRITE_ONCE(*y, 1);
+	r3 = READ_ONCE(*y);
+	r4 = READ_ONCE(*x);
+}
+
+locations [0:r1; 1:r3; x; y] (* Debug aid: Print things not in "exists". *)
+exists (0:r2=0 /\ 1:r4=0)
-- 
2.17.1
