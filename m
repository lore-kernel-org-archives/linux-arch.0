From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCHv3 4/5] sh: add mm API for DMA to vmalloc/vmap areas
Date: Fri,  5 Feb 2010 09:50:56 -0600
Message-ID: <1265385057-2575-5-git-send-email-James.Bottomley@suse.de>
References: <1265385057-2575-1-git-send-email-James.Bottomley@suse.de>
 <1265385057-2575-2-git-send-email-James.Bottomley@suse.de>
 <1265385057-2575-3-git-send-email-James.Bottomley@suse.de>
 <1265385057-2575-4-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1265385057-2575-4-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, rmk@arm.linux.org.uk, lethal@linux-sh.org, torvalds@linux-foundation.org, hch@lst.de, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 arch/sh/include/asm/cacheflush.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index dda96eb..da3ebec 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -63,6 +63,14 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 	if (boot_cpu_data.dcache.n_aliases && PageAnon(page))
 		__flush_anon_page(page, vmaddr);
 }
+static inline void flush_kernel_vmap_range(void *addr, int size)
+{
+	__flush_wback_region(addr, size);
+}
+static inline void invalidate_kernel_vmap_range(void *addr, int size)
+{
+	__flush_invalidate_region(addr, size);
+}
 
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 static inline void flush_kernel_dcache_page(struct page *page)
-- 
1.6.5

