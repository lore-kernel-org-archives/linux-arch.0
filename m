Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752452AbeENXce (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:32:34 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4ENOLsg127474
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:34 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hyj5hkv4p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:33 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 14 May 2018 19:32:32 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 14/19] tools/memory-model: Improve mixed-access checking in lock.cat
Date: Mon, 14 May 2018 16:33:52 -0700
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Message-ID: <1526340837-12222-14-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180514233352.-_4d_aOllPYRJIT_RptZBJDnDjDv02Gl5DYxUL1QHNI@z>

From: Alan Stern <stern@rowland.harvard.edu>

The code in lock.cat which checks for normal read/write accesses to
spinlock variables doesn't take into account the newly added RL and RU
events.  Add them into the test, and move the resulting code up near
the start of the file, since a violation would indicate a pretty
severe conceptual error in a litmus test.

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
---
 tools/memory-model/lock.cat | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index df74de2148f6..7217cd4941a4 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -32,6 +32,17 @@ include "cross.cat"
  * LKW, LF, RL, and RU have no ordering properties.
  *)
 
+(* Backward compatibility *)
+let RL = try RL with emptyset
+let RU = try RU with emptyset
+
+(* Treat RL as a kind of LF: a read with no ordering properties *)
+let LF = LF | RL
+
+(* There should be no ordinary R or W accesses to spinlocks *)
+let ALL-LOCKS = LKR | LKW | UL | LF | RU
+flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
+
 (* Link Lock-Reads to their RMW-partner Lock-Writes *)
 let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
 let rmw = rmw | lk-rmw
@@ -49,20 +60,9 @@ flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
 (* This will be allowed if we implement spin_is_locked() *)
 flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
 
-(* There should be no ordinary R or W accesses to spinlocks *)
-let ALL-LOCKS = LKR | LKW | UL | LF
-flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
-
 (* The final value of a spinlock should not be tested *)
 flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
 
-(* Backward compatibility *)
-let RL = try RL with emptyset
-let RU = try RU with emptyset
-
-(* Treat RL as a kind of LF: a read with no ordering properties *)
-let LF = LF | RL
-
 (*
  * Put lock operations in their appropriate classes, but leave UL out of W
  * until after the co relation has been generated.
-- 
2.5.2
