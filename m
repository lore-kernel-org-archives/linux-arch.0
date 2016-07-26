From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-barriers.txt 2/5] memory-barriers.txt: Maintain consistent blank line
Date: Tue, 26 Jul 2016 11:19:28 -0700
Message-ID: <1469557171-27507-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160726181807.GA26700@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53803 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757462AbcGZSTi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Jul 2016 14:19:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6QIIqRr107176
	for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2016 14:19:37 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24e27cn7x5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2016 14:19:37 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 26 Jul 2016 12:19:36 -0600
In-Reply-To: <20160726181807.GA26700@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, dhowells@redhat.com, will.deacon@arm.com, linux-arch@vger.kernel.org, sj38.park@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

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
