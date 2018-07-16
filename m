Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729810AbeGPScW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jul 2018 14:32:22 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GHxHt2118025
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:50 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k9031gj2h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:49 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 14:03:49 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 05/14] tools/memory-model: Remove ACCESS_ONCE() from recipes
Date: Mon, 16 Jul 2018 11:05:56 -0700
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Message-ID: <20180716180605.16115-5-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Mark Rutland <mark.rutland@arm.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180716180556.bvkb77UTGSNSePKllQPg-27O_u3wQsvYhBD8QqEO7KM@z>

From: Mark Rutland <mark.rutland@arm.com>

Since commit:

  b899a850431e2dd0 ("compiler.h: Remove ACCESS_ONCE()")

... there has been no definition of ACCESS_ONCE() in the kernel tree,
and it has been necessary to use READ_ONCE() or WRITE_ONCE() instead.

Let's update the exmaples in recipes.txt likewise for consistency, using
READ_ONCE() for reads.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/recipes.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index ee4309a87fc4..1fea8ef2b184 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -322,9 +322,9 @@ the following write-side code fragment:
 And the xlog_valid_lsn() function in fs/xfs/xfs_log_priv.h contains
 the corresponding read-side code fragment:
 
-	cur_cycle = ACCESS_ONCE(log->l_curr_cycle);
+	cur_cycle = READ_ONCE(log->l_curr_cycle);
 	smp_rmb();
-	cur_block = ACCESS_ONCE(log->l_curr_block);
+	cur_block = READ_ONCE(log->l_curr_block);
 
 Alternatively, consider the following comment in function
 perf_output_put_handle() in kernel/events/ring_buffer.c:
-- 
2.17.1
