Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 02/20] mm: make early_pfn_to_nid() and related defintions close to each other
Date: Wed, 29 Apr 2020 15:11:08 +0300
Message-ID: <20200429121126.17989-3-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121108.VYLVVQKUYcjFcMs1M7O-qS8bZBhJZiUzFX7fkGNL71Q@z>

From: Mike Rapoport <rppt@linux.ibm.com>

The early_pfn_to_nid() and it's helper __early_pfn_to_nid() are spread
around include/linux/mm.h, include/linux/mmzone.h and mm/page_alloc.c.

Drop unused stub for __early_pfn_to_nid() and move its actual generic
implementation close to its users.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/mm.h     |  4 ++--
 include/linux/mmzone.h |  9 --------
 mm/page_alloc.c        | 49 +++++++++++++++++++++---------------------
 3 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..a404026d14d4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2388,9 +2388,9 @@ extern void sparse_memory_present_with_active_regio=
ns(int nid);
=20
 #if !defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP) && \
     !defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID)
-static inline int __early_pfn_to_nid(unsigned long pfn,
-					struct mminit_pfnnid_cache *state)
+static inline int early_pfn_to_nid(unsigned long pfn)
 {
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_NUMA));
 	return 0;
 }
 #else
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1b9de7d220fb..7b5b6eba402f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1078,15 +1078,6 @@ static inline struct zoneref *first_zones_zonelist=
(struct zonelist *zonelist,
 #include <asm/sparsemem.h>
 #endif
=20
-#if !defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID) && \
-	!defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP)
-static inline unsigned long early_pfn_to_nid(unsigned long pfn)
-{
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_NUMA));
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_FLATMEM
 #define pfn_to_nid(pfn)		(0)
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0d012eda1694..a802ee47e715 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1504,6 +1504,31 @@ void __free_pages_core(struct page *page, unsigned=
 int order)
=20
 static struct mminit_pfnnid_cache early_pfnnid_cache __meminitdata;
=20
+#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
+
+/*
+ * Required by SPARSEMEM. Given a PFN, return what node the PFN is on.
+ */
+int __meminit __early_pfn_to_nid(unsigned long pfn,
+					struct mminit_pfnnid_cache *state)
+{
+	unsigned long start_pfn, end_pfn;
+	int nid;
+
+	if (state->last_start <=3D pfn && pfn < state->last_end)
+		return state->last_nid;
+
+	nid =3D memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn);
+	if (nid !=3D NUMA_NO_NODE) {
+		state->last_start =3D start_pfn;
+		state->last_end =3D end_pfn;
+		state->last_nid =3D nid;
+	}
+
+	return nid;
+}
+#endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
+
 int __meminit early_pfn_to_nid(unsigned long pfn)
 {
 	static DEFINE_SPINLOCK(early_pfn_lock);
@@ -6299,30 +6324,6 @@ void __meminit init_currently_empty_zone(struct zo=
ne *zone,
 }
=20
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
-#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
-
-/*
- * Required by SPARSEMEM. Given a PFN, return what node the PFN is on.
- */
-int __meminit __early_pfn_to_nid(unsigned long pfn,
-					struct mminit_pfnnid_cache *state)
-{
-	unsigned long start_pfn, end_pfn;
-	int nid;
-
-	if (state->last_start <=3D pfn && pfn < state->last_end)
-		return state->last_nid;
-
-	nid =3D memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn);
-	if (nid !=3D NUMA_NO_NODE) {
-		state->last_start =3D start_pfn;
-		state->last_end =3D end_pfn;
-		state->last_nid =3D nid;
-	}
-
-	return nid;
-}
-#endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
=20
 /**
  * free_bootmem_with_active_regions - Call memblock_free_early_nid for e=
ach active range
--=20
2.26.1
