From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 19/21] tools/memory-model: Keep assembly-language litmus tests
Date: Tue, 26 Mar 2019 16:41:31 -0700
Message-ID: <20190326234133.24962-19-paulmck@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326234114.GA23843@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

This commit retains the assembly-language litmus tests generated from
the C-language litmus tests, appending the hardware tag to the original
C-language litmus test's filename.  Thus, S+poonceonces.litmus.AArch64
contains the Armv8 assembly language corresponding to the C-language
S+poonceonces.litmus test.

This commit also updates the .gitignore to avoid commiting these
automatically generated assembly-language litmus tests.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/litmus-tests/.gitignore | 2 +-
 tools/memory-model/scripts/runlitmus.sh    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/litmus-tests/.gitignore b/tools/memory-model/litmus-tests/.gitignore
index f47cb2045f13..848e62d2a9b3 100644
--- a/tools/memory-model/litmus-tests/.gitignore
+++ b/tools/memory-model/litmus-tests/.gitignore
@@ -1 +1 @@
-*.out
+*.litmus.*
diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 154c95ce79da..71d13bb0c764 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -69,7 +69,7 @@ fi
 
 # Generate the assembly code and run herd on it.
 gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
-jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
-/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+jingle7 -theme $themefile $litmus > $LKMM_DESTDIR/$hwlitmus 2> $T/$hwlitmusfile.jingle7.out
+/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
 
 exit $?
-- 
2.17.1
