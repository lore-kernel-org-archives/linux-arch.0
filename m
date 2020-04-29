From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 02/20] mm: make early_pfn_to_nid() and related defintions
 close to each other
Date: Wed, 29 Apr 2020 15:11:08 +0300
Message-ID: <20200429121126.17989-3-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
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
@@ -2388,9 +2388,9 @@ extern void sparse_memory_present_with_active_regions(int nid);
 
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
@@ -1078,15 +1078,6 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 #include <asm/sparsemem.h>
 #endif
 
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
@@ -1504,6 +1504,31 @@ void __free_pages_core(struct page *page, unsigned int order)
 
 static struct mminit_pfnnid_cache early_pfnnid_cache __meminitdata;
 
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
+	if (state->last_start <= pfn && pfn < state->last_end)
+		return state->last_nid;
+
+	nid = memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn);
+	if (nid != NUMA_NO_NODE) {
+		state->last_start = start_pfn;
+		state->last_end = end_pfn;
+		state->last_nid = nid;
+	}
+
+	return nid;
+}
+#endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
+
 int __meminit early_pfn_to_nid(unsigned long pfn)
 {
 	static DEFINE_SPINLOCK(early_pfn_lock);
@@ -6299,30 +6324,6 @@ void __meminit init_currently_empty_zone(struct zone *zone,
 }
 
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
-	if (state->last_start <= pfn && pfn < state->last_end)
-		return state->last_nid;
-
-	nid = memblock_search_pfn_nid(pfn, &start_pfn, &end_pfn);
-	if (nid != NUMA_NO_NODE) {
-		state->last_start = start_pfn;
-		state->last_end = end_pfn;
-		state->last_nid = nid;
-	}
-
-	return nid;
-}
-#endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
 
 /**
  * free_bootmem_with_active_regions - Call memblock_free_early_nid for each active range
-- 
2.26.1
