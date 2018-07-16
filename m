From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 07/14] tools/memory-model: Make scripts executable
Date: Mon, 16 Jul 2018 11:05:58 -0700
Message-ID: <20180716180605.16115-7-paulmck@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

This commit makes the scripts executable to avoid the need for everyone
to do so manually in their archive.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/scripts/checkalllitmus.sh | 2 +-
 tools/memory-model/scripts/checklitmus.sh    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 tools/memory-model/scripts/checkalllitmus.sh
 mode change 100644 => 100755 tools/memory-model/scripts/checklitmus.sh

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
old mode 100644
new mode 100755
index af0aa15ab84e..ca528f9a24d4
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -9,7 +9,7 @@
 # appended.
 #
 # Usage:
-#	sh checkalllitmus.sh [ directory ]
+#	checkalllitmus.sh [ directory ]
 #
 # The LINUX_HERD_OPTIONS environment variable may be used to specify
 # arguments to herd, whose default is defined by the checklitmus.sh script.
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
old mode 100644
new mode 100755
index e2e477472844..bf12a75c0719
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -8,7 +8,7 @@
 # with ".out" appended.
 #
 # Usage:
-#	sh checklitmus.sh file.litmus
+#	checklitmus.sh file.litmus
 #
 # The LINUX_HERD_OPTIONS environment variable may be used to specify
 # arguments to herd, which default to "-conf linux-kernel.cfg".  Thus,
-- 
2.17.1
