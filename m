Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729590AbfJCA0z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:55 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 07/32] tools/memory-model: Make judgelitmus.sh identify bad macros
Date: Wed,  2 Oct 2019 17:26:25 -0700
Message-ID: <20191003002650.11249-7-paulmck@kernel.org>
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20191003002625.G9aDvw-zb988T50kXmxTwtW-jatC3fPwux5YZ9EaTXs@z>

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Currently, judgelitmus.sh treats use of unknown primitives (such as
srcu_read_lock() prior to SRCU support) as "!!! Verification error".
This can be misleading because it fails to call out typos and running
a version LKMM on a litmus test requiring a feature not provided by
that version.  This commit therefore changes judgelitmus.sh to check
for unknown primitives and to report them, for example, with:

	'!!! Current LKMM version does not know "rcu_write_lock"'.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/cmplitmushist.sh | 31 +++++++++++++++++++++++++----
 tools/memory-model/scripts/judgelitmus.sh   | 12 +++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/tools/memory-model/scripts/cmplitmushist.sh b/tools/memory-model/scripts/cmplitmushist.sh
index b9c174d..ca1ac8b 100755
--- a/tools/memory-model/scripts/cmplitmushist.sh
+++ b/tools/memory-model/scripts/cmplitmushist.sh
@@ -12,6 +12,7 @@ trap 'rm -rf $T' 0
 mkdir $T
 
 # comparetest oldpath newpath
+badmacnam=0
 timedout=0
 perfect=0
 obsline=0
@@ -19,8 +20,26 @@ noobsline=0
 obsresult=0
 badcompare=0
 comparetest () {
-	if grep -q '^Command exited with non-zero status 124' $1 ||
-	   grep -q '^Command exited with non-zero status 124' $2
+	if grep -q ': Unknown macro ' $1 || grep -q ': Unknown macro ' $2
+	then
+		if grep -q ': Unknown macro ' $1
+		then
+			badname=`grep ': Unknown macro ' $1 |
+				sed -e 's/^.*: Unknown macro //' |
+				sed -e 's/ (User error).*$//'`
+			echo 'Current LKMM version does not know "'$badname'"' $1
+		fi
+		if grep -q ': Unknown macro ' $2
+		then
+			badname=`grep ': Unknown macro ' $2 |
+				sed -e 's/^.*: Unknown macro //' |
+				sed -e 's/ (User error).*$//'`
+			echo 'Current LKMM version does not know "'$badname'"' $2
+		fi
+		badmacnam=`expr "$badmacnam" + 1`
+		return 0
+	elif grep -q '^Command exited with non-zero status 124' $1 ||
+	     grep -q '^Command exited with non-zero status 124' $2
 	then
 		if grep -q '^Command exited with non-zero status 124' $1 &&
 		   grep -q '^Command exited with non-zero status 124' $2
@@ -56,7 +75,7 @@ comparetest () {
 			return 0
 		fi
 	else
-		echo Missing Observation line "(e.g., herd7 timeout)": $2
+		echo Missing Observation line "(e.g., syntax error)": $2
 		noobsline=`expr "$noobsline" + 1`
 		return 0
 	fi
@@ -90,7 +109,7 @@ then
 fi
 if test "$noobsline" -ne 0
 then
-	echo Missing Observation line "(e.g., herd7 timeout)": $noobsline 1>&2
+	echo Missing Observation line "(e.g., syntax error)": $noobsline 1>&2
 fi
 if test "$obsresult" -ne 0
 then
@@ -100,6 +119,10 @@ if test "$timedout" -ne 0
 then
 	echo "!!!" Timed out: $timedout 1>&2
 fi
+if test "$badmacnam" -ne 0
+then
+	echo "!!!" Unknown primitive: $badmacnam 1>&2
+fi
 if test "$badcompare" -ne 0
 then
 	echo "!!!" Result changed: $badcompare 1>&2
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index d3c313b..d40439c 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -42,6 +42,18 @@ grep '^Observation' $LKMM_DESTDIR/$litmus.out
 if grep -q '^Observation' $LKMM_DESTDIR/$litmus.out
 then
 	:
+elif grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out
+then
+	badname=`grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out |
+		sed -e 's/^.*: Unknown macro //' |
+		sed -e 's/ (User error).*$//'`
+	badmsg=' !!! Current LKMM version does not know "'$badname'"'" $litmus"
+	echo $badmsg
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	then
+		echo ' !!! '$badmsg >> $LKMM_DESTDIR/$litmus.out 2>&1
+	fi
+	exit 254
 elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmus.out
 then
 	echo ' !!! Timeout' $litmus
-- 
2.9.5
