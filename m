From: Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH 2/2] mm/sparse: add common helper to mark all memblocks present
Date: Wed,  7 Nov 2018 10:38:59 -0700
Message-ID: <20181107173859.24096-3-logang@deltatee.com>
References: <20181107173859.24096-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107173859.24096-1-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Bates <sbates@raithlin.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Logan Gunthorpe <logang@deltatee.com>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
List-Id: linux-arch.vger.kernel.org

Presently the arches arm64, arm and sh have a function which loops through
each memblock and calls memory present. riscv will require a similar
function.

Introduce a common memblocks_present() function that can be used by
all the arches. Subsequent patches will cleanup the arches that
make use of this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mmzone.h |  6 ++++++
 mm/sparse.c            | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 847705a6d0ec..db023a92f3a4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -783,6 +783,12 @@ void memory_present(int nid, unsigned long start, unsigned long end);
 static inline void memory_present(int nid, unsigned long start, unsigned long end) {}
 #endif
 
+#if defined(CONFIG_SPARSEMEM)
+void memblocks_present(void);
+#else
+static inline void memblocks_present(void) {}
+#endif
+
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
 int local_memory_node(int node_id);
 #else
diff --git a/mm/sparse.c b/mm/sparse.c
index 33307fc05c4d..5841e4ad6d93 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -239,6 +239,17 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
 	}
 }
 
+void __init memblocks_present(void)
+{
+	struct memblock_region *reg;
+
+	for_each_memblock(memory, reg) {
+		memory_present(memblock_get_region_node(reg),
+			       memblock_region_memory_base_pfn(reg),
+			       memblock_region_memory_end_pfn(reg));
+	}
+}
+
 /*
  * Subtle, we encode the real pfn into the mem_map such that
  * the identity pfn - section_mem_map will return the actual
-- 
2.19.0
