Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37803 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfG1DNJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jul 2019 23:13:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so26204137plr.4
        for <linux-arch@vger.kernel.org>; Sat, 27 Jul 2019 20:13:09 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2] lkmm/docs: Correct ->prop example with additional rfe link
Date: Sat, 27 Jul 2019 23:13:03 -0400
Message-ID: <20190728031303.164545-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>, kernel-team@android.com, Boqun Feng <boqun.feng@gmail.com>, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Message-ID: <20190728031303.boO4aobNBKdT8116M1DxQsOjqMQJqN8ioSE0xOiOvyo@z>

The lkmm example about ->prop relation should describe an additional rfe
link between P1's store to y and P2's load of y, which should be
critical to establishing the ordering resulting in the ->prop ordering
on P0. IOW, there are 2 rfe links, not one.

Correct these in the docs to make the ->prop ordering on P0 more clear.

Cc: kernel-team@android.com
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../memory-model/Documentation/explanation.txt  | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0..aa84fce854cc 100644
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
 
@@ -1334,11 +1334,14 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
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
+of y executes before P2's store to z (second fence), which implies that
+that stores to x and y propagate to P2 before the smp_store_release(), which
+means that P2's smp_store_release() will propagate stores to x and y to all
+CPUs before the store to z propagates (A-cumulative property of this fence).
+Finally P0's load of z executes after P2's store to z has propagated to
+P0 (rfe link).
 
 In summary, the fact that the hb relation links memory access events
 in the order they execute means that it must not have cycles.  This
-- 
2.22.0.709.g102302147b-goog
