From: paulmck@kernel.org
Subject: [PATCH lkmm tip/core/rcu 03/10] Documentation: LKMM: Move MP+onceassign+derefonce to new litmus-tests/rcu/
Date: Wed, 15 Apr 2020 11:49:38 -0700
Message-ID: <20200415184945.16487-3-paulmck@kernel.org>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416859AbgDOSts (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 14:49:48 -0400
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Paul E . McKenney" <paulmck@kernel.org>

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Move MP+onceassign+derefonce to the new Documentation/litmus-tests/rcu/
directory.

More RCU-related litmus tests would be added here.

Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/litmus-tests/README                                | 9 +++++++++
 .../litmus-tests/rcu}/MP+onceassign+derefonce.litmus             | 0
 tools/memory-model/litmus-tests/README                           | 3 ---
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/litmus-tests/README
 rename {tools/memory-model/litmus-tests => Documentation/litmus-tests/rcu}/MP+onceassign+derefonce.litmus (100%)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
new file mode 100644
index 0000000..84208bc
--- /dev/null
+++ b/Documentation/litmus-tests/README
@@ -0,0 +1,9 @@
+============
+LITMUS TESTS
+============
+
+RCU (/rcu directory)
+--------------------
+MP+onceassign+derefonce.litmus
+    Demonstrates that rcu_assign_pointer() and rcu_dereference() to
+    ensure that an RCU reader will not see pre-initialization garbage.
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/Documentation/litmus-tests/rcu/MP+onceassign+derefonce.litmus
similarity index 100%
rename from tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
rename to Documentation/litmus-tests/rcu/MP+onceassign+derefonce.litmus
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 681f906..79e1b1e 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -63,9 +63,6 @@ LB+poonceonces.litmus
 	As above, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
 
-MP+onceassign+derefonce.litmus
-	As below, but with rcu_assign_pointer() and an rcu_dereference().
-
 MP+polockmbonce+poacquiresilsil.litmus
 	Protect the access with a lock and an smp_mb__after_spinlock()
 	in one process, and use an acquire load followed by a pair of
-- 
2.9.5
