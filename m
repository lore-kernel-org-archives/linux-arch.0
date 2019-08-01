From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 18/31] tools/memory-model: Make runlitmus.sh check for jingle errors
Date: Thu,  1 Aug 2019 15:20:43 -0700
Message-ID: <20190801222056.12144-18-paulmck@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

It turns out that the jingle7 tool is currently a bit picky about
the litmus tests it is willing to process.  This commit therefore
ensures that jingle7 failures are reported.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/runlitmus.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index afb196d7ef10..5f2d29b460ff 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -69,6 +69,11 @@ fi
 # Generate the assembly code and run herd7 on it.
 gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
 jingle7 -theme $themefile $litmus > $LKMM_DESTDIR/$hwlitmus 2> $T/$hwlitmusfile.jingle7.out
+if grep -q "Generated 0 tests" $T/$hwlitmusfile.jingle7.out
+then
+	echo ' !!! ' jingle7 failed, no $hwlitmus generated
+	exit 253
+fi
 /usr/bin/time $LKMM_TIMEOUT_CMD herd7 $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
 
 exit $?
-- 
2.17.1
