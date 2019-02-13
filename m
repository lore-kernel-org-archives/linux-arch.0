Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393063AbfBMRg5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Feb 2019 12:36:57 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DHSoZj118171
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 12:36:56 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qmpwpjg2m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 12:36:56 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Feb 2019 17:36:54 -0000
Date: Wed, 13 Feb 2019 09:36:50 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 0/7] LKMM updates for v5.1
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20190213173650.GA26078@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20190213173650.9CB-zqertafZVhZQ1WvpIaso8POBtAbC3lE4Bkhz1hs@z>

Hello, Ingo,

This series contains updates for the Linux-kernel memory model, which
are ready for inclusion into -tip:

1-5.	Add support for SRCU, courtesy of Alan Stern.

6.	Dynamically check SRCU lock-to-unlock matching, courtesy of
	Luc Maranget.

7.	Avoid duplicating herdtools versions in documentation, courtesy
	of Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt |  289 ++++++++++++++++++++++--------------------
 README                        |   33 ++++
 linux-kernel.bell             |   37 ++++-
 linux-kernel.cat              |   57 +++++---
 linux-kernel.def              |    7 -
 lock.cat                      |    3 
 6 files changed, 254 insertions(+), 172 deletions(-)
