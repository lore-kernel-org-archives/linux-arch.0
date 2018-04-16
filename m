From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 15/17] tools/memory-order: smp_mb__after_atomic() orders later RMW operations
Date: Mon, 16 Apr 2018 09:12:43 -0700
Message-ID: <1523895165-17576-15-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

The current cheat sheet does not claim that smp_mb__after_atomic()
orders later RMW atomic operations, which it must, at least against
earlier RMW atomic operations and whatever precedes them.  This commit
therefore adds the needed "Y".

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/cheatsheet.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index d502993ac7d2..94bdc25944d9 100644
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
