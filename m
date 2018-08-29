Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729037AbeH3BJp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 21:09:45 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TL8nv3054997
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 17:11:04 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m6158vtk6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 17:11:03 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:11:02 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC LKMM 4/7] tools/memory-model: Fix a README typo
Date: Wed, 29 Aug 2018 14:10:50 -0700
In-Reply-To: <20180829211018.GA19646@linux.vnet.ibm.com>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
Message-ID: <20180829211053.20531-4-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, SeongJae Park <sj38.park@gmail.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180829211050.5nyMDAS8XINYpp2rUxYI6lKE61ijUGJUaTi3XkVtKIQ@z>

From: SeongJae Park <sj38.park@gmail.com>

This commit fixes a duplicate-"the" typo in README.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/Documentation/recipes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index af72700cc20a..7fe8d7aa3029 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -311,7 +311,7 @@ The smp_wmb() macro orders prior stores against later stores, and the
 smp_rmb() macro orders prior loads against later loads.  Therefore, if
 the final value of r0 is 1, the final value of r1 must also be 1.
 
-The the xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
+The xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
 the following write-side code fragment:
 
 	log->l_curr_block -= log->l_logBBsize;
-- 
2.17.1
