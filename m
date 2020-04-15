From: paulmck@kernel.org
Subject: [PATCH lkmm tip/core/rcu 09/10] Documentation/litmus-tests/atomic: Add a test for atomic_set()
Date: Wed, 15 Apr 2020 11:49:44 -0700
Message-ID: <20200415184945.16487-9-paulmck@kernel.org>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416865AbgDOStt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 14:49:49 -0400
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>

From: Boqun Feng <boqun.feng@gmail.com>

We already use a litmus test in atomic_t.txt to describe the behavior of
an atomic_set() with the an atomic RMW, so add it into atomic-tests
directory to make it easily accessible for anyone who cares about the
semantics of our atomic APIs.

Besides currently the litmus test "atomic-set" in atomic_t.txt has a few
things to be improved:

1)	The CPU/Processor numbers "P1,P2" are not only inconsistent with
	the rest of the document, which uses "CPU0" and "CPU1", but also
	unacceptable by the herd tool, which requires processors start
	at "P0".

2)	The initialization block uses a "atomic_set()", which is OK, but
	it's better to use ATOMIC_INIT() to make clear this is an
	initialization.

3)	The return value of atomic_add_unless() is discarded
	inexplicitly, which is OK for C language, but it will be helpful
	to the herd tool if we use a void cast to make the discard
	explicit.

4)	The name and the paragraph describing the test need to be more
	accurate and aligned with our wording in LKMM.

Therefore fix these in both atomic_t.txt and the new added litmus test.

Acked-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/atomic_t.txt                         | 14 ++++++-------
 ...Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++++++++++
 Documentation/litmus-tests/atomic/README           |  7 +++++++
 3 files changed, 38 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 0ab747e..67d1d99f 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -85,21 +85,21 @@ smp_store_release() respectively. Therefore, if you find yourself only using
 the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
 and are doing it wrong.
 
-A subtle detail of atomic_set{}() is that it should be observable to the RMW
-ops. That is:
+A note for the implementation of atomic_set{}() is that it must not break the
+atomicity of the RMW ops. That is:
 
-  C atomic-set
+  C Atomic-RMW-ops-are-atomic-WRT-atomic_set
 
   {
-    atomic_set(v, 1);
+    atomic_t v = ATOMIC_INIT(1);
   }
 
-  P1(atomic_t *v)
+  P0(atomic_t *v)
   {
-    atomic_add_unless(v, 1, 0);
+    (void)atomic_add_unless(v, 1, 0);
   }
 
-  P2(atomic_t *v)
+  P1(atomic_t *v)
   {
     atomic_set(v, 0);
   }
diff --git a/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
new file mode 100644
index 0000000..4938531
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
@@ -0,0 +1,24 @@
+C Atomic-RMW-ops-are-atomic-WRT-atomic_set
+
+(*
+ * Result: Never
+ *
+ * Test that atomic_set() cannot break the atomicity of atomic RMWs.
+ *)
+
+{
+	atomic_t v = ATOMIC_INIT(1);
+}
+
+P0(atomic_t *v)
+{
+	(void)atomic_add_unless(v, 1, 0);
+}
+
+P1(atomic_t *v)
+{
+	atomic_set(v, 0);
+}
+
+exists
+(v=2)
diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
index ae61201..a1b7241 100644
--- a/Documentation/litmus-tests/atomic/README
+++ b/Documentation/litmus-tests/atomic/README
@@ -2,3 +2,10 @@ This directory contains litmus tests that are typical to describe the semantics
 of our atomic APIs. For more information about how to "run" a litmus test or
 how to generate a kernel test module based on a litmus test, please see
 tools/memory-model/README.
+
+============
+LITMUS TESTS
+============
+
+Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
+	Test that atomic_set() cannot break the atomicity of atomic RMWs.
-- 
2.9.5
