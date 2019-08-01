Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729750AbfHAWUd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:20:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MHrPT055448
        for <linux-arch@vger.kernel.org>; Thu, 1 Aug 2019 18:20:31 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u45u86cvk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 01 Aug 2019 18:20:31 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:20:31 +0100
Date: Thu, 1 Aug 2019 15:20:26 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 0/31] LKMM updates for review
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20190801222026.GA11315@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20190801222026.8mwwx1YTocteQYdSAWwGvEFtNkgVWcmv5wlcY_mw0wI@z>

Hello!

This series contains LKMM updates:

1.	Make scripts be executable.

2-3.	Make LKMM scripts note timeouts instead of just saying that
	the validation was bad.

4.	Make LKMM scripts identify litmus-test typos and use of
	unsupported primitives instead of just saying that the validation
	was bad.

5.	Make LKMM scripts detect unconditional deadlocks.

6.	Fix email address on LKMM scripts.

7-29.	Leverage Boqun Feng's C-to-assembly litmus-test-translation
	capability to allow verifying LKMM against hardware models for
	checkalllitmus.sh.  This is a work in progress.

30.	Use cumul-fence instead of fence in ->prop example, courtesy
	of Joel Fernandes.

31.	Update the informal documentation, courtesy of Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt |   53 +++++++--------
 README                        |   18 ++---
 litmus-tests/.gitignore       |    4 -
 scripts/README                |   16 +++-
 scripts/checkalllitmus.sh     |   29 ++++----
 scripts/checkghlitmus.sh      |   11 +--
 scripts/checklitmus.sh        |  101 ++++++++++++-----------------
 scripts/checklitmushist.sh    |    2 
 scripts/checktheselitmus.sh   |   43 ++++++++++++
 scripts/cmplitmushist.sh      |   53 ++++++++++++++-
 scripts/hwfnseg.sh            |   20 +++++
 scripts/initlitmushist.sh     |    2 
 scripts/judgelitmus.sh        |  142 +++++++++++++++++++++++++++++++----------
 scripts/newlitmushist.sh      |    4 -
 scripts/parseargs.sh          |   21 ++++--
 scripts/runlitmus.sh          |  144 ++++++++++++++++++++++++++++++++----------
 scripts/runlitmushist.sh      |   30 +++++---
 scripts/simpletest.sh         |   35 ++++++++++
 18 files changed, 514 insertions(+), 214 deletions(-)
