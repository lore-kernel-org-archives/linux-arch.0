Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752430AbeENXce (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:32:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4ENOLgh040742
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:33 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hyfnssmgm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 19:32:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 14 May 2018 19:32:32 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 12/19] tools/memory-model: Remove duplicated code from lock.cat
Date: Mon, 14 May 2018 16:33:50 -0700
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Message-ID: <1526340837-12222-12-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180514233350.okRFejfzGcf49CBWEccTTtFEpqY45C8vZAa_bQjDXaw@z>

From: Alan Stern <stern@rowland.harvard.edu>

This patch simplifies the implementation of spin_is_locked in the
LKMM.  It capitalizes on the fact that a failed spin_trylock() and a
spin_is_locked() which returns True have exactly the same semantics
(those of READ_ONCE) and ordering properties (none).  Therefore the
two kinds of events can be combined and handled by the same code,
instead of treated separately as they are currently.

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
 tools/memory-model/lock.cat | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 3b1439edc818..1f6d67e79065 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -41,11 +41,15 @@ flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
  *)
 let RL = try RL with emptyset (* defined herd7 >= 7.49 *)
 let RU = try RU with emptyset (* defined herd7 >= 7.49 *)
+
+(* Treat RL as a kind of LF: a read with no ordering properties *)
+let LF = LF | RL
+
 (*
  * Put lock operations in their appropriate classes, but leave UL out of W
  * until after the co relation has been generated.
  *)
-let R = R | LKR | LF | RL | RU
+let R = R | LKR | LF | RU
 let W = W | LKW
 
 let Release = Release | UL
@@ -80,28 +84,8 @@ let all-possible-rfe-lf =
 
 (* Generate all rf relations for LF events *)
 with rfe-lf from cross(all-possible-rfe-lf)
-
 let rf-lf = rfe-lf | rfi-lf
 
-(* rf for RL events, ie islocked returning true, similar to LF above *)
-
-(* islocked returning true inside a critical section
- * must read from the opening lock
- *)
-let rfi-rl = ([LKW] ; po-loc ; [RL]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
-
-(* islocked returning true outside critical sections can match any
- * external lock.
- *)
-let all-possible-rfe-rl =
-  let possible-rfe-lf r =
-    let pair-to-relation p = p ++ 0
-    in map pair-to-relation ((LKW * {r}) & loc & ext)
-  in map possible-rfe-lf (RL \ range(rfi-rl))
-
-with rfe-rl from cross(all-possible-rfe-rl)
-let rf-rl = rfe-rl | rfi-rl
-
 (* Read from unlock, ie islocked returning false, slightly different *)
 
 (* islocked returning false can read from the last po-previous unlock *)
@@ -118,7 +102,7 @@ with rfe-ru from cross(all-possible-rfe-ru)
 let rf-ru = rfe-ru | rfi-ru
 
 (* Final rf relation *)
-let rf = rf | rf-lf | rf-rl | rf-ru
+let rf = rf | rf-lf | rf-ru
 
 (* Generate all co relations, including LKW events but not UL *)
 let co0 = co0 | ([IW] ; loc ; [LKW]) |
-- 
2.5.2
