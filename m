From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 1/6] mm: add coherence API for DMA to vmalloc/vmap areas
Date: Thu, 17 Sep 2009 18:06:56 -0500
Message-ID: <1253228821-4700-2-git-send-email-James.Bottomley@suse.de>
References: <1253228821-4700-1-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1253228821-4700-1-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <jejb@external.hp.com>, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-arch.vger.kernel.org

From: James Bottomley <jejb@external.hp.com>

On Virtually Indexed architectures (which don't do automatic alias
resolution in their caches), we have to flush via the correct
virtual address to prepare pages for DMA.  On some architectures
(like arm) we cannot prevent the CPU from doing data movein along
the alias (and thus giving stale read data), so we not only have to
introduce a flush API to push dirty cache lines out, but also an invalidate
API to kill inconsistent cache lines that may have moved in before
DMA changed the data

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 include/linux/highmem.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 211ff44..eb99c70 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -17,6 +17,12 @@ static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page
 static inline void flush_kernel_dcache_page(struct page *page)
 {
 }
+static inline void flush_kernel_dcache_addr(void *vaddr)
+{
+}
+static inline void invalidate_kernel_dcache_addr(void *vaddr)
+{
+}
 #endif
 
 #include <asm/kmap_types.h>
-- 
1.6.3.3

