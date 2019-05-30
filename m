From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 16/33] tools/memory-model: Fix checkalllitmus.sh comment
Date: Thu, 30 May 2019 07:42:08 -0700
Message-ID: <20190530144225.27624-16-paulmck@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

The checkalllitmus.sh runs litmus tests in the litmus-tests directory,
not those in the github archive, so this commit updates the comment to
reflect this reality.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkalllitmus.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index 10e14d94acee..54d8da8c338e 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -30,8 +30,8 @@ else
 	exit 255
 fi
 
-# Create any new directories that have appeared in the github litmus
-# repo since the last run.
+# Create any new directories that have appeared in the litmus-tests
+# directory since the last run.
 if test "$LKMM_DESTDIR" != "."
 then
 	find $litmusdir -type d -print |
-- 
2.17.1
