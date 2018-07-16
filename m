Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728719AbeGPScW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jul 2018 14:32:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GHxD1o092020
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:49 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k8yxprum8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:49 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 14:03:48 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 07/14] tools/memory-model: Make scripts executable
Date: Mon, 16 Jul 2018 11:05:58 -0700
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Message-ID: <20180716180605.16115-7-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180716180558.3yYPi6EPCCWc_gKmZ8hCEQbYi4VR4h2WyfgzK8XRb74@z>

This commit makes the scripts executable to avoid the need for everyone
to do so manually in their archive.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/scripts/checkalllitmus.sh | 2 +-
 tools/memory-model/scripts/checklitmus.sh    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 tools/memory-model/scripts/checkalllitmus.sh
 mode change 100644 => 100755 tools/memory-model/scripts/checklitmus.sh

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
old mode 100644
new mode 100755
index af0aa15ab84e..ca528f9a24d4
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -9,7 +9,7 @@
 # appended.
 #
 # Usage:
-#	sh checkalllitmus.sh [ directory ]
+#	checkalllitmus.sh [ directory ]
 #
 # The LINUX_HERD_OPTIONS environment variable may be used to specify
 # arguments to herd, whose default is defined by the checklitmus.sh script.
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
old mode 100644
new mode 100755
index e2e477472844..bf12a75c0719
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -8,7 +8,7 @@
 # with ".out" appended.
 #
 # Usage:
-#	sh checklitmus.sh file.litmus
+#	checklitmus.sh file.litmus
 #
 # The LINUX_HERD_OPTIONS environment variable may be used to specify
 # arguments to herd, which default to "-conf linux-kernel.cfg".  Thus,
-- 
2.17.1
