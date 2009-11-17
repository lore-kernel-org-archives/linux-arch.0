Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47467 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610AbZKQRD6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Nov 2009 12:03:58 -0500
From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 3/6] arm: add mm API for DMA to vmalloc/vmap areas
Date: Tue, 17 Nov 2009 11:03:49 -0600
Message-ID: <1258477432-2513-4-git-send-email-James.Bottomley@suse.de>
In-Reply-To: <1258477432-2513-3-git-send-email-James.Bottomley@suse.de>
References: <1258477432-2513-1-git-send-email-James.Bottomley@suse.de>
 <1258477432-2513-2-git-send-email-James.Bottomley@suse.de>
 <1258477432-2513-3-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: James Bottomley <James.Bottomley@suse.de>
Message-ID: <20091117170349.bOPT6ydSbHvetS1Fh8lyNF0aLpg7k6P1jHSCAav_ZMg@z>

ARM cannot prevent cache movein, so this patch implements both the
flush and invalidate pieces of the API.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 arch/arm/include/asm/cacheflush.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 1a711ea..1104ee9 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -436,6 +436,16 @@ static inline void flush_kernel_dcache_page(struct page *page)
 	if ((cache_is_vivt() || cache_is_vipt_aliasing()) && !PageHighMem(page))
 		__cpuc_flush_dcache_page(page_address(page));
 }
+static inline void flush_kernel_dcache_addr(void *addr)
+{
+	if ((cache_is_vivt() || cache_is_vipt_aliasing()))
+		__cpuc_flush_dcache_page(addr);
+}
+static inline void invalidate_kernel_dcache_addr(void *addr)
+{
+	if ((cache_is_vivt() || cache_is_vipt_aliasing()))
+		__cpuc_flush_dcache_page(addr);
+}
 
 #define flush_dcache_mmap_lock(mapping) \
 	spin_lock_irq(&(mapping)->tree_lock)
-- 
1.6.3.3

