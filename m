From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/21] tools/memory-model: Add support for synchronize_srcu_expedited()
Date: Tue, 26 Mar 2019 16:41:20 -0700
Message-ID: <20190326234133.24962-8-paulmck@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326234114.GA23843@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

Given that synchronize_rcu_expedited() is supported, this commit adds
support for synchronize_srcu_expedited().

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/linux-kernel.def | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 0c3f0ef486f4..551eeaa389d4 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -51,6 +51,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
 srcu_read_lock(X)  __srcu{srcu-lock}(X)
 srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
 synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
+synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
 
 // Atomic
 atomic_read(X) READ_ONCE(*X)
-- 
2.17.1
