From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 22/31] tools/memory-model: Make checkghlitmus.sh use mselect7
Date: Thu,  1 Aug 2019 15:20:47 -0700
Message-ID: <20190801222056.12144-22-paulmck@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

The checkghlitmus.sh script currently uses grep to ignore non-C-language
litmus tests, which is a bit fragile.  This commit therefore enlists the
aid of "mselect7 -arch C", given Luc Maraget's recent modifications that
allow mselect7 to operate in filter mode.

This change requires herdtools 7.52-32-g1da3e0e50977 or later.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkghlitmus.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
index 2ea220d2564b..cedd0290b73f 100755
--- a/tools/memory-model/scripts/checkghlitmus.sh
+++ b/tools/memory-model/scripts/checkghlitmus.sh
@@ -41,7 +41,7 @@ fi
 
 # Create a list of C-language litmus tests with "Result:" commands and
 # no more than the specified number of processes.
-find litmus -name '*.litmus' -exec grep -l -m 1 "^C " {} \; > $T/list-C
+find litmus -name '*.litmus' -print | mselect7 -arch C > $T/list-C
 xargs < $T/list-C -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
 xargs < $T/list-C-result -r grep -L "^P${LKMM_PROCS}" > $T/list-C-result-short
 
-- 
2.17.1
