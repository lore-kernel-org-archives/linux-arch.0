From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 14/19] tools/memory-model: Improve mixed-access checking in lock.cat
Date: Mon, 14 May 2018 16:33:52 -0700
Message-ID: <1526340837-12222-14-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

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
