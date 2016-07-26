From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-barriers.txt 4/5] Doc/memory-barriers: Fix a typo of example result
Date: Tue, 26 Jul 2016 11:19:30 -0700
Message-ID: <1469557171-27507-4-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160726181807.GA26700@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18476 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757588AbcGZSTj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Jul 2016 14:19:39 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6QIIsJB045319
	for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2016 14:19:38 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24dsrpbbm7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2016 14:19:38 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 26 Jul 2016 14:19:37 -0400
In-Reply-To: <20160726181807.GA26700@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, dhowells@redhat.com, will.deacon@arm.com, linux-arch@vger.kernel.org, sj38.park@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

From: SeongJae Park <sj38.park@gmail.com>

An example result for data dependent write has a typo.  This commit
fixes the wrong typo.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 19c8eb6f246e..ba818ecce6f9 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -609,7 +609,7 @@ A data-dependency barrier must also order against dependent writes:
 The data-dependency barrier must order the read into Q with the store
 into *Q.  This prohibits this outcome:
 
-	(Q == B) && (B == 4)
+	(Q == &B) && (B == 4)
 
 Please note that this pattern should be rare.  After all, the whole point
 of dependency ordering is to -prevent- writes to the data structure, along
-- 
2.5.2
