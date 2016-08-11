Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32801 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932125AbcHKW2e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Aug 2016 18:28:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u7BMIsmM027994
	for <linux-arch@vger.kernel.org>; Thu, 11 Aug 2016 18:28:34 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24rty42b7s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 11 Aug 2016 18:28:33 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 11 Aug 2016 16:28:33 -0600
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-barriers.txt 1/4] memory-barriers.txt: Maintain consistent blank line
Date: Thu, 11 Aug 2016 11:17:40 -0700
In-Reply-To: <20160811181602.GA31464@linux.vnet.ibm.com>
References: <20160811181602.GA31464@linux.vnet.ibm.com>
Message-ID: <1470939463-31950-1-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, dhowells@redhat.com, will.deacon@arm.com, linux-arch@vger.kernel.org, sj38.park@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20160811181740.q-gzXsMUUUKzIJzLj31FP3tVsliCzK8SzfYp3ou0Fr8@z>

From: SeongJae Park <sj38.park@gmail.com>

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a4d0a99de04d..e1926a096818 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1928,6 +1928,7 @@ There are some more advanced barrier functions:
 
      See Documentation/DMA-API.txt for more information on consistent memory.
 
+
 MMIO WRITE BARRIER
 ------------------
 
-- 
2.5.2

