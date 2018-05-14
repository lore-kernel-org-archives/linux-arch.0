Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752503AbeENXcf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:32:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4ENOIpn044828
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:35 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hykjah825-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:35 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 14 May 2018 19:32:32 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 15/19] tools/memory-model: Remove out-of-date comments and code from lock.cat
Date: Mon, 14 May 2018 16:33:53 -0700
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Message-ID: <1526340837-12222-15-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180514233353.p5YQjamUAmNV4mNA1UHdyjF_egqJg6b4ZPziZzkgNvI@z>

From: Alan Stern <stern@rowland.harvard.edu>

lock.cat contains old comments and code referring to the possibility
of LKR events that are not part of an RMW pair.  This is a holdover
from when I though we might end up using LKR events to implement
spin_is_locked().  Reword the comments to remove this assumption and
replace domain(lk-rmw) in the code with LKR.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Akira Yokosawa <akiyks@gmail.com>
CC: Andrea Parri <andrea.parri@amarulasolutions.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: David Howells <dhowells@redhat.com>
CC: Jade Alglave <j.alglave@ucl.ac.uk>
CC: Luc Maranget <luc.maranget@inria.fr>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
[ paulmck: Pulled "as lock-nest" into previous line as discussed. ]
---
 tools/memory-model/lock.cat | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 7217cd4941a4..cd002a33ca8a 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -47,18 +47,15 @@ flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
 let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
 let rmw = rmw | lk-rmw
 
+(* The litmus test is invalid if an LKR/LKW event is not part of an RMW pair *)
+flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
+flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
+
 (*
- * A paired LKR must always see an unlocked value; spin_lock() calls nested
+ * An LKR must always see an unlocked value; spin_lock() calls nested
  * inside a critical section (for the same lock) always deadlock.
  *)
-empty ([LKW] ; po-loc ; [domain(lk-rmw)]) \ (po-loc ; [UL] ; po-loc)
-	as lock-nest
-
-(* The litmus test is invalid if an LKW event is not part of an RMW pair *)
-flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
-
-(* This will be allowed if we implement spin_is_locked() *)
-flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
+empty ([LKW] ; po-loc ; [LKR]) \ (po-loc ; [UL] ; po-loc) as lock-nest
 
 (* The final value of a spinlock should not be tested *)
 flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
-- 
2.5.2
