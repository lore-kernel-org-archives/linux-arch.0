Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbfJCA06 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:58 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 17/32] tools/memory-model: Make runlitmus.sh generate .litmus.out for --hw
Date: Wed,  2 Oct 2019 17:26:35 -0700
Message-ID: <20191003002650.11249-17-paulmck@kernel.org>
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20191003002635.l9InvMhrPNIniNz0F6Ho_esPq4duJnib8VjKD9QMufk@z>

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

In the absence of "Result:" comments, the runlitmus.sh script relies on
litmus.out files from prior LKMM runs.  This can be a bit user-hostile,
so this commit makes runlitmus.sh generate any needed .litmus.out files
that don't already exist.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/runlitmus.sh | 54 ++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 91af859..2865a96 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -28,42 +28,48 @@ if test -f "$litmus" -a -r "$litmus"
 then
 	:
 else
-	echo ' --- ' error: \"$litmus\" is not a readable file
+	echo ' !!! ' error: \"$litmus\" is not a readable file
 	exit 255
 fi
 
-if test -z "$LKMM_HW_MAP_FILE"
+if test -z "$LKMM_HW_MAP_FILE" -o ! -e $LKMM_DESTDIR/$litmus.out
 then
 	# LKMM run
 	herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
 	echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
 	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
-else
-	# Hardware run
+	ret=$?
+	if test -z "$LKMM_HW_MAP_FILE"
+	then
+		exit $ret
+	fi
+	echo " --- " Automatically generated LKMM output for '"'--hw $LKMM_HW_MAP_FILE'"' run
+fi
 
-	T=/tmp/checklitmushw.sh.$$
-	trap 'rm -rf $T' 0 2
-	mkdir $T
+# Hardware run
 
-	# Generate filenames
-	catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
-	mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
-	themefile="$T/${LKMM_HW_MAP_FILE}.theme"
-	herdoptions="-model $LKMM_HW_CAT_FILE"
-	hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
-	hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
+T=/tmp/checklitmushw.sh.$$
+trap 'rm -rf $T' 0 2
+mkdir $T
 
-	# Don't run on litmus tests with complex synchronization
-	if ! scripts/simpletest.sh $litmus
-	then
-		echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
-		exit 254
-	fi
+# Generate filenames
+catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
+mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
+themefile="$T/${LKMM_HW_MAP_FILE}.theme"
+herdoptions="-model $LKMM_HW_CAT_FILE"
+hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
+hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
 
-	# Generate the assembly code and run herd on it.
-	gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
-	jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
-	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+# Don't run on litmus tests with complex synchronization
+if ! scripts/simpletest.sh $litmus
+then
+	echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
+	exit 254
 fi
 
+# Generate the assembly code and run herd7 on it.
+gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
+jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
+/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+
 exit $?
-- 
2.9.5
