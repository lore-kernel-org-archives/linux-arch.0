Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55584 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbfBSKdQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 05:33:16 -0500
Message-ID: <20190219103148.192029670@infradead.org>
Date: Tue, 19 Feb 2019 11:31:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 00/18] generic mmu_gather patches
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Message-ID: <20190219103148.IDPTxeIQYr9qtabspszyXfi4QPziuIy3Nw6UL17lTlo@z>

Hi all,

Sorry I haven't posted these in a while, I sorta forgot about them for a little.

Not much changed since last time; one change to the ARM patch as suggested by
Will and a fresh Changelog for patch 12 as requested by Vineet. And some
trivial rebasing of the s390 bits.

They've sat in my queue.git for a while and 0-day hasn't reported anything
funny with them.

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git mm/tlb

I'm thinking this is about ready to go.

---
 arch/Kconfig                      |   8 +-
 arch/alpha/Kconfig                |   1 +
 arch/alpha/include/asm/tlb.h      |   6 -
 arch/arc/include/asm/tlb.h        |  32 -----
 arch/arm/include/asm/tlb.h        | 255 ++-------------------------------
 arch/arm64/Kconfig                |   1 -
 arch/arm64/include/asm/tlb.h      |   1 +
 arch/c6x/Kconfig                  |   1 +
 arch/c6x/include/asm/tlb.h        |   2 -
 arch/h8300/include/asm/tlb.h      |   2 -
 arch/hexagon/include/asm/tlb.h    |  12 --
 arch/ia64/include/asm/tlb.h       | 257 +---------------------------------
 arch/ia64/include/asm/tlbflush.h  |  25 ++++
 arch/ia64/mm/tlb.c                |  23 ++-
 arch/m68k/Kconfig                 |   1 +
 arch/m68k/include/asm/tlb.h       |  14 --
 arch/microblaze/Kconfig           |   1 +
 arch/microblaze/include/asm/tlb.h |   9 --
 arch/mips/include/asm/tlb.h       |  17 ---
 arch/nds32/include/asm/tlb.h      |  16 ---
 arch/nios2/Kconfig                |   1 +
 arch/nios2/include/asm/tlb.h      |  14 +-
 arch/openrisc/Kconfig             |   1 +
 arch/openrisc/include/asm/tlb.h   |   8 +-
 arch/parisc/include/asm/tlb.h     |  18 ---
 arch/powerpc/Kconfig              |   2 +
 arch/powerpc/include/asm/tlb.h    |  18 +--
 arch/riscv/include/asm/tlb.h      |   1 +
 arch/s390/Kconfig                 |   2 +
 arch/s390/include/asm/tlb.h       | 130 ++++++-----------
 arch/s390/mm/pgalloc.c            |  63 +--------
 arch/sh/include/asm/pgalloc.h     |   9 ++
 arch/sh/include/asm/tlb.h         | 132 +----------------
 arch/sparc/Kconfig                |   1 +
 arch/sparc/include/asm/tlb_32.h   |  18 ---
 arch/um/include/asm/tlb.h         | 158 +--------------------
 arch/unicore32/Kconfig            |   1 +
 arch/unicore32/include/asm/tlb.h  |   7 +-
 arch/x86/Kconfig                  |   1 -
 arch/x86/include/asm/tlb.h        |   1 +
 arch/xtensa/include/asm/tlb.h     |  26 ----
 include/asm-generic/tlb.h         | 288 ++++++++++++++++++++++++++++++++++----
 mm/huge_memory.c                  |   4 +-
 mm/hugetlb.c                      |   2 +-
 mm/madvise.c                      |   2 +-
 mm/memory.c                       |   6 +-
 mm/mmu_gather.c                   | 129 +++++++++--------
 47 files changed, 477 insertions(+), 1250 deletions(-)
