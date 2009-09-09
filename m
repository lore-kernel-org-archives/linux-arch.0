From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 4/6] sh: add mm API for DMA to vmalloc/vmap areas
Date: Wed,  9 Sep 2009 10:52:14 -0500
Message-ID: <1252511536-22066-5-git-send-email-James.Bottomley@suse.de>
References: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-2-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-3-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-4-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47989 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbZIIPwe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 Sep 2009 11:52:34 -0400
In-Reply-To: <1252511536-22066-4-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <James.Bottomley@suse.de>

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 arch/sh/include/asm/cacheflush.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index 4c5462d..db06611 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -48,6 +48,14 @@ static inline void flush_kernel_dcache_page(struct page *page)
 {
 	flush_dcache_page(page);
 }
+static inline void flush_kernel_dcache_addr(void *addr)
+{
+	__flush_invalidate_region(addr, PAGE_SIZE);
+}
+static inline void invalidate_kernel_dcache_addr(void *addr)
+{
+	__flush_invalidate_region(addr, PAGE_SIZE);
+}
 
 #if defined(CONFIG_CPU_SH4) && !defined(CONFIG_CACHE_OFF)
 extern void copy_to_user_page(struct vm_area_struct *vma,
-- 
1.6.3.3
