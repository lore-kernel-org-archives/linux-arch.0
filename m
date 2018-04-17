From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Tue, 17 Apr 2018 15:55:08 +0530
Message-ID: <b2ea9760-cad4-8f30-98ac-86a04c4d42a4@codeaurora.org>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, tglx@linutronix.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Ping...

On 4/3/2018 1:30 PM, Chintan Pandya wrote:
> This series of patches are follow up work (and depends on)
> Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
> panic in ioremap huge pages".
> 
> This series of patches are tested on 4.9 kernel with Cortex-A75
> based SoC.
> 
> These patches can also go into '-stable' branch (if accepted)
> for 4.6 onwards.
> 
>  From V7->V8:
>   - Properly fixed compilation issue in x86 file
> 
>  From V6->V7:
>   - Fixed compilation issue in x86 case
>   - V6 patches were not properly enumarated
> 
>  From V5->V6:
>   - Use __flush_tlb_kernel_pgtable() for both PUD and PMD. Remove
>     "bool tlb_inv" based variance as it is not need now
>   - Re-naming for consistency
> 
>  From V4->V5:
>   - Add new API __flush_tlb_kernel_pgtable(unsigned long addr)
>     for kernel addresses
> 
>  From V3->V4:
>   - Add header for 'addr' in x86 implementation
>   - Re-order pmd/pud clear and table free
>   - Avoid redundant TLB invalidatation in one perticular case
> 
>  From V2->V3:
>   - Use the exisiting page table free interface to do arm64
>     specific things
> 
>  From V1->V2:
>   - Rebased my patches on top of "[PATCH v2 1/2] mm/vmalloc:
>     Add interfaces to free unmapped page table"
>   - Honored BBM for ARM64
> 
> Chintan Pandya (4):
>    ioremap: Update pgtable free interfaces with addr
>    arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
>    arm64: Implement page table free interfaces
>    Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
> 
>   arch/arm64/include/asm/tlbflush.h |  6 ++++++
>   arch/arm64/mm/mmu.c               | 37 +++++++++++++++++++++++++------------
>   arch/x86/mm/pgtable.c             |  8 +++++---
>   include/asm-generic/pgtable.h     |  8 ++++----
>   lib/ioremap.c                     |  4 ++--
>   5 files changed, 42 insertions(+), 21 deletions(-)
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
