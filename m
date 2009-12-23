Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58596 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757277AbZLWVW5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 23 Dec 2009 16:22:57 -0500
From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCHv2 4/5] sh: add mm API for DMA to vmalloc/vmap areas
Date: Wed, 23 Dec 2009 15:22:24 -0600
Message-ID: <1261603345-2494-5-git-send-email-James.Bottomley@suse.de>
In-Reply-To: <1261603345-2494-4-git-send-email-James.Bottomley@suse.de>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de>
 <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
 <1261603345-2494-3-git-send-email-James.Bottomley@suse.de>
 <1261603345-2494-4-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <James.Bottomley@suse.de>
Message-ID: <20091223212224.-KN54BUVpst-lhmzxuTC61DAuWZA0c6EXXnQUU_R5ho@z>

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

