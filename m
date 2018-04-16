Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753088AbeDPQLt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3GFtiKl140810
        for <linux-arch@vger.kernel.org>; Mon, 16 Apr 2018 12:11:48 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hcwe2weph-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Apr 2018 12:11:48 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Apr 2018 12:11:47 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 15/17] tools/memory-order: smp_mb__after_atomic() orders later RMW operations
Date: Mon, 16 Apr 2018 09:12:43 -0700
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
Message-ID: <1523895165-17576-15-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180416161243.JGXPK3r2Yio395XfHnlzpw2pxAgQ8UBz-IUZt2Zh3oM@z>

The current cheat sheet does not claim that smp_mb__after_atomic()
orders later RMW atomic operations, which it must, at least against
earlier RMW atomic operations and whatever precedes them.  This commit
therefore adds the needed "Y".

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/cheatsheet.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index d502993ac7d2..94bdc25944d9 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -14,7 +14,7 @@ smp_wmb()                                  Y    W           Y       Y    W
 smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
 Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
 smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
-smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y
+smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
 
 
 Key:	C:	Ordering is cumulative
-- 
2.5.2
