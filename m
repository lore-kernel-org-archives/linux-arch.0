From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 1/5] tools/memory-model: Add litmus-test naming scheme
Date: Wed, 26 Sep 2018 11:29:16 -0700
Message-ID: <20180926182920.27644-1-paulmck@linux.ibm.com>
References: <20180926182845.GA24839@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926182845.GA24839@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

This commit documents the scheme used to generate the names for the
litmus tests.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Apply feedback from Andrea Parri and Will Deacon. ]
Acked-by: Will Deacon <will.deacon@arm.com>
---
 tools/memory-model/litmus-tests/README | 104 ++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 4581ec2d3c57..5ee08f129094 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -1,4 +1,6 @@
-This directory contains the following litmus tests:
+============
+LITMUS TESTS
+============
 
 CoRR+poonceonce+Once.litmus
 	Test of read-read coherence, that is, whether or not two
@@ -36,7 +38,7 @@ IRIW+poonceonces+OnceOnce.litmus
 ISA2+pooncelock+pooncelock+pombonce.litmus
 	Tests whether the ordering provided by a lock-protected S
 	litmus test is visible to an external process whose accesses are
-	separated by smp_mb().	This addition of an external process to
+	separated by smp_mb().  This addition of an external process to
 	S is otherwise known as ISA2.
 
 ISA2+poonceonces.litmus
@@ -151,3 +153,101 @@ Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
 A great many more litmus tests are available here:
 
 	https://github.com/paulmckrcu/litmus
+
+==================
+LITMUS TEST NAMING
+==================
+
+Litmus tests are usually named based on their contents, which means that
+looking at the name tells you what the litmus test does.  The naming
+scheme covers litmus tests having a single cycle that passes through
+each process exactly once, so litmus tests not fitting this description
+are named on an ad-hoc basis.
+
+The structure of a litmus-test name is the litmus-test class, a plus
+sign ("+"), and one string for each process, separated by plus signs.
+The end of the name is ".litmus".
+
+The litmus-test classes may be found in the infamous test6.pdf:
+https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test6.pdf
+Each class defines the pattern of accesses and of the variables accessed.
+For example, if the one process writes to a pair of variables, and
+the other process reads from these same variables, the corresponding
+litmus-test class is "MP" (message passing), which may be found on the
+left-hand end of the second row of tests on page one of test6.pdf.
+
+The strings used to identify the actions carried out by each process are
+complex due to a desire to have short(er) names.  Thus, there is a tool to
+generate these strings from a given litmus test's actions.  For example,
+consider the processes from SB+rfionceonce-poonceonces.litmus:
+
+	P0(int *x, int *y)
+	{
+		int r1;
+		int r2;
+
+		WRITE_ONCE(*x, 1);
+		r1 = READ_ONCE(*x);
+		r2 = READ_ONCE(*y);
+	}
+
+	P1(int *x, int *y)
+	{
+		int r3;
+		int r4;
+
+		WRITE_ONCE(*y, 1);
+		r3 = READ_ONCE(*y);
+		r4 = READ_ONCE(*x);
+	}
+
+The next step is to construct a space-separated list of descriptors,
+interleaving descriptions of the relation between a pair of consecutive
+accesses with descriptions of the second access in the pair.
+
+P0()'s WRITE_ONCE() is read by its first READ_ONCE(), which is a
+reads-from link (rf) and internal to the P0() process.  This is
+"rfi", which is an abbreviation for "reads-from internal".  Because
+some of the tools string these abbreviations together with space
+characters separating processes, the first character is capitalized,
+resulting in "Rfi".
+
+P0()'s second access is a READ_ONCE(), as opposed to (for example)
+smp_load_acquire(), so next is "Once".  Thus far, we have "Rfi Once".
+
+P0()'s third access is also a READ_ONCE(), but to y rather than x.
+This is related to P0()'s second access by program order ("po"),
+to a different variable ("d"), and both accesses are reads ("RR").
+The resulting descriptor is "PodRR".  Because P0()'s third access is
+READ_ONCE(), we add another "Once" descriptor.
+
+A from-read ("fre") relation links P0()'s third to P1()'s first
+access, and the resulting descriptor is "Fre".  P1()'s first access is
+WRITE_ONCE(), which as before gives the descriptor "Once".  The string
+thus far is thus "Rfi Once PodRR Once Fre Once".
+
+The remainder of P1() is similar to P0(), which means we add
+"Rfi Once PodRR Once".  Another fre links P1()'s last access to
+P0()'s first access, which is WRITE_ONCE(), so we add "Fre Once".
+The full string is thus:
+
+	Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once
+
+This string can be given to the "norm7" and "classify7" tools to
+produce the name:
+
+	$ norm7 -bell linux-kernel.bell \
+		Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once | \
+	  sed -e 's/:.*//g'
+	SB+rfionceonce-poonceonces
+
+Adding the ".litmus" suffix: SB+rfionceonce-poonceonces.litmus
+
+The descriptors that describe connections between consecutive accesses
+within the cycle through a given litmus test can be provided by the herd
+tool (Rfi, Po, Fre, and so on) or by the linux-kernel.bell file (Once,
+Release, Acquire, and so on).
+
+To see the full list of descriptors, execute the following command:
+
+	$ diyone7 -bell linux-kernel.bell -show edges
-- 
2.17.1
