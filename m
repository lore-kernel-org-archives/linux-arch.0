Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389528AbfHAWVT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:19 -0400
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 24/31] tools/memory-model:  Add "--" to parseargs.sh for additional arguments
Date: Thu,  1 Aug 2019 15:20:49 -0700
Message-ID: <20190801222056.12144-24-paulmck@linux.ibm.com>
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190801222049.0p8p3ZPtQZYVwRjcDRjT7RNWbDkABxrK9LM_vZYdS1M@z>

Currently, parseargs.sh expects to consume all the command-line arguments,
which prevents the calling script from having any of its own arguments.
This commit therefore causes parseargs.sh to stop consuming arguments
when it encounters a "--" argument, leaving any remaining arguments for
the calling script.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 25a81ac0dfdf..7aa58755adfc 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -83,7 +83,7 @@ do
 			echo "Cannot create directory --destdir '$LKMM_DESTDIR'"
 			usage
 		fi
-		if test -d "$LKMM_DESTDIR" -a -w "$LKMM_DESTDIR" -a -x "$LKMM_DESTDIR"
+		if test -d "$LKMM_DESTDIR" -a -x "$LKMM_DESTDIR"
 		then
 			:
 		else
@@ -127,6 +127,10 @@ do
 		LKMM_TIMEOUT="$2"
 		shift
 		;;
+	--)
+		shift
+		break
+		;;
 	*)
 		echo Unknown argument $1
 		usage
-- 
2.17.1
