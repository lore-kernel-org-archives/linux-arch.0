From: Steve Capper <steve.capper@arm.com>
Subject: [RFC PATCH 0/6] ARM: mm: HugeTLB + THP support.
Date: Thu, 18 Oct 2012 17:15:36 +0100
Message-ID: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:51806 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757091Ab2JRQP4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2012 12:15:56 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

Hello,
The following patches bring both HugeTLB support and Transparent HugePage (=
THP)
support to ARM.

Both short descriptors (non-LPAE) and long descriptors (LPAE) are supported=
.

The non-LPAE HugeTLB code is based on patches by Bill Carson [1], but inste=
ad of
allocating extra memory to store "Linux PTEs", it re-purposes the domain bi=
ts
of section descriptors and constructs huge Linux PTEs on demand.

As PMDs are walked directly by the kernel THP functions (there are no
huge_pmd_offset style functions), any "linux PMD"/"hardware PMD" distinctio=
n
would require some re-working of the ARM PMD/PTE code. Use of the domain bi=
ts
allows for a more straightforward THP implementation.

Some general HugeTLB code relating to huge page migration on memory failure
(CONFIG_MEMORY_FAILURE) de-references huge pte_t *s directly rather than us=
e
the huge_ptep_get and set_huge_pte_at functions. Thus this config option is
incompatible with non-LPAE hugepages. At the moment I can only see x86 usin=
g
CONFIG_MEMORY_FAILURE though.

For non-LPAE, I make an assumption about how the memory type is mapped betw=
een
linux PTE and section descriptor. Ideally I would like to look this informa=
tion
up, possibly from get_mem_types(MT_MEMORY). Comments on an elegant way of
achieving this are welcome.

Non-LPAE code was tested on a Versatile Express (V2P-CA15_A7 Cortex A15 til=
e),
Tegra 2 TrimSlice and RealView ARM11MPCore.

The LPAE code manipulates the hardware page tables directly as the long
descriptors are wide enough to contain all the Linux PTE information.

The LPAE code has been tested on a Versatile Express: V2F-2XV6 Cortex A15 a=
nd
V2P-CA15_A7 Cortex A15 tiles.

This patch set requires the following to be applied on top of 3.7-rc1:
"ARM: mm: introduce L_PTE_VALID for page table entries"
  (PROT_NONE series, posted by Will on linux-arm-kernel)
  - http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/1261=
30.html

"mm: thp: Set the accessed flag for old pages on access fault."
  (posted by Will on linux-mm)
   - http://marc.info/?l=3Dlinux-kernel&m=3D135048927416117&w=3D2

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
 arch/arm/include/asm/hugetlb-2level.h       |   71 ++++++++++
 arch/arm/include/asm/hugetlb-3level.h       |   61 +++++++++
 arch/arm/include/asm/hugetlb.h              |   87 ++++++++++++
 arch/arm/include/asm/pgtable-2level.h       |  152 ++++++++++++++++++++-
 arch/arm/include/asm/pgtable-3level-hwdef.h |    2 +
 arch/arm/include/asm/pgtable-3level.h       |   77 +++++++++++
 arch/arm/include/asm/pgtable.h              |   34 ++++-
 arch/arm/include/asm/tlb.h                  |   16 ++-
 arch/arm/include/asm/tlbflush.h             |    2 +
 arch/arm/kernel/head.S                      |   10 +-
 arch/arm/mm/Makefile                        |    6 +
 arch/arm/mm/dma-mapping.c                   |    2 +-
 arch/arm/mm/fault.c                         |    6 +-
 arch/arm/mm/flush.c                         |   25 ++--
 arch/arm/mm/fsr-3level.c                    |    2 +-
 arch/arm/mm/hugetlbpage-2level.c            |  115 ++++++++++++++++
 arch/arm/mm/hugetlbpage-3level.c            |  190 +++++++++++++++++++++++=
++++
 arch/arm/mm/hugetlbpage.c                   |   65 +++++++++
 19 files changed, 909 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-2level.h
 create mode 100644 arch/arm/include/asm/hugetlb-3level.h
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlbpage-2level.c
 create mode 100644 arch/arm/mm/hugetlbpage-3level.c
 create mode 100644 arch/arm/mm/hugetlbpage.c

--=20
1.7.9.5
