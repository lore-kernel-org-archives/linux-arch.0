Return-Path: <SRS0=NZEn=AE=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732386AbgFWAwf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:35 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 10/14] tools/memory-model: Fix reference to litmus test in recipes.txt
Date: Mon, 22 Jun 2020 17:52:27 -0700
Message-ID: <20200623005231.27712-10-paulmck@kernel.org>
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Message-ID: <20200623005227.I11Qz8fGomxPe3IPpof1TlFCGNlmwIelned1JmCK240@z>

From: Akira Yokosawa <akiyks@gmail.com>

The name of litmus test doesn't match the one described below.
Fix the name of litmus test.

Acked-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/recipes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index 7fe8d7a..63c4adf 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -126,7 +126,7 @@ However, it is not necessarily the case that accesses ordered by
 locking will be seen as ordered by CPUs not holding that lock.
 Consider this example:
 
-	/* See Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus. */
+	/* See Z6.0+pooncelock+pooncelock+pombonce.litmus. */
 	void CPU0(void)
 	{
 		spin_lock(&mylock);
-- 
2.9.5
