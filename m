From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 11/33] tools/memory-model: Make judgelitmus.sh detect hard deadlocks
Date: Thu, 30 May 2019 07:42:03 -0700
Message-ID: <20190530144225.27624-11-paulmck@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

If a litmus test specifies "Result: Never" and if it contains an
unconditional ("hard") deadlock, then running checklitmus.sh on it will
not flag any errors, despite the fact that there are no executions.
This commit therefore updates judgelitmus.sh to complain about tests
with no executions that are marked, but not as "Result: DEADLOCK".

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index d40439c7b71e..84c62eee321b 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -83,6 +83,14 @@ then
 		fi
 		ret=1
 	fi
+elif grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q 'Never 0 0$'
+then
+	echo " !!! Unexpected non-$outcome deadlock" $litmus
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	then
+		echo " !!! Unexpected non-$outcome deadlock" $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+	fi
+	ret=1
 elif grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q $outcome || test "$outcome" = Maybe
 then
 	ret=0
-- 
2.17.1
