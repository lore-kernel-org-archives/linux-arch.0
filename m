From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 06/33] tools/memory-model: Fix comment in MP+poonceonces.litmus
Date: Thu, 30 May 2019 07:41:58 -0700
Message-ID: <20190530144225.27624-6-paulmck@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

The comment should say "Sometimes" for the result.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/litmus-tests/MP+poonceonces.litmus | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index b2b60b84fb9d..172f0145301c 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -1,7 +1,7 @@
 C MP+poonceonces
 
 (*
- * Result: Maybe
+ * Result: Sometimes
  *
  * Can the counter-intuitive message-passing outcome be prevented with
  * no ordering at all?
-- 
2.17.1
