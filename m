Return-Path: <SRS0=zDlA=5F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39108 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgCTG4E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 02:56:04 -0400
Received: by mail-qv1-f65.google.com with SMTP id v38so2427868qvf.6
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2020 23:56:02 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 2/3] LKMM: Add litmus test for RCU GP guarantee where reader stores
Date: Fri, 20 Mar 2020 02:55:51 -0400
Message-ID: <20200320065552.253696-2-joel@joelfernandes.org>
In-Reply-To: <20200320065552.253696-1-joel@joelfernandes.org>
References: <20200320065552.253696-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Message-ID: <20200320065551.aF3_aYIJOr0mx02BizOEGxAU0FQpo2ycWnLlSsPcOSI@z>

This adds an example for the important RCU grace period guarantee, which
shows an RCU reader can never span a grace period.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus

diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
new file mode 100644
index 0000000000000..73557772e2a32
--- /dev/null
+++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
@@ -0,0 +1,37 @@
+C RCU+sync+read
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that after a grace period, an RCU updater always
+ * sees all stores done in prior RCU read-side critical sections. Such
+ * read-side critical sections would have ended before the grace period ended.
+ *
+ * This guarantee also implies, an RCU reader can never span a grace period and
+ * is an important RCU grace period memory ordering guarantee.
+ *)
+
+{
+x = 0;
+y = 0;
+}
+
+P0(int *x, int *y)
+{
+	rcu_read_lock();
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	rcu_read_unlock();
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+	int r1;
+
+	r0 = READ_ONCE(*x);
+	synchronize_rcu();
+	r1 = READ_ONCE(*y);
+}
+
+exists (1:r0=1 /\ 1:r1=0)
-- 
2.25.1.696.g5e7596f4ac-goog
