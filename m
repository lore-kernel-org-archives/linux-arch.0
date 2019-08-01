Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389562AbfHAWVS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:18 -0400
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 29/31] tools/memory-model: Use "-unroll 0" to keep --hw runs finite
Date: Thu,  1 Aug 2019 15:20:54 -0700
Message-ID: <20190801222056.12144-29-paulmck@linux.ibm.com>
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190801222054.r4rxHWP7Eyelk7PEiEo0mNbeV3g5_zEq-yFNUrFDp1s@z>

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
index dfdb1f00fcc0..94608d4b6502 100755
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
2.17.1
