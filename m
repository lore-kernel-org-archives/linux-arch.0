Return-Path: <SRS0=YdXP=AO=kvack.org=owner-linux-mm@kernel.org>
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v6 00/26]  arm64: Memory Tagging Extension user-space support
Date: Fri,  3 Jul 2020 16:36:52 +0100
Message-ID: <20200703153718.16973-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200703153652.OtItrH4nXmFODYLzuC27xefD56OJKPOt3DwfH36UIM4@z>

This is version 6 (5th version here [1]) of the series adding user-space
support for the ARMv8.5 Memory Tagging Extension ([2], [3]). The patches
are also available on this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/mte

There are no ABI changes since v4/v5. I'll push these patches into
linux-next for wider coverage, aiming for merging into 5.9. There are
still some acks needed on the core mm and fs patches in the series.
Thanks for the review/acks on v5.

An important note, patch 7 introduces a core mm change to
__split_huge_page_tail() so that it transfers the PG_arch_* flags from
the head page to the tail ones. My understanding is that it shouldn't
break anything but a more informed opinion from the mm folk is needed.

Changes in this version:

- __split_huge_page_tail() function update to preserve the PG_arch_*
  flags.

- copy_mount_options() simplified with a fall-back to byte-by-byte
  copying. It turns out we arm64 can't guarantee an exact
  copy_from_user() with intra-page (tag) faults.

- Dropped CONFIG_ARCH_USES_PG_ARCH_2 in favour of simply guarding
  PG_arch_2 by CONFIG_64BIT.

- Added comments on where the new arch_swap_* and __HAVE_ARCH_SWAP_*
  macros should be defined by the arch code if they need to be
  overridden.

- Fixed broken rebase conflict resolution in v5 re-introducing
  asm-generic/pgtable.h.

- Added the acks received so far.

[1] https://lore.kernel.org/linux-arm-kernel/20200624175244.25837-1-catal=
in.marinas@arm.com/
[2] https://community.arm.com/developer/ip-products/processors/b/processo=
rs-ip-blog/posts/enhancing-memory-safety
[3] https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Arm=
_Memory_Tagging_Extension_Whitepaper.pdf
[4] https://sourceware.org/pipermail/libc-alpha/2020-June/115039.html

Catalin Marinas (14):
  arm64: mte: Use Normal Tagged attributes for the linear map
  mm: Preserve the PG_arch_* flags in __split_huge_page_tail()
  arm64: mte: Clear the tags when a page is mapped in user-space with
    PROT_MTE
  arm64: Avoid unnecessary clear_user_page() indirection
  arm64: mte: Tags-aware aware memcmp_pages() implementation
  arm64: mte: Add PROT_MTE support to mmap() and mprotect()
  mm: Introduce arch_validate_flags()
  arm64: mte: Validate the PROT_MTE request via arch_validate_flags()
  mm: Allow arm64 mmap(PROT_MTE) on RAM-based files
  arm64: mte: Allow user control of the tag check mode via prctl()
  arm64: mte: Allow user control of the generated random tags via
    prctl()
  arm64: mte: Restore the GCR_EL1 register after a suspend
  arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS support
  fs: Handle intra-page faults in copy_mount_options()

Kevin Brodsky (1):
  mm: Introduce arch_calc_vm_flag_bits()

Steven Price (4):
  mm: Add PG_arch_2 page flag
  mm: Add arch hooks for saving/restoring tags
  arm64: mte: Enable swap of tagged pages
  arm64: mte: Save tags when hibernating

Vincenzo Frascino (7):
  arm64: mte: system register definitions
  arm64: mte: CPU feature detection and initial sysreg configuration
  arm64: mte: Add specific SIGSEGV codes
  arm64: mte: Handle synchronous and asynchronous tag check faults
  arm64: mte: Tags-aware copy_{user_,}highpage() implementations
  arm64: mte: Kconfig entry
  arm64: mte: Add Memory Tagging Extension documentation

 Documentation/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arm64/elf_hwcaps.rst            |   4 +
 Documentation/arm64/index.rst                 |   1 +
 .../arm64/memory-tagging-extension.rst        | 297 ++++++++++++++++
 arch/arm64/Kconfig                            |  28 ++
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_arm.h              |   3 +-
 arch/arm64/include/asm/memory.h               |  17 +-
 arch/arm64/include/asm/mman.h                 |  56 ++-
 arch/arm64/include/asm/mte.h                  |  86 +++++
 arch/arm64/include/asm/page.h                 |  19 +-
 arch/arm64/include/asm/pgtable-prot.h         |   2 +
 arch/arm64/include/asm/pgtable.h              |  46 ++-
 arch/arm64/include/asm/processor.h            |   4 +
 arch/arm64/include/asm/sysreg.h               |  61 ++++
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/include/uapi/asm/mman.h            |   1 +
 arch/arm64/include/uapi/asm/ptrace.h          |   4 +
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/cpufeature.c                |  61 ++++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/entry.S                     |  37 ++
 arch/arm64/kernel/hibernate.c                 | 118 +++++++
 arch/arm64/kernel/mte.c                       | 331 ++++++++++++++++++
 arch/arm64/kernel/process.c                   |  31 +-
 arch/arm64/kernel/ptrace.c                    |   9 +-
 arch/arm64/kernel/signal.c                    |   9 +
 arch/arm64/kernel/suspend.c                   |   4 +
 arch/arm64/kernel/syscall.c                   |  10 +
 arch/arm64/lib/Makefile                       |   2 +
 arch/arm64/lib/mte.S                          | 151 ++++++++
 arch/arm64/mm/Makefile                        |   1 +
 arch/arm64/mm/copypage.c                      |  25 +-
 arch/arm64/mm/dump.c                          |   4 +
 arch/arm64/mm/fault.c                         |   9 +-
 arch/arm64/mm/mmu.c                           |  22 +-
 arch/arm64/mm/mteswap.c                       |  83 +++++
 arch/arm64/mm/proc.S                          |   8 +-
 arch/x86/kernel/signal_compat.c               |   2 +-
 fs/namespace.c                                |  25 +-
 fs/proc/page.c                                |   3 +
 fs/proc/task_mmu.c                            |   4 +
 include/linux/kernel-page-flags.h             |   1 +
 include/linux/mm.h                            |   8 +
 include/linux/mman.h                          |  23 +-
 include/linux/page-flags.h                    |   3 +
 include/linux/pgtable.h                       |  28 ++
 include/trace/events/mmflags.h                |   9 +-
 include/uapi/asm-generic/siginfo.h            |   4 +-
 include/uapi/linux/prctl.h                    |   9 +
 mm/huge_memory.c                              |   4 +
 mm/mmap.c                                     |   9 +
 mm/mprotect.c                                 |   6 +
 mm/page_io.c                                  |  10 +
 mm/shmem.c                                    |   9 +
 mm/swapfile.c                                 |   2 +
 mm/util.c                                     |   2 +-
 tools/vm/page-types.c                         |   2 +
 61 files changed, 1678 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/arm64/memory-tagging-extension.rst
 create mode 100644 arch/arm64/include/asm/mte.h
 create mode 100644 arch/arm64/kernel/mte.c
 create mode 100644 arch/arm64/lib/mte.S
 create mode 100644 arch/arm64/mm/mteswap.c
