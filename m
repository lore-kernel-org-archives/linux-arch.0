From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 4/7] tools/memory-model: Update README for addition of SRCU
Date: Wed,  9 Jan 2019 13:07:45 -0800
Message-ID: <20190109210748.29074-4-paulmck@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

This commit updates the section on LKMM limitations to no longer say
that SRCU is not modeled, but instead describe how LKMM's modeling of
SRCU departs from the Linux-kernel implementation.

TL;DR:  There is no known valid use case that cares about the Linux
kernel's ability to have partially overlapping SRCU read-side critical
sections.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/README | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 0f2c366518c6..9d7d4f23503f 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -221,8 +221,29 @@ The Linux-kernel memory model has the following limitations:
 		additional call_rcu() process to the site of the
 		emulated rcu-barrier().
 
-	e.	Sleepable RCU (SRCU) is not modeled.  It can be
-		emulated, but perhaps not simply.
+	e.	Although sleepable RCU (SRCU) is now modeled, there
+		are some subtle differences between its semantics and
+		those in the Linux kernel.  For example, the kernel
+		might interpret the following sequence as two partially
+		overlapping SRCU read-side critical sections:
+
+			 1  r1 = srcu_read_lock(&my_srcu);
+			 2  do_something_1();
+			 3  r2 = srcu_read_lock(&my_srcu);
+			 4  do_something_2();
+			 5  srcu_read_unlock(&my_srcu, r1);
+			 6  do_something_3();
+			 7  srcu_read_unlock(&my_srcu, r2);
+
+		In contrast, LKMM will interpret this as a nested pair of
+		SRCU read-side critical sections, with the outer critical
+		section spanning lines 1-7 and the inner critical section
+		spanning lines 3-5.
+
+		This difference would be more of a concern had anyone
+		identified a reasonable use case for partially overlapping
+		SRCU read-side critical sections.  For more information,
+		please see: https://paulmck.livejournal.com/40593.html
 
 	f.	Reader-writer locking is not modeled.  It can be
 		emulated in litmus tests using atomic read-modify-write
-- 
2.17.1
