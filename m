Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727477AbeH3BJG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 21:09:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TL8pcS038334
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 17:10:24 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m615dcunc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 17:10:24 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:10:23 -0400
Date: Wed, 29 Aug 2018 14:10:18 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC memory-model 0/7] Memory-model changes
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20180829211018.GA19646@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180829211018.jfVal5Juh6-8auQ05RhE1mwdUbyUpZtdaoUif1yw-D4@z>

Hello!

This series contains memory-model updates, not yet ready for inclusion:

1.	Add extra ordering for locks and remove it for ordinary
	release/acquire, courtesy of Alan Stern.  There is some
	remaining disagreement as to whether or not locks and ordinary
	release/acquire should have identical ordering properties.

2.	Replace smp_cond_acquire() with smp_cond_load_acquire(),
	courtesy of Andrea Parri.

3.	Expand the list of LKMM limitations.

4.	Fix a README typo, courtesy of SeongJae Park.

5.	Add scripts to check github litmus tests.

6.	Make scripts take "-j" abbreviation for "--jobs".

7.	Add .cfg and .cat files for s390, which is a not-for-mainline
	placeholder.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                                          |    3 
 tools/memory-model/.gitignore                                              |    1 
 tools/memory-model/Documentation/explanation.txt                           |  186 +++++++---
 tools/memory-model/Documentation/recipes.txt                               |    2 
 tools/memory-model/README                                                  |   41 ++
 tools/memory-model/linux-kernel.cat                                        |    8 
 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus |    7 
 tools/memory-model/s390.cat                                                |   18 
 tools/memory-model/s390.cfg                                                |   21 +
 tools/memory-model/scripts/README                                          |   70 +++
 tools/memory-model/scripts/checkalllitmus.sh                               |   53 +-
 tools/memory-model/scripts/checkghlitmus.sh                                |   65 +++
 tools/memory-model/scripts/checklitmus.sh                                  |   74 ---
 tools/memory-model/scripts/checklitmushist.sh                              |   60 +++
 tools/memory-model/scripts/cmplitmushist.sh                                |   87 ++++
 tools/memory-model/scripts/initlitmushist.sh                               |   68 +++
 tools/memory-model/scripts/judgelitmus.sh                                  |   78 ++++
 tools/memory-model/scripts/newlitmushist.sh                                |   61 +++
 tools/memory-model/scripts/parseargs.sh                                    |  140 +++++++
 tools/memory-model/scripts/runlitmushist.sh                                |   87 ++++
 20 files changed, 981 insertions(+), 149 deletions(-)
