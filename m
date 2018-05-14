Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752077AbeENWxb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 18:53:31 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4EMiD4L139415
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 18:53:31 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hyjry1q6c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 18:53:30 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 14 May 2018 18:53:30 -0400
Date: Mon, 14 May 2018 15:54:57 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 0/8] memory-barriers.txt and atomic_ops.rst
 updates
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20180514225457.GA5142@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180514225457.G2rqmFhlmxW21By5O6fkeHvisI9TdqSZ9ew2JP-UonA@z>

Hello!

This series contains changes to the atomic_ops.rst file and to the
memory-barriers.txt file and its Korean translation.  These changes are
ready for inclusion into -tip.

1.	Fix memory-barriers.txt's ordering example contrasting DMA to
	MMIO, courtesy of Will Deacon.

2-6.	Updates to Korean translation of memory-barriers.txt, courtesy
	of SeongJae Park.

7.	Fix example code in atomic_ops.rst, courtesy of SeongJae Park.

8.	Use `warning` rst directive in atomic_ops.rst, courtesy of
	SeongJae Park.

							Thanx, Paul

------------------------------------------------------------------------

 core-api/atomic_ops.rst                |   13 ++++---
 memory-barriers.txt                    |   17 +++++-----
 translations/ko_KR/memory-barriers.txt |   56 +++++++++++++++++++++------------
 3 files changed, 53 insertions(+), 33 deletions(-)
