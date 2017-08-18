From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [GIT PULL rcu/next] RCU commits for 4.14
Date: Fri, 18 Aug 2017 09:37:33 -0700
Message-ID: <20170818163733.GA2331@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750984AbdHRQhi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Aug 2017 12:37:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7IGYD5C130431
        for <linux-arch@vger.kernel.org>; Fri, 18 Aug 2017 12:37:37 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2cdwm68frr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 18 Aug 2017 12:37:37 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 18 Aug 2017 12:37:36 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: mcgrof@kernel.org, mhiramat@kernel.org, peterz@infradead.org, joe@perches.com, tj@kernel.org, mathieu.desnoyers@efficios.com, manfred@colorfullife.com, oleg@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hello, Ingo,

Back to the usual branched format!  ;-)

This pull request contains the following changes:

1.	Documentation updates.

	http://lkml.kernel.org/r/20170724213605.GA8766@linux.vnet.ibm.com

2.	Miscellaneous fixes.

	http://lkml.kernel.org/r/20170724214425.GA9665@linux.vnet.ibm.com

	(But note that I have dropped the cond_resched() commit.)

3.	CPU-hotplug fixes.

	http://lkml.kernel.org/r/20170724215139.GA10881@linux.vnet.ibm.com

4.	Miscellaneous non-RCU fixes.

	http://lkml.kernel.org/r/20170731225159.GA2674@linux.vnet.ibm.com
	http://lkml.kernel.org/r/20170728204040.568-1-mathieu.desnoyers@efficios.com

5.	Removal of spin_unlock_wait().

	http://lkml.kernel.org/r/20170731225754.GB2674@linux.vnet.ibm.com
	http://lkml.kernel.org/r/20170811201247.GH3730@linux.vnet.ibm.com

6.	SRCU updates.

	http://lkml.kernel.org/r/20170724221511.GA15085@linux.vnet.ibm.com

7.	Torture-test updates.

	http://lkml.kernel.org/r/20170724222326.GA15933@linux.vnet.ibm.com

All of these changes have been subjected to 0day Test Robot and -next
testing, and are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 656e7c0c0a2e8d899f87fd7f081ea7a711146604:

  Merge branches 'doc.2017.08.17a', 'fixes.2017.08.17a', 'hotplug.2017.07.25b', 'misc.2017.08.17a', 'spin_unlock_wait_no.2017.08.17a', 'srcu.2017.07.27c' and 'torture.2017.07.24c' into HEAD (2017-08-17 08:10:04 -0700)

----------------------------------------------------------------
Joe Perches (1):
      module: Fix pr_fmt() bug for header use of printk

Luis R. Rodriguez (2):
      swait: Add idle variants which don't contribute to load average
      rcu: Use idle versions of swait to make idle-hack clear

Manfred Spraul (1):
      net/netfilter/nf_conntrack_core: Fix net_conntrack_lock()

Masami Hiramatsu (1):
      rcu/tracing: Set disable_rcu_irq_enter on rcu_eqs_exit()

Mathieu Desnoyers (1):
      membarrier: Provide expedited private command

Oleg Nesterov (1):
      task_work: Replace spin_unlock_wait() with lock/unlock pair

Paul E. McKenney (55):
      documentation: Fix relation between nohz_full and rcu_nocbs
      init_task: Remove redundant INIT_TASK_RCU_TREE_PREEMPT() macro
      srcu: Move rcu_scheduler_starting() from Tiny RCU to Tiny SRCU
      rcutorture: Remove obsolete SRCU-C.boot
      srcu: Make process_srcu() be static
      rcutorture: Move SRCU status printing to SRCU implementations
      rcutorture: Print SRCU lock/unlock totals
      rcu: Remove CONFIG_TASKS_RCU ifdef from rcuperf.c
      rcutorture: Select CONFIG_PROVE_LOCKING for Tiny SRCU scenario
      torture: Add --kconfig argument to kvm.sh
      rcutorture: Don't wait for kernel when all builds fail
      rcutorture: Enable SRCU readers from timer handler
      rcutorture: Place event-traced strings into trace buffer
      rcutorture: Use nr_cpus rather than maxcpus to limit test size
      rcutorture: Add task's CPU for rcutorture writer stalls
      rcutorture: Eliminate unused ts_rem local from rcu_trace_clock_local()
      rcu: Add last-CPU to GP-kthread starvation messages
      rcutorture: Invoke call_rcu() from timer handler
      rcu: Use timer as backstop for NOCB deferred wakeups
      atomics: Revert addition of comment header to spin_unlock_wait()
      rcu: Migrate callbacks earlier in the CPU-offline timeline
      rcu: Make expedited GPs correctly handle hardware CPU insertion
      torture: Fix typo suppressing CPU-hotplug statistics
      rcu: Remove orphan/adopt event-tracing fields
      rcu: Check for NOCB CPUs and empty lists earlier in CB migration
      rcu: Make NOCB CPUs migrate CBs directly from outgoing CPU
      rcu: Advance outgoing CPU's callbacks before migrating them
      rcu: Eliminate rcu_state ->orphan_lock
      rcu: Advance callbacks after migration
      rcu: Localize rcu_state ->orphan_pend and ->orphan_done
      rcu: Remove unused RCU list functions
      rcu: Move callback-list warning to irq-disable region
      srcu: Provide ordering for CPU not involved in grace period
      sched: Replace spin_unlock_wait() with lock/unlock pair
      rcu: Drive TASKS_RCU directly off of PREEMPT
      rcu: Create reasonable API for do_exit() TASKS_RCU processing
      rcu: Add TPS() to event-traced strings
      rcu: Move rcu.h to new trivial-function style
      rcu: Add event tracing to ->gp_tasks update at GP start
      rcu: Add TPS() protection for _rcu_barrier_trace strings
      rcu: Add assertions verifying blocked-tasks list
      rcu: Add warning to rcu_idle_enter() for irqs enabled
      rcu: Remove exports from rcu_idle_exit() and rcu_idle_enter()
      doc: Update RCU documentation
      doc: Update memory-barriers.txt for read-to-write dependencies
      doc: Add RCU files to docbook-generation files
      doc: No longer allowed to use rcu_dereference on non-pointers
      doc: Set down RCU's scheduling-clock-interrupt needs
      completion: Replace spin_unlock_wait() with lock/unlock pair
      exit: Replace spin_unlock_wait() with lock/unlock pair
      ipc: Replace spin_unlock_wait() with lock/unlock pair
      drivers/ata: Replace spin_unlock_wait() with lock/unlock pair
      locking: Remove spin_unlock_wait() generic definitions
      arch: Remove spin_unlock_wait() arch-specific definitions
      Merge branches 'doc.2017.08.17a', 'fixes.2017.08.17a', 'hotplug.2017.07.25b', 'misc.2017.08.17a', 'spin_unlock_wait_no.2017.08.17a', 'srcu.2017.07.27c' and 'torture.2017.07.24c' into HEAD

Peter Zijlstra (Intel) (1):
      rcu: Make rcu_idle_enter() rely on callers disabling irqs

Tejun Heo (1):
      sched: Allow migrating kthreads into online but inactive CPUs

 .../RCU/Design/Requirements/Requirements.html      | 130 +++++++++++
 Documentation/RCU/checklist.txt                    | 121 +++++++----
 Documentation/RCU/rcu.txt                          |   9 +-
 Documentation/RCU/rcu_dereference.txt              |  61 ++----
 Documentation/RCU/rcubarrier.txt                   |   5 +
 Documentation/RCU/torture.txt                      |  20 +-
 Documentation/RCU/whatisRCU.txt                    |   5 +-
 Documentation/admin-guide/kernel-parameters.txt    |   7 +-
 Documentation/core-api/kernel-api.rst              |  49 +++++
 Documentation/memory-barriers.txt                  |  41 ++--
 MAINTAINERS                                        |   2 +-
 arch/alpha/include/asm/spinlock.h                  |   5 -
 arch/arc/include/asm/spinlock.h                    |   5 -
 arch/arm/include/asm/spinlock.h                    |  16 --
 arch/arm64/include/asm/spinlock.h                  |  58 +----
 arch/arm64/kernel/process.c                        |   2 +
 arch/blackfin/include/asm/spinlock.h               |   5 -
 arch/blackfin/kernel/module.c                      |  39 ++--
 arch/hexagon/include/asm/spinlock.h                |   5 -
 arch/ia64/include/asm/spinlock.h                   |  21 --
 arch/m32r/include/asm/spinlock.h                   |   5 -
 arch/metag/include/asm/spinlock.h                  |   5 -
 arch/mn10300/include/asm/spinlock.h                |   5 -
 arch/parisc/include/asm/spinlock.h                 |   7 -
 arch/powerpc/include/asm/spinlock.h                |  33 ---
 arch/s390/include/asm/spinlock.h                   |   7 -
 arch/sh/include/asm/spinlock-cas.h                 |   5 -
 arch/sh/include/asm/spinlock-llsc.h                |   5 -
 arch/sparc/include/asm/spinlock_32.h               |   5 -
 arch/tile/include/asm/spinlock_32.h                |   2 -
 arch/tile/include/asm/spinlock_64.h                |   2 -
 arch/tile/lib/spinlock_32.c                        |  23 --
 arch/tile/lib/spinlock_64.c                        |  22 --
 arch/xtensa/include/asm/spinlock.h                 |   5 -
 drivers/ata/libata-eh.c                            |   8 +-
 include/asm-generic/qspinlock.h                    |  14 --
 include/linux/init_task.h                          |   8 +-
 include/linux/rcupdate.h                           |  15 +-
 include/linux/rcutiny.h                            |   8 +-
 include/linux/sched.h                              |   5 +-
 include/linux/spinlock.h                           |  31 ---
 include/linux/spinlock_up.h                        |   6 -
 include/linux/srcutiny.h                           |  13 ++
 include/linux/srcutree.h                           |   3 +-
 include/linux/swait.h                              |  55 +++++
 include/trace/events/rcu.h                         |   7 +-
 include/uapi/linux/membarrier.h                    |  23 +-
 ipc/sem.c                                          |   3 +-
 kernel/Makefile                                    |   1 -
 kernel/cpu.c                                       |   1 +
 kernel/exit.c                                      |  10 +-
 kernel/locking/qspinlock.c                         | 117 ----------
 kernel/membarrier.c                                |  70 ------
 kernel/rcu/Kconfig                                 |   3 +-
 kernel/rcu/rcu.h                                   | 128 ++---------
 kernel/rcu/rcu_segcblist.c                         | 108 +++-------
 kernel/rcu/rcu_segcblist.h                         |  28 +--
 kernel/rcu/rcuperf.c                               |  17 +-
 kernel/rcu/rcutorture.c                            |  83 +++----
 kernel/rcu/srcutiny.c                              |   8 +
 kernel/rcu/srcutree.c                              |  50 ++++-
 kernel/rcu/tiny.c                                  |   2 -
 kernel/rcu/tiny_plugin.h                           |  47 ----
 kernel/rcu/tree.c                                  | 213 ++++++++----------
 kernel/rcu/tree.h                                  |  15 +-
 kernel/rcu/tree_exp.h                              |   2 +-
 kernel/rcu/tree_plugin.h                           | 238 ++++++++++++---------
 kernel/rcu/update.c                                |  18 +-
 kernel/sched/Makefile                              |   1 +
 kernel/sched/completion.c                          |  11 +-
 kernel/sched/core.c                                |  38 +++-
 kernel/sched/membarrier.c                          | 152 +++++++++++++
 kernel/task_work.c                                 |   8 +-
 kernel/torture.c                                   |   2 +-
 net/netfilter/nf_conntrack_core.c                  |  52 +++--
 .../selftests/rcutorture/bin/config_override.sh    |  61 ++++++
 .../testing/selftests/rcutorture/bin/functions.sh  |  27 ++-
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |  11 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  58 ++---
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  34 ++-
 .../selftests/rcutorture/configs/rcu/BUSTED.boot   |   2 +-
 .../selftests/rcutorture/configs/rcu/SRCU-C.boot   |   1 -
 .../selftests/rcutorture/configs/rcu/SRCU-u        |   3 +-
 .../selftests/rcutorture/configs/rcu/TREE01.boot   |   2 +-
 .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |   2 +-
 85 files changed, 1237 insertions(+), 1323 deletions(-)
 delete mode 100644 kernel/membarrier.c
 delete mode 100644 kernel/rcu/tiny_plugin.h
 create mode 100644 kernel/sched/membarrier.c
 create mode 100755 tools/testing/selftests/rcutorture/bin/config_override.sh
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-C.boot
