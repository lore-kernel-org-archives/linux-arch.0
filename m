Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752259AbeENW7k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 18:59:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4EMxdus105642
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 18:59:39 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hygsr5yby-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 14 May 2018 18:59:39 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 14 May 2018 18:59:38 -0400
Date: Mon, 14 May 2018 16:01:05 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 0/3] Kernel fixes to spin_is_locked()
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20180514230105.GA6421@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180514230105.r_u1vw2Bo2W-GAvhI7rr0-t3Z-bVLhREfEpBwbe_WEw@z>

Hello!

This series contains fixes to the kernel related to the semantics
of spin_is_locked(), all courtesy of Andrea Parri, and all ready for
inclusion in -tip:

1.	Document the semantics of spin_is_locked() by adding a docbook
	header comment.

2.	Remove smp_mb() from arch_spin_is_locked(), given that the
	new order-free spin_is_locked() semantics require no such barrier.

3.	Clean up comment and #ifndef for {,queued_}spin_is_locked().
	The comment was "XXX think about spin_is_locked", and I can
	attest that we have now done some serious thinking.  ;-)

							Thanx, Paul

------------------------------------------------------------------------
