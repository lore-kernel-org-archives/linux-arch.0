Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57683 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbZIIPwb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 Sep 2009 11:52:31 -0400
From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 2/6] parisc: add mm API for DMA to vmalloc/vmap areas
Date: Wed,  9 Sep 2009 10:52:12 -0500
Message-ID: <1252511536-22066-3-git-send-email-James.Bottomley@suse.de>
In-Reply-To: <1252511536-22066-2-git-send-email-James.Bottomley@suse.de>
References: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-2-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <James.Bottomley@suse.de>
Message-ID: <20090909155212.d_k1oG18tFfk-SUR2kPsjrvOvj8omd7mgvlc8E69IW0@z>

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

