Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752028AbeBTXZP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:15 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1KNO5gg124888
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:15 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g8rqead3p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:04 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 20 Feb 2018 18:25:03 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 08/12] memory-barriers: Fix description of data dependency barriers
Date: Tue, 20 Feb 2018 15:25:08 -0800
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
Message-Id: <1519169112-20593-8-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

From: Nikolay Borisov <nborisov@suse.com>

In the description of data dependency barriers the words 'before' is
used erroneously. Since such barrier order dependent loads one after
the other. So substitute 'before' with 'after'.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 74ad222d11ed..0d83333b84a9 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -400,7 +400,7 @@ Memory barriers come in four basic varieties:
      where two loads are performed such that the second depends on the result
      of the first (eg: the first load retrieves the address to which the second
      load will be directed), a data dependency barrier would be required to
-     make sure that the target of the second load is updated before the address
+     make sure that the target of the second load is updated after the address
      obtained by the first load is accessed.
 
      A data dependency barrier is a partial ordering on interdependent loads
-- 
2.5.2
