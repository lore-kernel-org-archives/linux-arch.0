From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 05/14] MAINTAINERS: Update maintainers for new Documentation/litmus-tests
Date: Mon, 22 Jun 2020 17:52:22 -0700
Message-ID: <20200623005231.27712-5-paulmck@kernel.org>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Paul E . McKenney" <paulmck@kernel.org>
List-Id: linux-arch.vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit adds Joel Fernandes as official LKMM reviewer.

Acked-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Apply Joe Perches alphabetization feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d4..696a02f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9960,6 +9960,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
+R:	Joel Fernandes <joel@joelfernandes.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
 S:	Supported
@@ -9968,6 +9969,7 @@ F:	Documentation/atomic_bitops.txt
 F:	Documentation/atomic_t.txt
 F:	Documentation/core-api/atomic_ops.rst
 F:	Documentation/core-api/refcount-vs-atomic.rst
+F:	Documentation/litmus-tests/
 F:	Documentation/memory-barriers.txt
 F:	tools/memory-model/
 
-- 
2.9.5
