Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbfJCA04 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:56 -0400
From: paulmck@kernel.org
Subject: [PATCH tip/core/rcu 12/32] tools/memory-model: Add simpletest.sh to check locking, RCU, and SRCU
Date: Wed,  2 Oct 2019 17:26:30 -0700
Message-ID: <20191003002650.11249-12-paulmck@kernel.org>
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20191003002630.mOJnBcvBId_mqk46RgAj2uTGXziAb3mC9MZgLFiVBOw@z>

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

This commit abstracts out common function to check a given litmus test
for locking, RCU, and SRCU in order to avoid duplicating code.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/simpletest.sh | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 tools/memory-model/scripts/simpletest.sh

diff --git a/tools/memory-model/scripts/simpletest.sh b/tools/memory-model/scripts/simpletest.sh
new file mode 100755
index 0000000..7edc5d3
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
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
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
2.9.5
