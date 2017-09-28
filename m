From: Richard Ruigrok <rruigrok@codeaurora.org>
Subject: Re: [RFC PATCH 0/2] Missing READ_ONCE in core and arch-specific
 pgtable code leading to crashes
Date: Thu, 28 Sep 2017 11:30:03 -0600
Message-ID: <7b9537f3-37dc-5b01-4ee0-2a350456e6d5@codeaurora.org>
References: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, peterz@infradead.org, paulmck@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com
List-Id: linux-arch.vger.kernel.org



On 9/27/2017 9:49 AM, Will Deacon wrote:
> Hi,
>
> We recently had a crash report[1] on arm64 that involved a bad dereference
> in the page_vma_mapped code during ext4 writeback with THP active. I can
> reproduce this on -rc2:
>
> [  254.032812] PC is at check_pte+0x20/0x170
> [  254.032948] LR is at page_vma_mapped_walk+0x2e0/0x540
> [...]
> [  254.036114] Process doio (pid: 2463, stack limit = 0xffff00000f2e8000)
> [  254.036361] Call trace:
> [  254.038977] [<ffff000008233328>] check_pte+0x20/0x170
> [  254.039137] [<ffff000008233758>] page_vma_mapped_walk+0x2e0/0x540
> [  254.039332] [<ffff000008234adc>] page_mkclean_one+0xac/0x278
> [  254.039489] [<ffff000008234d98>] rmap_walk_file+0xf0/0x238
> [  254.039642] [<ffff000008236e74>] rmap_walk+0x64/0xa0
> [  254.039784] [<ffff0000082370c8>] page_mkclean+0x90/0xa8
> [  254.040029] [<ffff0000081f3c64>] clear_page_dirty_for_io+0x84/0x2a8
> [  254.040311] [<ffff00000832f984>] mpage_submit_page+0x34/0x98
> [  254.040518] [<ffff00000832fb4c>] mpage_process_page_bufs+0x164/0x170
> [  254.040743] [<ffff00000832fc8c>] mpage_prepare_extent_to_map+0x134/0x2b8
> [  254.040969] [<ffff00000833530c>] ext4_writepages+0x484/0xe30
> [  254.041175] [<ffff0000081f6ab4>] do_writepages+0x44/0xe8
> [  254.041372] [<ffff0000081e5bd4>] __filemap_fdatawrite_range+0xbc/0x110
> [  254.041568] [<ffff0000081e5e68>] file_write_and_wait_range+0x48/0xd8
> [  254.041739] [<ffff000008324310>] ext4_sync_file+0x80/0x4b8
> [  254.041907] [<ffff0000082bd434>] vfs_fsync_range+0x64/0xc0
> [  254.042106] [<ffff0000082332b4>] SyS_msync+0x194/0x1e8
>
> After digging into the issue, I found that we appear to be racing with
> a concurrent pmd update in page_vma_mapped_walk, assumedly due a THP
> splitting operation. Looking at the code there:
>
> 	pvmw->pmd = pmd_offset(pud, pvmw->address);
> 	if (pmd_trans_huge(*pvmw->pmd) || is_pmd_migration_entry(*pvmw->pmd)) {
> 		[...]
> 	} else {
> 		if (!check_pmd(pvmw))
> 			return false;
> 	}
> 	if (!map_pte(pvmw))
> 		goto next_pte;
>
> what happens in the crashing scenario is that we see all zeroes for the
> PMD in pmd_trans_huge(*pvmw->pmd), and so go to the 'else' case (migration
> isn't enabled, so the test is removed at compile-time). check_pmd then does:
>
> 	pmde = READ_ONCE(*pvmw->pmd);
> 	return pmd_present(pmde) && !pmd_trans_huge(pmde);
>
> and reads a valid table entry for the PMD because the splitting has completed
> (i.e. the first dereference reads from the pmdp_invalidate in the splitting
> code, whereas the second dereferenced reads from the following pmd_populate).
> It returns true because we should descend to the PTE level in map_pte. map_pte
> does:
>
> 	pvmw->pte = pte_offset_map(pvmw->pmd, pvmw->address);
>
> which on arm64 (and this appears to be the same on x86) ends up doing:
>
> 	(pmd_page_paddr((*(pvmw->pmd))) + pte_index(pvmw->address) * sizeof(pte_t))
>
> as part of its calculation. However, this is horribly broken because GCC
> inlines everything and reuses the register it loaded for the initial
> pmd_trans_huge check (when we loaded the value of zero) here, so we end up
> calculating a junk pointer and crashing when we dereference it. Disassembly
> at the end of the mail[2] for those who are curious.
>
> The moral of the story is that read-after-read (same address) ordering *only*
> applies if READ_ONCE is used consistently. This means we need to fix page
> table dereferences in the core code as well as the arch code to avoid this
> problem. The two RFC patches in this series fix arm64 (which is a bigger fix
> that necessary since I clean things up too) and page_vma_mapped_walk.
>
> Comments welcome.
Hi Will,
This fix works for me, tested with LTP rwtest 15 iterations on Qualcomm Centiq2400.
Compiler: gcc version 5.2.1 20151005 (Linaro GCC 5.2-2015.11-1)

Tested-by: Richard Ruigrok <rruigrok@codeaurora.org>

Thanks,
Richard
> Will
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-September/532786.html
> [2]
>
> // page_vma_mapped_walk
> // pvmw->pmd = pmd_offset(pud, pvmw->address);
> ldr     x0, [x19, #24]		// pvmw->pmd
>
> // if (pmd_trans_huge(*pvmw->pmd) || is_pmd_migration_entry(*pvmw->pmd)) {
> ldr     x1, [x0]		// *pvmw->pmd
> cbz     x1, ffff0000082336a0 <page_vma_mapped_walk+0x228>
> tbz     w1, #1, ffff000008233788 <page_vma_mapped_walk+0x310>	// pmd_trans_huge?
>
> // else if (!check_pmd(pvmw))
> ldr     x0, [x0]		// READ_ONCE in check_pmd
> tst     x0, x24			// pmd_present?
> b.eq    ffff000008233538 <page_vma_mapped_walk+0xc0>  // b.none
> tbz     w0, #1, ffff000008233538 <page_vma_mapped_walk+0xc0>	// pmd_trans_huge?
>
> // if (!map_pte(pvmw))
> ldr     x0, [x19, #16]		// pvmw->address
>
> // pvmw->pte = pte_offset_map(pvmw->pmd, pvmw->address);
> and     x1, x1, #0xfffffffff000	// Reusing the old value of *pvmw->pmd!!!
> [...]
>
> --->8
>
> Will Deacon (2):
>   arm64: mm: Use READ_ONCE/WRITE_ONCE when accessing page tables
>   mm: page_vma_mapped: Ensure pmd is loaded with READ_ONCE outside of
>     lock
>
>  arch/arm64/include/asm/hugetlb.h     |   2 +-
>  arch/arm64/include/asm/kvm_mmu.h     |  18 +--
>  arch/arm64/include/asm/mmu_context.h |   4 +-
>  arch/arm64/include/asm/pgalloc.h     |  42 +++---
>  arch/arm64/include/asm/pgtable.h     |  29 ++--
>  arch/arm64/kernel/hibernate.c        | 148 +++++++++---------
>  arch/arm64/mm/dump.c                 |  54 ++++---
>  arch/arm64/mm/fault.c                |  44 +++---
>  arch/arm64/mm/hugetlbpage.c          |  94 ++++++------
>  arch/arm64/mm/kasan_init.c           |  62 ++++----
>  arch/arm64/mm/mmu.c                  | 281 ++++++++++++++++++-----------------
>  arch/arm64/mm/pageattr.c             |  30 ++--
>  mm/page_vma_mapped.c                 |  25 ++--
>  13 files changed, 427 insertions(+), 406 deletions(-)
>

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
