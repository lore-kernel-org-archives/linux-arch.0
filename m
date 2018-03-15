From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Thu, 15 Mar 2018 18:15:02 +0530
Message-ID: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com, Chintan Pandya <cpandya@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

These series of patches are follow up work (and depends on)
Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
panic in ioremap huge pages".

IOREMAP code has been touched up to honor BBM which is
requirement for some arch (like arm64) and works well
with all other.

Chintan Pandya (4):
  asm/tlbflush: Add flush_tlb_pgtable() for ARM64
  ioremap: Implement TLB_INV before huge mapping
  arm64: Implement page table free interfaces
  Revert "arm64: Enforce BBM for huge IO/VMAP mappings"

From V1->V2:
 - Rebased my patches on top of "[PATCH v2 1/2] mm/vmalloc:
 Add interfaces to free unmapped page table"
 - Honored BBM for ARM64

 arch/arm64/include/asm/tlbflush.h |  5 +++++
 arch/arm64/mm/mmu.c               | 28 ++++++++++++++++++----------
 include/asm-generic/tlb.h         |  6 ++++++
 lib/ioremap.c                     | 25 +++++++++++++++++++------
 4 files changed, 48 insertions(+), 16 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
