From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [GIT PULL urgent-membarrier] membarrier commits for 4.14
Date: Thu, 19 Oct 2017 17:30:42 +0000 (UTC)
Message-ID: <1300627407.45155.1508434242913.JavaMail.zimbra@efficios.com>
References: <20171018195944.GA15331@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018195944.GA15331@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

----- On Oct 18, 2017, at 3:59 PM, Paul E. McKenney paulmck@linux.vnet.ibm.com wrote:

> Hello, Linus,

Hi Linus,

Time did fly since I submitted this series near the beginning of
the 4.14 rc cycle. Now that we are closer to the end of the cycle,
a more surgical approach would be more appropriate.

I have prepared the minimal patch that needs to be applied to
modify the user-space visible ABI before the end of the 4.14
cycle.

I will send that patch to you directly, hoping you can apply
it before the end of the 4.14 cycle.

Thanks,

Mathieu

> 
> This urgent pull request contains five commits that fix a problem
> that arose when designing requested extensions to sys_membarrier()
> to allow JITs to efficiently flush old code from instruction caches.
> Several potential algorithms are much less painful if the user register
> intent to use this functionality early on, for example, before the process
> spawns the second thread.  Registering at this time removes the need to
> interrupt each and every thread in that process at the first expedited
> sys_membarrier() system call.
> 
> However, if we let the current function out, then user programs might be
> written without registration, which would make it more difficult to add
> required registration after the fact.  Hence the late-in-merge-window
> pull request.
> 
> The last two commits remove unused code from architectures not supporting
> sys_membarrier() and fix a problem that arises when tasks are created
> with CLONE_VM but !CLONE_THREAD on powerpc.
> 
> These have been subject to 0day test robot and -next testing and
> are available in the git repository at:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>  membarrier.2017.10.09a
> 
> for you to fetch changes up to f7399e01ccd0850786bdedbee2fd351651ce99f8:
> 
>  Fix: membarrier: Handle CLONE_VM + !CLONE_THREAD correctly on powerpc
>  (2017-10-09 14:24:49 -0700)
> 
> ----------------------------------------------------------------
> Mathieu Desnoyers (5):
>      membarrier: Provide register expedited private command
>      membarrier: selftest: Test private expedited cmd
>      membarrier: Document scheduler barrier requirements
>      membarrier: Remove unused code for architectures without membarrier hooks
>      Fix: membarrier: Handle CLONE_VM + !CLONE_THREAD correctly on powerpc
> 
> MAINTAINERS                                        |   2 +
> arch/powerpc/Kconfig                               |   1 +
> arch/powerpc/include/asm/membarrier.h              |  26 +++++
> arch/powerpc/kernel/Makefile                       |   2 +
> arch/powerpc/kernel/membarrier.c                   |  36 +++++++
> arch/powerpc/mm/mmu_context.c                      |   7 ++
> arch/x86/mm/tlb.c                                  |   5 +
> fs/exec.c                                          |   1 +
> include/linux/mm_types.h                           |   3 +
> include/linux/sched/mm.h                           |  37 +++++++
> include/uapi/linux/membarrier.h                    |  23 +++--
> init/Kconfig                                       |   3 +
> kernel/sched/core.c                                |  47 +++++----
> kernel/sched/membarrier.c                          |  35 ++++++-
> .../testing/selftests/membarrier/membarrier_test.c | 109 ++++++++++++++++++---
> 15 files changed, 290 insertions(+), 47 deletions(-)
> create mode 100644 arch/powerpc/include/asm/membarrier.h
>  create mode 100644 arch/powerpc/kernel/membarrier.c

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
