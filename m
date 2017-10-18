From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [GIT PULL urgent-membarrier] membarrier commits for 4.14
Date: Wed, 18 Oct 2017 12:59:44 -0700
Message-ID: <20171018195944.GA15331@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750880AbdJRT7x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Oct 2017 15:59:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9IJwkVJ061808
        for <linux-arch@vger.kernel.org>; Wed, 18 Oct 2017 15:59:53 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dp9p4we0j-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 18 Oct 2017 15:59:53 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 18 Oct 2017 15:59:51 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: mingo@kernel.org, mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, ahh@google.com, maged.michael@gmail.com, gromer@google.com, avi@scylladb.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, davejwatson@fb.com, stern@rowland.harvard.edu, will.deacon@arm.com, luto@kernel.org, viro@zeniv.linux.org.uk, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Linus,

This urgent pull request contains five commits that fix a problem
that arose when designing requested extensions to sys_membarrier()
to allow JITs to efficiently flush old code from instruction caches.
Several potential algorithms are much less painful if the user register
intent to use this functionality early on, for example, before the process
spawns the second thread.  Registering at this time removes the need to
interrupt each and every thread in that process at the first expedited
sys_membarrier() system call.

However, if we let the current function out, then user programs might be
written without registration, which would make it more difficult to add
required registration after the fact.  Hence the late-in-merge-window
pull request.

The last two commits remove unused code from architectures not supporting
sys_membarrier() and fix a problem that arises when tasks are created
with CLONE_VM but !CLONE_THREAD on powerpc.

These have been subject to 0day test robot and -next testing and
are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git membarrier.2017.10.09a

for you to fetch changes up to f7399e01ccd0850786bdedbee2fd351651ce99f8:

  Fix: membarrier: Handle CLONE_VM + !CLONE_THREAD correctly on powerpc (2017-10-09 14:24:49 -0700)

----------------------------------------------------------------
Mathieu Desnoyers (5):
      membarrier: Provide register expedited private command
      membarrier: selftest: Test private expedited cmd
      membarrier: Document scheduler barrier requirements
      membarrier: Remove unused code for architectures without membarrier hooks
      Fix: membarrier: Handle CLONE_VM + !CLONE_THREAD correctly on powerpc

 MAINTAINERS                                        |   2 +
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/membarrier.h              |  26 +++++
 arch/powerpc/kernel/Makefile                       |   2 +
 arch/powerpc/kernel/membarrier.c                   |  36 +++++++
 arch/powerpc/mm/mmu_context.c                      |   7 ++
 arch/x86/mm/tlb.c                                  |   5 +
 fs/exec.c                                          |   1 +
 include/linux/mm_types.h                           |   3 +
 include/linux/sched/mm.h                           |  37 +++++++
 include/uapi/linux/membarrier.h                    |  23 +++--
 init/Kconfig                                       |   3 +
 kernel/sched/core.c                                |  47 +++++----
 kernel/sched/membarrier.c                          |  35 ++++++-
 .../testing/selftests/membarrier/membarrier_test.c | 109 ++++++++++++++++++---
 15 files changed, 290 insertions(+), 47 deletions(-)
 create mode 100644 arch/powerpc/include/asm/membarrier.h
 create mode 100644 arch/powerpc/kernel/membarrier.c
