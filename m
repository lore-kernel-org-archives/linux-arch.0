Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbfE3Omc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdglr029415
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:31 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stgm21p1m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:30 +0100
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 09/33] tools/memory-model: Make cmplitmushist.sh note timeouts
Date: Thu, 30 May 2019 07:42:01 -0700
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Message-ID: <20190530144225.27624-9-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190530144201.bdHIOiP3n_2tqYF_eslgCZF15h_FsYdJXlQIJ7TRiy0@z>

Currently, cmplitmushist.sh treats timeouts (as in the "--timeout"
argument) as "Missing Observation line".  This can be misleading because
it is quite possible that running the test longer would have produced
a verification.  This commit therefore changes cmplitmushist.sh to check
for timeouts and to report them with "Timed out".

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/cmplitmushist.sh | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/memory-model/scripts/cmplitmushist.sh b/tools/memory-model/scripts/cmplitmushist.sh
index 0f498aeeccf5..b9c174dd8004 100755
--- a/tools/memory-model/scripts/cmplitmushist.sh
+++ b/tools/memory-model/scripts/cmplitmushist.sh
@@ -12,12 +12,30 @@ trap 'rm -rf $T' 0
 mkdir $T
 
 # comparetest oldpath newpath
+timedout=0
 perfect=0
 obsline=0
 noobsline=0
 obsresult=0
 badcompare=0
 comparetest () {
+	if grep -q '^Command exited with non-zero status 124' $1 ||
+	   grep -q '^Command exited with non-zero status 124' $2
+	then
+		if grep -q '^Command exited with non-zero status 124' $1 &&
+		   grep -q '^Command exited with non-zero status 124' $2
+		then
+			echo Both runs timed out: $2
+		elif grep -q '^Command exited with non-zero status 124' $1
+		then
+			echo Old run timed out: $2
+		elif grep -q '^Command exited with non-zero status 124' $2
+		then
+			echo New run timed out: $2
+		fi
+		timedout=`expr "$timedout" + 1`
+		return 0
+	fi
 	grep -v 'maxresident)k\|minor)pagefaults\|^Time' $1 > $T/oldout
 	grep -v 'maxresident)k\|minor)pagefaults\|^Time' $2 > $T/newout
 	if cmp -s $T/oldout $T/newout && grep -q '^Observation' $1
@@ -78,6 +96,10 @@ if test "$obsresult" -ne 0
 then
 	echo Matching Observation Always/Sometimes/Never result: $obsresult 1>&2
 fi
+if test "$timedout" -ne 0
+then
+	echo "!!!" Timed out: $timedout 1>&2
+fi
 if test "$badcompare" -ne 0
 then
 	echo "!!!" Result changed: $badcompare 1>&2
-- 
2.17.1
