Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753104AbeDPQVv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Apr 2018 12:21:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3GGKfXK094507
        for <linux-arch@vger.kernel.org>; Mon, 16 Apr 2018 12:21:51 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hcwe2ww4t-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Apr 2018 12:21:50 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Apr 2018 12:21:49 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/memory-model 2/5] tools/memory-model: Add litmus test for multicopy atomicity
Date: Mon, 16 Apr 2018 09:22:48 -0700
In-Reply-To: <20180416162228.GA18167@linux.vnet.ibm.com>
References: <20180416162228.GA18167@linux.vnet.ibm.com>
Message-ID: <1523895771-19224-2-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180416162248.YGZTqb1bql-bRajMC5Xot0Q7p0dmn1_fkd15T3_fMdE@z>

This commit adds a litmus test suggested by Alan Stern that is forbidden
on multicopy atomic systems, but allowed on non-multicopy atomic systems.
Note that other-multicopy atomic systems are examples of non-multicopy
atomic systems.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../litmus-tests/SB+poonceoncescoh.litmus          | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus

diff --git a/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
new file mode 100644
index 000000000000..991a2d6dec63
--- /dev/null
+++ b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
@@ -0,0 +1,31 @@
+C SB+poonceoncescoh
+
+(*
+ * Result: Sometimes
+ *
+ * This litmus test demonstrates that LKMM is not multicopy atomic.
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
+exists (0:r2=0 /\ 1:r4=0 /\ 0:r1=1 /\ 1:r3=1)
-- 
2.5.2
