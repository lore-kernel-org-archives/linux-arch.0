From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 14/14] tools/memory-model: Rename litmus tests to comply to norm7
Date: Mon, 16 Jul 2018 11:06:05 -0700
Message-ID: <20180716180605.16115-14-paulmck@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

norm7 produces the 'normalized' name of a litmus test,  when the test
can be generated from a single cycle that passes through each process
exactly once. The commit renames such tests in order to comply to the
naming scheme implemented by this tool.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/Documentation/recipes.txt  |  8 ++++----
 tools/memory-model/README                     | 20 +++++++++----------
 ... => IRIW+fencembonceonces+OnceOnce.litmus} |  2 +-
 ...=> LB+fencembonceonce+ctrlonceonce.litmus} |  2 +-
 ...+fencewmbonceonce+fencermbonceonce.litmus} |  2 +-
 ...onces.litmus => R+fencembonceonces.litmus} |  2 +-
 tools/memory-model/litmus-tests/README        | 16 +++++++--------
 ...> S+fencewmbonceonce+poacquireonce.litmus} |  2 +-
 ...nces.litmus => SB+fencembonceonces.litmus} |  2 +-
 ...ooncerelease+fencermbonceonce+Once.litmus} |  2 +-
 ...e+poacquirerelease+fencembonceonce.litmus} |  2 +-
 11 files changed, 30 insertions(+), 30 deletions(-)
 rename tools/memory-model/litmus-tests/{IRIW+mbonceonces+OnceOnce.litmus => IRIW+fencembonceonces+OnceOnce.litmus} (95%)
 rename tools/memory-model/litmus-tests/{LB+ctrlonceonce+mbonceonce.litmus => LB+fencembonceonce+ctrlonceonce.litmus} (95%)
 rename tools/memory-model/litmus-tests/{MP+wmbonceonce+rmbonceonce.litmus => MP+fencewmbonceonce+fencermbonceonce.litmus} (91%)
 rename tools/memory-model/litmus-tests/{R+mbonceonces.litmus => R+fencembonceonces.litmus} (95%)
 rename tools/memory-model/litmus-tests/{S+wmbonceonce+poacquireonce.litmus => S+fencewmbonceonce+poacquireonce.litmus} (90%)
 rename tools/memory-model/litmus-tests/{SB+mbonceonces.litmus => SB+fencembonceonces.litmus} (95%)
 rename tools/memory-model/litmus-tests/{WRC+pooncerelease+rmbonceonce+Once.litmus => WRC+pooncerelease+fencermbonceonce+Once.litmus} (93%)
 rename tools/memory-model/litmus-tests/{Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus => Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus} (94%)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index 1fea8ef2b184..af72700cc20a 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -126,7 +126,7 @@ However, it is not necessarily the case that accesses ordered by
 locking will be seen as ordered by CPUs not holding that lock.
 Consider this example:
 
-	/* See Z6.0+pooncelock+pooncelock+pombonce.litmus. */
+	/* See Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus. */
 	void CPU0(void)
 	{
 		spin_lock(&mylock);
@@ -292,7 +292,7 @@ and to use smp_load_acquire() instead of smp_rmb().  However, the older
 smp_wmb() and smp_rmb() APIs are still heavily used, so it is important
 to understand their use cases.  The general approach is shown below:
 
-	/* See MP+wmbonceonce+rmbonceonce.litmus. */
+	/* See MP+fencewmbonceonce+fencermbonceonce.litmus. */
 	void CPU0(void)
 	{
 		WRITE_ONCE(x, 1);
@@ -360,7 +360,7 @@ can be seen in the LB+poonceonces.litmus litmus test.
 One way of avoiding the counter-intuitive outcome is through the use of a
 control dependency paired with a full memory barrier:
 
-	/* See LB+ctrlonceonce+mbonceonce.litmus. */
+	/* See LB+fencembonceonce+ctrlonceonce.litmus. */
 	void CPU0(void)
 	{
 		r0 = READ_ONCE(x);
@@ -476,7 +476,7 @@ that one CPU first stores to one variable and then loads from a second,
 while another CPU stores to the second variable and then loads from the
 first.  Preserving order requires nothing less than full barriers:
 
-	/* See SB+mbonceonces.litmus. */
+	/* See SB+fencembonceonces.litmus. */
 	void CPU0(void)
 	{
 		WRITE_ONCE(x, 1);
diff --git a/tools/memory-model/README b/tools/memory-model/README
index 734f7feaa5dc..ee987ce20aae 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -35,13 +35,13 @@ BASIC USAGE: HERD7
 The memory model is used, in conjunction with "herd7", to exhaustively
 explore the state space of small litmus tests.
 
-For example, to run SB+mbonceonces.litmus against the memory model:
+For example, to run SB+fencembonceonces.litmus against the memory model:
 
-  $ herd7 -conf linux-kernel.cfg litmus-tests/SB+mbonceonces.litmus
+  $ herd7 -conf linux-kernel.cfg litmus-tests/SB+fencembonceonces.litmus
 
 Here is the corresponding output:
 
-  Test SB+mbonceonces Allowed
+  Test SB+fencembonceonces Allowed
   States 3
   0:r0=0; 1:r0=1;
   0:r0=1; 1:r0=0;
@@ -50,8 +50,8 @@ Here is the corresponding output:
   Witnesses
   Positive: 0 Negative: 3
   Condition exists (0:r0=0 /\ 1:r0=0)
-  Observation SB+mbonceonces Never 0 3
-  Time SB+mbonceonces 0.01
+  Observation SB+fencembonceonces Never 0 3
+  Time SB+fencembonceonces 0.01
   Hash=d66d99523e2cac6b06e66f4c995ebb48
 
 The "Positive: 0 Negative: 3" and the "Never 0 3" each indicate that
@@ -67,16 +67,16 @@ BASIC USAGE: KLITMUS7
 The "klitmus7" tool converts a litmus test into a Linux kernel module,
 which may then be loaded and run.
 
-For example, to run SB+mbonceonces.litmus against hardware:
+For example, to run SB+fencembonceonces.litmus against hardware:
 
   $ mkdir mymodules
-  $ klitmus7 -o mymodules litmus-tests/SB+mbonceonces.litmus
+  $ klitmus7 -o mymodules litmus-tests/SB+fencembonceonces.litmus
   $ cd mymodules ; make
   $ sudo sh run.sh
 
 The corresponding output includes:
 
-  Test SB+mbonceonces Allowed
+  Test SB+fencembonceonces Allowed
   Histogram (3 states)
   644580  :>0:r0=1; 1:r0=0;
   644328  :>0:r0=0; 1:r0=1;
@@ -86,8 +86,8 @@ The corresponding output includes:
   Positive: 0, Negative: 2000000
   Condition exists (0:r0=0 /\ 1:r0=0) is NOT validated
   Hash=d66d99523e2cac6b06e66f4c995ebb48
-  Observation SB+mbonceonces Never 0 2000000
-  Time SB+mbonceonces 0.16
+  Observation SB+fencembonceonces Never 0 2000000
+  Time SB+fencembonceonces 0.16
 
 The "Positive: 0 Negative: 2000000" and the "Never 0 2000000" indicate
 that during two million trials, the state specified in this litmus
diff --git a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
similarity index 95%
rename from tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
rename to tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
index 98a3716efa37..e729d2776e89 100644
--- a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
@@ -1,4 +1,4 @@
-C IRIW+mbonceonces+OnceOnce
+C IRIW+fencembonceonces+OnceOnce
 
 (*
  * Result: Never
diff --git a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
similarity index 95%
rename from tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
rename to tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
index de6708229dd1..4727f5aaf03b 100644
--- a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
@@ -1,4 +1,4 @@
-C LB+ctrlonceonce+mbonceonce
+C LB+fencembonceonce+ctrlonceonce
 
 (*
  * Result: Never
diff --git a/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
similarity index 91%
rename from tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
rename to tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
index c078f38ff27a..a273da9faa6d 100644
--- a/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -1,4 +1,4 @@
-C MP+wmbonceonce+rmbonceonce
+C MP+fencewmbonceonce+fencermbonceonce
 
 (*
  * Result: Never
diff --git a/tools/memory-model/litmus-tests/R+mbonceonces.litmus b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
similarity index 95%
rename from tools/memory-model/litmus-tests/R+mbonceonces.litmus
rename to tools/memory-model/litmus-tests/R+fencembonceonces.litmus
index a0e884ad2132..222a0b850b4a 100644
--- a/tools/memory-model/litmus-tests/R+mbonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
@@ -1,4 +1,4 @@
-C R+mbonceonces
+C R+fencembonceonces
 
 (*
  * Result: Never
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 00140aaf58b7..4581ec2d3c57 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -18,7 +18,7 @@ CoWW+poonceonce.litmus
 	Test of write-write coherence, that is, whether or not two
 	successive writes to the same variable are ordered.
 
-IRIW+mbonceonces+OnceOnce.litmus
+IRIW+fencembonceonces+OnceOnce.litmus
 	Test of independent reads from independent writes with smp_mb()
 	between each pairs of reads.  In other words, is smp_mb()
 	sufficient to cause two different reading processes to agree on
@@ -47,7 +47,7 @@ ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
 	Can a release-acquire chain order a prior store against
 	a later load?
 
-LB+ctrlonceonce+mbonceonce.litmus
+LB+fencembonceonce+ctrlonceonce.litmus
 	Does a control dependency and an smp_mb() suffice for the
 	load-buffering litmus test, where each process reads from one
 	of two variables then writes to the other?
@@ -88,14 +88,14 @@ MP+porevlocks.litmus
 	As below, but with the first access of the writer process
 	and the second access of reader process protected by a lock.
 
-MP+wmbonceonce+rmbonceonce.litmus
+MP+fencewmbonceonce+fencermbonceonce.litmus
 	Does a smp_wmb() (between the stores) and an smp_rmb() (between
 	the loads) suffice for the message-passing litmus test, where one
 	process writes data and then a flag, and the other process reads
 	the flag and then the data.  (This is similar to the ISA2 tests,
 	but with two processes instead of three.)
 
-R+mbonceonces.litmus
+R+fencembonceonces.litmus
 	This is the fully ordered (via smp_mb()) version of one of
 	the classic counterintuitive litmus tests that illustrates the
 	effects of store propagation delays.
@@ -103,7 +103,7 @@ R+mbonceonces.litmus
 R+poonceonces.litmus
 	As above, but without the smp_mb() invocations.
 
-SB+mbonceonces.litmus
+SB+fencembonceonces.litmus
 	This is the fully ordered (again, via smp_mb() version of store
 	buffering, which forms the core of Dekker's mutual-exclusion
 	algorithm.
@@ -123,12 +123,12 @@ SB+rfionceonce-poonceonces.litmus
 S+poonceonces.litmus
 	As below, but without the smp_wmb() and acquire load.
 
-S+wmbonceonce+poacquireonce.litmus
+S+fencewmbonceonce+poacquireonce.litmus
 	Can a smp_wmb(), instead of a release, and an acquire order
 	a prior store against a subsequent store?
 
 WRC+poonceonces+Once.litmus
-WRC+pooncerelease+rmbonceonce+Once.litmus
+WRC+pooncerelease+fencermbonceonce+Once.litmus
 	These two are members of an extension of the MP litmus-test
 	class in which the first write is moved to a separate process.
 	The second is forbidden because smp_store_release() is
@@ -143,7 +143,7 @@ Z6.0+pooncelock+poonceLock+pombonce.litmus
 	As above, but with smp_mb__after_spinlock() immediately
 	following the spin_lock().
 
-Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
+Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
 	Is the ordering provided by a release-acquire chain sufficient
 	to make ordering apparent to accesses by a process that does
 	not participate in that release-acquire chain?
diff --git a/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
similarity index 90%
rename from tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
rename to tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
index c53350205d28..18479823cd6c 100644
--- a/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
@@ -1,4 +1,4 @@
-C S+wmbonceonce+poacquireonce
+C S+fencewmbonceonce+poacquireonce
 
 (*
  * Result: Never
diff --git a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
similarity index 95%
rename from tools/memory-model/litmus-tests/SB+mbonceonces.litmus
rename to tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
index 74b874ffa8da..ed5fff18d223 100644
--- a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
@@ -1,4 +1,4 @@
-C SB+mbonceonces
+C SB+fencembonceonces
 
 (*
  * Result: Never
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
similarity index 93%
rename from tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
rename to tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
index ad3448b941e6..e9947250d7de 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
@@ -1,4 +1,4 @@
-C WRC+pooncerelease+rmbonceonce+Once
+C WRC+pooncerelease+fencermbonceonce+Once
 
 (*
  * Result: Never
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
similarity index 94%
rename from tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
rename to tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
index a20fc3fafb53..88e70b87a683 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
@@ -1,4 +1,4 @@
-C Z6.0+pooncerelease+poacquirerelease+mbonceonce
+C Z6.0+pooncerelease+poacquirerelease+fencembonceonce
 
 (*
  * Result: Sometimes
-- 
2.17.1
