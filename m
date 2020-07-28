From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 00/24] Use asm-generic for mmu_context no-op functions
Date: Tue, 28 Jul 2020 13:33:41 +1000
Message-ID: <20200728033405.78469-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgG1DeU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:20 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>

It would be nice to be able to modify these or add a hook without
updating all architectures, most of which just use noops.

There was some discussion around the lazy tlb switching vs membarrier
barriers that may have needed changes here to fix (addition of an
exit_lazy_tlb() function). I don't know whether that's what we will
end up doing, but these are the prep patches I did for it which are
still a good cleanup so I would like to mege them.

All arch patches depend on patch 1. If everybody is fine with it
then Arnd could merge that one in this merge window then we do the
rest of them in the next window?

Thanks,
Nick

Nicholas Piggin (24):
  asm-generic: add generic versions of mmu context functions
  alpha: use asm-generic/mmu_context.h for no-op implementations
  arc: use asm-generic/mmu_context.h for no-op implementations
  arm: use asm-generic/mmu_context.h for no-op implementations
  arm64: use asm-generic/mmu_context.h for no-op implementations
  csky: use asm-generic/mmu_context.h for no-op implementations
  hexagon: use asm-generic/mmu_context.h for no-op implementations
  ia64: use asm-generic/mmu_context.h for no-op implementations
  m68k: use asm-generic/mmu_context.h for no-op implementations
  microblaze: use asm-generic/mmu_context.h for no-op implementations
  mips: use asm-generic/mmu_context.h for no-op implementations
  nds32: use asm-generic/mmu_context.h for no-op implementations
  nios2: use asm-generic/mmu_context.h for no-op implementations
  openrisc: use asm-generic/mmu_context.h for no-op implementations
  parisc: use asm-generic/mmu_context.h for no-op implementations
  powerpc: use asm-generic/mmu_context.h for no-op implementations
  riscv: use asm-generic/mmu_context.h for no-op implementations
  s390: use asm-generic/mmu_context.h for no-op implementations
  sh: use asm-generic/mmu_context.h for no-op implementations
  sparc: use asm-generic/mmu_context.h for no-op implementations
  um: use asm-generic/mmu_context.h for no-op implementations
  unicore32: use asm-generic/mmu_context.h for no-op implementations
  x86: use asm-generic/mmu_context.h for no-op implementations
  xtensa: use asm-generic/mmu_context.h for no-op implementations

 arch/alpha/include/asm/mmu_context.h         | 12 ++---
 arch/arc/include/asm/mmu_context.h           | 16 +++---
 arch/arm/include/asm/mmu_context.h           | 26 ++-------
 arch/arm64/include/asm/mmu_context.h         |  7 ++-
 arch/csky/include/asm/mmu_context.h          |  8 ++-
 arch/hexagon/include/asm/mmu_context.h       | 33 ++----------
 arch/ia64/include/asm/mmu_context.h          | 17 ++----
 arch/m68k/include/asm/mmu_context.h          | 47 +++-------------
 arch/microblaze/include/asm/mmu_context.h    |  2 +-
 arch/microblaze/include/asm/mmu_context_mm.h |  8 +--
 arch/microblaze/include/asm/processor.h      |  3 --
 arch/mips/include/asm/mmu_context.h          | 11 ++--
 arch/nds32/include/asm/mmu_context.h         | 10 +---
 arch/nios2/include/asm/mmu_context.h         | 21 ++------
 arch/nios2/mm/mmu_context.c                  |  1 +
 arch/openrisc/include/asm/mmu_context.h      |  8 ++-
 arch/openrisc/mm/tlb.c                       |  2 +
 arch/parisc/include/asm/mmu_context.h        | 12 ++---
 arch/powerpc/include/asm/mmu_context.h       | 22 +++-----
 arch/riscv/include/asm/mmu_context.h         | 22 +-------
 arch/s390/include/asm/mmu_context.h          |  9 ++--
 arch/sh/include/asm/mmu_context.h            |  7 ++-
 arch/sh/include/asm/mmu_context_32.h         |  9 ----
 arch/sparc/include/asm/mmu_context_32.h      | 10 ++--
 arch/sparc/include/asm/mmu_context_64.h      | 10 ++--
 arch/um/include/asm/mmu_context.h            | 12 ++---
 arch/unicore32/include/asm/mmu_context.h     | 24 ++-------
 arch/x86/include/asm/mmu_context.h           |  6 +++
 arch/xtensa/include/asm/mmu_context.h        | 11 ++--
 arch/xtensa/include/asm/nommu_context.h      | 26 +--------
 include/asm-generic/mmu_context.h            | 57 +++++++++++++++-----
 include/asm-generic/nommu_context.h          | 19 +++++++
 32 files changed, 170 insertions(+), 318 deletions(-)
 create mode 100644 include/asm-generic/nommu_context.h

-- 
2.23.0
