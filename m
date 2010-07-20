From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5/5] ARM: Remove superfluous flush_kernel_dcache_page()
Date: Tue, 20 Jul 2010 18:12:29 +0100
Message-ID: <20100720171229.19582.31539.stgit@e102109-lin.cambridge.arm.com>
References: <20100720171201.19582.85920.stgit@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38969 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755582Ab0GTRMp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Jul 2010 13:12:45 -0400
In-Reply-To: <20100720171201.19582.85920.stgit@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>

Since page cache pages are now considered 'dirty' by default, the cache
flushing is handled via __flush_dcache_page() when a page gets mapped to
user space. Highmem pages on VIVT systems are flushed during kunmap()
and flush_kernel_dcache_page() was already a no-op in this case.

ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE is still defined since ARM needs
specific implementations for flush_kernel_vmap_range() and
invalidate_kernel_vmap_range().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/cacheflush.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index d3730f0..042e139 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -405,9 +405,6 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 static inline void flush_kernel_dcache_page(struct page *page)
 {
-	/* highmem pages are always flushed upon kunmap already */
-	if ((cache_is_vivt() || cache_is_vipt_aliasing()) && !PageHighMem(page))
-		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
 }
 
 #define flush_dcache_mmap_lock(mapping) \
