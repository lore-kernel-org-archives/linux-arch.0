From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level paging
Date: Thu, 25 May 2017 23:33:26 +0300
Message-ID: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28477 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966442AbdEYUd4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 May 2017 16:33:56 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Here' my first attempt to bring boot-time between 4- and 5-level paging.
It looks not too terrible to me. I've expected it to be worse.

The basic idea is to implement the same logic as pgtable-nop4d.h provides,
but at runtime.

Runtime folding is only implemented for CONFIG_X86_5LEVEL=y case. With the
option disabled, we do compile-time folding.

Initially, I tried to fold pgd instread. I've got to shell, but it
required a lot of hacks as kernel threats pgd in a special way.

Few things are broken (see patch 7/8) and many things are not yet tested.
So more work is required.

I also haven't evaluated performance impact. We can look into some form of
boot-time code patching later if required.

Please review. Any feedback is welcome.

Kirill A. Shutemov (8):
  x86/boot/compressed/64: Detect and handle 5-level paging at boot-time
  x86/mm: Make virtual memory layout movable for CONFIG_X86_5LEVEL
  x86/mm: Make PGDIR_SHIFT and PTRS_PER_P4D variable
  x86/mm: Handle boot-time paging mode switching at early boot
  x86/mm: Fold p4d page table layer at runtime
  x86/mm: Replace compile-time checks for 5-level with runtime-time
  x86/mm: Hacks for boot-time switching between 4- and 5-level paging
  x86/mm: Allow to boot without la57 if CONFIG_X86_5LEVEL=y

 arch/x86/Kconfig                         |  4 +-
 arch/x86/boot/compressed/head_64.S       | 37 ++++++++++++++++++
 arch/x86/entry/entry_64.S                |  5 +++
 arch/x86/include/asm/kaslr.h             |  4 --
 arch/x86/include/asm/page_64.h           |  4 ++
 arch/x86/include/asm/page_64_types.h     | 15 +++-----
 arch/x86/include/asm/paravirt.h          |  3 +-
 arch/x86/include/asm/pgalloc.h           |  5 ++-
 arch/x86/include/asm/pgtable.h           | 10 ++++-
 arch/x86/include/asm/pgtable_32.h        |  2 +
 arch/x86/include/asm/pgtable_64_types.h  | 46 ++++++++++++++--------
 arch/x86/include/asm/processor.h         |  2 +-
 arch/x86/include/asm/required-features.h |  8 +---
 arch/x86/kernel/head64.c                 | 66 ++++++++++++++++++++++++++++----
 arch/x86/kernel/head_64.S                | 22 +++++++----
 arch/x86/mm/dump_pagetables.c            | 11 ++----
 arch/x86/mm/ident_map.c                  |  2 +-
 arch/x86/mm/init_64.c                    | 30 +++++++++------
 arch/x86/mm/kaslr.c                      | 16 ++------
 arch/x86/platform/efi/efi_64.c           |  4 +-
 arch/x86/power/hibernate_64.c            |  4 +-
 arch/x86/xen/Kconfig                     |  2 +-
 arch/x86/xen/mmu_pv.c                    |  2 +-
 23 files changed, 208 insertions(+), 96 deletions(-)

-- 
2.11.0
