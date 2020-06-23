From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 03/14] Documentation: LKMM: Add litmus test for RCU GP guarantee where updater frees object
Date: Mon, 22 Jun 2020 17:52:20 -0700
Message-ID: <20200623005231.27712-3-paulmck@kernel.org>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732368AbgFWAwe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:34 -0400
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Paul E . McKenney" <paulmck@kernel.org>

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This adds an example for the important RCU grace period guarantee, which
shows an RCU reader can never span a grace period.

Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../litmus-tests/rcu/RCU+sync+free.litmus          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/litmus-tests/rcu/RCU+sync+free.litmus

diff --git a/Documentation/litmus-tests/rcu/RCU+sync+free.litmus b/Documentation/litmus-tests/rcu/RCU+sync+free.litmus
new file mode 100644
index 0000000..4ee67e1
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU+sync+free.litmus
@@ -0,0 +1,42 @@
+C RCU+sync+free
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that an RCU reader can never see a write that
+ * follows a grace period, if it did not see writes that precede that grace
+ * period.
+ *
+ * This is a typical pattern of RCU usage, where the write before the grace
+ * period assigns a pointer, and the writes following the grace period destroy
+ * the object that the pointer used to point to.
+ *
+ * This is one implication of the RCU grace-period guarantee, which says (among
+ * other things) that an RCU read-side critical section cannot span a grace period.
+ *)
+
+{
+int x = 1;
+int *y = &x;
+int z = 1;
+}
+
+P0(int *x, int *z, int **y)
+{
+	int *r0;
+	int r1;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*y);
+	r1 = READ_ONCE(*r0);
+	rcu_read_unlock();
+}
+
+P1(int *x, int *z, int **y)
+{
+	rcu_assign_pointer(*y, z);
+	synchronize_rcu();
+	WRITE_ONCE(*x, 0);
+}
+
+exists (0:r0=x /\ 0:r1=0)
-- 
2.9.5
