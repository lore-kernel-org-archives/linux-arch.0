From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-barriers.txt 0/5] Fixes and Korean translation
Date: Tue, 26 Jul 2016 11:18:07 -0700
Message-ID: <20160726181807.GA26700@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41149 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751453AbcGZSSL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Jul 2016 14:18:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6QIEZji035839
	for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2016 14:18:10 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24e1bseukm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2016 14:18:10 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 26 Jul 2016 12:18:09 -0600
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, dhowells@redhat.com, will.deacon@arm.com, linux-arch@vger.kernel.org

Hello!

This series provides some fixes and updates:

1.	Clarify the limited scope of control dependencies.

2.	Whitespace fixes, courtesy of SeongJae Park.

3.	Fix a section reference, courtesy of SeongJae Park.

4.	Fix a bug in a memory-ordering example, courtesy of SeongJae Park.

5.	Korean translation, courtesy of SeongJae Park.

							Thanx, Paul

------------------------------------------------------------------------

 ko_KR/memory-barriers.txt | 3135 ++++++++++++++++++++++++++++++++++++++++++++++
 memory-barriers.txt       |   46 
 2 files changed, 3179 insertions(+), 2 deletions(-)
