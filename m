From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 1/5] mm: add coherence API for DMA to vmalloc/vmap areas
Date: Wed, 09 Sep 2009 03:17:06 +0000
Message-ID: <1252466226.13003.367.camel@mulgrave.site>
References: <1252434469.13003.3.camel@mulgrave.site>
	 <20090908190031.GF6538@flint.arm.linux.org.uk>
	 <1252437112.13003.39.camel@mulgrave.site>
	 <20090908201619.GG6538@flint.arm.linux.org.uk>
	 <1252442352.13003.132.camel@mulgrave.site>
	 <20090908213910.GH6538@flint.arm.linux.org.uk>
	 <1252466070.13003.365.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1252466070.13003.365.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

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
 include/linux/highmem.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 211ff44..9719952 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -17,6 +17,12 @@ static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page
 static inline void flush_kernel_dcache_page(struct page *page)
 {
 }
+static incline void flush_kernel_dcache_addr(void *vaddr)
+{
+}
+static incline void invalidate_kernel_dcache_addr(void *vaddr)
+{
+}
 #endif
 
 #include <asm/kmap_types.h>
-- 
1.6.3.3



