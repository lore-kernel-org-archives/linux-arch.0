Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389443AbfHAWVF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MGvuk073627
        for <linux-arch@vger.kernel.org>; Thu, 1 Aug 2019 18:21:03 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u48609654-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 01 Aug 2019 18:21:03 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:21:02 +0100
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 07/31] tools/memory-model: Update parseargs.sh for hardware verification
Date: Thu,  1 Aug 2019 15:20:32 -0700
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Message-ID: <20190801222056.12144-7-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190801222032.1tuwMl3oCG9XbsUtvs059MRFUDWENWN6Fr9DG4RN7uo@z>

This commit adds a --hw argument to parseargs.sh to specify the CPU
family for a hardware verification.  For example, "--hw AArch64" will
specify that a C-language litmus test is to be translated to ARMv8 and
the result verified.  This will set the LKMM_HW_MAP_FILE environment
variable accordingly.  If there is no --hw argument, this environment
variable will be set to the empty string.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index afe7bd23de6b..5f016fc3f3af 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -27,6 +27,7 @@ initparam () {
 
 initparam LKMM_DESTDIR "."
 initparam LKMM_HERD_OPTIONS "-conf linux-kernel.cfg"
+initparam LKMM_HW_MAP_FILE ""
 initparam LKMM_JOBS `getconf _NPROCESSORS_ONLN`
 initparam LKMM_PROCS "3"
 initparam LKMM_TIMEOUT "1m"
@@ -37,10 +38,11 @@ usagehelp () {
 	echo "Usage $scriptname [ arguments ]"
 	echo "      --destdir path (place for .litmus.out, default by .litmus)"
 	echo "      --herdopts -conf linux-kernel.cfg ..."
+	echo "      --hw AArch64"
 	echo "      --jobs N (number of jobs, default one per CPU)"
 	echo "      --procs N (litmus tests with at most this many processes)"
 	echo "      --timeout N (herd7 timeout (e.g., 10s, 1m, 2hr, 1d, '')"
-	echo "Defaults: --destdir '$LKMM_DESTDIR_DEF' --herdopts '$LKMM_HERD_OPTIONS_DEF' --jobs '$LKMM_JOBS_DEF' --procs '$LKMM_PROCS_DEF' --timeout '$LKMM_TIMEOUT_DEF'"
+	echo "Defaults: --destdir '$LKMM_DESTDIR_DEF' --herdopts '$LKMM_HERD_OPTIONS_DEF' --hw '$LKMM_HW_MAP_FILE' --jobs '$LKMM_JOBS_DEF' --procs '$LKMM_PROCS_DEF' --timeout '$LKMM_TIMEOUT_DEF'"
 	exit 1
 }
 
@@ -95,6 +97,11 @@ do
 		LKMM_HERD_OPTIONS="$2"
 		shift
 		;;
+	--hw)
+		checkarg --hw "(.map file architecture name)" "$#" "$2" '^[A-Za-z0-9_-]\+' '^--'
+		LKMM_HW_MAP_FILE="$2"
+		shift
+		;;
 	-j[1-9]*)
 		njobs="`echo $1 | sed -e 's/^-j//'`"
 		trailchars="`echo $njobs | sed -e 's/[0-9]\+\(.*\)$/\1/'`"
-- 
2.17.1
