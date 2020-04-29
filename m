Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 08/20] arm64: simplify detection of memory zone boundaries for UMA configs
Date: Wed, 29 Apr 2020 15:11:14 +0300
Message-ID: <20200429121126.17989-9-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121114.rZWh8R8Wh8wyVn7n0L2TuDF093EoF-Wb62rD4hVdKSY@z>

From: Mike Rapoport <rppt@linux.ibm.com>

The free_area_init() function only requires the definition of maximal PFN
for each of the supported zone rater than calculation of actual zone size=
s
and the sizes of the holes between the zones.

After removal of CONFIG_HAVE_MEMBLOCK_NODE_MAP the free_area_init() is
available to all architectures.

Using this function instead of free_area_init_node() simplifies the zone
detection.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/init.c | 54 --------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a650adb358ee..d54ad2250dce 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -192,8 +192,6 @@ static phys_addr_t __init max_zone_phys(unsigned int =
zone_bits)
 	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
 }
=20
-#ifdef CONFIG_NUMA
-
 static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  =3D {0};
@@ -209,58 +207,6 @@ static void __init zone_sizes_init(unsigned long min=
, unsigned long max)
 	free_area_init(max_zone_pfns);
 }
=20
-#else
-
-static void __init zone_sizes_init(unsigned long min, unsigned long max)
-{
-	struct memblock_region *reg;
-	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
-	unsigned long __maybe_unused max_dma, max_dma32;
-
-	memset(zone_size, 0, sizeof(zone_size));
-
-	max_dma =3D max_dma32 =3D min;
-#ifdef CONFIG_ZONE_DMA
-	max_dma =3D max_dma32 =3D PFN_DOWN(arm64_dma_phys_limit);
-	zone_size[ZONE_DMA] =3D max_dma - min;
-#endif
-#ifdef CONFIG_ZONE_DMA32
-	max_dma32 =3D PFN_DOWN(arm64_dma32_phys_limit);
-	zone_size[ZONE_DMA32] =3D max_dma32 - max_dma;
-#endif
-	zone_size[ZONE_NORMAL] =3D max - max_dma32;
-
-	memcpy(zhole_size, zone_size, sizeof(zhole_size));
-
-	for_each_memblock(memory, reg) {
-		unsigned long start =3D memblock_region_memory_base_pfn(reg);
-		unsigned long end =3D memblock_region_memory_end_pfn(reg);
-
-#ifdef CONFIG_ZONE_DMA
-		if (start >=3D min && start < max_dma) {
-			unsigned long dma_end =3D min(end, max_dma);
-			zhole_size[ZONE_DMA] -=3D dma_end - start;
-			start =3D dma_end;
-		}
-#endif
-#ifdef CONFIG_ZONE_DMA32
-		if (start >=3D max_dma && start < max_dma32) {
-			unsigned long dma32_end =3D min(end, max_dma32);
-			zhole_size[ZONE_DMA32] -=3D dma32_end - start;
-			start =3D dma32_end;
-		}
-#endif
-		if (start >=3D max_dma32 && start < max) {
-			unsigned long normal_end =3D min(end, max);
-			zhole_size[ZONE_NORMAL] -=3D normal_end - start;
-		}
-	}
-
-	free_area_init_node(0, zone_size, min, zhole_size);
-}
-
-#endif /* CONFIG_NUMA */
-
 int pfn_valid(unsigned long pfn)
 {
 	phys_addr_t addr =3D pfn << PAGE_SHIFT;
--=20
2.26.1
