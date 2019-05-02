From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 00/15] introduce generic pte_{alloc,free}_one[_kernel]
Date: Thu,  2 May 2019 18:28:27 +0300
Message-ID: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, linux-mips@vger.kernel.org, Guo Ren <guoren@kernel.org>, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>, Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, linux-m68k@lists.linux-m68k.org, Greentime Hu <green.hu@gmail.com>, nios2-dev@lists.rocketboards.org, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-kernel@vger.ke
List-Id: linux-arch.vger.kernel.org

Hi,

I've tried to trim down the recipients list, but it's still quite long, so
sorry for the spam.

Many architectures have similar, if not identical implementation of
pte_alloc_one_kernel(), pte_alloc_one(), pte_free_kernel() and pte_free().

A while ago Anshuman suggested to introduce a common definition of
GFP_PGTABLE and during the discussion it was suggested to rather
consolidate the allocators.

These patches introduce generic version of PTE allocation and free and
enable their use on several architectures.

The conversion introduces some changes for some of the architectures.
Here's the executive summary and the details are described at each patch.

* Most architectures do not set __GFP_ACCOUNT for the user page tables.
Switch to the generic functions is "spreading that goodness to all other
architectures"
* arm, arm64 and unicore32 used to check if the pte is not NULL before
freeing its memory in pte_free_kernel(). It's dropped during the
conversion as it seems superfluous.
* x86 used to BUG_ON() is pte was not page aligned duirng
pte_free_kernel(), the generic version simply frees the memory without any
checks.

This set only performs the straightforward conversion, the architectures
with different logic in pte_alloc_one() and pte_alloc_one_kernel() are not
touched, as well as architectures that have custom page table allocators.

[1] https://lore.kernel.org/lkml/1547619692-7946-1-git-send-email-anshuman.khandual@arm.com

 asm-generic, x86: introduce generic pte_{alloc,free}_one[_kernel]

Mike Rapoport (15):
  asm-generic, x86: introduce generic pte_{alloc,free}_one[_kernel]
  alpha: switch to generic version of pte allocation
  arm: switch to generic version of pte allocation
  arm64: switch to generic version of pte allocation
  csky: switch to generic version of pte allocation
  hexagon: switch to generic version of pte allocation
  m68k: sun3: switch to generic version of pte allocation
  mips: switch to generic version of pte allocation
  nds32: switch to generic version of pte allocation
  nios2: switch to generic version of pte allocation
  parisc: switch to generic version of pte allocation
  powerpc/nohash/64: switch to generic version of pte allocation
  riscv: switch to generic version of pte allocation
  um: switch to generic version of pte allocation
  unicore32: switch to generic version of pte allocation

 arch/alpha/include/asm/pgalloc.h             |  40 +---------
 arch/arm/include/asm/pgalloc.h               |  41 ++++------
 arch/arm/mm/mmu.c                            |   2 +-
 arch/arm64/include/asm/pgalloc.h             |  43 +----------
 arch/arm64/mm/mmu.c                          |   2 +-
 arch/arm64/mm/pgd.c                          |   4 +-
 arch/csky/include/asm/pgalloc.h              |  30 +-------
 arch/hexagon/include/asm/pgalloc.h           |  34 +--------
 arch/m68k/include/asm/sun3_pgalloc.h         |  41 +---------
 arch/mips/include/asm/pgalloc.h              |  33 +--------
 arch/nds32/include/asm/pgalloc.h             |  31 +-------
 arch/nios2/include/asm/pgalloc.h             |  37 +--------
 arch/parisc/include/asm/pgalloc.h            |  33 +--------
 arch/powerpc/include/asm/nohash/64/pgalloc.h |  35 +--------
 arch/riscv/include/asm/pgalloc.h             |  29 +-------
 arch/um/include/asm/pgalloc.h                |  16 +---
 arch/um/kernel/mem.c                         |  22 ------
 arch/unicore32/include/asm/pgalloc.h         |  36 ++-------
 arch/x86/include/asm/pgalloc.h               |  19 +----
 arch/x86/mm/pgtable.c                        |  33 +++------
 include/asm-generic/pgalloc.h                | 107 ++++++++++++++++++++++++++-
 virt/kvm/arm/mmu.c                           |   2 +-
 22 files changed, 171 insertions(+), 499 deletions(-)

-- 
2.7.4
