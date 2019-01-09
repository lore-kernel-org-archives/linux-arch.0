Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbfAIVHQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 16:07:16 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Kn5Sa109908
        for <linux-arch@vger.kernel.org>; Wed, 9 Jan 2019 16:07:15 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwqsva09c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 16:07:15 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:07:12 -0000
Date: Wed, 9 Jan 2019 13:07:06 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 0/6] LKMM updates
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20190109210706.GA27268@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, willy@infradead.org
Message-ID: <20190109210706.Vpi1B6J_7BhmBJVY6gjRkD-KCIDzmn5yhtOCFS-4n3g@z>

Hello!

This series contains updates for the Linux-kernel memory model:

1-3.	Add SRCU support, courtesy of Alan Stern.

4.	Update README for adding of SRCU support.

5.	Update memory-barriers.txt on enforcing heavy ordering for
	port-I/O accesses, courtesy of Will Deacon.  This one needs
	an ack, preferably by someone from Intel.  Matthew Wilcox
	posted some feedback from an Intel manual here, which might
	be considered to be a close substitute, but...  ;-)

	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org

6.	Update Documentation/explanation.txt to include SRCU support,
	courtesy of Alan Stern.

7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
	Luc Maranget.  This needs an ack.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                |    6 
 tools/memory-model/Documentation/explanation.txt |  289 ++++++++++++-----------
 tools/memory-model/README                        |   25 +
 tools/memory-model/linux-kernel.bell             |   37 ++
 tools/memory-model/linux-kernel.cat              |   55 ++--
 tools/memory-model/linux-kernel.def              |    7 
 6 files changed, 250 insertions(+), 169 deletions(-)
