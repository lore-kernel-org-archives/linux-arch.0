From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Date: Fri, 25 May 2018 12:10:20 -0700
Message-ID: <20180525191020.GA5914@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

This commit documents the scheme used to generate the names for the
litmus tests.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 00140aaf58b7..b81f51054cd3 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -1,4 +1,6 @@
-This directory contains the following litmus tests:
+============
+LITMUS TESTS
+============
 
 CoRR+poonceonce+Once.litmus
 	Test of read-read coherence, that is, whether or not two
@@ -151,3 +153,135 @@ Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
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
+complex due to a desire to have finite-length names.  Thus, there is a
+tool to generate these strings from a given litmus test's actions.  For
+example, consider the processes from SB+rfionceonce-poonceonces.litmus:
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
+$ norm7 -bell linux-kernel.bell Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once |  classify7 -bell linux-kernel.bell -diyone | sed -e 's/:.*//g'
+SB+rfionceonce-poonceonces
+
+Adding the ".litmus" suffix: SB+rfionceonce-poonceonces.litmus
+
+
+=======================
+LITMUS TEST DESCRIPTORS
+=======================
+
+These descriptors cover connections between consecutive accesses:
+
+Fre: From-read external.  The current process wrote a variable that
+	the previous process read.  Example: The SB (store buffering) test.
+Fri: From-read internal.  This process read a variable and then
+	immediately wrote to it.  Example: ???
+PodRR: Program-order different variable, read followed by read.
+	This process read a variable and again read a different variable.
+	Example: The read-side process in the MP (message-passing) test.
+PodRW: Program-order different variable, read followed by write.
+	This process read a variable and then wrote a different variable.
+	Example: The LB (load buffering) test.
+PodWR: Program-order different variable, write followed by read.
+	This process wrote a variable and then read a different variable.
+	Example: The SB (store buffering) test.
+PodWW: Program-order different variable, write followed by write.
+	This process wrote a variable and again wrote a different variable.
+	Example: The write-side process in the MP (message-passing) test.
+PosRR: Program-order same variable, read followed by read.
+	This process read a variable and again read that same variable.
+	Example: ???
+PosRW: Program-order same variable, read followed by write.
+	This process read a variable and then wrote that same variable.
+	Example: ???
+PosWR: Program-order same variable, write followed by read.
+	This process wrote a variable and then read that same variable.
+	Example: ???
+PosWW: Program-order same variable, write followed by write.
+	This process wrote a variable and again rrote that same variable.
+	Example: ???
+Rfe: Read-from external.  The current process read a variable written
+	by the previous process.  Example: The MP (message passing) test.
+Rfi: Read-from internal.  The current process wrote a variable and then
+	immediately read the value back from it.  Example:  ???
+	Comparison to PosWR???
+Wse: Write same external.  The current process wrote to a variable that
+	was also written to by the previous process.  Example:  ???
+Wsi: Write same internal.  The current process wrote to a variable and
+	then immediately wrote to it again.  Example:  ???
