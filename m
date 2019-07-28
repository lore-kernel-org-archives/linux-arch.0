Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34062 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfG1AAr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jul 2019 20:00:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so20220019pgc.1
        for <linux-arch@vger.kernel.org>; Sat, 27 Jul 2019 17:00:47 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] docs/lkmm: Correct ->prop example with additional rfe link
Date: Sat, 27 Jul 2019 20:00:31 -0400
Message-ID: <20190728000031.112364-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Message-ID: <20190728000031.Wky6S0Eewl0r2OHZsLbO6RQty1vqar9D-IxNdWPovhc@z>

This lkmm example should describe an additional rfe link between P1's
store to y and P2's load of y, which should be critical to establishing
the ordering resulting in the ->prop ordering on P0. IOW, there are 2 rfe
links, not one.

Correct these in the docs to make the ->prop ordering in P0 more clear.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/memory-model/Documentation/explanation.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0..6c0dfaac7f04 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1302,8 +1302,8 @@ followed by an arbitrary number of cumul-fence links, ending with an
 rfe link.  You can concoct more exotic examples, containing more than
 one fence, although this quickly leads to diminishing returns in terms
 of complexity.  For instance, here's an example containing a coe link
-followed by two fences and an rfe link, utilizing the fact that
-release fences are A-cumulative:
+followed by a fence, an rfe link, another fence and and a final rfe link,
+utilizing the fact that release fences are A-cumulative:
 
 	int x, y, z;
 
@@ -1334,11 +1334,13 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
 link from P0's store to its load.  This is because P0's store gets
 overwritten by P1's store since x = 2 at the end (a coe link), the
 smp_wmb() ensures that P1's store to x propagates to P2 before the
-store to y does (the first fence), the store to y propagates to P2
-before P2's load and store execute, P2's smp_store_release()
-guarantees that the stores to x and y both propagate to P0 before the
-store to z does (the second fence), and P0's load executes after the
-store to z has propagated to P0 (an rfe link).
+store to y does (the first fence), P2's store to y happens before P2's
+load of y (rfe link), P2's smp_store_release() ensures that P2's load
+of y executes before P2's store of z (second fence), which also would
+imply that stores to x and y happen before the smp_store_release(), which
+means that P2's smp_store_release() will propagate stores to x and y to all
+CPUs before the store to z does (A-cumulative property of this fence).
+Finally P0's load executes after store to z has propagated to P0 (rfe link).
 
 In summary, the fact that the hb relation links memory access events
 in the order they execute means that it must not have cycles.  This
-- 
2.22.0.709.g102302147b-goog
