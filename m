Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49758 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdC0QaN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Mar 2017 12:30:13 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/8] x86: 5-level paging enabling for v4.12, Part 3
Date: Mon, 27 Mar 2017 19:29:17 +0300
Message-ID: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170327162917.t_oW7ZQ_RXbIXLU4FGfM20oiCaQKoKPgQsCrZStihOE@z>

Here's the third bunch of patches of 5-level patchset.

This time we prepare code to handle non-folded version of the additional page
table level.

Kirill A. Shutemov (8):
  x86/boot: Detect 5-level paging support
  x86/asm: Remove __VIRTUAL_MASK_SHIFT==47 assert
  x86/mm: Define virtual memory map for 5-level paging
  x86/paravirt: Make paravirt code support 5-level paging
  x86/mm: Add basic defines/helpers for CONFIG_X86_5LEVEL
  x86/dump_pagetables: Add support 5-level paging
  x86/kasan: Extend to support 5-level paging
  x86/espfix: Add support 5-level paging

 Documentation/x86/x86_64/mm.txt          | 33 +++++++++++++++++++--
 arch/x86/Kconfig                         |  1 +
 arch/x86/boot/cpucheck.c                 |  9 ++++++
 arch/x86/boot/cpuflags.c                 | 12 ++++++--
 arch/x86/entry/entry_64.S                |  7 ++---
 arch/x86/include/asm/disabled-features.h |  8 +++++-
 arch/x86/include/asm/kasan.h             |  9 ++++--
 arch/x86/include/asm/page_64_types.h     | 10 +++++++
 arch/x86/include/asm/paravirt.h          | 37 +++++++++++++++++-------
 arch/x86/include/asm/paravirt_types.h    |  7 ++++-
 arch/x86/include/asm/pgalloc.h           |  2 ++
 arch/x86/include/asm/pgtable_64.h        | 11 +++++++
 arch/x86/include/asm/pgtable_64_types.h  | 26 +++++++++++++++++
 arch/x86/include/asm/pgtable_types.h     | 10 ++++++-
 arch/x86/include/asm/required-features.h |  8 +++++-
 arch/x86/include/asm/sparsemem.h         |  9 ++++--
 arch/x86/kernel/espfix_64.c              | 12 ++++----
 arch/x86/kernel/paravirt.c               |  9 ++++--
 arch/x86/mm/dump_pagetables.c            | 49 +++++++++++++++++++++++++++-----
 arch/x86/mm/kasan_init_64.c              | 18 ++++++++++--
 arch/x86/mm/pgtable.c                    | 34 +++++++++++++++++++++-
 21 files changed, 274 insertions(+), 47 deletions(-)

-- 
2.11.0
