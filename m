From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCHv2 3/5] arm: add mm API for DMA to vmalloc/vmap areas
Date: Wed, 23 Dec 2009 15:22:23 -0600
Message-ID: <1261603345-2494-4-git-send-email-James.Bottomley@suse.de>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de>
 <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
 <1261603345-2494-3-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58592 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757185AbZLWVWz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 23 Dec 2009 16:22:55 -0500
In-Reply-To: <1261603345-2494-3-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <James.Bottomley@suse.de>

ARM cannot prevent cache movein, so this patch implements both the
flush and invalidate pieces of the API.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 arch/arm/include/asm/cacheflush.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 730aefc..4ae503c 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -432,6 +432,16 @@ static inline void __flush_icache_all(void)
 	    : "r" (0));
 #endif
 }
+static inline void flush_kernel_vmap_range(void *addr, int size)
+{
+	if ((cache_is_vivt() || cache_is_vipt_aliasing()))
+	  __cpuc_flush_dcache_area(addr, (size_t)size);
+}
+static inline void invalidate_kernel_vmap_range(void *addr, int size)
+{
+	if ((cache_is_vivt() || cache_is_vipt_aliasing()))
+	  __cpuc_flush_dcache_area(addr, (size_t)size);
+}
 
 #define ARCH_HAS_FLUSH_ANON_PAGE
 static inline void flush_anon_page(struct vm_area_struct *vma,
-- 
1.6.5
