From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 28/31] tools/memory-model: Make judgelitmus.sh handle scripted Result: tag
Date: Thu,  1 Aug 2019 15:20:53 -0700
Message-ID: <20190801222056.12144-28-paulmck@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

The scripts that generate the litmus tests in the "auto" directory of
the https://github.com/paulmckrcu/litmus archive place the "Result:"
tag into a single-line ocaml comment, which judgelitmus.sh currently
does not recognize.  This commit therefore makes judgelitmus.sh
recognize both the multiline comment format that it currently does
and the automatically generated single-line format.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index eaa2cc7d3b36..6408c012bdf5 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -51,10 +51,10 @@ if grep -q '^Flag data-race$' "$LKMM_DESTDIR/$litmusout"
 then
 	datarace_modeled=1
 fi
-if grep -q '^ \* Result: ' $litmus
+if grep -q '^[( ]\* Result: ' $litmus
 then
-	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
-	if grep -m1 '^ \* Result: .* DATARACE' $litmus
+	outcome=`grep -m 1 '^[( ]\* Result: ' $litmus | awk '{ print $3 }'`
+	if grep -m1 '^[( ]\* Result: .* DATARACE' $litmus
 	then
 		datarace_predicted=1
 	fi
-- 
2.17.1
