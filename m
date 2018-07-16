From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 03/14] MAINTAINERS: Add Daniel Lustig as an LKMM reviewer
Date: Mon, 16 Jul 2018 11:05:54 -0700
Message-ID: <20180716180605.16115-3-paulmck@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

Dan runs the RISC-V memory model working group.  I've been forwarding
him LKMM emails that end up in my inbox, but I'm far from an expert in
this stuff.  He requested to be added as a reviewer, which seems sane to
me as it'll take a human out of the loop.

CC: Daniel Lustig <dlustig@nvidia.com>
Acked-by: Daniel Lustig <dlustig@nvidia.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..ac8ed55dbe9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8316,6 +8316,7 @@ M:	Jade Alglave <j.alglave@ucl.ac.uk>
 M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
 R:	Akira Yokosawa <akiyks@gmail.com>
+R:	Daniel Lustig <dlustig@nvidia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
-- 
2.17.1
