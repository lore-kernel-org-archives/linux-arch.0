From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 12/14] Documentation/litmus-tests: Cite an RCU litmus test
Date: Mon, 22 Jun 2020 17:52:29 -0700
Message-ID: <20200623005231.27712-12-paulmck@kernel.org>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732389AbgFWAwf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:35 -0400
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Paul E . McKenney" <paulmck@kernel.org>

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit cites a pertinent RCU-related litmus test.

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
[Alan: grammar nit]
[ paulmck: Update commit log and title per Akira feedback. ]
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/litmus-tests/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index ac0b270..b79e640 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -24,6 +24,10 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 RCU (/rcu directory)
 --------------------
 
+MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)
+    Demonstrates the use of rcu_assign_pointer() and rcu_dereference() to
+    ensure that an RCU reader will not see pre-initialization garbage.
+
 RCU+sync+read.litmus
 RCU+sync+free.litmus
     Both the above litmus tests demonstrate the RCU grace period guarantee
-- 
2.9.5
