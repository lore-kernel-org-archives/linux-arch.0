Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732642AbfCZXll (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Mar 2019 19:41:41 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNXT0N059309
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:40 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfv1yc28v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:40 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:41:39 -0000
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 12/21] tools/memory-model: Add simpletest.sh to check locking, RCU, and SRCU
Date: Tue, 26 Mar 2019 16:41:24 -0700
In-Reply-To: <20190326234114.GA23843@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
Message-ID: <20190326234133.24962-12-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190326234124.tX726PIfkyC-yGmlaO36FOX_YdQzDhAHsMunFOsGEwI@z>

This commit abstracts out common function to check a given litmus test
for locking, RCU, and SRCU in order to avoid duplicating code.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/simpletest.sh | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 tools/memory-model/scripts/simpletest.sh

diff --git a/tools/memory-model/scripts/simpletest.sh b/tools/memory-model/scripts/simpletest.sh
new file mode 100755
index 000000000000..b03420e0dbb6
--- /dev/null
+++ b/tools/memory-model/scripts/simpletest.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Give zero status if this is a simple test and non-zero otherwise.
+# Simple tests do not contain locking, RCU, or SRCU.
+#
+# Usage:
+#	simpletest.sh file.litmus
+#
+# Copyright IBM Corporation, 2019
+#
+# Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
+
+
+litmus=$1
+
+if test -f "$litmus" -a -r "$litmus"
+then
+	:
+else
+	echo ' --- ' error: \"$litmus\" is not a readable file
+	exit 255
+fi
+exclude="^[[:space:]]*\("
+exclude="${exclude}spin_lock(\|spin_unlock(\|spin_trylock(\|spin_is_locked("
+exclude="${exclude}\|rcu_read_lock(\|rcu_read_unlock("
+exclude="${exclude}\|synchronize_rcu(\|synchronize_rcu_expedited("
+exclude="${exclude}\|srcu_read_lock(\|srcu_read_unlock("
+exclude="${exclude}\|synchronize_srcu(\|synchronize_srcu_expedited("
+exclude="${exclude}\)"
+if grep -q $exclude $litmus
+then
+	exit 255
+fi
+exit 0
-- 
2.17.1
