From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 32/33] csky: fix flush_cache_range and tlb_start_vma
Date: Fri, 28 Sep 2018 08:51:29 +0800
Message-ID: <33f94d1b44080b4dd39759443a8c4704c70cab01.1538058840.git.ren_guo@c-sky.com>
References: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

In flush_cache_range(vma, ...) cache_wbinv_range() couldn't deal with
vma->mm's asid for cache_flush_line. So we use cache_wbinv_all() first
and we'll improve with cache_flush(vma, start, end) in future.

For tlb_start_vma, we make it the same as other arch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/inc/abi/cacheflush.h | 6 +++++-
 arch/csky/abiv1/inc/abi/tlb.h        | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index f0de49c..4ae81b0 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -15,7 +15,11 @@ extern void flush_dcache_page(struct page *);
 #define flush_cache_page(vma,page,pfn)	cache_wbinv_all()
 #define flush_cache_dup_mm(mm)		cache_wbinv_all()
 
-#define flush_cache_range(mm,start,end)	cache_wbinv_range(start, end)
+/*
+ * if (current_mm != vma->mm) cache_wbinv_range(start, end) will be broken.
+ * Use cache_wbinv_all() here and need to be improved in future.
+ */
+#define flush_cache_range(vma,start,end)	cache_wbinv_all()
 #define flush_cache_vmap(start, end)	cache_wbinv_range(start, end)
 #define flush_cache_vunmap(start, end)  cache_wbinv_range(start, end)
 
diff --git a/arch/csky/abiv1/inc/abi/tlb.h b/arch/csky/abiv1/inc/abi/tlb.h
index 6d461f3..3b9d6d9 100644
--- a/arch/csky/abiv1/inc/abi/tlb.h
+++ b/arch/csky/abiv1/inc/abi/tlb.h
@@ -7,6 +7,6 @@
 #define tlb_start_vma(tlb, vma) \
 	do { \
 		if (!tlb->fullmm) \
-			cache_wbinv_all(); \
+			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
 	}  while (0)
 #endif /* __ABI_CSKY_TLB_H */
-- 
2.7.4
