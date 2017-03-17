From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/7] Switch x86 to generic get_user_pages_fast()
 implementation
Date: Fri, 17 Mar 2017 09:31:05 +0100
Message-ID: <20170317083105.GA4383@gmail.com>
References: <20170316152655.37789-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170316152655.37789-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Steve Capper <steve.capper@linaro.org>, Dann Frazier <dann.frazier@canonical.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> Hi,
> 
> The patcheset generalize mm/gup.c implementation of get_user_pages_fast()
> to be usable for x86 and switches x86 over.
> 
> Please review and consider applying.
> 
> Kirill A. Shutemov (7):
>   mm: Drop arch_pte_access_permitted() mmu hook
>   mm/gup: Move permission checks into helpers
>   mm/gup: Move page table entry dereference into helper
>   mm/gup: Make pages referenced during generic get_user_pages_fast()
>   mm/gup: Implement dev_pagemap logic in generic get_user_pages_fast()
>   mm/gup: Provide hook to check if __GUP_fast() is allowed for the range
>   x86/mm: Switch to generic get_user_page_fast() implementation
> 
>  arch/powerpc/include/asm/mmu_context.h   |   6 -
>  arch/s390/include/asm/mmu_context.h      |   6 -
>  arch/um/include/asm/mmu_context.h        |   6 -
>  arch/unicore32/include/asm/mmu_context.h |   6 -
>  arch/x86/Kconfig                         |   3 +
>  arch/x86/include/asm/mmu_context.h       |  16 -
>  arch/x86/include/asm/pgtable-3level.h    |  45 +++
>  arch/x86/include/asm/pgtable.h           |  53 ++++
>  arch/x86/include/asm/pgtable_64.h        |  16 +-
>  arch/x86/mm/Makefile                     |   2 +-
>  arch/x86/mm/gup.c                        | 496 -------------------------------
>  include/asm-generic/mm_hooks.h           |   6 -
>  include/asm-generic/pgtable.h            |  25 ++
>  include/linux/mm.h                       |   4 +
>  mm/gup.c                                 | 134 +++++++--
>  15 files changed, 262 insertions(+), 562 deletions(-)
>  delete mode 100644 arch/x86/mm/gup.c

It fails to build on x86-64 defconfig/allyesconfig/allmodconfig:

  mm/gup.c:1422:15: error: implicit declaration of function ‘pgd_devmap’ [-Werror=implicit-function-declaration]

The PowerPC allnoconfig build broke as well:

/home/mingo/tip/mm/gup.c: In function '__gup_device_huge_pmd':
/home/mingo/tip/mm/gup.c:1319:2: error: implicit declaration of function 'pmd_pfn' [-Werror=implicit-function-declaration]

Please send delta fixes, because I've already done many small readability edits to 
the patches.

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
