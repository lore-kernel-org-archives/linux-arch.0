From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 00/21] mm: rework free_area_init*() funcitons
Date: Sun, 12 Apr 2020 22:48:38 +0300
Message-ID: <20200412194859.12663-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@in>
List-Id: linux-arch.vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

After the discussion [1] about removal of CONFIG_NODES_SPAN_OTHER_NODES and
CONFIG_HAVE_MEMBLOCK_NODE_MAP options, I took it a bit further and updated
the node/zone initialization. 

Since all architectures have memblock, it is possible to use only the newer
version of free_area_init_node() that calculates the zone and node
boundaries based on memblock node mapping and architectural limits on
possible zone PFNs. 

The architectures that still determined zone and hole sizes can be switched
to the generic code and the old code that took those zone and hole sizes
can be simply removed.

And, since it all started from the removal of
CONFIG_NODES_SPAN_OTHER_NODES, the memmap_init() is now updated to iterate
over memblocks and so it does not need to perform early_pfn_to_nid() query
for every PFN.

--
Sincerely yours,
Mike.

[1] https://lore.kernel.org/lkml/1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com

Baoquan He (1):
  mm: memmap_init: iterate over memblock regions rather that check each PFN

Mike Rapoport (20):
  mm: memblock: replace dereferences of memblock_region.nid with API calls
  mm: make early_pfn_to_nid() and related defintions close to each other
  mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option
  mm: free_area_init: use maximal zone PFNs rather than zone sizes
  mm: use free_area_init() instead of free_area_init_nodes()
  alpha: simplify detection of memory zone boundaries
  arm: simplify detection of memory zone boundaries
  arm64: simplify detection of memory zone boundaries for UMA configs
  csky: simplify detection of memory zone boundaries
  m68k: mm: simplify detection of memory zone boundaries
  parisc: simplify detection of memory zone boundaries
  sparc32: simplify detection of memory zone boundaries
  unicore32: simplify detection of memory zone boundaries
  xtensa: simplify detection of memory zone boundaries
  mm: remove early_pfn_in_nid() and CONFIG_NODES_SPAN_OTHER_NODES
  mm: free_area_init: allow defining max_zone_pfn in descending order
  mm: rename free_area_init_node() to free_area_init_memoryless_node()
  mm: clean up free_area_init_node() and its helpers
  mm: simplify find_min_pfn_with_active_regions()
  docs/vm: update memory-models documentation

 .../vm/numa-memblock/arch-support.txt         |  34 ---
 Documentation/vm/memory-model.rst             |   9 +-
 arch/alpha/mm/init.c                          |  16 +-
 arch/alpha/mm/numa.c                          |  22 +-
 arch/arc/mm/init.c                            |  36 +--
 arch/arm/mm/init.c                            |  66 +----
 arch/arm64/Kconfig                            |   1 -
 arch/arm64/mm/init.c                          |  56 +---
 arch/arm64/mm/numa.c                          |   9 +-
 arch/c6x/mm/init.c                            |   8 +-
 arch/csky/kernel/setup.c                      |  26 +-
 arch/h8300/mm/init.c                          |   6 +-
 arch/hexagon/mm/init.c                        |   6 +-
 arch/ia64/Kconfig                             |   1 -
 arch/ia64/mm/contig.c                         |   2 +-
 arch/ia64/mm/discontig.c                      |   2 +-
 arch/m68k/mm/init.c                           |   6 +-
 arch/m68k/mm/mcfmmu.c                         |   9 +-
 arch/m68k/mm/motorola.c                       |  15 +-
 arch/m68k/mm/sun3mmu.c                        |  10 +-
 arch/microblaze/Kconfig                       |   1 -
 arch/microblaze/mm/init.c                     |   2 +-
 arch/mips/Kconfig                             |   1 -
 arch/mips/loongson64/numa.c                   |   2 +-
 arch/mips/mm/init.c                           |   2 +-
 arch/mips/sgi-ip27/ip27-memory.c              |   2 +-
 arch/nds32/mm/init.c                          |  11 +-
 arch/nios2/mm/init.c                          |   8 +-
 arch/openrisc/mm/init.c                       |   9 +-
 arch/parisc/mm/init.c                         |  22 +-
 arch/powerpc/Kconfig                          |  10 -
 arch/powerpc/mm/mem.c                         |   2 +-
 arch/riscv/Kconfig                            |   1 -
 arch/riscv/mm/init.c                          |   2 +-
 arch/s390/Kconfig                             |   1 -
 arch/s390/mm/init.c                           |   2 +-
 arch/sh/Kconfig                               |   1 -
 arch/sh/mm/init.c                             |   2 +-
 arch/sparc/Kconfig                            |  10 -
 arch/sparc/mm/init_64.c                       |   2 +-
 arch/sparc/mm/srmmu.c                         |  21 +-
 arch/um/kernel/mem.c                          |  12 +-
 arch/unicore32/include/asm/memory.h           |   2 +-
 arch/unicore32/include/mach/memory.h          |   6 +-
 arch/unicore32/kernel/pci.c                   |  14 +-
 arch/unicore32/mm/init.c                      |  43 +--
 arch/x86/Kconfig                              |  10 -
 arch/x86/mm/init.c                            |   2 +-
 arch/x86/mm/numa.c                            |  11 +-
 arch/xtensa/mm/init.c                         |   8 +-
 include/linux/memblock.h                      |   8 +-
 include/linux/mm.h                            |  30 +-
 include/linux/mmzone.h                        |  11 +-
 mm/Kconfig                                    |   3 -
 mm/memblock.c                                 |  19 +-
 mm/memory_hotplug.c                           |   4 -
 mm/page_alloc.c                               | 262 +++++++-----------
 57 files changed, 249 insertions(+), 650 deletions(-)
 delete mode 100644 Documentation/features/vm/numa-memblock/arch-support.txt

-- 
2.25.1
