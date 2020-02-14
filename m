From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Date: Fri, 14 Feb 2020 12:01:31 +0800
Message-ID: <20200214040132.91934-3-boqun.feng@gmail.com>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214040132.91934-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

We already use a litmus test in atomic_t.txt to describe the behavior of
an atomic_set() with the an atomic RMW, so add it into the litmus-tests
directory to make it easily accessible for anyone who cares about the
semantics of our atomic APIs.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 .../Atomic-set-observable-to-RMW.litmus       | 24 +++++++++++++++++++
 tools/memory-model/litmus-tests/README        |  3 +++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus

diff --git a/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus b/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
new file mode 100644
index 000000000000..4326f56f2c1a
--- /dev/null
+++ b/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
@@ -0,0 +1,24 @@
+C Atomic-set-observable-to-RMW
+
+(*
+ * Result: Never
+ *
+ * Test of the result of atomic_set() must be observable to atomic RMWs.
+ *)
+
+{
+	atomic_t v = ATOMIC_INIT(1);
+}
+
+P0(atomic_t *v)
+{
+	(void)atomic_add_unless(v,1,0);
+}
+
+P1(atomic_t *v)
+{
+	atomic_set(v, 0);
+}
+
+exists
+(v=2)
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 681f9067fa9e..81eeacebd160 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -2,6 +2,9 @@
 LITMUS TESTS
 ============
 
+Atomic-set-observable-to-RMW.litmus
+	Test of the result of atomic_set() must be observable to atomic RMWs.
+
 CoRR+poonceonce+Once.litmus
 	Test of read-read coherence, that is, whether or not two
 	successive reads from the same variable are ordered.
-- 
2.25.0
