From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-barriers.txt v2 0/5] Fixes and Korean translation
Date: Thu, 11 Aug 2016 11:16:02 -0700
Message-ID: <20160811181602.GA31464@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47615 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751752AbcHKW2S (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Aug 2016 18:28:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u7BMIx9P004976
	for <linux-arch@vger.kernel.org>; Thu, 11 Aug 2016 18:28:17 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9wvtxx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 11 Aug 2016 18:28:17 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 11 Aug 2016 16:28:17 -0600
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, dhowells@redhat.com, will.deacon@arm.com, linux-arch@vger.kernel.org, sj38.park@gmail.com

Hello!

This series provides some fixes and updates:

1.	Whitespace fixes, courtesy of SeongJae Park.

2.	Fix a section reference, courtesy of SeongJae Park.

3.	Fix a bug in a memory-ordering example, courtesy of SeongJae Park.

4.	Korean translation, courtesy of SeongJae Park.

Changes since v1:

o	Dropped the control-dependencies patch, which is already in
	-tip.  (And was at v1 time, what I get for failing to check!)

							Thanx, Paul

------------------------------------------------------------------------

 ko_KR/memory-barriers.txt | 3135 ++++++++++++++++++++++++++++++++++++++++++++++
 memory-barriers.txt       |    5 
 2 files changed, 3138 insertions(+), 2 deletions(-)
