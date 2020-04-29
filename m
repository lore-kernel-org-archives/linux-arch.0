Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 17/20] mm: free_area_init: allow defining max_zone_pfn in descending order
Date: Wed, 29 Apr 2020 15:11:23 +0300
Message-ID: <20200429121126.17989-18-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121123.wZW-5_MHthLH4vETqUFUStoSQIOpdOq-Lap-JMjuJQ0@z>

From: Mike Rapoport <rppt@linux.ibm.com>

Some architectures (e.g. ARC) have the ZONE_HIGHMEM zone below the
ZONE_NORMAL. Allowing free_area_init() parse max_zone_pfn array even it i=
s
sorted in descending order allows using free_area_init() on such
architectures.

Add top -> down traversal of max_zone_pfn array in free_area_init() and u=
se
the latter in ARC node/zone initialization.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arc/mm/init.c | 36 +++++++-----------------------------
 mm/page_alloc.c    | 24 +++++++++++++++++++-----
 2 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 0920c969c466..41eb9be1653c 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -63,11 +63,13 @@ void __init early_init_dt_add_memory_arch(u64 base, u=
64 size)
=20
 		low_mem_sz =3D size;
 		in_use =3D 1;
+		memblock_add_node(base, size, 0);
 	} else {
 #ifdef CONFIG_HIGHMEM
 		high_mem_start =3D base;
 		high_mem_sz =3D size;
 		in_use =3D 1;
+		memblock_add_node(base, size, 1);
 #endif
 	}
=20
@@ -83,8 +85,7 @@ void __init early_init_dt_add_memory_arch(u64 base, u64=
 size)
  */
 void __init setup_arch_memory(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES];
-	unsigned long zones_holes[MAX_NR_ZONES];
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D { 0 };
=20
 	init_mm.start_code =3D (unsigned long)_text;
 	init_mm.end_code =3D (unsigned long)_etext;
@@ -115,7 +116,6 @@ void __init setup_arch_memory(void)
 	 * the crash
 	 */
=20
-	memblock_add_node(low_mem_start, low_mem_sz, 0);
 	memblock_reserve(CONFIG_LINUX_LINK_BASE,
 			 __pa(_end) - CONFIG_LINUX_LINK_BASE);
=20
@@ -133,22 +133,7 @@ void __init setup_arch_memory(void)
 	memblock_dump_all();
=20
 	/*----------------- node/zones setup --------------------------*/
-	memset(zones_size, 0, sizeof(zones_size));
-	memset(zones_holes, 0, sizeof(zones_holes));
-
-	zones_size[ZONE_NORMAL] =3D max_low_pfn - min_low_pfn;
-	zones_holes[ZONE_NORMAL] =3D 0;
-
-	/*
-	 * We can't use the helper free_area_init(zones[]) because it uses
-	 * PAGE_OFFSET to compute the @min_low_pfn which would be wrong
-	 * when our kernel doesn't start at PAGE_OFFSET, i.e.
-	 * PAGE_OFFSET !=3D CONFIG_LINUX_RAM_BASE
-	 */
-	free_area_init_node(0,			/* node-id */
-			    zones_size,		/* num pages per zone */
-			    min_low_pfn,	/* first pfn of node */
-			    zones_holes);	/* holes */
+	max_zone_pfn[ZONE_NORMAL] =3D max_low_pfn;
=20
 #ifdef CONFIG_HIGHMEM
 	/*
@@ -168,20 +153,13 @@ void __init setup_arch_memory(void)
 	min_high_pfn =3D PFN_DOWN(high_mem_start);
 	max_high_pfn =3D PFN_DOWN(high_mem_start + high_mem_sz);
=20
-	zones_size[ZONE_NORMAL] =3D 0;
-	zones_holes[ZONE_NORMAL] =3D 0;
-
-	zones_size[ZONE_HIGHMEM] =3D max_high_pfn - min_high_pfn;
-	zones_holes[ZONE_HIGHMEM] =3D 0;
-
-	free_area_init_node(1,			/* node-id */
-			    zones_size,		/* num pages per zone */
-			    min_high_pfn,	/* first pfn of node */
-			    zones_holes);	/* holes */
+	max_zone_pfn[ZONE_HIGHMEM] =3D max_high_pfn;
=20
 	high_memory =3D (void *)(min_high_pfn << PAGE_SHIFT);
 	kmap_init();
 #endif
+
+	free_area_init(max_zone_pfn);
 }
=20
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d35ca0996a09..98a47f90065a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7408,7 +7408,8 @@ static void check_for_memory(pg_data_t *pgdat, int =
nid)
 void __init free_area_init(unsigned long *max_zone_pfn)
 {
 	unsigned long start_pfn, end_pfn;
-	int i, nid;
+	int i, nid, zone;
+	bool descending =3D false;
=20
 	/* Record where the zone boundaries are */
 	memset(arch_zone_lowest_possible_pfn, 0,
@@ -7418,13 +7419,26 @@ void __init free_area_init(unsigned long *max_zon=
e_pfn)
=20
 	start_pfn =3D find_min_pfn_with_active_regions();
=20
+	/*
+	 * Some architecturs, e.g. ARC may have ZONE_HIGHMEM below
+	 * ZONE_NORMAL. For such cases we allow max_zone_pfn sorted in the
+	 * descending order
+	 */
+	if (MAX_NR_ZONES > 1 && max_zone_pfn[0] > max_zone_pfn[1])
+		descending =3D true;
+
 	for (i =3D 0; i < MAX_NR_ZONES; i++) {
-		if (i =3D=3D ZONE_MOVABLE)
+		if (descending)
+			zone =3D MAX_NR_ZONES - i - 1;
+		else
+			zone =3D i;
+
+		if (zone =3D=3D ZONE_MOVABLE)
 			continue;
=20
-		end_pfn =3D max(max_zone_pfn[i], start_pfn);
-		arch_zone_lowest_possible_pfn[i] =3D start_pfn;
-		arch_zone_highest_possible_pfn[i] =3D end_pfn;
+		end_pfn =3D max(max_zone_pfn[zone], start_pfn);
+		arch_zone_lowest_possible_pfn[zone] =3D start_pfn;
+		arch_zone_highest_possible_pfn[zone] =3D end_pfn;
=20
 		start_pfn =3D end_pfn;
 	}
--=20
2.26.1
