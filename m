From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 33/33] tools/memory-model: Add data-race capabilities to judgelitmus.sh
Date: Thu, 30 May 2019 07:42:25 -0700
Message-ID: <20190530144225.27624-33-paulmck@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

This commit adds functionality to judgelitmus.sh to allow it to handle
both the "DATARACE" markers in the "Result:" comments in litmus tests
and the "Flag data-race" markers in LKMM output.  For C-language tests,
if either marker is present, the other must also be as well, at least for
litmus tests having a "Result:" comment.  If the LKMM output indicates
a data race, then failures of the Always/Sometimes/Never portion of the
"Result:" prediction are forgiven.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index ca9a19829d79..eaa2cc7d3b36 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -47,9 +47,27 @@ else
 	echo ' --- ' error: \"$LKMM_DESTDIR/$litmusout is not a readable file
 	exit 255
 fi
+if grep -q '^Flag data-race$' "$LKMM_DESTDIR/$litmusout"
+then
+	datarace_modeled=1
+fi
 if grep -q '^ \* Result: ' $litmus
 then
 	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
+	if grep -m1 '^ \* Result: .* DATARACE' $litmus
+	then
+		datarace_predicted=1
+	fi
+	if test -n "$datarace_predicted" -a -z "$datarace_modeled" -a -z "$LKMM_HW_MAP_FILE"
+	then
+		echo '!!! Predicted data race not modeled' $litmus
+		exit 252
+	elif test -z "$datarace_predicted" -a -n "$datarace_modeled"
+	then
+		# Note that hardware models currently don't model data races
+		echo '!!! Unexpected data race modeled' $litmus
+		exit 253
+	fi
 elif test -n "$LKMM_HW_MAP_FILE" && grep -q '^Observation' $LKMM_DESTDIR/$lkmmout > /dev/null 2>&1
 then
 	outcome=`grep -m 1 '^Observation ' $LKMM_DESTDIR/$lkmmout | awk '{ print $3 }'`
@@ -114,7 +132,7 @@ elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q $outcome || test "$o
 then
 	ret=0
 else
-	if test -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes
+	if test \( -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes \) -o -n "$datarace_modeled"
 	then
 		flag="--- Forgiven"
 		ret=0
-- 
2.17.1
