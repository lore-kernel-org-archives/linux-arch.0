From: paulmck@kernel.org
Subject: [PATCH lkmm tip/core/rcu 06/10] MAINTAINERS: Update maintainers for new Documentaion/litmus-tests/
Date: Wed, 15 Apr 2020 11:49:41 -0700
Message-ID: <20200415184945.16487-6-paulmck@kernel.org>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Paul E . McKenney" <paulmck@kernel.org>
List-Id: linux-arch.vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Also add me as Reviewer for LKMM. Previously a patch to do this was
Acked but somewhere along the line got lost. Add myself in this patch.

Acked-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db..5d2b065 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9806,6 +9806,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
+R:	Joel Fernandes <joel@joelfernandes.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
 S:	Supported
@@ -9816,6 +9817,7 @@ F:	Documentation/core-api/atomic_ops.rst
 F:	Documentation/core-api/refcount-vs-atomic.rst
 F:	Documentation/memory-barriers.txt
 F:	tools/memory-model/
+F:	Documentation/litmus-tests/
 
 LIS3LV02D ACCELEROMETER DRIVER
 M:	Eric Piel <eric.piel@tremplin-utc.net>
-- 
2.9.5
