Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63959 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932129AbcHKW2e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Aug 2016 18:28:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u7BMIwZV059502
	for <linux-arch@vger.kernel.org>; Thu, 11 Aug 2016 18:28:34 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24r5ugw35x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 11 Aug 2016 18:28:34 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 11 Aug 2016 16:28:33 -0600
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-barriers.txt 3/4] Doc/memory-barriers: Fix a typo of example result
Date: Thu, 11 Aug 2016 11:17:42 -0700
In-Reply-To: <1470939463-31950-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160811181602.GA31464@linux.vnet.ibm.com>
 <1470939463-31950-1-git-send-email-paulmck@linux.vnet.ibm.com>
Message-ID: <1470939463-31950-3-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, dhowells@redhat.com, will.deacon@arm.com, linux-arch@vger.kernel.org, sj38.park@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20160811181742.5GWUNUbzGaSGJKzH2mtHqJDA1QuMMys4ZxMSoGr-tHw@z>

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

