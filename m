From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 09/14] tools/memory-model: Add informal LKMM documentation to MAINTAINERS
Date: Mon, 16 Jul 2018 11:06:00 -0700
Message-ID: <20180716180605.16115-9-paulmck@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

The Linux-kernel memory model has been informal, with a number of
text files documenting it.  It would be good to make sure that these
informal descriptions are kept up to date and/or pruned appropriately.
This commit therefore brings more of those text files into the LKMM
MAINTAINERS file entry.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ac8ed55dbe9b..b60d6daad132 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8318,9 +8318,14 @@ M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
 L:	linux-kernel@vger.kernel.org
+L:	linux-arch@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
 F:	tools/memory-model/
+F:	Documentation/atomic_bitops.txt
+F:	Documentation/atomic_t.txt
+F:	Documentation/core-api/atomic_ops.rst
+F:	Documentation/core-api/refcount-vs-atomic.rst
 F:	Documentation/memory-barriers.txt
 
 LINUX SECURITY MODULE (LSM) FRAMEWORK
-- 
2.17.1
