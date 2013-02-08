From: Steve Capper <steve.capper@arm.com>
Subject: [PATCH 0/6] ARM: mm: HugeTLB + THP support.
Date: Fri,  8 Feb 2013 15:01:17 +0000
Message-ID: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:40240 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758440Ab3BHPBo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2013 10:01:44 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: c.dall@virtualopensystems.com, akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

Hello,
The following patches bring both HugeTLB support and Transparent
HugePage (THP) support to ARM.

These are not intended for 3.9.

Both short descriptors (non-LPAE) and long descriptors (LPAE) are
supported.

The non-LPAE HugeTLB code is based on patches by Bill Carson [1],
but instead of allocating extra memory to store "Linux PTEs", it
re-purposes the domain bits of section descriptors and constructs
huge Linux PTEs on demand.

As PMDs are walked directly by the kernel THP functions (there are
no huge_pmd_offset style functions), any "linux PMD"/"hardware PMD"
distinction would require some re-working of the ARM PMD/PTE code.
Use of the domain bits allows for a more straightforward THP
implementation.

Some general HugeTLB code relating to huge page migration on memory
failure (CONFIG_MEMORY_FAILURE) de-references huge pte_t *s directly
rather than use the huge_ptep_get and set_huge_pte_at functions.
Thus this config option is incompatible with non-LPAE hugepages. At
the moment I can only see x86 using CONFIG_MEMORY_FAILURE though.

Non-LPAE code was tested on an Arndale board (Exynos 5250) and a
Tegra 2 TrimSlice.

The LPAE code manipulates the hardware page tables directly as the
long descriptors are wide enough to contain all the Linux PTE
information.

The LPAE code has been tested on an Arndale board (Exynos 5250).

This patch set is based on 3.8-rc6.

Major changes since the RFC:
 * huge pmd sharing removed from the 3-level code as this was
   found to be very rarely, if ever?, used. This allowed for some
   code simplification.

 * hardware pmd bits for 2-levels of paging are now taken from
   mmu.c. Also the mapping code now uses pte/pmd bit helper
   functions rather than the custom pre-processor logic.

Cheers,
--=20
Steve

[1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/0=
84359.html

Catalin Marinas (2):
  ARM: mm: HugeTLB support for LPAE systems.
  ARM: mm: Transparent huge page support for LPAE systems.

Steve Capper (4):
  ARM: mm: correct pte_same behaviour for LPAE.
  ARM: mm: Add support for flushing HugeTLB pages.
  ARM: mm: HugeTLB support for non-LPAE systems.
  ARM: mm: Transparent huge page support for non-LPAE systems.

 arch/arm/Kconfig                            |    8 ++
 arch/arm/include/asm/hugetlb-2level.h       |  121 +++++++++++++++++++++
 arch/arm/include/asm/hugetlb-3level.h       |   61 +++++++++++
 arch/arm/include/asm/hugetlb.h              |   87 +++++++++++++++
 arch/arm/include/asm/pgtable-2level.h       |  151 +++++++++++++++++++++++=
++++
 arch/arm/include/asm/pgtable-3level-hwdef.h |    2 +
 arch/arm/include/asm/pgtable-3level.h       |   83 +++++++++++++++
 arch/arm/include/asm/pgtable.h              |   13 ++-
 arch/arm/include/asm/tlb.h                  |   16 ++-
 arch/arm/include/asm/tlbflush.h             |    2 +
 arch/arm/kernel/head.S                      |   10 +-
 arch/arm/mm/Makefile                        |    1 +
 arch/arm/mm/dma-mapping.c                   |    2 +-
 arch/arm/mm/fault.c                         |   11 --
 arch/arm/mm/flush.c                         |   26 +++--
 arch/arm/mm/fsr-2level.c                    |    4 +-
 arch/arm/mm/fsr-3level.c                    |    4 +-
 arch/arm/mm/hugetlbpage.c                   |  100 ++++++++++++++++++
 arch/arm/mm/mmu.c                           |   27 +++++
 19 files changed, 697 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-2level.h
 create mode 100644 arch/arm/include/asm/hugetlb-3level.h
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlbpage.c

--=20
1.7.9.5
