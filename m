From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [GIT PULL membarrier/urgent] membarrier commits for 4.14
Date: Wed, 4 Oct 2017 15:05:53 -0700
Message-ID: <20171004220553.GA16154@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751132AbdJDWGA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2017 18:06:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v94M3pdX027409
        for <linux-arch@vger.kernel.org>; Wed, 4 Oct 2017 18:06:00 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dd4knsmgm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 04 Oct 2017 18:06:00 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 4 Oct 2017 18:05:59 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, ahh@google.com, maged.michael@gmail.com, gromer@google.com, avi@scylladb.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, davejwatson@fb.com, stern@rowland.harvard.edu, will.deacon@arm.com, luto@kernel.org, mingo@redhat.com, viro@zeniv.linux.org.uk, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Ingo,

This urgent pull request contains three commits that fix a problem
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

These have been subject to 0day test robot and -next testing and
are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-for-mingo

for you to fetch changes up to 204a0fa1a3ecd9244869fa67608ad4fda232cba1:

  membarrier: Document scheduler barrier requirements (2017-10-04 11:02:18 -0700)

----------------------------------------------------------------
Mathieu Desnoyers (3):
      membarrier: Provide register expedited private command
      membarrier: selftest: Test private expedited cmd
      membarrier: Document scheduler barrier requirements

 MAINTAINERS                                        |   2 +
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/membarrier.h              |  43 ++++++++
 arch/powerpc/include/asm/thread_info.h             |   3 +
 arch/powerpc/kernel/Makefile                       |   2 +
 arch/powerpc/kernel/membarrier.c                   |  45 +++++++++
 arch/powerpc/mm/mmu_context.c                      |   7 ++
 arch/x86/mm/tlb.c                                  |   5 +
 fs/exec.c                                          |   1 +
 include/linux/mm_types.h                           |   3 +
 include/linux/sched/mm.h                           |  55 +++++++++++
 include/uapi/linux/membarrier.h                    |  23 +++--
 init/Kconfig                                       |   3 +
 kernel/fork.c                                      |   2 +
 kernel/sched/core.c                                |  47 +++++----
 kernel/sched/membarrier.c                          |  25 ++++-
 .../testing/selftests/membarrier/membarrier_test.c | 109 ++++++++++++++++++---
 17 files changed, 329 insertions(+), 47 deletions(-)
 create mode 100644 arch/powerpc/include/asm/membarrier.h
 create mode 100644 arch/powerpc/kernel/membarrier.c
