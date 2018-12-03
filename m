Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbeLCXE7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Dec 2018 18:04:59 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3N4aaN024325
        for <linux-arch@vger.kernel.org>; Mon, 3 Dec 2018 18:04:58 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p5a5g9eun-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 03 Dec 2018 18:04:57 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 3 Dec 2018 23:04:56 -0000
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 3/3] EXP tools/memory-model: Make scripts take "-j" abbreviation for "--jobs"
Date: Mon,  3 Dec 2018 15:04:51 -0800
In-Reply-To: <20181203230411.GA27476@linux.ibm.com>
References: <20181203230411.GA27476@linux.ibm.com>
Message-ID: <20181203230451.28921-3-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20181203230451.n5RktqoTJAOYDsrtBzUYYuL0d7V4lIHuR98PVp4BUj0@z>

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
