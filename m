Return-Path: <SRS0=hCR/=AV=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 0/7] mmu context cleanup, lazy tlb cleanup,
Date: Fri, 10 Jul 2020 11:56:39 +1000
Message-ID: <20200710015646.2020871-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200710015639.lXhwrtSaaw6zRyLClVmK5CecbK2Teb7LQFvI0vAKN-Y@z>

This blew up a bit bigger than I thought, so I'd like to get some
comments as to whether people agree with the direction it's going.

The patches aren't cleanly split out by arch, but as it is now it's
probably easier to get a quick overview of the changes at a glance
anyway.

So there's a few different things here.

1. Clean up and use asm-generic for no-op mmu context functions (so
   not just for nommu architectures). This should be functionally a
   no-op for everybody. This allows exit_lazy_tlb to easily be added.

2. Add exit_lazy_tlb and use it for x86, so this is x86 and membarrier
   specific changes. I _may_ have spotted a small membarrier / core sync
   bug here when adding exit_lazy_tlb.

3. Tidy up lazy tlb a little bit, have its own refcount function and
   allow it to be selected out. We can audit the nommu archs and
   deselect it for those.

4. Add a non-refcounting lazy mmu mode, to help scalability when the
   same mm is used for a lot of lazy mmu switching.

Comments, questions on anything would be much appreciated.

Thanks,
Nick

Nicholas Piggin (7):
  asm-generic: add generic MMU versions of mmu context functions
  arch: use asm-generic mmu context for no-op implementations
  mm: introduce exit_lazy_tlb
  x86: use exit_lazy_tlb rather than
    membarrier_mm_sync_core_before_usermode
  lazy tlb: introduce lazy mm refcount helper functions
  lazy tlb: allow lazy tlb mm switching to be configurable
  lazy tlb: shoot lazies, a non-refcounting lazy tlb option

 .../membarrier-sync-core/arch-support.txt     |  6 +-
 arch/Kconfig                                  | 23 +++++
 arch/alpha/include/asm/mmu_context.h          | 12 +--
 arch/arc/include/asm/mmu_context.h            | 16 ++--
 arch/arm/include/asm/mmu_context.h            | 26 +-----
 arch/arm64/include/asm/mmu_context.h          |  7 +-
 arch/csky/include/asm/mmu_context.h           |  8 +-
 arch/hexagon/include/asm/mmu_context.h        | 33 ++------
 arch/ia64/include/asm/mmu_context.h           | 17 +---
 arch/m68k/include/asm/mmu_context.h           | 47 ++---------
 arch/microblaze/include/asm/mmu_context.h     |  2 +-
 arch/microblaze/include/asm/mmu_context_mm.h  |  8 +-
 arch/microblaze/include/asm/processor.h       |  3 -
 arch/mips/include/asm/mmu_context.h           | 11 +--
 arch/nds32/include/asm/mmu_context.h          | 10 +--
 arch/nios2/include/asm/mmu_context.h          | 21 +----
 arch/nios2/mm/mmu_context.c                   |  1 +
 arch/openrisc/include/asm/mmu_context.h       |  8 +-
 arch/openrisc/mm/tlb.c                        |  2 +
 arch/parisc/include/asm/mmu_context.h         | 12 +--
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/include/asm/mmu_context.h        | 22 ++---
 arch/powerpc/kernel/smp.c                     |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c          |  4 +-
 arch/riscv/include/asm/mmu_context.h          | 22 +----
 arch/s390/include/asm/mmu_context.h           |  9 +-
 arch/sh/include/asm/mmu_context.h             |  7 +-
 arch/sh/include/asm/mmu_context_32.h          |  9 --
 arch/sparc/include/asm/mmu_context_32.h       | 10 +--
 arch/sparc/include/asm/mmu_context_64.h       | 10 +--
 arch/um/include/asm/mmu_context.h             | 12 ++-
 arch/unicore32/include/asm/mmu_context.h      | 24 +-----
 arch/x86/include/asm/mmu_context.h            | 41 +++++++++
 arch/x86/include/asm/sync_core.h              | 28 -------
 arch/xtensa/include/asm/mmu_context.h         | 11 +--
 arch/xtensa/include/asm/nommu_context.h       | 26 +-----
 fs/exec.c                                     |  5 +-
 include/asm-generic/mmu_context.h             | 77 +++++++++++++----
 include/asm-generic/nommu_context.h           | 19 +++++
 include/linux/sched/mm.h                      | 35 ++++----
 include/linux/sync_core.h                     | 21 -----
 kernel/cpu.c                                  |  6 +-
 kernel/exit.c                                 |  2 +-
 kernel/fork.c                                 | 39 +++++++++
 kernel/kthread.c                              | 12 ++-
 kernel/sched/core.c                           | 84 ++++++++++++-------
 kernel/sched/sched.h                          |  4 +-
 47 files changed, 388 insertions(+), 427 deletions(-)
 delete mode 100644 arch/x86/include/asm/sync_core.h
 create mode 100644 include/asm-generic/nommu_context.h
 delete mode 100644 include/linux/sync_core.h

--=20
2.23.0
