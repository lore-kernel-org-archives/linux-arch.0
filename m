From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 06/14] tools/memory-model: Remove ACCESS_ONCE() from model
Date: Mon, 16 Jul 2018 11:05:57 -0700
Message-ID: <20180716180605.16115-6-paulmck@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Mark Rutland <mark.rutland@arm.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Since commit:

  b899a850431e2dd0 ("compiler.h: Remove ACCESS_ONCE()")

... there has been no definition of ACCESS_ONCE() in the kernel tree,
and it has been necessary to use READ_ONCE() or WRITE_ONCE() instead.

Correspondingly, let's remove ACCESS_ONCE() from the kernel memory
model.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/linux-kernel.bell | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 64f5740e0e75..b84fb2f67109 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -13,7 +13,7 @@
 
 "Linux-kernel memory consistency model"
 
-enum Accesses = 'once (*READ_ONCE,WRITE_ONCE,ACCESS_ONCE*) ||
+enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
 		'release (*smp_store_release*) ||
 		'acquire (*smp_load_acquire*) ||
 		'noreturn (* R of non-return RMW *)
-- 
2.17.1
