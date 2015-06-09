From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 23/28] ARCv2: SLC: Handle explcit flush for DMA ops (w/o IO-coherency)
Date: Tue, 9 Jun 2015 17:18:23 +0530
Message-ID: <1433850508-26317-24-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

L2 cache on ARCHS processors is called SLC (System Level Cache)
For working DMA (in absence of hardware assisted IO Coherency) we need
to manage SLC explicitly when buffers transition between cpu and
controllers.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/cache.h | 11 ++++++++
 arch/arc/mm/cache.c          | 64 ++++++++++++++++++++++++++++++++++++++++++--
 arch/arc/mm/dma.c            | 12 +++++++++
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index d21c76d6b054..d67345d3e2d4 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -82,5 +82,16 @@ extern void read_decode_cache_bcr(void);
 
 /*System-level cache (L2 cache) related Auxiliary registers */
 #define ARC_REG_SLC_CFG		0x901
+#define ARC_REG_SLC_CTRL	0x903
+#define ARC_REG_SLC_FLUSH	0x904
+#define ARC_REG_SLC_INVALIDATE	0x905
+#define ARC_REG_SLC_RGN_START	0x914
+#define ARC_REG_SLC_RGN_END	0x916
+
+/* Bit val in SLC_CONTROL */
+#define SLC_CTRL_IM		0x040
+#define SLC_CTRL_DISABLE	0x001
+#define SLC_CTRL_BUSY		0x100
+#define SLC_CTRL_RGN_OP_INV	0x200
 
 #endif /* _ASM_CACHE_H */
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 0eaaee60fd0b..b29d62ed4f7e 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -21,6 +21,8 @@
 #include <asm/cachectl.h>
 #include <asm/setup.h>
 
+static int l2_line_sz;
+
 void (*_cache_line_loop_ic_fn)(unsigned long paddr, unsigned long vaddr,
 			       unsigned long sz, const int cacheop);
 
@@ -120,13 +122,16 @@ dc_chk:
 	p_dc->ver = dbcr.ver;
 
 slc_chk:
+	if (!is_isa_arcv2())
+		return;
+
 	p_slc = &cpuinfo_arc700[cpu].slc;
 	READ_BCR(ARC_REG_SLC_BCR, sbcr);
 	if (sbcr.ver) {
 		READ_BCR(ARC_REG_SLC_CFG, slc_cfg);
 		p_slc->ver = sbcr.ver;
 		p_slc->sz_k = 128 << slc_cfg.sz;
-		p_slc->line_len = (slc_cfg.lsz == 0) ? 128 : 64;
+		l2_line_sz = p_slc->line_len = (slc_cfg.lsz == 0) ? 128 : 64;
 	}
 }
 
@@ -460,6 +465,53 @@ static void __ic_line_inv_vaddr(unsigned long paddr, unsigned long vaddr,
 
 #endif /* CONFIG_ARC_HAS_ICACHE */
 
+noinline void slc_op(unsigned long paddr, unsigned long sz, const int op)
+{
+#ifdef CONFIG_ISA_ARCV2
+	unsigned long flags;
+	unsigned int ctrl;
+
+	local_irq_save(flags);
+
+	/*
+	 * The Region Flush operation is specified by CTRL.RGN_OP[11..9]
+	 *  - b'000 (default) is Flush,
+	 *  - b'001 is Invalidate if CTRL.IM == 0
+	 *  - b'001 is Flush-n-Invalidate if CTRL.IM == 1
+	 */
+	ctrl = read_aux_reg(ARC_REG_SLC_CTRL);
+
+	/* Don't rely on default value of IM bit */
+	if (!(op & OP_FLUSH))		/* i.e. OP_INV */
+		ctrl &= ~SLC_CTRL_IM;	/* clear IM: Disable flush before Inv */
+	else
+		ctrl |= SLC_CTRL_IM;
+
+	if (op & OP_INV)
+		ctrl |= SLC_CTRL_RGN_OP_INV;	/* Inv or flush-n-inv */
+	else
+		ctrl &= ~SLC_CTRL_RGN_OP_INV;
+
+	write_aux_reg(ARC_REG_SLC_CTRL, ctrl);
+
+	/*
+	 * Lower bits are ignored, no need to clip
+	 * END needs to be setup before START (latter triggers the operation)
+	 * END can't be same as START, so add (l2_line_sz - 1) to sz
+	 */
+	write_aux_reg(ARC_REG_SLC_RGN_END, (paddr + sz + l2_line_sz - 1));
+	write_aux_reg(ARC_REG_SLC_RGN_START, paddr);
+
+	while (read_aux_reg(ARC_REG_SLC_CTRL) & SLC_CTRL_BUSY);
+
+	local_irq_restore(flags);
+#endif
+}
+
+static inline int need_slc_flush(void)
+{
+	return is_isa_arcv2() && l2_line_sz;
+}
 
 /***********************************************************
  * Exported APIs
@@ -509,22 +561,30 @@ void flush_dcache_page(struct page *page)
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
-
 void dma_cache_wback_inv(unsigned long start, unsigned long sz)
 {
 	__dc_line_op_k(start, sz, OP_FLUSH_N_INV);
+
+	if (need_slc_flush())
+		slc_op(start, sz, OP_FLUSH_N_INV);
 }
 EXPORT_SYMBOL(dma_cache_wback_inv);
 
 void dma_cache_inv(unsigned long start, unsigned long sz)
 {
 	__dc_line_op_k(start, sz, OP_INV);
+
+	if (need_slc_flush())
+		slc_op(start, sz, OP_INV);
 }
 EXPORT_SYMBOL(dma_cache_inv);
 
 void dma_cache_wback(unsigned long start, unsigned long sz)
 {
 	__dc_line_op_k(start, sz, OP_FLUSH);
+
+	if (need_slc_flush())
+		slc_op(start, sz, OP_FLUSH);
 }
 EXPORT_SYMBOL(dma_cache_wback);
 
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 2cfe81dca92a..74a637a1cfc4 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -66,6 +66,18 @@ void *dma_alloc_coherent(struct device *dev, size_t size,
 	/* This is bus address, platform dependent */
 	*dma_handle = (dma_addr_t)paddr;
 
+	/*
+	 * Evict any existing L1 and/or L2 lines for the backing page
+	 * in case it was used earlier as a normal "cached" page.
+	 * Yeah this bit us - STAR 9000898266
+	 *
+	 * Although core does call flush_cache_vmap(), it gets kvaddr hence
+	 * can't be used to efficiently flush L1 and/or L2 which need paddr
+	 * Currently flush_cache_vmap nukes the L1 cache completely which
+	 * will be optimized as a separate commit
+	 */
+	dma_cache_wback_inv((unsigned long)paddr, size);
+
 	return kvaddr;
 }
 EXPORT_SYMBOL(dma_alloc_coherent);
-- 
1.9.1
