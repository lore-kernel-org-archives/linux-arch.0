From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC LKMM 2/7] doc: Replace smp_cond_acquire() with smp_cond_load_acquire()
Date: Wed, 29 Aug 2018 14:10:48 -0700
Message-ID: <20180829211053.20531-2-paulmck@linux.vnet.ibm.com>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829211018.GA19646@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-arch.vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
with smp_cond_load_acquire()") by updating the documentation accordingly.
Also remove some obsolete information related to the implementation.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 0d8d7ef131e9..c1d913944ad8 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -471,8 +471,7 @@ And a couple of implicit varieties:
      operations after the ACQUIRE operation will appear to happen after the
      ACQUIRE operation with respect to the other components of the system.
      ACQUIRE operations include LOCK operations and both smp_load_acquire()
-     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
-     semantics from relying on a control dependency and smp_rmb().
+     and smp_cond_load_acquire() operations.
 
      Memory operations that occur before an ACQUIRE operation may appear to
      happen after it completes.
-- 
2.17.1
