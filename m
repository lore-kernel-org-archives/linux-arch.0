Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3607 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdCQS4o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Mar 2017 14:56:44 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/6] x86: 5-level paging enabling for v4.12, Part 2
Date: Fri, 17 Mar 2017 21:55:09 +0300
Message-ID: <20170317185515.8636-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170317185509.5Cw2Czq0-A_7oQZc6LTVU5lRO0EEKfccf1lIhG3Iy9o@z>

Here's the second bunch of patches of 5-level patchset.

These patches finish switching x86 from <asm-generic/5level-fixup.h>
to <asm-generic/pgtable-nop4d.h>.

Please review and consider applying.

Kirill A. Shutemov (6):
  x86/kexec: Add 5-level paging support
  x86/efi: Add 5-level paging support
  x86/mm/pat: Add 5-level paging support
  x86/kasan: Prepare clear_pgds() to switch to
    <asm-generic/pgtable-nop4d.h>
  x86/xen: Change __xen_pgd_walk() and xen_cleanmfnmap() to support p4d
  x86: Convert the rest of the code to support p4d_t

 arch/x86/include/asm/kexec.h          |   1 +
 arch/x86/include/asm/paravirt.h       |  33 ++-
 arch/x86/include/asm/paravirt_types.h |  12 +-
 arch/x86/include/asm/pgalloc.h        |  35 ++-
 arch/x86/include/asm/pgtable.h        |  59 ++++-
 arch/x86/include/asm/pgtable_64.h     |  12 +-
 arch/x86/include/asm/pgtable_types.h  |  10 +-
 arch/x86/include/asm/xen/page.h       |   8 +-
 arch/x86/kernel/machine_kexec_32.c    |   4 +-
 arch/x86/kernel/machine_kexec_64.c    |  14 +-
 arch/x86/kernel/paravirt.c            |  10 +-
 arch/x86/mm/init_64.c                 | 183 ++++++++++++----
 arch/x86/mm/kasan_init_64.c           |  15 +-
 arch/x86/mm/pageattr.c                |  54 +++--
 arch/x86/platform/efi/efi_64.c        |  36 ++-
 arch/x86/xen/mmu.c                    | 397 ++++++++++++++++++++--------------
 arch/x86/xen/mmu.h                    |   1 +
 include/trace/events/xen.h            |  28 +--
 18 files changed, 646 insertions(+), 266 deletions(-)

-- 
2.11.0
