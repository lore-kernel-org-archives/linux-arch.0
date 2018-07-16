Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728037AbeGPSb5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jul 2018 14:31:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GHxGAs117984
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:25 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k9031ghkv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 16 Jul 2018 14:03:25 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 14:03:24 -0400
Date: Mon, 16 Jul 2018 11:05:40 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 0/14] Updates to the formal memory model
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Message-ID: <20180716180540.GA14222@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, palmer@sifive.com, sj38.park@gmail.com, mark.rutland@arm.com, j.neuschaefer@gmx.net, yauheni.kaliuta@redhat.com
Message-ID: <20180716180540.-KOm-t4E76U3pz8AzeLkcNY6osHj6Mamb6FKVW5HOJk@z>

Hello!

This series contains updates to the Linux kernel's formal memory model
in tools/memory-model, along with corresponding changes in documentation
and Linux-kernel code.  These patches are ready for inclusion into -tip.

1.	Add a litmus test for full multi-copy atomicity.

2.	Fix the name of the ISA2+pooncelock+pooncelock+pombonce litmus test.

3.	Add Daniel Lustig as an LKMM reviewer, with focus on RISC-V,
	courtesy of Palmer Dabbelt.

4.	Update Korean translation to fix broken DMA vs. MMIO ordering
	example, courtesy of SeongJae Park with edits suggested by
	Byungchul Park.

5-6.	Remove the now-obsolete ACCESS_ONCE() from recipes and the model
	itself, courtesy of Mark Rutland.

7.	Make regression-test scripts executable.

8.	Describe atomic_set as a write operation, courtesy of Jonathan
	Neuschäfer.

9.	Add informal LKMM documentation to MAINTAINERS.

10.	Use smp_mb() in wake_woken_function(), courtesy of Andrea Parri.

11.	Clarify requirements for smp_mb__after_spinlock(), courtesy of
	Andrea Parri.

12.	Update wake_up() and friends' memory-barrier guarantees,
	courtesy of Andrea Parri.

13.	Fix "smb_wmb()" typo (should be "smp_wmb()"), courtesy of
	Yauheni Kaliuta.

14.	Rename litmus tests to comply to norm7, courtesy of Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/core-api/atomic_ops.rst                                                      |    2 
 Documentation/memory-barriers.txt                                                          |   43 +++---
 Documentation/translations/ko_KR/memory-barriers.txt                                       |   22 +--
 MAINTAINERS                                                                                |    6 
 include/linux/sched.h                                                                      |    4 
 include/linux/spinlock.h                                                                   |   53 +++++--
 kernel/sched/completion.c                                                                  |    8 -
 kernel/sched/core.c                                                                        |   71 ++++------
 kernel/sched/wait.c                                                                        |   55 +++----
 tools/memory-model/Documentation/explanation.txt                                           |    2 
 tools/memory-model/Documentation/recipes.txt                                               |   12 -
 tools/memory-model/README                                                                  |   20 +-
 tools/memory-model/linux-kernel.bell                                                       |    2 
 tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus                      |    2 
 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus                 |    2 
 tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus                     |    2 
 tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus                |    2 
 tools/memory-model/litmus-tests/R+fencembonceonces.litmus                                  |    2 
 tools/memory-model/litmus-tests/README                                                     |   25 ++-
 tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus                    |    2 
 tools/memory-model/litmus-tests/SB+fencembonceonces.litmus                                 |    2 
 tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus                          |   32 ++++
 tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus             |    2 
 tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus |    2 
 tools/memory-model/scripts/checkalllitmus.sh                                               |    2 
 tools/memory-model/scripts/checklitmus.sh                                                  |    2 
 26 files changed, 223 insertions(+), 156 deletions(-)
