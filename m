Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732688AbfCZXlm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Mar 2019 19:41:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNXUx8059344
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:40 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfv1yc28q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:40 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:41:39 -0000
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 02/21] tools/memory-model: Fix comment in MP+poonceonces.litmus
Date: Tue, 26 Mar 2019 16:41:14 -0700
In-Reply-To: <20190326234114.GA23843@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
Message-ID: <20190326234133.24962-2-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190326234114.2wodGbE8n-FtJotm2m8e-JfxHzPVd5FgVTNXB2-K7j4@z>

From: Andrea Parri <andrea.parri@amarulasolutions.com>

The comment should say "Sometimes" for the result.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/litmus-tests/MP+poonceonces.litmus | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index b2b60b84fb9d..172f0145301c 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -1,7 +1,7 @@
 C MP+poonceonces
 
 (*
- * Result: Maybe
+ * Result: Sometimes
  *
  * Can the counter-intuitive message-passing outcome be prevented with
  * no ordering at all?
-- 
2.17.1
