Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731824AbfCZXlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Mar 2019 19:41:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNXWtH123372
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:18 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rftk1qmd2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:18 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:41:17 -0000
Date: Tue, 26 Mar 2019 16:41:14 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 0/21] LKMM updates for review
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20190326234114.GA23843@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20190326234114.DB9Kd0NyTdtvM3fEN0ukQENkpdH49cUMumC-jVcpsW8@z>

Hello!

This series contains LKMM updates:

1.	Make scripts be executable.

2.	Fix comment in MP+poonceonces.litmus, courtesy of Andrea Parri.

3.	Do not use "herd" to refer to "herd7", courtesy of Andrea Parri.

4.	Rewrite "KERNEL I/O BARRIER EFFECTS" section of memory-barriers.txt,
	courtesy of Will Deacon.

5-6.	Make LKMM scripts note timeouts instead of just saying that
	the validation was bad.

7.	Make LKMM scripts identify litmus-test typos and use of
	unsupported primitives instead of just saying that the validation
	was bad.

8.	Add support for synchronize_srcu_expedited().

9.	Make LKMM scripts detect unconditional deadlocks.

10-21.	Leverage Boqun Feng's C-to-assembly litmus-test-translation
	capability to allow verifying LKMM against hardware models
	for checkalllitmus.sh.  This is a work in progress.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                     |  115 +++++++++------
 tools/memory-model/linux-kernel.def                   |    1 
 tools/memory-model/litmus-tests/.gitignore            |    4 
 tools/memory-model/litmus-tests/MP+poonceonces.litmus |    2 
 tools/memory-model/litmus-tests/README                |    2 
 tools/memory-model/lock.cat                           |    2 
 tools/memory-model/scripts/README                     |   12 -
 tools/memory-model/scripts/checkalllitmus.sh          |   29 +--
 tools/memory-model/scripts/checklitmus.sh             |  101 +++++--------
 tools/memory-model/scripts/cmplitmushist.sh           |   53 ++++++
 tools/memory-model/scripts/judgelitmus.sh             |  114 +++++++++++---
 tools/memory-model/scripts/parseargs.sh               |   11 +
 tools/memory-model/scripts/runlitmus.sh               |  137 ++++++++++++++----
 tools/memory-model/scripts/runlitmushist.sh           |    3 
 tools/memory-model/scripts/simpletest.sh              |   35 ++++
 15 files changed, 425 insertions(+), 196 deletions(-)
