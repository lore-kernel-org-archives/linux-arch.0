From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCHv3 1/5] mm: add coherence API for DMA to vmalloc/vmap areas
Date: Fri,  5 Feb 2010 09:50:53 -0600
Message-ID: <1265385057-2575-2-git-send-email-James.Bottomley@suse.de>
References: <1265385057-2575-1-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52409 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753586Ab0BEPvH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Feb 2010 10:51:07 -0500
In-Reply-To: <1265385057-2575-1-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, rmk@arm.linux.org.uk, lethal@linux-sh.org, torvalds@linux-foundation.org, hch@lst.de, James Bottomley <James.Bottomley@suse.de>

On Virtually Indexed architectures (which don't do automatic alias
resolution in their caches), we have to flush via the correct
virtual address to prepare pages for DMA.  On some architectures
(like arm) we cannot prevent the CPU from doing data movein along
the alias (and thus giving stale read data), so we not only have to
introduce a flush API to push dirty cache lines out, but also an invalidate
API to kill inconsistent cache lines that may have moved in before
DMA changed the data

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 Documentation/cachetlb.txt |   24 ++++++++++++++++++++++++
 include/linux/highmem.h    |    6 ++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/cachetlb.txt b/Documentation/cachetlb.txt
index da42ab4..b231414 100644
--- a/Documentation/cachetlb.txt
+++ b/Documentation/cachetlb.txt
@@ -377,3 +377,27 @@ maps this page at its virtual address.
 	All the functionality of flush_icache_page can be implemented in
 	flush_dcache_page and update_mmu_cache. In 2.7 the hope is to
 	remove this interface completely.
+
+The final category of APIs is for I/O to deliberately aliased address
+ranges inside the kernel.  Such aliases are set up by use of the
+vmap/vmalloc API.  Since kernel I/O goes via physical pages, the I/O
+subsystem assumes that the user mapping and kernel offset mapping are
+the only aliases.  This isn't true for vmap aliases, so anything in
+the kernel trying to do I/O to vmap areas must manually manage
+coherency.  It must do this by flushing the vmap range before doing
+I/O and invalidating it after the I/O returns.
+
+  void flush_kernel_vmap_range(void *vaddr, int size)
+       flushes the kernel cache for a given virtual address range in
+       the vmap area.  This is to make sure that any data the kernel
+       modified in the vmap range is made visible to the physical
+       page.  The design is to make this area safe to perform I/O on.
+       Note that this API does *not* also flush the offset map alias
+       of the area.
+
+  void invalidate_kernel_vmap_range(void *vaddr, int size) invalidates
+       the cache for a given virtual address range in the vmap area
+       which prevents the processor from making the cache stale by
+       speculatively reading data while the I/O was occurring to the
+       physical pages.  This is only necessary for data reads into the
+       vmap area.
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 211ff44..adfe101 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -17,6 +17,12 @@ static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page
 static inline void flush_kernel_dcache_page(struct page *page)
 {
 }
+static inline void flush_kernel_vmap_range(void *vaddr, int size)
+{
+}
+static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
+{
+}
 #endif
 
 #include <asm/kmap_types.h>
-- 
1.6.5
