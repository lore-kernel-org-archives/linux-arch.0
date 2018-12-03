From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 3/3] EXP tools/memory-model: Make scripts take "-j" abbreviation for "--jobs"
Date: Mon,  3 Dec 2018 15:04:51 -0800
Message-ID: <20181203230451.28921-3-paulmck@linux.ibm.com>
References: <20181203230411.GA27476@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203230411.GA27476@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

The "--jobs" argument to the litmus-test scripts is similar to the "-jN"
argument to "make", so this commit allows the "-jN" form as well.  While
in the area, it also prohibits the various forms of "-j0".

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 96b307c8d64a..859e1d581e05 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -95,8 +95,18 @@ do
 		LKMM_HERD_OPTIONS="$2"
 		shift
 		;;
-	--jobs|--job)
-		checkarg --jobs "(number)" "$#" "$2" '^[0-9]\+$' '^--'
+	-j[1-9]*)
+		njobs="`echo $1 | sed -e 's/^-j//'`"
+		trailchars="`echo $njobs | sed -e 's/[0-9]\+\(.*\)$/\1/'`"
+		if test -n "$trailchars"
+		then
+			echo $1 trailing characters "'$trailchars'"
+			usagehelp
+		fi
+		LKMM_JOBS="`echo $njobs | sed -e 's/^\([0-9]\+\).*$/\1/'`"
+		;;
+	--jobs|--job|-j)
+		checkarg --jobs "(number)" "$#" "$2" '^[1-9][0-9]\+$' '^--'
 		LKMM_JOBS="$2"
 		shift
 		;;
-- 
2.17.1
