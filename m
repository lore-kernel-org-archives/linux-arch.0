From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 06/14] tools/memory-model: Add an exception for limitations on _unless() family
Date: Mon, 22 Jun 2020 17:52:23 -0700
Message-ID: <20200623005231.27712-6-paulmck@kernel.org>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732379AbgFWAwe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:34 -0400
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>

From: Boqun Feng <boqun.feng@gmail.com>

According to Luc, atomic_add_unless() is directly provided by herd7,
therefore it can be used in litmus tests. So change the limitation
section in README to unlimit the use of atomic_add_unless().

Cc: Luc Maranget <luc.maranget@inria.fr>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/README | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index fc07b52..b9c562e 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -207,11 +207,15 @@ The Linux-kernel memory model (LKMM) has the following limitations:
 		case as a store release.
 
 	b.	The "unless" RMW operations are not currently modeled:
-		atomic_long_add_unless(), atomic_add_unless(),
-		atomic_inc_unless_negative(), and
-		atomic_dec_unless_positive().  These can be emulated
+		atomic_long_add_unless(), atomic_inc_unless_negative(),
+		and atomic_dec_unless_positive().  These can be emulated
 		in litmus tests, for example, by using atomic_cmpxchg().
 
+		One exception of this limitation is atomic_add_unless(),
+		which is provided directly by herd7 (so no corresponding
+		definition in linux-kernel.def).  atomic_add_unless() is
+		modeled by herd7 therefore it can be used in litmus tests.
+
 	c.	The call_rcu() function is not modeled.  It can be
 		emulated in litmus tests by adding another process that
 		invokes synchronize_rcu() and the body of the callback
-- 
2.9.5
