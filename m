Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729360AbeGPScV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jul 2018 14:32:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GHxFsm044844
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:50 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8w190t7j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:49 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 14:03:48 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 13/14] memory-model/Documentation: Fix typo, smb->smp
Date: Mon, 16 Jul 2018 11:06:04 -0700
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Message-ID: <20180716180605.16115-13-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180716180604.GxYXT5gcA_43tVjkrFzarx5ymiyb3DC8-v0WXRF9Id0@z>

From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

The tools/memory-model/Documentation/explanation.txt file says
"For each other CPU C', smb_wmb() forces all po-earlier stores"
This commit therefore replaces the "smb_wmb()" with "smp_wmb()".

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/Documentation/explanation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 1b09f3175a1f..0cbd1ef8f86d 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -804,7 +804,7 @@ type of fence:
 Second, some types of fence affect the way the memory subsystem
 propagates stores.  When a fence instruction is executed on CPU C:
 
-	For each other CPU C', smb_wmb() forces all po-earlier stores
+	For each other CPU C', smp_wmb() forces all po-earlier stores
 	on C to propagate to C' before any po-later stores do.
 
 	For each other CPU C', any store which propagates to C before
-- 
2.17.1
