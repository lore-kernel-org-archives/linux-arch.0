From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 05/33] Documentation: atomic_t.txt: Explain ordering provided by smp_mb__{before,after}_atomic()
Date: Thu, 30 May 2019 07:41:57 -0700
Message-ID: <20190530144225.27624-5-paulmck@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Jonathan Corbet <corbet@lwn.net>, "Paul E . McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

The description of smp_mb__before_atomic() and smp_mb__after_atomic()
in Documentation/atomic_t.txt is slightly terse and misleading.  It
does not clearly state which other instructions are ordered by these
barriers.

This improves the text to make the actual ordering implications clear,
and also to explain how these barriers differ from a RELEASE or
ACQUIRE ordering.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/atomic_t.txt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index dca3fb0554db..b3afe69d03a1 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -187,8 +187,14 @@ The barriers:
 
   smp_mb__{before,after}_atomic()
 
-only apply to the RMW ops and can be used to augment/upgrade the ordering
-inherent to the used atomic op. These barriers provide a full smp_mb().
+only apply to the RMW atomic ops and can be used to augment/upgrade the
+ordering inherent to the op. These barriers act almost like a full smp_mb():
+smp_mb__before_atomic() orders all earlier accesses against the RMW op
+itself and all accesses following it, and smp_mb__after_atomic() orders all
+later accesses against the RMW op and all accesses preceding it. However,
+accesses between the smp_mb__{before,after}_atomic() and the RMW op are not
+ordered, so it is advisable to place the barrier right next to the RMW atomic
+op whenever possible.
 
 These helper barriers exist because architectures have varying implicit
 ordering on their SMP atomic primitives. For example our TSO architectures
@@ -212,7 +218,9 @@ Further, while something like:
   atomic_dec(&X);
 
 is a 'typical' RELEASE pattern, the barrier is strictly stronger than
-a RELEASE. Similarly for something like:
+a RELEASE because it orders preceding instructions against both the read
+and write parts of the atomic_dec(), and against all following instructions
+as well. Similarly, something like:
 
   atomic_inc(&X);
   smp_mb__after_atomic();
@@ -244,7 +252,8 @@ strictly stronger than ACQUIRE. As illustrated:
 
 This should not happen; but a hypothetical atomic_inc_acquire() --
 (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
-since then:
+because it would not order the W part of the RMW against the following
+WRITE_ONCE.  Thus:
 
   P1			P2
 
-- 
2.17.1
