From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v3 0/6] Documentation/features: Provide and apply 'features-refresh.sh'
Date: Mon,  7 May 2018 12:43:37 +0200
Message-ID: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, paulmck@linux.vnet.ibm.com, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-arch.vger.kernel.org

Hi,

This series provides the script 'features-refresh.sh', which operates on
the arch support status files, and it applies this script to refresh the
status files in place; previous discussions about this series are at [1].

The series is organized as follows.

  - Patch 1/6 adds the script to 'Documentation/features/scripts/'.

  - Patch 2/6 presents the results of running the script; this run
    also printed the messages

       WARNING: 'HAVE_BPF_JIT' is not a valid Kconfig
       WARNING: '__HAVE_ARCH_STRNCASECMP' is not a valid Kconfig
       WARNING: 'Optimized asm/rwsem.h' is not a valid Kconfig
       WARNING: '__HAVE_ARCH_PTE_SPECIAL' is not a valid Kconfig

    to standard output.

  - Patches 3-6/6 fix each of these warnings.

(Applies on -rc4.)

Cheers,
  Andrea

[1] http://lkml.kernel.org/r/1523205027-31786-1-git-send-email-andrea.parri@amarulasolutions.com
    http://lkml.kernel.org/r/1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com
    http://lkml.kernel.org/r/20180328122211.GA25420@andrea

Changes in v3:
  - rebase on -rc4

Changes in v2:
  - support negation operators in Kconfig (suggested by Ingo Molnar)
  - reorder patches 2/6 and 3/6 (suggested by Ingo Molnar)
  - add patches 4-6/6 (suggested by Ingo Molnar)

Andrea Parri (6):
  Documentation/features: Add script that refreshes the arch support
    status files in place
  Documentation/features: Refresh the arch support status files in place
  Documentation/features/core: Add arch support status files for
    'cBPF-JIT' and 'eBPF-JIT'
  Documentation/features/locking: Use '!RWSEM_GENERIC_SPINLOCK' as
    Kconfig for 'rwsem-optimized'
  Documentation/features/lib: Remove arch support status file for
    'strncasecmp'
  Documentation/features/vm: Remove arch support status file for
    'pte_special'

 .../features/core/BPF-JIT/arch-support.txt         | 31 -------
 .../features/core/cBPF-JIT/arch-support.txt        | 33 ++++++++
 .../features/core/eBPF-JIT/arch-support.txt        | 33 ++++++++
 .../core/generic-idle-thread/arch-support.txt      |  4 +-
 .../features/core/jump-labels/arch-support.txt     |  2 +
 .../features/core/tracehook/arch-support.txt       |  2 +
 .../features/debug/KASAN/arch-support.txt          |  4 +-
 .../debug/gcov-profile-all/arch-support.txt        |  2 +
 Documentation/features/debug/kgdb/arch-support.txt |  4 +-
 .../debug/kprobes-on-ftrace/arch-support.txt       |  2 +
 .../features/debug/kprobes/arch-support.txt        |  4 +-
 .../features/debug/kretprobes/arch-support.txt     |  4 +-
 .../features/debug/optprobes/arch-support.txt      |  4 +-
 .../features/debug/stackprotector/arch-support.txt |  2 +
 .../features/debug/uprobes/arch-support.txt        |  6 +-
 .../debug/user-ret-profiler/arch-support.txt       |  2 +
 .../features/io/dma-api-debug/arch-support.txt     |  2 +
 .../features/io/dma-contiguous/arch-support.txt    |  4 +-
 .../features/io/sg-chain/arch-support.txt          |  2 +
 .../features/lib/strncasecmp/arch-support.txt      | 31 -------
 .../locking/cmpxchg-local/arch-support.txt         |  4 +-
 .../features/locking/lockdep/arch-support.txt      |  4 +-
 .../locking/queued-rwlocks/arch-support.txt        | 10 ++-
 .../locking/queued-spinlocks/arch-support.txt      |  8 +-
 .../locking/rwsem-optimized/arch-support.txt       | 10 ++-
 .../features/perf/kprobes-event/arch-support.txt   |  6 +-
 .../features/perf/perf-regs/arch-support.txt       |  4 +-
 .../features/perf/perf-stackdump/arch-support.txt  |  4 +-
 .../sched/membarrier-sync-core/arch-support.txt    |  2 +
 .../features/sched/numa-balancing/arch-support.txt |  6 +-
 Documentation/features/scripts/features-refresh.sh | 98 ++++++++++++++++++++++
 .../seccomp/seccomp-filter/arch-support.txt        |  6 +-
 .../time/arch-tick-broadcast/arch-support.txt      |  4 +-
 .../features/time/clockevents/arch-support.txt     |  4 +-
 .../time/context-tracking/arch-support.txt         |  2 +
 .../features/time/irq-time-acct/arch-support.txt   |  4 +-
 .../time/modern-timekeeping/arch-support.txt       |  2 +
 .../features/time/virt-cpuacct/arch-support.txt    |  2 +
 .../features/vm/ELF-ASLR/arch-support.txt          |  4 +-
 .../features/vm/PG_uncached/arch-support.txt       |  2 +
 Documentation/features/vm/THP/arch-support.txt     |  2 +
 Documentation/features/vm/TLB/arch-support.txt     |  2 +
 .../features/vm/huge-vmap/arch-support.txt         |  2 +
 .../features/vm/ioremap_prot/arch-support.txt      |  2 +
 .../features/vm/numa-memblock/arch-support.txt     |  4 +-
 .../features/vm/pte_special/arch-support.txt       | 31 -------
 46 files changed, 279 insertions(+), 128 deletions(-)
 delete mode 100644 Documentation/features/core/BPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/cBPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/eBPF-JIT/arch-support.txt
 delete mode 100644 Documentation/features/lib/strncasecmp/arch-support.txt
 create mode 100755 Documentation/features/scripts/features-refresh.sh
 delete mode 100644 Documentation/features/vm/pte_special/arch-support.txt

-- 
2.7.4
