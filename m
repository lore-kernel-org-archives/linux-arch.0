From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 07/28] ARCv2: MMUv4: cache programming model changes
Date: Tue, 9 Jun 2015 17:18:07 +0530
Message-ID: <1433850508-26317-8-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Caveats about cache flush on ARCv2 based cores

- dcache is PIPT so paddr is sufficient for cache maintenance ops (no
  need to setup PTAG reg

- icache is still VIPT but only aliasing configs need PTAG setup

So basically this is departure from MMU-v3 which always need vaddr in
line ops registers (DC_IVDL, DC_FLDL, IC_IVIL) but paddr in DC_PTAG,
IC_PTAG respectively.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig               |   2 +-
 arch/arc/include/asm/arcregs.h |   5 +-
 arch/arc/include/asm/cache.h   |   3 ++
 arch/arc/mm/cache.c            | 112 +++++++++++++++++++++++++++++++++++------
 4 files changed, 104 insertions(+), 18 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 6568977bb302..974ed9058018 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -223,7 +223,7 @@ config ARC_CACHE_PAGES
 
 config ARC_CACHE_VIPT_ALIASING
 	bool "Support VIPT Aliasing D$"
-	depends on ARC_HAS_DCACHE
+	depends on ARC_HAS_DCACHE && ISA_ARCOMPACT
 	default n
 
 endif	#ARC_CACHE
diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 3a56cd00c59e..4db1af296454 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -17,6 +17,7 @@
 #define ARC_REG_FP_BCR		0x6B	/* ARCompact: Single-Precision FPU */
 #define ARC_REG_DPFP_BCR	0x6C	/* ARCompact: Dbl Precision FPU */
 #define ARC_REG_FP_V2_BCR	0xc8	/* ARCv2 FPU */
+#define ARC_REG_SLC_BCR		0xce
 #define ARC_REG_DCCM_BCR	0x74	/* DCCM Present + SZ */
 #define ARC_REG_TIMERS_BCR	0x75
 #define ARC_REG_AP_BCR		0x76
@@ -330,7 +331,7 @@ struct cpuinfo_arc_mmu {
 };
 
 struct cpuinfo_arc_cache {
-	unsigned int sz_k:8, line_len:8, assoc:4, ver:4, alias:1, vipt:1, pad:6;
+	unsigned int sz_k:14, line_len:8, assoc:4, ver:4, alias:1, vipt:1;
 };
 
 struct cpuinfo_arc_bpu {
@@ -342,7 +343,7 @@ struct cpuinfo_arc_ccm {
 };
 
 struct cpuinfo_arc {
-	struct cpuinfo_arc_cache icache, dcache;
+	struct cpuinfo_arc_cache icache, dcache, slc;
 	struct cpuinfo_arc_mmu mmu;
 	struct cpuinfo_arc_bpu bpu;
 	struct bcr_identity core;
diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index 7861255da32d..e54977a7d006 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -82,4 +82,7 @@ extern void read_decode_cache_bcr(void);
 #define DC_CTRL_INV_MODE_FLUSH  0x40
 #define DC_CTRL_FLUSH_STATUS    0x100
 
+/*System-level cache (L2 cache) related Auxiliary registers */
+#define ARC_REG_SLC_CFG		0x901
+
 #endif /* _ASM_CACHE_H */
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 6fa5f0f7f549..7a898f57d84b 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -24,6 +24,7 @@
 char *arc_cache_mumbojumbo(int c, char *buf, int len)
 {
 	int n = 0;
+	struct cpuinfo_arc_cache *p;
 
 #define PR_CACHE(p, cfg, str)						\
 	if (!(p)->ver)							\
@@ -39,6 +40,11 @@ char *arc_cache_mumbojumbo(int c, char *buf, int len)
 	PR_CACHE(&cpuinfo_arc700[c].icache, CONFIG_ARC_HAS_ICACHE, "I-Cache");
 	PR_CACHE(&cpuinfo_arc700[c].dcache, CONFIG_ARC_HAS_DCACHE, "D-Cache");
 
+	p = &cpuinfo_arc700[c].slc;
+	if (p->ver)
+		n += scnprintf(buf + n, len - n,
+			"SLC\t\t: %uK, %uB Line\n", p->sz_k, p->line_len);
+
 	return buf;
 }
 
@@ -49,7 +55,7 @@ char *arc_cache_mumbojumbo(int c, char *buf, int len)
  */
 void read_decode_cache_bcr(void)
 {
-	struct cpuinfo_arc_cache *p_ic, *p_dc;
+	struct cpuinfo_arc_cache *p_ic, *p_dc, *p_slc;
 	unsigned int cpu = smp_processor_id();
 	struct bcr_cache {
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -59,14 +65,29 @@ void read_decode_cache_bcr(void)
 #endif
 	} ibcr, dbcr;
 
+	struct bcr_generic sbcr;
+
+	struct bcr_slc_cfg {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		unsigned int pad:24, way:2, lsz:2, sz:4;
+#else
+		unsigned int sz:4, lsz:2, way:2, pad:24;
+#endif
+	} slc_cfg;
+
 	p_ic = &cpuinfo_arc700[cpu].icache;
 	READ_BCR(ARC_REG_IC_BCR, ibcr);
 
 	if (!ibcr.ver)
 		goto dc_chk;
 
-	BUG_ON(ibcr.config != 3);
-	p_ic->assoc = 2;		/* Fixed to 2w set assoc */
+	if (ibcr.ver <= 3) {
+		BUG_ON(ibcr.config != 3);
+		p_ic->assoc = 2;		/* Fixed to 2w set assoc */
+	} else if (ibcr.ver >= 4) {
+		p_ic->assoc = 1 << ibcr.config;	/* 1,2,4,8 */
+	}
+
 	p_ic->line_len = 8 << ibcr.line_len;
 	p_ic->sz_k = 1 << (ibcr.sz - 1);
 	p_ic->ver = ibcr.ver;
@@ -78,15 +99,32 @@ dc_chk:
 	READ_BCR(ARC_REG_DC_BCR, dbcr);
 
 	if (!dbcr.ver)
-		return;
+		goto slc_chk;
+
+	if (dbcr.ver <= 3) {
+		BUG_ON(dbcr.config != 2);
+		p_dc->assoc = 4;		/* Fixed to 4w set assoc */
+		p_dc->vipt = 1;
+		p_dc->alias = p_dc->sz_k/p_dc->assoc/TO_KB(PAGE_SIZE) > 1;
+	} else if (dbcr.ver >= 4) {
+		p_dc->assoc = 1 << dbcr.config;	/* 1,2,4,8 */
+		p_dc->vipt = 0;
+		p_dc->alias = 0;		/* PIPT so can't VIPT alias */
+	}
 
-	BUG_ON(dbcr.config != 2);
-	p_dc->assoc = 4;		/* Fixed to 4w set assoc */
 	p_dc->line_len = 16 << dbcr.line_len;
 	p_dc->sz_k = 1 << (dbcr.sz - 1);
 	p_dc->ver = dbcr.ver;
-	p_dc->vipt = 1;
-	p_dc->alias = p_dc->sz_k/p_dc->assoc/TO_KB(PAGE_SIZE) > 1;
+
+slc_chk:
+	p_slc = &cpuinfo_arc700[cpu].slc;
+	READ_BCR(ARC_REG_SLC_BCR, sbcr);
+	if (sbcr.ver) {
+		READ_BCR(ARC_REG_SLC_CFG, slc_cfg);
+		p_slc->ver = sbcr.ver;
+		p_slc->sz_k = 128 << slc_cfg.sz;
+		p_slc->line_len = (slc_cfg.lsz == 0) ? 128 : 64;
+	}
 }
 
 /*
@@ -225,10 +263,53 @@ void __cache_line_loop_v3(unsigned long paddr, unsigned long vaddr,
 	}
 }
 
+/*
+ * In HS38x (MMU v4), although icache is VIPT, only paddr is needed for cache
+ * maintenance ops (in IVIL reg), as long as icache doesn't alias.
+ *
+ * For Aliasing icache, vaddr is also needed (in IVIL), while paddr is
+ * specified in PTAG (similar to MMU v3)
+ */
+static inline
+void __cache_line_loop_v4(unsigned long paddr, unsigned long vaddr,
+			  unsigned long sz, const int cacheop)
+{
+	unsigned int aux_cmd;
+	int num_lines;
+	const int full_page_op = __builtin_constant_p(sz) && sz == PAGE_SIZE;
+
+	if (cacheop == OP_INV_IC) {
+		aux_cmd = ARC_REG_IC_IVIL;
+	} else {
+		/* d$ cmd: INV (discard or wback-n-discard) OR FLUSH (wback) */
+		aux_cmd = cacheop & OP_INV ? ARC_REG_DC_IVDL : ARC_REG_DC_FLDL;
+	}
+
+	/* Ensure we properly floor/ceil the non-line aligned/sized requests
+	 * and have @paddr - aligned to cache line and integral @num_lines.
+	 * This however can be avoided for page sized since:
+	 *  -@paddr will be cache-line aligned already (being page aligned)
+	 *  -@sz will be integral multiple of line size (being page sized).
+	 */
+	if (!full_page_op) {
+		sz += paddr & ~CACHE_LINE_MASK;
+		paddr &= CACHE_LINE_MASK;
+	}
+
+	num_lines = DIV_ROUND_UP(sz, L1_CACHE_BYTES);
+
+	while (num_lines-- > 0) {
+		write_aux_reg(aux_cmd, paddr);
+		paddr += L1_CACHE_BYTES;
+	}
+}
+
 #if (CONFIG_ARC_MMU_VER < 3)
 #define __cache_line_loop	__cache_line_loop_v2
 #elif (CONFIG_ARC_MMU_VER == 3)
 #define __cache_line_loop	__cache_line_loop_v3
+#elif (CONFIG_ARC_MMU_VER > 3)
+#define __cache_line_loop	__cache_line_loop_v4
 #endif
 
 #ifdef CONFIG_ARC_HAS_DCACHE
@@ -669,7 +750,6 @@ void arc_cache_init(void)
 
 	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {
 		struct cpuinfo_arc_cache *dc = &cpuinfo_arc700[cpu].dcache;
-		int handled;
 
 		if (!dc->ver)
 			panic("cache support enabled but non-existent cache\n");
@@ -678,12 +758,14 @@ void arc_cache_init(void)
 			panic("DCache line [%d] != kernel Config [%d]",
 			      dc->line_len, L1_CACHE_BYTES);
 
-		/* check for D-Cache aliasing */
-		handled = IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);
+		/* check for D-Cache aliasing on ARCompact: ARCv2 has PIPT */
+		if (is_isa_arcompact()) {
+			int handled = IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);
 
-		if (dc->alias && !handled)
-			panic("Enable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
-		else if (!dc->alias && handled)
-			panic("Disable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
+			if (dc->alias && !handled)
+				panic("Enable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
+			else if (!dc->alias && handled)
+				panic("Disable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
+		}
 	}
 }
-- 
1.9.1
