From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [HELP-NEEDED, PATCH 0/3] Do not loose dirty bit on THP pages
Date: Wed, 14 Jun 2017 16:51:40 +0300
Message-ID: <20170614135143.25068-1-kirill.shutemov@linux.intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:50513 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbdFNNwC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jun 2017 09:52:02 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Hi,

Vlastimil noted that pmdp_invalidate() is not atomic and we can loose
dirty and access bits if CPU sets them after pmdp dereference, but
before set_pmd_at().

The bug doesn't lead to user-visible misbehaviour in current kernel, but
fixing this would be critical for future work on THP: both huge-ext4 and THP
swap out rely on proper dirty tracking.

Unfortunately, there's no way to address the issue in a generic way. We need to
fix all architectures that support THP one-by-one.

All architectures that have THP supported have to provide atomic
pmdp_invalidate(). If generic implementation of pmdp_invalidate() is used,
architecture needs to provide atomic pmdp_mknonpresent().

I've fixed the issue for x86, but I need help with the rest.

So far THP is supported on 8 architectures. Power and S390 already provides
atomic pmdp_invalidate(). x86 is fixed by this patches, so 5 architectures
left:

 - arc;
 - arm;
 - arm64;
 - mips;
 - sparc -- it has custom pmdp_invalidate(), but it's racy too;

Please, help me with them.

Kirill A. Shutemov (3):
  x86/mm: Provide pmdp_mknotpresent() helper
  mm: Do not loose dirty and access bits in pmdp_invalidate()
  mm, thp: Do not loose dirty bit in __split_huge_pmd_locked()

 arch/x86/include/asm/pgtable-3level.h | 17 +++++++++++++++++
 arch/x86/include/asm/pgtable.h        | 13 +++++++++++++
 mm/huge_memory.c                      | 13 +++++++++----
 mm/pgtable-generic.c                  |  3 +--
 4 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.11.0
