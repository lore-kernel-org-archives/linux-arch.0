Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36863 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933068AbdC3IHk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Mar 2017 04:07:40 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 0/7] x86: 5-level paging enabling for v4.12, Part 3
Date: Thu, 30 Mar 2017 11:07:24 +0300
Message-ID: <20170330080731.65421-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170330080724.A4Hsiax-jcLN6U9ZfpgID8pSpO6Kcy84L3uwutr-MwU@z>

Here's the third bunch of patches of 5-level patchset.

This time we prepare code to handle non-folded version of the additional page
table level.

v3:
 - rebased onto tip/master;
v2:
 - address Ingo's and Peter's feedback;

Kirill A. Shutemov (7):
  x86/boot: Detect 5-level paging support
  x86/asm: Remove __VIRTUAL_MASK_SHIFT==47 assert
  x86/mm: Define virtual memory map for 5-level paging
  x86/paravirt: Make paravirt code support 5-level paging
  x86/mm: Add basic defines/helpers for CONFIG_X86_5LEVEL
  x86/kasan: Extend to support 5-level paging
  x86/espfix: Add support 5-level paging

 Documentation/x86/x86_64/mm.txt          | 33 +++++++++++++++++++++++++---
 arch/x86/Kconfig                         |  1 +
 arch/x86/boot/cpucheck.c                 |  9 ++++++++
 arch/x86/boot/cpuflags.c                 | 12 +++++++++--
 arch/x86/entry/entry_64.S                |  7 ++----
 arch/x86/include/asm/disabled-features.h |  8 ++++++-
 arch/x86/include/asm/kasan.h             |  9 +++++---
 arch/x86/include/asm/page_64_types.h     | 10 +++++++++
 arch/x86/include/asm/paravirt.h          | 37 ++++++++++++++++++++++----------
 arch/x86/include/asm/paravirt_types.h    |  7 +++++-
 arch/x86/include/asm/pgalloc.h           |  2 ++
 arch/x86/include/asm/pgtable_64.h        | 11 ++++++++++
 arch/x86/include/asm/pgtable_64_types.h  | 28 +++++++++++++++++++++++-
 arch/x86/include/asm/pgtable_types.h     | 10 ++++++++-
 arch/x86/include/asm/required-features.h |  8 ++++++-
 arch/x86/include/asm/sparsemem.h         |  9 ++++++--
 arch/x86/kernel/espfix_64.c              | 12 ++++++-----
 arch/x86/kernel/paravirt.c               |  9 ++++++--
 arch/x86/mm/kasan_init_64.c              | 18 ++++++++++++++--
 arch/x86/mm/pgtable.c                    | 32 ++++++++++++++++++++++++++-
 20 files changed, 231 insertions(+), 41 deletions(-)

-- 
2.11.0
