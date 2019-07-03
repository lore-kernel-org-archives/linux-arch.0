From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] mm: provide a print_vma_addr stub for !CONFIG_MMU
Date: Wed,  3 Jul 2019 05:23:58 -0700
Message-ID: <20190703122359.18200-3-hch@lst.de>
References: <20190703122359.18200-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703122359.18200-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 include/linux/mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd0b5f4e1e45..69843ee0c5f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2756,7 +2756,13 @@ extern int randomize_va_space;
 #endif
 
 const char * arch_vma_name(struct vm_area_struct *vma);
+#ifdef CONFIG_MMU
 void print_vma_addr(char *prefix, unsigned long rip);
+#else
+static inline void print_vma_addr(char *prefix, unsigned long rip)
+{
+}
+#endif
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
-- 
2.20.1
