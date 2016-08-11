From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-barriers.txt 2/4] memory-barriers.txt: Fix wrong section reference
Date: Thu, 11 Aug 2016 11:17:41 -0700
Message-ID: <1470939463-31950-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160811181602.GA31464@linux.vnet.ibm.com>
 <1470939463-31950-1-git-send-email-paulmck@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64473 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751797AbcHKW2U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Aug 2016 18:28:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u7BMLp6M109573
	for <linux-arch@vger.kernel.org>; Thu, 11 Aug 2016 18:28:19 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9veb64-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 11 Aug 2016 18:28:19 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 11 Aug 2016 16:28:19 -0600
In-Reply-To: <1470939463-31950-1-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, dhowells@redhat.com, will.deacon@arm.com, linux-arch@vger.kernel.org, sj38.park@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

From: SeongJae Park <sj38.park@gmail.com>

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index e1926a096818..19c8eb6f246e 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2076,7 +2076,7 @@ systems, and so cannot be counted on in such a situation to actually achieve
 anything at all - especially with respect to I/O accesses - unless combined
 with interrupt disabling operations.
 
-See also the section on "Inter-CPU locking barrier effects".
+See also the section on "Inter-CPU acquiring barrier effects".
 
 
 As an example, consider the following:
-- 
2.5.2
