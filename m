From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 23/31] tools/memory-model: Make history-check scripts use mselect7
Date: Thu,  1 Aug 2019 15:20:48 -0700
Message-ID: <20190801222056.12144-23-paulmck@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

The history-check scripts currently use grep to ignore non-C-language
litmus tests, which is a bit fragile.  This commit therefore enlists the
aid of "mselect7 -arch C", given Luc Maraget's recent modifications that
allow mselect7 to operate in filter mode.

This change requires herdtools 7.52-32-g1da3e0e50977 or later.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/initlitmushist.sh | 2 +-
 tools/memory-model/scripts/newlitmushist.sh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/initlitmushist.sh b/tools/memory-model/scripts/initlitmushist.sh
index 956b6957484d..31ea782955d3 100755
--- a/tools/memory-model/scripts/initlitmushist.sh
+++ b/tools/memory-model/scripts/initlitmushist.sh
@@ -60,7 +60,7 @@ fi
 
 # Create a list of the C-language litmus tests with no more than the
 # specified number of processes (per the --procs argument).
-find litmus -name '*.litmus' -exec grep -l -m 1 "^C " {} \; > $T/list-C
+find litmus -name '*.litmus' -print | mselect7 -arch C > $T/list-C
 xargs < $T/list-C -r grep -L "^P${LKMM_PROCS}" > $T/list-C-short
 
 scripts/runlitmushist.sh < $T/list-C-short
diff --git a/tools/memory-model/scripts/newlitmushist.sh b/tools/memory-model/scripts/newlitmushist.sh
index 3f4b06e29988..25235e2049cf 100755
--- a/tools/memory-model/scripts/newlitmushist.sh
+++ b/tools/memory-model/scripts/newlitmushist.sh
@@ -43,7 +43,7 @@ fi
 
 # Form full list of litmus tests with no more than the specified
 # number of processes (per the --procs argument).
-find litmus -name '*.litmus' -exec grep -l -m 1 "^C " {} \; > $T/list-C-all
+find litmus -name '*.litmus' -print | mselect7 -arch C > $T/list-C-all
 xargs < $T/list-C-all -r grep -L "^P${LKMM_PROCS}" > $T/list-C-short
 
 # Form list of new tests.  Note: This does not handle litmus-test deletion!
-- 
2.17.1
