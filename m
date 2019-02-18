Return-Path: <rppt@linux.ibm.com>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 0/4] provide a generic free_initmem implementation
Date: Mon, 18 Feb 2019 20:41:21 +0200
Message-ID: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190218184121.7WnuPBX6MfyoISx3FyvvOsTOTf_F2AD-vWjJCuTJXzM@z>

Hi,

Many architectures implement free_initmem() in exactly the same or very
similar way: they wrap the call to free_initmem_default() with sometimes
different 'poison' parameter.

These patches switch those architectures to use a generic implementation
that does free_initmem_default(POISON_FREE_INITMEM).

This was inspired by Christoph's patches for free_initrd_mem [1] and I
shamelessly copied changelog entries from his patches :)

v2: rebased on top of v5.0-rc7 + Christoph's patches for free_initrd_mem

[1] https://lore.kernel.org/lkml/20190213174621.29297-1-hch@lst.de/

Mike Rapoport (4):
  init: provide a generic free_initmem implementation
  hexagon: switch over to generic free_initmem()
  init: free_initmem: poison freed init memory
  riscv: switch over to generic free_initmem()

 arch/alpha/mm/init.c      |  6 ------
 arch/arc/mm/init.c        |  8 --------
 arch/c6x/mm/init.c        |  5 -----
 arch/h8300/mm/init.c      |  6 ------
 arch/hexagon/mm/init.c    | 10 ----------
 arch/microblaze/mm/init.c |  5 -----
 arch/nds32/mm/init.c      |  5 -----
 arch/nios2/mm/init.c      |  5 -----
 arch/openrisc/mm/init.c   |  5 -----
 arch/riscv/mm/init.c      |  5 -----
 arch/sh/mm/init.c         |  5 -----
 arch/sparc/mm/init_32.c   |  5 -----
 arch/unicore32/mm/init.c  |  5 -----
 arch/xtensa/mm/init.c     |  5 -----
 init/main.c               |  5 +++++
 15 files changed, 5 insertions(+), 80 deletions(-)

-- 
2.7.4
