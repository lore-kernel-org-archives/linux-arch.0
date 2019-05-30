Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbfE3Omf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEe1Tr091608
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:34 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgm11rw1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:32 +0100
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 32/33] tools/memory-model: Add checktheselitmus.sh to run specified litmus tests
Date: Thu, 30 May 2019 07:42:24 -0700
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Message-ID: <20190530144225.27624-32-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190530144224.QDS4LzNONnB5KiEMeE2BcxsGuBp7W_T6L_n0vTWhkRg@z>

This commit adds a checktheselitmus.sh script that runs the litmus tests
specified on the command line.  This is useful for verifying fixes to
specific litmus tests.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/README             |  8 ++++
 .../memory-model/scripts/checktheselitmus.sh  | 43 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100755 tools/memory-model/scripts/checktheselitmus.sh

diff --git a/tools/memory-model/scripts/README b/tools/memory-model/scripts/README
index 0e29a52044c1..cc2c4e5be9ec 100644
--- a/tools/memory-model/scripts/README
+++ b/tools/memory-model/scripts/README
@@ -27,6 +27,14 @@ checklitmushist.sh
 checklitmus.sh
 
 	Check a single litmus test against its "Result:" expected result.
+	Not intended to for manual use.
+
+checktheselitmus.sh
+
+	Check the specified list of litmus tests against their "Result:"
+	expected results.  This takes optional parseargs.sh arguments,
+	followed by "--" followed by pathnames starting from the current
+	directory.
 
 cmplitmushist.sh
 
diff --git a/tools/memory-model/scripts/checktheselitmus.sh b/tools/memory-model/scripts/checktheselitmus.sh
new file mode 100755
index 000000000000..10eeb5ecea6d
--- /dev/null
+++ b/tools/memory-model/scripts/checktheselitmus.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Invokes checklitmus.sh on its arguments to run the specified litmus
+# test and pass judgment on the results.
+#
+# Usage:
+#	checktheselitmus.sh -- [ file1.litmus [ file2.litmus ... ] ]
+#
+# Run this in the directory containing the memory model, specifying the
+# pathname of the litmus test to check.  The usual parseargs.sh arguments
+# can be specified prior to the "--".
+#
+# This script is intended for use with pathnames that start from the
+# tools/memory-model directory.  If some of the pathnames instead start at
+# the root directory, they all must do so and the "--destdir /" parseargs.sh
+# argument must be specified prior to the "--".  Alternatively, some other
+# "--destdir" argument can be supplied as long as the needed subdirectories
+# are populated.
+#
+# Copyright IBM Corporation, 2018
+#
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
+
+. scripts/parseargs.sh
+
+ret=0
+for i in "$@"
+do
+	if scripts/checklitmus.sh $i
+	then
+		:
+	else
+		ret=1
+	fi
+done
+if test "$ret" -ne 0
+then
+	echo " ^^^ VERIFICATION MISMATCHES" 1>&2
+else
+	echo All litmus tests verified as was expected. 1>&2
+fi
+exit $ret
-- 
2.17.1
