Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbfJCA07 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:59 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 24/32] tools/memory-model: Fix scripting --jobs argument
Date: Wed,  2 Oct 2019 17:26:42 -0700
Message-ID: <20191003002650.11249-24-paulmck@kernel.org>
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20191003002642.ub5fXqBoIYH_x8yB3nXoakLoYfL69txvKvV-Gi5rssw@z>

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

The parseargs.sh regular expression for the --jobs argument incorrectly
requires that the number of jobs be at least 10, that is, have at least
two digits.  This commit therefore adjusts this regular expression to
allow single-digit numbers of jobs to be specified.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 5f016fc..25a81ac 100755
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
2.9.5
