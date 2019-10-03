Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfJCA1C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:27:02 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 32/32] tools/memory-model: Use "-unroll 0" to keep --hw runs finite
Date: Wed,  2 Oct 2019 17:26:50 -0700
Message-ID: <20191003002650.11249-32-paulmck@kernel.org>
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20191003002650.o23yGE5TBq-fSlH76zemd9_v846YWsGrgsWoHCJex8E@z>

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Litmus tests involving atomic operations produce LL/SC loops on a number
of architectures, and unrolling these loops can result in excessive
verification times or even stack overflows.  This commit therefore uses
the "-unroll 0" herd7 argument to avoid unrolling, on the grounds that
additional passes through an LL/SC loop should not change the verification.

Note however, that certain bugs in the mapping of the LL/SC loop to
machine instructions may go undetected.  On the other hand, herd7 might
not be the best vehicle for finding such bugs in any case.  (You do
stress-test your architecture-specific code, don't you?)

Suggested-by: Luc Maranget <luc.maranget@inria.fr>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/runlitmus.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index dfdb1f0..94608d4b 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -75,6 +75,6 @@ then
 	cp $T/$hwlitmusfile.jingle7.out $LKMM_DESTDIR/$hwlitmus.err
 	exit 253
 fi
-/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -unroll 0 $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
 
 exit $?
-- 
2.9.5
