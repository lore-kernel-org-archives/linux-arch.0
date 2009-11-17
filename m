From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 4/6] sh: add mm API for DMA to vmalloc/vmap areas
Date: Tue, 17 Nov 2009 11:03:50 -0600
Message-ID: <1258477432-2513-5-git-send-email-James.Bottomley@suse.de>
References: <1258477432-2513-1-git-send-email-James.Bottomley@suse.de>
 <1258477432-2513-2-git-send-email-James.Bottomley@suse.de>
 <1258477432-2513-3-git-send-email-James.Bottomley@suse.de>
 <1258477432-2513-4-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1258477432-2513-4-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: James Bottomley <James.Bottomley@suse.de>
List-Id: linux-arch.vger.kernel.org

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

