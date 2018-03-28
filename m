Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeC1MKf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Mar 2018 08:10:35 -0400
Subject: Re: [PATCH v6 0/4] Fix issues with huge mapping in ioremap for ARM64
References: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <f0b3057e-dc8c-d0ef-cffb-87b0f01c80aa@codeaurora.org>
Date: Wed, 28 Mar 2018 17:40:26 +0530
MIME-Version: 1.0
In-Reply-To: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Message-ID: <20180328121026.z8sHENn-tFLTqAhFBzO7N4KIOegaPvQt-qJrxwk1vZQ@z>

I goofed up in making a patch file so enumeration is wrong.
I'll upload v7

On 3/28/2018 4:28 PM, Chintan Pandya wrote:
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
>   arch/x86/mm/pgtable.c             |  6 ++++--
>   include/asm-generic/pgtable.h     |  8 ++++----
>   lib/ioremap.c                     |  4 ++--
>   5 files changed, 41 insertions(+), 20 deletions(-)
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
