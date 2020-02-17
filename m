Return-Path: <SRS0=n14h=4F=kvack.org=owner-linux-mm@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 0/5] mm/vma: Use available wrappers when possible
Date: Mon, 17 Feb 2020 10:33:48 +0530
Message-ID: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200217050348.wWo-Z505yPPlkgrV8u5O-P-uC3G93fiQTiDiQoWq8nY@z>

Apart from adding a VMA flag readable name for trace purpose, this series
does some open encoding replacements with availabe VMA specific wrappers.
This skips VM_HUGETLB check in vma_migratable() as its already being done
with another patch (https://patchwork.kernel.org/patch/11347831/) which
is yet to be merged.

This series applies on 5.6-rc2. This has been build tested on multiple
platforms, though boot and runtime testing was limited to arm64 and x86.

Cc: linux-kernel@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: kvm-ppc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org

Anshuman Khandual (5):
  mm/vma: Add missing VMA flag readable name for VM_SYNC
  mm/vma: Make vma_is_accessible() available for general use
  mm/vma: Replace all remaining open encodings with is_vm_hugetlb_page()
  mm/vma: Replace all remaining open encodings with vma_set_anonymous()
  mm/vma: Replace all remaining open encodings with vma_is_anonymous()

 arch/csky/mm/fault.c              | 2 +-
 arch/m68k/mm/fault.c              | 2 +-
 arch/mips/mm/fault.c              | 2 +-
 arch/powerpc/kvm/e500_mmu_host.c  | 2 +-
 arch/powerpc/mm/fault.c           | 2 +-
 arch/sh/mm/fault.c                | 2 +-
 arch/x86/mm/fault.c               | 2 +-
 drivers/misc/mic/scif/scif_mmap.c | 2 +-
 fs/binfmt_elf.c                   | 2 +-
 include/asm-generic/tlb.h         | 2 +-
 include/linux/mm.h                | 5 +++++
 include/trace/events/mmflags.h    | 1 +
 kernel/events/core.c              | 3 ++-
 kernel/sched/fair.c               | 2 +-
 mm/gup.c                          | 5 +++--
 mm/memory.c                       | 5 -----
 mm/mempolicy.c                    | 3 +--
 17 files changed, 23 insertions(+), 21 deletions(-)

-- 
2.20.1
