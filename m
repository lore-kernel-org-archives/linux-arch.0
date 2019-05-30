Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727277AbfE3Ome (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdQwX024028
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:33 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stepvgeb2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:33 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:31 +0100
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 14/33] tools/memory-model: Make judgelitmus.sh handle hardware verifications
Date: Thu, 30 May 2019 07:42:06 -0700
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Message-ID: <20190530144225.27624-14-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190530144206.nScogn6YbPA73OV0KE5992cndFG3hRx2V3tgYthe0Vg@z>

This commit makes the judgelitmus.sh script check the --hw argument
(AKA the LKMM_HW_MAP_FILE environment variable) and to adjust its
judgment for a run where a C-language litmus test has been translated to
assembly and the assembly version verified.  In this case, the assembly
verification output is checked against the C-language script's "Result:"
comment.  However, because hardware can be stronger than LKMM requires,
the judgelitmus.sh script forgives verification mismatches featuring
a "Sometimes" in the C-language script and an "Always" or "Never"
assembly-language verification.

Note that deadlock is not forgiven, however, this should not normally be
an issue given that C-language tests containing locking, RCU, or SRCU
cannot be translated to assembly.  However, this issue can crop up in
litmus tests that mimic deadlock by using the "filter" clause to ignore
all executions.  It can also crop up when certain herd arguments are
used to autofilter everything that does not match the "exists" clause
in cases where the "exists" clause cannot be satisfied.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/README         |  8 +--
 tools/memory-model/scripts/judgelitmus.sh | 75 ++++++++++++++---------
 2 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/tools/memory-model/scripts/README b/tools/memory-model/scripts/README
index 095c7eb36f9f..0e29a52044c1 100644
--- a/tools/memory-model/scripts/README
+++ b/tools/memory-model/scripts/README
@@ -43,10 +43,10 @@ initlitmushist.sh
 
 judgelitmus.sh
 
-	Given a .litmus file and its .litmus.out herd7 output, check the
-	.litmus.out file against the .litmus file's "Result:" comment to
-	judge whether the test ran correctly.  Not normally run manually,
-	provided instead for use by other scripts.
+	Given a .litmus file and its herd7 output, check the output file
+	against the .litmus file's "Result:" comment to judge whether
+	the test ran correctly.  Not normally run manually, provided
+	instead for use by other scripts.
 
 newlitmushist.sh
 
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index d82133e75580..6f3c60065c8b 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -1,9 +1,14 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Given a .litmus test and the corresponding .litmus.out file, check
-# the .litmus.out file against the "Result:" comment to judge whether
-# the test ran correctly.
+# Given a .litmus test and the corresponding litmus output file, check
+# the .litmus.out file against the "Result:" comment to judge whether the
+# test ran correctly.  If the --hw argument is omitted, check against the
+# LKMM output, which is assumed to be in file.litmus.out.  If this argument
+# is provided, this is assumed to be a hardware test, and the output is
+# assumed to be in file.HW.litmus.out, where "HW" is the --hw argument.
+# In addition, non-Sometimes verification results will be noted, but
+# forgiven.
 #
 # Usage:
 #	judgelitmus.sh file.litmus
@@ -24,11 +29,18 @@ else
 	echo ' --- ' error: \"$litmus\" is not a readable file
 	exit 255
 fi
-if test -f "$LKMM_DESTDIR/$litmus".out -a -r "$LKMM_DESTDIR/$litmus".out
+if test -z "$LKMM_HW_MAP_FILE"
+then
+	litmusout=$litmus.out
+else
+	litmusout="`echo $litmus |
+		sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`.out"
+fi
+if test -f "$LKMM_DESTDIR/$litmusout" -a -r "$LKMM_DESTDIR/$litmusout"
 then
 	:
 else
-	echo ' --- ' error: \"$LKMM_DESTDIR/$litmus\".out is not a readable file
+	echo ' --- ' error: \"$LKMM_DESTDIR/$litmusout is not a readable file
 	exit 255
 fi
 if grep -q '^ \* Result: ' $litmus
@@ -38,69 +50,76 @@ else
 	outcome=specified
 fi
 
-grep '^Observation' $LKMM_DESTDIR/$litmus.out
-if grep -q '^Observation' $LKMM_DESTDIR/$litmus.out
+grep '^Observation' $LKMM_DESTDIR/$litmusout
+if grep -q '^Observation' $LKMM_DESTDIR/$litmusout
 then
 	:
-elif grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out
+elif grep ': Unknown macro ' $LKMM_DESTDIR/$litmusout
 then
-	badname=`grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out |
+	badname=`grep ': Unknown macro ' $LKMM_DESTDIR/$litmusout |
 		sed -e 's/^.*: Unknown macro //' |
 		sed -e 's/ (User error).*$//'`
 	badmsg=' !!! Current LKMM version does not know "'$badname'"'" $litmus"
 	echo $badmsg
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo ' !!! '$badmsg >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo ' !!! '$badmsg >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	exit 254
-elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmus.out
+elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmusout
 then
 	echo ' !!! Timeout' $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo ' !!! Timeout' >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo ' !!! Timeout' >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	exit 124
 else
 	echo ' !!! Verification error' $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo ' !!! Verification error' >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo ' !!! Verification error' >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	exit 255
 fi
 if test "$outcome" = DEADLOCK
 then
-	if grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q 'Never 0 0$'
+	if grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q 'Never 0 0$'
 	then
 		ret=0
 	else
 		echo " !!! Unexpected non-$outcome verification" $litmus
-		if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+		if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 		then
-			echo " !!! Unexpected non-$outcome verification" >> $LKMM_DESTDIR/$litmus.out 2>&1
+			echo " !!! Unexpected non-$outcome verification" >> $LKMM_DESTDIR/$litmusout 2>&1
 		fi
 		ret=1
 	fi
-elif grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q 'Never 0 0$'
+elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q 'Never 0 0$'
 then
 	echo " !!! Unexpected non-$outcome deadlock" $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo " !!! Unexpected non-$outcome deadlock" $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo " !!! Unexpected non-$outcome deadlock" $litmus >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	ret=1
-elif grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q $outcome || test "$outcome" = Maybe
+elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q $outcome || test "$outcome" = Maybe
 then
 	ret=0
 else
-	echo " !!! Unexpected non-$outcome verification" $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if test -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes
 	then
-		echo " !!! Unexpected non-$outcome verification" >> $LKMM_DESTDIR/$litmus.out 2>&1
+		flag="--- Forgiven"
+		ret=0
+	else
+		flag="!!! Unexpected"
+		ret=1
+	fi
+	echo " $flag non-$outcome verification" $litmus
+	if ! grep -qe "$flag" $LKMM_DESTDIR/$litmusout
+	then
+		echo " $flag non-$outcome verification" >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
-	ret=1
 fi
-tail -2 $LKMM_DESTDIR/$litmus.out | head -1
+tail -2 $LKMM_DESTDIR/$litmusout | head -1
 exit $ret
-- 
2.17.1
