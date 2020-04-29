Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 09/20] csky: simplify detection of memory zone boundaries
Date: Wed, 29 Apr 2020 15:11:15 +0300
Message-ID: <20200429121126.17989-10-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121115.X6LjKen8GHPPV69Y_1Ix24KjEnQe8QxvAQezRMCO6Xo@z>

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
 arch/csky/kernel/setup.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 819a9a7bf786..0481f4e34538 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -26,7 +26,9 @@ struct screen_info screen_info =3D {
=20
 static void __init csky_memblock_init(void)
 {
-	unsigned long zone_size[MAX_NR_ZONES];
+	unsigned long lowmem_size =3D PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSE=
T);
+	unsigned long sseg_size =3D PFN_DOWN(SSEG_SIZE - PHYS_OFFSET_OFFSET);
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D { 0 };
 	signed long size;
=20
 	memblock_reserve(__pa(_stext), _end - _stext);
@@ -36,28 +38,22 @@ static void __init csky_memblock_init(void)
=20
 	memblock_dump_all();
=20
-	memset(zone_size, 0, sizeof(zone_size));
-
 	min_low_pfn =3D PFN_UP(memblock_start_of_DRAM());
 	max_low_pfn =3D max_pfn =3D PFN_DOWN(memblock_end_of_DRAM());
=20
 	size =3D max_pfn - min_low_pfn;
=20
-	if (size <=3D PFN_DOWN(SSEG_SIZE - PHYS_OFFSET_OFFSET))
-		zone_size[ZONE_NORMAL] =3D size;
-	else if (size < PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET)) {
-		zone_size[ZONE_NORMAL] =3D
-				PFN_DOWN(SSEG_SIZE - PHYS_OFFSET_OFFSET);
-		max_low_pfn =3D min_low_pfn + zone_size[ZONE_NORMAL];
-	} else {
-		zone_size[ZONE_NORMAL] =3D
-				PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
-		max_low_pfn =3D min_low_pfn + zone_size[ZONE_NORMAL];
+	if (size >=3D lowmem_size) {
+		max_low_pfn =3D min_low_pfn + lowmem_size;
 		write_mmu_msa1(read_mmu_msa0() + SSEG_SIZE);
+	} else if (size > sseg_size) {
+		max_low_pfn =3D min_low_pfn + sseg_size;
 	}
=20
+	max_zone_pfn[ZONE_NORMAL] =3D max_low_pfn;
+
 #ifdef CONFIG_HIGHMEM
-	zone_size[ZONE_HIGHMEM] =3D max_pfn - max_low_pfn;
+	max_zone_pfn[ZONE_HIGHMEM] =3D max_pfn;
=20
 	highstart_pfn =3D max_low_pfn;
 	highend_pfn   =3D max_pfn;
@@ -66,7 +62,7 @@ static void __init csky_memblock_init(void)
=20
 	dma_contiguous_reserve(0);
=20
-	free_area_init_node(0, zone_size, min_low_pfn, NULL);
+	free_area_init(max_zone_pfn);
 }
=20
 void __init setup_arch(char **cmdline_p)
--=20
2.26.1
