Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfJCA07 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:59 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 22/32] tools/memory-model: Add -v flag to jingle7 runs
Date: Wed,  2 Oct 2019 17:26:40 -0700
Message-ID: <20191003002650.11249-22-paulmck@kernel.org>
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20191003002640.TQQOcgJEUSDqOMfWZoBbSc63LtR-IzqEnZBjobUvo5I@z>

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Adding the -v flag to jingle7 invocations gives much useful information
on why jingle7 didn't like a given litmus test.  This commit therefore
adds this flag and saves off any such information into a .err file.

Suggested-by: Luc Maranget <luc.maranget@inria.fr>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/runlitmus.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 5f2d29b..dfdb1f0 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -68,10 +68,11 @@ fi
 
 # Generate the assembly code and run herd7 on it.
 gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
-jingle7 -theme $themefile $litmus > $LKMM_DESTDIR/$hwlitmus 2> $T/$hwlitmusfile.jingle7.out
+jingle7 -v -theme $themefile $litmus > $LKMM_DESTDIR/$hwlitmus 2> $T/$hwlitmusfile.jingle7.out
 if grep -q "Generated 0 tests" $T/$hwlitmusfile.jingle7.out
 then
-	echo ' !!! ' jingle7 failed, no $hwlitmus generated
+	echo ' !!! ' jingle7 failed, errors in $hwlitmus.err
+	cp $T/$hwlitmusfile.jingle7.out $LKMM_DESTDIR/$hwlitmus.err
 	exit 253
 fi
 /usr/bin/time $LKMM_TIMEOUT_CMD herd7 $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
-- 
2.9.5
