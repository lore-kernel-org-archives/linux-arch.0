Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33453 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbZIIDSX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Sep 2009 23:18:23 -0400
Subject: [PATCH 2/5] parisc: add mm API for DMA to vmalloc/vmap areas
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
Date: Wed, 09 Sep 2009 03:18:17 +0000
Message-ID: <1252466297.13003.369.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Message-ID: <20090909031817.FL73YZW_rhJRpJYK1AyCzaRxa-RL9n7SmdZ7Hg145o8@z>

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



