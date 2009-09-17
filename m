From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 4/6] sh: add mm API for DMA to vmalloc/vmap areas
Date: Thu, 17 Sep 2009 18:06:59 -0500
Message-ID: <1253228821-4700-5-git-send-email-James.Bottomley@suse.de>
References: <1253228821-4700-1-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-2-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-3-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-4-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1253228821-4700-4-git-send-email-James.Bottomley@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-arch.vger.kernel.org

From: James Bottomley <James.Bottomley@HansenPartnership.com>

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 arch/sh/include/asm/cacheflush.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index 4c5462d..3cb8824 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -48,6 +48,14 @@ static inline void flush_kernel_dcache_page(struct page *page)
 {
 	flush_dcache_page(page);
 }
+static inline void flush_kernel_dcache_addr(void *addr)
+{
+	__flush_wback_region(addr, PAGE_SIZE);
+}
+static inline void invalidate_kernel_dcache_addr(void *addr)
+{
+	__flush_invalidate_region(addr, PAGE_SIZE);
+}
 
 #if defined(CONFIG_CPU_SH4) && !defined(CONFIG_CACHE_OFF)
 extern void copy_to_user_page(struct vm_area_struct *vma,
-- 
1.6.3.3

