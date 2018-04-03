From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH 0/3] Documentation/features: Provide and apply "features-refresh.sh"
Date: Tue,  3 Apr 2018 18:55:48 +0200
Message-ID: <1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-arch.vger.kernel.org

In Ingo's words [1]:

  "[...]  what should be done instead is to write a script that refreshes
   all the arch-support.txt files in-place. [...]

   It's OK for the script to have various quirks for weirdly implemented
   features and exceptions: i.e. basically whenever it gets a feature wrong,
   we can just tweak the script with quirks to make it all work out of box.

   [...]  But in the end there should only be a single new script:

     Documentation/features/scripts/features-refresh.sh

   ... which operates on the arch-support.txt files and refreshes them in
   place, and which, after all the refreshes have been committed, should
   produce an empty 'git diff' result."

  "[...]  New features can then be added by basically just creating a
   header-only arch-support.txt file, such as:

     triton:~/tip/Documentation/features> cat foo/bar/arch-support.txt
     #
     # Feature name:          shiny new fubar kernel feature
     #         Kconfig:       ARCH_USE_FUBAR
     #         description:   arch supports the fubar feature
     #

   And running Documentation/features/scripts/features-refresh.sh would
   auto-generate the arch support matrix. [...]
 
   This way we soft- decouple the refreshing of the entries from the
   introduction of the features, while still making it all easy to keep
   sync and to extend."

This RFC presents a first attempt to implement such a feature/script, and
applies it script on top of Arnd's:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git arch-removal

Patch 1/3 provides the "features-refresh.sh" script.  Patch 2/3 removes the
"BPF-JIT" feature file and it creates header-only files for "cBPF-JIT" and
"eBPF-JIT".  Patch 3/3 presents the results of running the script; this run
also printed to standard output the following warnings:

  WARNING: '__HAVE_ARCH_STRNCASECMP' is not a valid Kconfig
  WARNING: 'Optimized asm/rwsem.h' is not a valid Kconfig
  WARNING: '!ARCH_USES_GETTIMEOFFSET' is not a valid Kconfig
  WARNING: '__HAVE_ARCH_PTE_SPECIAL' is not a valid Kconfig

(I'm sending these patches with empty commit messagges, for early feedback:
 I'll fill in these messages in subsequent versions if this makes sense...)

Cheers,
  Andrea

Andrea Parri (3):
  Documentation/features: Add script that refreshes the arch support
    status files in place
  Documentation/features/core: Add arch support status files for
    'cBPF-JIT' and 'eBPF-JIT'
  Documentation/features: Refresh and auto-generate the arch support
    status files in place

 .../features/core/BPF-JIT/arch-support.txt         | 31 ------------
 .../features/core/cBPF-JIT/arch-support.txt        | 32 +++++++++++++
 .../features/core/eBPF-JIT/arch-support.txt        | 32 +++++++++++++
 .../core/generic-idle-thread/arch-support.txt      |  3 +-
 .../features/core/jump-labels/arch-support.txt     |  1 +
 .../features/core/tracehook/arch-support.txt       |  1 +
 .../features/debug/KASAN/arch-support.txt          |  3 +-
 .../debug/gcov-profile-all/arch-support.txt        |  1 +
 Documentation/features/debug/kgdb/arch-support.txt |  3 +-
 .../debug/kprobes-on-ftrace/arch-support.txt       |  1 +
 .../features/debug/kprobes/arch-support.txt        |  3 +-
 .../features/debug/kretprobes/arch-support.txt     |  3 +-
 .../features/debug/optprobes/arch-support.txt      |  3 +-
 .../features/debug/stackprotector/arch-support.txt |  1 +
 .../features/debug/uprobes/arch-support.txt        |  5 +-
 .../debug/user-ret-profiler/arch-support.txt       |  1 +
 .../features/io/dma-api-debug/arch-support.txt     |  1 +
 .../features/io/dma-contiguous/arch-support.txt    |  3 +-
 .../features/io/sg-chain/arch-support.txt          |  1 +
 .../features/lib/strncasecmp/arch-support.txt      |  1 +
 .../locking/cmpxchg-local/arch-support.txt         |  3 +-
 .../features/locking/lockdep/arch-support.txt      |  3 +-
 .../locking/queued-rwlocks/arch-support.txt        |  9 ++--
 .../locking/queued-spinlocks/arch-support.txt      |  7 +--
 .../locking/rwsem-optimized/arch-support.txt       |  1 +
 .../features/perf/kprobes-event/arch-support.txt   |  5 +-
 .../features/perf/perf-regs/arch-support.txt       |  3 +-
 .../features/perf/perf-stackdump/arch-support.txt  |  3 +-
 .../sched/membarrier-sync-core/arch-support.txt    |  1 +
 .../features/sched/numa-balancing/arch-support.txt |  5 +-
 Documentation/features/scripts/features-refresh.sh | 55 ++++++++++++++++++++++
 .../seccomp/seccomp-filter/arch-support.txt        |  5 +-
 .../time/arch-tick-broadcast/arch-support.txt      |  3 +-
 .../features/time/clockevents/arch-support.txt     |  3 +-
 .../time/context-tracking/arch-support.txt         |  1 +
 .../features/time/irq-time-acct/arch-support.txt   |  3 +-
 .../time/modern-timekeeping/arch-support.txt       |  1 +
 .../features/time/virt-cpuacct/arch-support.txt    |  1 +
 .../features/vm/ELF-ASLR/arch-support.txt          |  3 +-
 .../features/vm/PG_uncached/arch-support.txt       |  1 +
 Documentation/features/vm/THP/arch-support.txt     |  1 +
 Documentation/features/vm/TLB/arch-support.txt     |  1 +
 .../features/vm/huge-vmap/arch-support.txt         |  1 +
 .../features/vm/ioremap_prot/arch-support.txt      |  1 +
 .../features/vm/numa-memblock/arch-support.txt     |  3 +-
 .../features/vm/pte_special/arch-support.txt       |  1 +
 46 files changed, 192 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/features/core/BPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/cBPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/eBPF-JIT/arch-support.txt
 create mode 100755 Documentation/features/scripts/features-refresh.sh

-- 
2.7.4
