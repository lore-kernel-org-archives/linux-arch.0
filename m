Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfJCA1A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:27:00 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 27/32] tools/memory-model:  Add "--" to parseargs.sh for additional arguments
Date: Wed,  2 Oct 2019 17:26:45 -0700
Message-ID: <20191003002650.11249-27-paulmck@kernel.org>
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20191003002645.93Aboz9U3NwCPzlZq27sUcXM4YNfJYQiZM-T5W9LEM0@z>

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

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
index 25a81ac..7aa5875 100755
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
2.9.5
