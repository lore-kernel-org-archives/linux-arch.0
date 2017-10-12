From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [GIT PULL v2 membarrier/urgent] membarrier commits for 4.14
Date: Thu, 12 Oct 2017 10:00:51 -0700
Message-ID: <20171012170051.GA27468@linux.vnet.ibm.com>
References: <20171004220553.GA16154@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171004220553.GA16154@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, ahh@google.com, maged.michael@gmail.com, gromer@google.com, avi@scylladb.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, davejwatson@fb.com, stern@rowland.harvard.edu, will.deacon@arm.com, luto@kernel.org, mingo@redhat.com, viro@zeniv.linux.org.uk, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hello, Ingo,

This v2 urgent pull request contains five commits that fix a problem
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

The additional two commits added by v2 remove unused code from
architectures not supporting sys_membarrier() and fix a problem that
arises when tasks are created with CLONE_VM but !CLONE_THREAD on powerpc.

These have been subject to 0day test robot and -next testing and
are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-membarrier

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
