From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 3/5] tools/memory-model: Fix a README typo
Date: Wed, 26 Sep 2018 11:29:18 -0700
Message-ID: <20180926182920.27644-3-paulmck@linux.ibm.com>
References: <20180926182845.GA24839@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926182845.GA24839@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, SeongJae Park <sj38.park@gmail.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: SeongJae Park <sj38.park@gmail.com>

This commit fixes a duplicate-"the" typo in README.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/Documentation/recipes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index af72700cc20a..7fe8d7aa3029 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -311,7 +311,7 @@ The smp_wmb() macro orders prior stores against later stores, and the
 smp_rmb() macro orders prior loads against later loads.  Therefore, if
 the final value of r0 is 1, the final value of r1 must also be 1.
 
-The the xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
+The xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
 the following write-side code fragment:
 
 	log->l_curr_block -= log->l_logBBsize;
-- 
2.17.1
