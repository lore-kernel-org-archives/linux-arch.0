Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbfE3OmJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdCDJ124770
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:08 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stgm11u6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:07 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:07 +0100
Date: Thu, 30 May 2019 07:42:02 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 0/33] LKMM updates for review
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20190530144202.GA26201@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20190530144202.ZjiOwOMRhd_z3ZU8K_QFq1jQYAhN7y8dOawpVh8aSEA@z>

Hello!

This series contains LKMM updates:

1-3.	Add plain C-language accesses to the model, including data-race
	detection, courtesy of Alan Stern.

4.	Make scripts be executable.

5.	Explain ordering provided by smp_mb__{before,after}_atomic(),
	courtesy of Alan Stern.

6.	Fix comment in MP+poonceonces.litmus, courtesy of Andrea Parri.

7.	Make documentation referencing "herd" instead reference the
	actual name of the command, "herd7", courtesy of Andrea Parri.

8-9.	Make LKMM scripts note timeouts instead of just saying that
	the validation was bad.

10.	Make LKMM scripts identify litmus-test typos and use of
	unsupported primitives instead of just saying that the validation
	was bad.

11.	Make LKMM scripts detect unconditional deadlocks.

12.	Fix email address on LKMM scripts.

13-33.	Leverage Boqun Feng's C-to-assembly litmus-test-translation
	capability to allow verifying LKMM against hardware models for
	checkalllitmus.sh.  This is a work in progress.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/atomic_t.txt                            |   17 +-
 tools/memory-model/linux-kernel.bell                  |    6 
 tools/memory-model/linux-kernel.cat                   |   82 ++++++++--
 tools/memory-model/linux-kernel.def                   |    1 
 tools/memory-model/litmus-tests/.gitignore            |    4 
 tools/memory-model/litmus-tests/MP+poonceonces.litmus |    2 
 tools/memory-model/litmus-tests/README                |    2 
 tools/memory-model/lock.cat                           |    2 
 tools/memory-model/scripts/README                     |   20 +-
 tools/memory-model/scripts/checkalllitmus.sh          |   31 +--
 tools/memory-model/scripts/checkghlitmus.sh           |   11 -
 tools/memory-model/scripts/checklitmus.sh             |  103 +++++--------
 tools/memory-model/scripts/checklitmushist.sh         |    2 
 tools/memory-model/scripts/checktheselitmus.sh        |   43 +++++
 tools/memory-model/scripts/cmplitmushist.sh           |   53 ++++++
 tools/memory-model/scripts/hwfnseg.sh                 |   20 ++
 tools/memory-model/scripts/initlitmushist.sh          |    2 
 tools/memory-model/scripts/judgelitmus.sh             |  136 +++++++++++++----
 tools/memory-model/scripts/newlitmushist.sh           |    4 
 tools/memory-model/scripts/parseargs.sh               |   23 ++
 tools/memory-model/scripts/runlitmus.sh               |  142 ++++++++++++++----
 tools/memory-model/scripts/runlitmushist.sh           |   32 ++--
 tools/memory-model/scripts/simpletest.sh              |   35 ++++
 23 files changed, 573 insertions(+), 200 deletions(-)
