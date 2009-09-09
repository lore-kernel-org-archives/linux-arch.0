From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 3/5] arm: add mm API for DMA to vmalloc/vmap areas
Date: Tue, 08 Sep 2009 22:20:09 -0500
Message-ID: <1252466409.13003.371.camel@mulgrave.site>
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



