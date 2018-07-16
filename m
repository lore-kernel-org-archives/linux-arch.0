From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 02/14] tools/memory-model: Fix ISA2+pooncelock+pooncelock+pombonce name
Date: Mon, 16 Jul 2018 11:05:53 -0700
Message-ID: <20180716180605.16115-2-paulmck@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

The names on the first line of the litmus tests are arbitrary,
but the convention is that they be the filename without the trailing
".litmus".  This commit therefore removes the stray trailing ".litmus"
from ISA2+pooncelock+pooncelock+pombonce.litmus's name.

Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 .../litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
index 7a39a0aaa976..0f749e419b34 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
@@ -1,4 +1,4 @@
-C ISA2+pooncelock+pooncelock+pombonce.litmus
+C ISA2+pooncelock+pooncelock+pombonce
 
 (*
  * Result: Sometimes
-- 
2.17.1
