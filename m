Return-Path: <SRS0=as/e=4M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:57634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgBXFDh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 00:03:37 -0500
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V2 0/4] mm/vma: Use all available wrappers when possible
Date: Mon, 24 Feb 2020 10:33:09 +0530
Message-ID: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200224050309.hBzLfdpqTYl7YnU44ibWeqn_XaTmAl-rqyT-dReXUJA@z>

Apart from adding a VMA flag readable name for trace purpose, this series
does some open encoding replacements with availabe VMA specific wrappers.
This skips VM_HUGETLB check in vma_migratable() as its already being done
with another patch (https://patchwork.kernel.org/patch/11347831/) which
is yet to be merged.

This series applies on 5.6-rc3. This has been build tested on multiple
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

Changes in V2:

- Dropped patch [PATCH 4/5] mm/vma: Replace....vma_set_anonymous() per Kirril
- Dropped braces around is_vm_hugetlb_page() in kvmppc_e500_shadow_map()
- Replaced two open encodings in mm/mmap.c with vma_is_accessible()
- Added hugetlb headers to prevent build failures wrt is_vm_hugetlb_page()

Changes in V1: (https://patchwork.kernel.org/cover/11385219/)

Anshuman Khandual (4):
  mm/vma: Add missing VMA flag readable name for VM_SYNC
  mm/vma: Make vma_is_accessible() available for general use
  mm/vma: Replace all remaining open encodings with is_vm_hugetlb_page()
  mm/vma: Replace all remaining open encodings with vma_is_anonymous()

 arch/csky/mm/fault.c             | 2 +-
 arch/m68k/mm/fault.c             | 2 +-
 arch/mips/mm/fault.c             | 2 +-
 arch/powerpc/kvm/e500_mmu_host.c | 2 +-
 arch/powerpc/mm/fault.c          | 2 +-
 arch/sh/mm/fault.c               | 2 +-
 arch/x86/mm/fault.c              | 2 +-
 fs/binfmt_elf.c                  | 3 ++-
 include/asm-generic/tlb.h        | 3 ++-
 include/linux/mm.h               | 5 +++++
 include/trace/events/mmflags.h   | 1 +
 kernel/events/core.c             | 3 ++-
 kernel/sched/fair.c              | 2 +-
 mm/gup.c                         | 5 +++--
 mm/memory.c                      | 5 -----
 mm/mempolicy.c                   | 3 +--
 mm/mmap.c                        | 5 ++---
 17 files changed, 26 insertions(+), 23 deletions(-)

-- 
2.20.1
