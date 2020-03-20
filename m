From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 1/3] LKMM: Add litmus test for RCU GP guarantee where updater frees object
Date: Fri, 20 Mar 2020 02:55:50 -0400
Message-ID: <20200320065552.253696-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37770 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCTG4B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 02:56:01 -0400
Received: by mail-qk1-f195.google.com with SMTP id z25so5865150qkj.4
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2020 23:56:01 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

This adds an example for the important RCU grace period guarantee, which
shows an RCU reader can never span a grace period.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../litmus-tests/RCU+sync+free.litmus         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/RCU+sync+free.litmus

diff --git a/tools/memory-model/litmus-tests/RCU+sync+free.litmus b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
new file mode 100644
index 0000000000000..c4682502dd296
--- /dev/null
+++ b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
@@ -0,0 +1,40 @@
+C RCU+sync+free
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that an RCU reader can never see a write after
+ * the grace period, if it saw writes that happen before the grace period. This
+ * is a typical pattern of RCU usage, where the write before the grace period
+ * assigns a pointer, and the writes after destroy the object that the pointer
+ * points to.
+ *
+ * This guarantee also implies, an RCU reader can never span a grace period and
+ * is an important RCU grace period memory ordering guarantee.
+ *)
+
+{
+x = 1;
+y = x;
+z = 1;
+}
+
+P0(int *x, int *z, int **y)
+{
+	int r0;
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
2.25.1.696.g5e7596f4ac-goog
