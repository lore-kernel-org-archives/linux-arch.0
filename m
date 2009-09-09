Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33561 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbZIIDUQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Sep 2009 23:20:16 -0400
Subject: [PATCH 3/5] arm: add mm API for DMA to vmalloc/vmap areas
From: James Bottomley <James.Bottomley@suse.de>
In-Reply-To: <1252466070.13003.365.camel@mulgrave.site>
References: <1252434469.13003.3.camel@mulgrave.site>
	 <20090908190031.GF6538@flint.arm.linux.org.uk>
	 <1252437112.13003.39.camel@mulgrave.site>
	 <20090908201619.GG6538@flint.arm.linux.org.uk>
	 <1252442352.13003.132.camel@mulgrave.site>
	 <20090908213910.GH6538@flint.arm.linux.org.uk>
	 <1252466070.13003.365.camel@mulgrave.site>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 22:20:09 -0500
Message-ID: <1252466409.13003.371.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Message-ID: <20090909032009.Aw8YP1tA0S0BMEnz2J7WtAg6YFvlD__9Fb1Ul4SbMPM@z>

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



