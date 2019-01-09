From: guoren@kernel.org
Subject: [GIT PULL] csky fixup for linux-5.0-rc1
Date: Wed,  9 Jan 2019 22:49:57 +0800
Message-ID: <1547045397-24388-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, guoren@kernel.org
List-Id: linux-arch.vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-for-linus-5.0-rc1

for you to fetch changes up to 56752b21755aef598709d143684cb363db98a7d2:

  irqchip/csky: fixup handle_irq_perbit break irq (2019-01-09 00:18:46 +0800)

----------------------------------------------------------------
arch/csky patches for 5.0-rc1

Here is some fixup patches for 5.0-rc1:

 - fixup compile error with pte_alloc
 - fixup handle_irq_perbit break irq flow
 - fixup CACHEV1 store instruction fast retire
 - fixup module relocation error with 807 & 860
 - add csky kernel features

----------------------------------------------------------------
Guo Ren (5):
      Documentation/features: Add csky kernel features
      csky: fixup relocation error with 807 & 860
      csky: fixup CACHEV1 store instruction fast retire
      csky: fixup compile error with pte_alloc
      irqchip/csky: fixup handle_irq_perbit break irq

 .../features/core/cBPF-JIT/arch-support.txt        |  1 +
 .../features/core/eBPF-JIT/arch-support.txt        |  1 +
 .../core/generic-idle-thread/arch-support.txt      |  1 +
 .../features/core/jump-labels/arch-support.txt     |  1 +
 .../features/core/tracehook/arch-support.txt       |  1 +
 .../features/debug/KASAN/arch-support.txt          |  1 +
 .../debug/gcov-profile-all/arch-support.txt        |  1 +
 Documentation/features/debug/kgdb/arch-support.txt |  1 +
 .../debug/kprobes-on-ftrace/arch-support.txt       |  1 +
 .../features/debug/kprobes/arch-support.txt        |  1 +
 .../features/debug/kretprobes/arch-support.txt     |  1 +
 .../features/debug/optprobes/arch-support.txt      |  1 +
 .../features/debug/stackprotector/arch-support.txt |  1 +
 .../features/debug/uprobes/arch-support.txt        |  1 +
 .../debug/user-ret-profiler/arch-support.txt       |  1 +
 .../features/io/dma-contiguous/arch-support.txt    |  1 +
 .../locking/cmpxchg-local/arch-support.txt         |  1 +
 .../features/locking/lockdep/arch-support.txt      |  1 +
 .../locking/queued-rwlocks/arch-support.txt        |  1 +
 .../locking/queued-spinlocks/arch-support.txt      |  1 +
 .../locking/rwsem-optimized/arch-support.txt       |  1 +
 .../features/perf/kprobes-event/arch-support.txt   |  1 +
 .../features/perf/perf-regs/arch-support.txt       |  1 +
 .../features/perf/perf-stackdump/arch-support.txt  |  1 +
 .../sched/membarrier-sync-core/arch-support.txt    |  1 +
 .../features/sched/numa-balancing/arch-support.txt |  1 +
 .../seccomp/seccomp-filter/arch-support.txt        |  1 +
 .../time/arch-tick-broadcast/arch-support.txt      |  1 +
 .../features/time/clockevents/arch-support.txt     |  1 +
 .../time/context-tracking/arch-support.txt         |  1 +
 .../features/time/irq-time-acct/arch-support.txt   |  1 +
 .../time/modern-timekeeping/arch-support.txt       |  1 +
 .../features/time/virt-cpuacct/arch-support.txt    |  1 +
 .../features/vm/ELF-ASLR/arch-support.txt          |  1 +
 .../features/vm/PG_uncached/arch-support.txt       |  1 +
 Documentation/features/vm/THP/arch-support.txt     |  1 +
 Documentation/features/vm/TLB/arch-support.txt     |  1 +
 .../features/vm/huge-vmap/arch-support.txt         |  1 +
 .../features/vm/ioremap_prot/arch-support.txt      |  1 +
 .../features/vm/numa-memblock/arch-support.txt     |  1 +
 .../features/vm/pte_special/arch-support.txt       |  1 +
 arch/csky/include/asm/io.h                         | 25 +++++++
 arch/csky/include/asm/pgalloc.h                    | 43 +++++-------
 arch/csky/kernel/module.c                          | 38 ++++++-----
 drivers/irqchip/irq-csky-apb-intc.c                | 77 ++++++++++++----------
 45 files changed, 148 insertions(+), 76 deletions(-)
