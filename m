Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733018AbfCZXln (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Mar 2019 19:41:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNXUqU117582
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:42 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rftkx7nqx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:42 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:41:42 -0000
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 17/21] tools/memory-model: Make runlitmus.sh generate .litmus.out for --hw
Date: Tue, 26 Mar 2019 16:41:29 -0700
In-Reply-To: <20190326234114.GA23843@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
Message-ID: <20190326234133.24962-17-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190326234129.QhylOxiVja-Le00asWytA_nTZ-9Ps4wWCSz2ahTrkdk@z>

In the absence of "Result:" comments, the runlitmus.sh script relies on
litmus.out files from prior LKMM runs.  This can be a bit user-hostile,
so this commit makes runlitmus.sh generate any needed .litmus.out files
that don't already exist.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/runlitmus.sh | 54 ++++++++++++++-----------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 0ae46ab08cbd..186944a7a528 100755
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
 
+# Generate the assembly code and run herd on it.
+gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
+jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
+/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+
 exit $?
-- 
2.17.1
