Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727203AbfE3Ome (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdY98039246
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stfmrw2w4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:32 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:31 +0100
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 27/33] tools/memory-model: Fix scripting --jobs argument
Date: Thu, 30 May 2019 07:42:19 -0700
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Message-ID: <20190530144225.27624-27-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190530144219.nJGlcHsA-_CpxpNWAalJHeC6blEKb3BKFtKacFUiZi8@z>

The parseargs.sh regular expression for the --jobs argument incorrectly
requires that the number of jobs be at least 10, that is, have at least
two digits.  This commit therefore adjusts this regular expression to
allow single-digit numbers of jobs to be specified.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 5f016fc3f3af..25a81ac0dfdf 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -113,7 +113,7 @@ do
 		LKMM_JOBS="`echo $njobs | sed -e 's/^\([0-9]\+\).*$/\1/'`"
 		;;
 	--jobs|--job|-j)
-		checkarg --jobs "(number)" "$#" "$2" '^[1-9][0-9]\+$' '^--'
+		checkarg --jobs "(number)" "$#" "$2" '^[1-9][0-9]*$' '^--'
 		LKMM_JOBS="$2"
 		shift
 		;;
-- 
2.17.1
