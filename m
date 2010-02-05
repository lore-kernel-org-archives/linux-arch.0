From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCHv3 2/5] parisc: add mm API for DMA to vmalloc/vmap areas
Date: Fri,  5 Feb 2010 09:50:54 -0600
Message-ID: <1265385057-2575-3-git-send-email-James.Bottomley@suse.de>
References: <1265385057-2575-1-git-send-email-James.Bottomley@suse.de>
 <1265385057-2575-2-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1265385057-2575-2-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, rmk@arm.linux.org.uk, lethal@linux-sh.org, torvalds@linux-foundation.org, hch@lst.de, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-arch.vger.kernel.org

We already have an API to flush a kernel page along an alias
address, so use it.  The TLB purge prevents the CPU from doing
speculative moveins on the flushed address, so we don't need to
implement and invalidate.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 arch/parisc/include/asm/cacheflush.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 7a73b61..4772777 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -38,6 +38,18 @@ void flush_cache_mm(struct mm_struct *mm);
 
 #define flush_kernel_dcache_range(start,size) \
 	flush_kernel_dcache_range_asm((start), (start)+(size));
+/* vmap range flushes and invalidates.  Architecturally, we don't need
+ * the invalidate, because the CPU should refuse to speculate once an
+ * area has been flushed, so invalidate is left empty */
+static inline void flush_kernel_vmap_range(void *vaddr, int size)
+{
+	unsigned long start = (unsigned long)vaddr;
+
+	flush_kernel_dcache_range_asm(start, start + size);
+}
+static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
+{
+}
 
 #define flush_cache_vmap(start, end)		flush_cache_all()
 #define flush_cache_vunmap(start, end)		flush_cache_all()
-- 
1.6.5

