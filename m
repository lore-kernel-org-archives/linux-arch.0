Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 01/20] mm: memblock: replace dereferences of memblock_region.nid with API calls
Date: Wed, 29 Apr 2020 15:11:07 +0300
Message-ID: <20200429121126.17989-2-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121107.lUItJjzPW1IR_8Obte4X57irJD_hN1hVGqqMFuT1NNU@z>

From: Mike Rapoport <rppt@linux.ibm.com>

There are several places in the code that directly dereference
memblock_region.nid despite this field being defined only when
CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy.

Replace these with calls to memblock_get_region_nid() to improve code
robustness and to avoid possible breakage when
CONFIG_HAVE_MEMBLOCK_NODE_MAP will be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/numa.c | 9 ++++++---
 arch/x86/mm/numa.c   | 6 ++++--
 mm/memblock.c        | 8 +++++---
 mm/page_alloc.c      | 4 ++--
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 4decf1659700..aafcee3e3f7e 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -350,13 +350,16 @@ static int __init numa_register_nodes(void)
 	struct memblock_region *mblk;
=20
 	/* Check that valid nid is set to memblks */
-	for_each_memblock(memory, mblk)
-		if (mblk->nid =3D=3D NUMA_NO_NODE || mblk->nid >=3D MAX_NUMNODES) {
+	for_each_memblock(memory, mblk) {
+		int mblk_nid =3D memblock_get_region_node(mblk);
+
+		if (mblk_nid =3D=3D NUMA_NO_NODE || mblk_nid >=3D MAX_NUMNODES) {
 			pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
-				mblk->nid, mblk->base,
+				mblk_nid, mblk->base,
 				mblk->base + mblk->size - 1);
 			return -EINVAL;
 		}
+	}
=20
 	/* Finally register nodes. */
 	for_each_node_mask(nid, numa_nodes_parsed) {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 59ba008504dc..fe024b2ac796 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -517,8 +517,10 @@ static void __init numa_clear_kernel_node_hotplug(vo=
id)
 	 *   reserve specific pages for Sandy Bridge graphics. ]
 	 */
 	for_each_memblock(reserved, mb_region) {
-		if (mb_region->nid !=3D MAX_NUMNODES)
-			node_set(mb_region->nid, reserved_nodemask);
+		int nid =3D memblock_get_region_node(mb_region);
+
+		if (nid !=3D MAX_NUMNODES)
+			node_set(nid, reserved_nodemask);
 	}
=20
 	/*
diff --git a/mm/memblock.c b/mm/memblock.c
index c79ba6f9920c..43e2fd3006c1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1207,13 +1207,15 @@ void __init_memblock __next_mem_pfn_range(int *id=
x, int nid,
 {
 	struct memblock_type *type =3D &memblock.memory;
 	struct memblock_region *r;
+	int r_nid;
=20
 	while (++*idx < type->cnt) {
 		r =3D &type->regions[*idx];
+		r_nid =3D memblock_get_region_node(r);
=20
 		if (PFN_UP(r->base) >=3D PFN_DOWN(r->base + r->size))
 			continue;
-		if (nid =3D=3D MAX_NUMNODES || nid =3D=3D r->nid)
+		if (nid =3D=3D MAX_NUMNODES || nid =3D=3D r_nid)
 			break;
 	}
 	if (*idx >=3D type->cnt) {
@@ -1226,7 +1228,7 @@ void __init_memblock __next_mem_pfn_range(int *idx,=
 int nid,
 	if (out_end_pfn)
 		*out_end_pfn =3D PFN_DOWN(r->base + r->size);
 	if (out_nid)
-		*out_nid =3D r->nid;
+		*out_nid =3D r_nid;
 }
=20
 /**
@@ -1810,7 +1812,7 @@ int __init_memblock memblock_search_pfn_nid(unsigne=
d long pfn,
 	*start_pfn =3D PFN_DOWN(type->regions[mid].base);
 	*end_pfn =3D PFN_DOWN(type->regions[mid].base + type->regions[mid].size=
);
=20
-	return type->regions[mid].nid;
+	return memblock_get_region_node(&type->regions[mid]);
 }
 #endif
=20
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69827d4fa052..0d012eda1694 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7208,7 +7208,7 @@ static void __init find_zone_movable_pfns_for_nodes=
(void)
 			if (!memblock_is_hotpluggable(r))
 				continue;
=20
-			nid =3D r->nid;
+			nid =3D memblock_get_region_node(r);
=20
 			usable_startpfn =3D PFN_DOWN(r->base);
 			zone_movable_pfn[nid] =3D zone_movable_pfn[nid] ?
@@ -7229,7 +7229,7 @@ static void __init find_zone_movable_pfns_for_nodes=
(void)
 			if (memblock_is_mirror(r))
 				continue;
=20
-			nid =3D r->nid;
+			nid =3D memblock_get_region_node(r);
=20
 			usable_startpfn =3D memblock_region_memory_base_pfn(r);
=20
--=20
2.26.1
