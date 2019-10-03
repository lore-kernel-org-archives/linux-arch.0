Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbfJCA0y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:54 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 05/32] tools/memory-model: Make judgelitmus.sh note timeouts
Date: Wed,  2 Oct 2019 17:26:23 -0700
Message-ID: <20191003002650.11249-5-paulmck@kernel.org>
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20191003002623.0UJeiLXuI59zB9IZp4qV-J7QhqGgKhzzjGZoEVCD4ss@z>

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Currently, judgelitmus.sh treats timeouts (as in the "--timeout" argument)
as "!!! Verification error".  This can be misleading because it is quite
possible that running the test longer would have produced a verification.
This commit therefore changes judgelitmus.sh to check for timeouts and
to report them with "!!! Timeout".

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 0cc6387..d3c313b 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -42,6 +42,14 @@ grep '^Observation' $LKMM_DESTDIR/$litmus.out
 if grep -q '^Observation' $LKMM_DESTDIR/$litmus.out
 then
 	:
+elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmus.out
+then
+	echo ' !!! Timeout' $litmus
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	then
+		echo ' !!! Timeout' >> $LKMM_DESTDIR/$litmus.out 2>&1
+	fi
+	exit 124
 else
 	echo ' !!! Verification error' $litmus
 	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
-- 
2.9.5
