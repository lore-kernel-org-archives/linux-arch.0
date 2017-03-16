Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:63446 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752849AbdCPP1w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Mar 2017 11:27:52 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/7] Switch x86 to generic get_user_pages_fast() implementation
Date: Thu, 16 Mar 2017 18:26:48 +0300
Message-ID: <20170316152655.37789-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Steve Capper <steve.capper@linaro.org>, Dann Frazier <dann.frazier@canonical.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170316152648.TKHVhapLLE6QNJXOKodmkE9dWUoHymFzmn-gb5HTqTo@z>

Hi,

The patcheset generalize mm/gup.c implementation of get_user_pages_fast()
to be usable for x86 and switches x86 over.

Please review and consider applying.

Kirill A. Shutemov (7):
  mm: Drop arch_pte_access_permitted() mmu hook
  mm/gup: Move permission checks into helpers
  mm/gup: Move page table entry dereference into helper
  mm/gup: Make pages referenced during generic get_user_pages_fast()
  mm/gup: Implement dev_pagemap logic in generic get_user_pages_fast()
  mm/gup: Provide hook to check if __GUP_fast() is allowed for the range
  x86/mm: Switch to generic get_user_page_fast() implementation

 arch/powerpc/include/asm/mmu_context.h   |   6 -
 arch/s390/include/asm/mmu_context.h      |   6 -
 arch/um/include/asm/mmu_context.h        |   6 -
 arch/unicore32/include/asm/mmu_context.h |   6 -
 arch/x86/Kconfig                         |   3 +
 arch/x86/include/asm/mmu_context.h       |  16 -
 arch/x86/include/asm/pgtable-3level.h    |  45 +++
 arch/x86/include/asm/pgtable.h           |  53 ++++
 arch/x86/include/asm/pgtable_64.h        |  16 +-
 arch/x86/mm/Makefile                     |   2 +-
 arch/x86/mm/gup.c                        | 496 -------------------------------
 include/asm-generic/mm_hooks.h           |   6 -
 include/asm-generic/pgtable.h            |  25 ++
 include/linux/mm.h                       |   4 +
 mm/gup.c                                 | 134 +++++++--
 15 files changed, 262 insertions(+), 562 deletions(-)
 delete mode 100644 arch/x86/mm/gup.c

-- 
2.11.0
