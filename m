From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v9 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Mon, 30 Apr 2018 13:11:30 +0530
Message-ID: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Philip Elcan <pelcan@codeaurora.org>, James Morse <james.morse@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>, Toshi Kani <toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

This series of patches takes Toshi Kani <toshi.kani@hpe.com>'s
patches ("fix memory leak/panic in ioremap huge pages") as base
and re-bring huge_vmap back for arm64.

This series of patches are tested on 4.16 kernel with Cortex-A75
based SoC.

The test used for verifying these patches is a stress test on
ioremap/unmap which tries to re-use same io-address but changes
size of mapping randomly i.e. 4K to 2M to 16K etc. The same test
used to reproduce 3rd level translation fault without these fixes
(and also of course with Revert "arm64: Enforce BBM for huge IO/VMAP
mappings" being part of the tree).

These patches can also go into '-stable' branch (if accepted)
for 4.6 onwards.

From V8->V9:
 - Used __TLBI_VADDR macros in new TLB flush API

From V7->V8:
 - Properly fixed compilation issue in x86 file

From V6->V7:
 - Fixed compilation issue in x86 case
 - V6 patches were not properly enumarated

From V5->V6:
 - Use __flush_tlb_kernel_pgtable() for both PUD and PMD. Remove
   "bool tlb_inv" based variance as it is not need now
 - Re-naming for consistency

From V4->V5:
 - Add new API __flush_tlb_kernel_pgtable(unsigned long addr)
   for kernel addresses

From V3->V4:
 - Add header for 'addr' in x86 implementation
 - Re-order pmd/pud clear and table free
 - Avoid redundant TLB invalidatation in one perticular case

From V2->V3:
 - Use the exisiting page table free interface to do arm64
   specific things

From V1->V2:
 - Rebased my patches on top of "[PATCH v2 1/2] mm/vmalloc:
   Add interfaces to free unmapped page table"
 - Honored BBM for ARM64

Chintan Pandya (4):
  ioremap: Update pgtable free interfaces with addr
  arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
  arm64: Implement page table free interfaces
  Revert "arm64: Enforce BBM for huge IO/VMAP mappings"

 arch/arm64/include/asm/tlbflush.h |  6 ++++++
 arch/arm64/mm/mmu.c               | 37 +++++++++++++++++++++++++------------
 arch/x86/mm/pgtable.c             |  8 +++++---
 include/asm-generic/pgtable.h     |  8 ++++----
 lib/ioremap.c                     |  4 ++--
 5 files changed, 42 insertions(+), 21 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
