Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752209AbeDPQLI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3GFtEdl060003
        for <linux-arch@vger.kernel.org>; Mon, 16 Apr 2018 12:11:07 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hcvpgg925-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Apr 2018 12:11:06 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Apr 2018 12:11:06 -0400
Date: Mon, 16 Apr 2018 09:12:09 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 0/17] Memory-model changes
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20180416161209.GA6895@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180416161209.TCpGTiIPcYK2Z351gwHsL2i4ag-bZMJ0wevf0PSqc2k@z>

Hello!

This series contains changes to the memory model, including the formal
model in tools/memory-model and documentation in memory-barriers.txt (plus
the Korean translation).  These changes are ready for inclusion in -tip.

1.	Rename LKMM's "link" and "rcu-path" relations to "rcu-link"
	and "rb", respectively, courtesy of Alan Stern.

2.	Redefine LKMM's "rb" relation in terms of rcu-fence in order
	to match the structure of LKMM's other strong fences, courtesy
	of Alan Stern.

3.	Fix memory-barriers.txt's ordering example contrasting DMA to
	MMIO, courtesy of Will Deacon.

4-6.	Fixes related to spin_is_locked(), courtesy of Andrea Parri.

7-11.	Updates to Korean translation of memory-barriers.txt, courtesy
	of SeongJae Park.

12.	Update required version of the herd7 tool, courtesy of Akira
	Yokosawa.

13.	Fix "RWM" typo in cheatsheet.txt, courtesy of Paolo Bonzini.

14.	Improve cheatsheet.txt's key.

15.	Fix cheatsheet.txt's ordering rules for smp_mb__after_atomic().

16.	Add smp_store_mb() to LKMM, courtesy of Andrea Parri.

17.	Use consistent coding style in linux-kernel.def, courtesy of
	Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                    |   17 -
 Documentation/translations/ko_KR/memory-barriers.txt |   56 ++--
 arch/arm64/include/asm/spinlock.h                    |    5 
 include/asm-generic/qspinlock.h                      |    2 
 include/linux/mutex.h                                |    3 
 include/linux/spinlock.h                             |   18 +
 tools/memory-model/Documentation/cheatsheet.txt      |    7 
 tools/memory-model/Documentation/explanation.txt     |  261 +++++++++++--------
 tools/memory-model/README                            |    2 
 tools/memory-model/linux-kernel.cat                  |   49 ++-
 tools/memory-model/linux-kernel.def                  |   29 +-
 11 files changed, 268 insertions(+), 181 deletions(-)
