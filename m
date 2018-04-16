From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/memory-model 2/5] tools/memory-model: Add litmus test for multicopy atomicity
Date: Mon, 16 Apr 2018 09:22:48 -0700
Message-ID: <1523895771-19224-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180416162228.GA18167@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416162228.GA18167@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

This commit adds a litmus test suggested by Alan Stern that is forbidden
on multicopy atomic systems, but allowed on non-multicopy atomic systems.
Note that other-multicopy atomic systems are examples of non-multicopy
atomic systems.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../litmus-tests/SB+poonceoncescoh.litmus          | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus

diff --git a/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
new file mode 100644
index 000000000000..991a2d6dec63
--- /dev/null
+++ b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
@@ -0,0 +1,31 @@
+C SB+poonceoncescoh
+
+(*
+ * Result: Sometimes
+ *
+ * This litmus test demonstrates that LKMM is not multicopy atomic.
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	r1 = READ_ONCE(*x);
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y)
+{
+	int r3;
+	int r4;
+
+	WRITE_ONCE(*y, 1);
+	r3 = READ_ONCE(*y);
+	r4 = READ_ONCE(*x);
+}
+
+exists (0:r2=0 /\ 1:r4=0 /\ 0:r1=1 /\ 1:r3=1)
-- 
2.5.2
