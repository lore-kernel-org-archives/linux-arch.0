From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v4 0/3] Fix issues with huge mapping in ioremap for ARM64
Date: Tue, 20 Mar 2018 17:15:11 +0530
Message-ID: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com, Chintan Pandya <cpandya@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

This series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

This series of patches are tested on 4.9 kernel with Cortex-A75
based SoC.

Chintan Pandya (3):
  ioremap: Update pgtable free interfaces with addr
  arm64: Implement page table free interfaces
  Revert "arm64: Enforce BBM for huge IO/VMAP mappings"

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

 arch/arm64/mm/mmu.c           | 51 +++++++++++++++++++++++++++++++++----------
 arch/x86/mm/pgtable.c         |  6 +++--
 include/asm-generic/pgtable.h |  8 +++----
 lib/ioremap.c                 |  4 ++--
 4 files changed, 49 insertions(+), 20 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
