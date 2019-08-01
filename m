Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389524AbfHAWVP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:15 -0400
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 21/31] tools/memory-model: Fix scripting --jobs argument
Date: Thu,  1 Aug 2019 15:20:46 -0700
Message-ID: <20190801222056.12144-21-paulmck@linux.ibm.com>
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190801222046.3XMN0z_z6F5mPs5Bj-wIvbXwz953QxHVaeErC1-rfuw@z>

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
