Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 07/20] arm: simplify detection of memory zone boundaries
Date: Wed, 29 Apr 2020 15:11:13 +0300
Message-ID: <20200429121126.17989-8-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121113.pIWcqDllkxkMJJEp27jGYPGMV4wQdOdAzuOvRO0hqDw@z>

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
 arch/arm/mm/init.c | 66 +++++-----------------------------------------
 1 file changed, 7 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 054be44d1cdb..4e43455fab84 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -92,18 +92,6 @@ EXPORT_SYMBOL(arm_dma_zone_size);
  */
 phys_addr_t arm_dma_limit;
 unsigned long arm_dma_pfn_limit;
-
-static void __init arm_adjust_dma_zone(unsigned long *size, unsigned lon=
g *hole,
-	unsigned long dma_size)
-{
-	if (size[0] <=3D dma_size)
-		return;
-
-	size[ZONE_NORMAL] =3D size[0] - dma_size;
-	size[ZONE_DMA] =3D dma_size;
-	hole[ZONE_NORMAL] =3D hole[0];
-	hole[ZONE_DMA] =3D 0;
-}
 #endif
=20
 void __init setup_dma_zone(const struct machine_desc *mdesc)
@@ -121,56 +109,16 @@ void __init setup_dma_zone(const struct machine_des=
c *mdesc)
 static void __init zone_sizes_init(unsigned long min, unsigned long max_=
low,
 	unsigned long max_high)
 {
-	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
-	struct memblock_region *reg;
-
-	/*
-	 * initialise the zones.
-	 */
-	memset(zone_size, 0, sizeof(zone_size));
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D { 0 };
=20
-	/*
-	 * The memory size has already been determined.  If we need
-	 * to do anything fancy with the allocation of this memory
-	 * to the zones, now is the time to do it.
-	 */
-	zone_size[0] =3D max_low - min;
-#ifdef CONFIG_HIGHMEM
-	zone_size[ZONE_HIGHMEM] =3D max_high - max_low;
+#ifdef CONFIG_ZONE_DMA
+	max_zone_pfn[ZONE_DMA] =3D min(arm_dma_pfn_limit, max_low);
 #endif
-
-	/*
-	 * Calculate the size of the holes.
-	 *  holes =3D node_size - sum(bank_sizes)
-	 */
-	memcpy(zhole_size, zone_size, sizeof(zhole_size));
-	for_each_memblock(memory, reg) {
-		unsigned long start =3D memblock_region_memory_base_pfn(reg);
-		unsigned long end =3D memblock_region_memory_end_pfn(reg);
-
-		if (start < max_low) {
-			unsigned long low_end =3D min(end, max_low);
-			zhole_size[0] -=3D low_end - start;
-		}
+	max_zone_pfn[ZONE_NORMAL] =3D max_low;
 #ifdef CONFIG_HIGHMEM
-		if (end > max_low) {
-			unsigned long high_start =3D max(start, max_low);
-			zhole_size[ZONE_HIGHMEM] -=3D end - high_start;
-		}
+	max_zone_pfn[ZONE_HIGHMEM] =3D max_high;
 #endif
-	}
-
-#ifdef CONFIG_ZONE_DMA
-	/*
-	 * Adjust the sizes according to any special requirements for
-	 * this machine type.
-	 */
-	if (arm_dma_zone_size)
-		arm_adjust_dma_zone(zone_size, zhole_size,
-			arm_dma_zone_size >> PAGE_SHIFT);
-#endif
-
-	free_area_init_node(0, zone_size, min, zhole_size);
+	free_area_init(max_zone_pfn);
 }
=20
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
@@ -306,7 +254,7 @@ void __init bootmem_init(void)
 	sparse_init();
=20
 	/*
-	 * Now free the memory - free_area_init_node needs
+	 * Now free the memory - free_area_init needs
 	 * the sparse mem_map arrays initialized by sparse_init()
 	 * for memmap_init_zone(), otherwise all PFNs are invalid.
 	 */
--=20
2.26.1
