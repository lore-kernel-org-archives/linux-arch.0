From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 06/19] tools/memory-order: smp_mb__after_atomic() orders later RMW operations
Date: Mon, 14 May 2018 16:33:44 -0700
Message-ID: <1526340837-12222-6-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

The current cheat sheet does not claim that smp_mb__after_atomic()
orders later RMW atomic operations, which it must, at least against
earlier RMW atomic operations and whatever precedes them.  This commit
therefore adds the needed "Y".

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/Documentation/cheatsheet.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 46fe79afc737..33ba98d72b16 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -14,7 +14,7 @@ smp_wmb()                                  Y    W           Y       Y    W
 smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
 Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
 smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
-smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y
+smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
 
 
 Key:	C:	Ordering is cumulative
-- 
2.5.2
