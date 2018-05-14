From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 12/19] tools/memory-model: Remove duplicated code from lock.cat
Date: Mon, 14 May 2018 16:33:50 -0700
Message-ID: <1526340837-12222-12-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

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
