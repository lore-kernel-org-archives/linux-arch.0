From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 2/6] parisc: add mm API for DMA to vmalloc/vmap areas
Date: Thu, 17 Sep 2009 18:06:57 -0500
Message-ID: <1253228821-4700-3-git-send-email-James.Bottomley@suse.de>
References: <1253228821-4700-1-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-2-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1253228821-4700-2-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <jejb@external.hp.com>, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-arch.vger.kernel.org

From: James Bottomley <jejb@external.hp.com>

We already have an API to flush a kernel page along an alias
address, so use it.  The TLB purge prevents the CPU from doing
speculative moveins on the flushed address, so we don't need to
implement and invalidate.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 arch/parisc/include/asm/cacheflush.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 7243951..2536a00 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -90,6 +90,14 @@ static inline void flush_kernel_dcache_page(struct page *page)
 {
 	flush_kernel_dcache_page_addr(page_address(page));
 }
+static inline void flush_kernel_dcache_addr(void *addr)
+{
+	flush_kernel_dcache_page_addr(addr);
+}
+static inline void invalidate_kernel_dcache_addr(void *addr)
+{
+	/* nop .. the flush prevents move in until the page is touched */
+}
 
 #ifdef CONFIG_DEBUG_RODATA
 void mark_rodata_ro(void);
-- 
1.6.3.3

