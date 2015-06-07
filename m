From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 02/19] ARC: cacheflush: move some code around, delete old comments
Date: Sun, 7 Jun 2015 14:08:06 +0530
Message-ID: <1433666303-26112-3-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:37832 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932777AbbFGIju (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:50 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/cache.c | 267 ++++++++++++++++++++--------------------------------
 1 file changed, 102 insertions(+), 165 deletions(-)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 322e11b3b1e3..1d34a6978a83 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -1,64 +1,12 @@
 /*
- * ARC700 VIPT Cache Management
+ * ARC Cache Management
  *
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- *  vineetg: May 2011: for Non-aliasing VIPT D-cache following can be NOPs
- *   -flush_cache_dup_mm (fork)
- *   -likewise for flush_cache_mm (exit/execve)
- *   -likewise for flush_cache_range,flush_cache_page (munmap, exit, COW-break)
- *
- * vineetg: Apr 2011
- *  -Now that MMU can support larger pg sz (16K), the determiniation of
- *   aliasing shd not be based on assumption of 8k pg
- *
- * vineetg: Mar 2011
- *  -optimised version of flush_icache_range( ) for making I/D coherent
- *   when vaddr is available (agnostic of num of aliases)
- *
- * vineetg: Mar 2011
- *  -Added documentation about I-cache aliasing on ARC700 and the way it
- *   was handled up until MMU V2.
- *  -Spotted a three year old bug when killing the 4 aliases, which needs
- *   bottom 2 bits, so we need to do paddr | {0x00, 0x01, 0x02, 0x03}
- *                        instead of paddr | {0x00, 0x01, 0x10, 0x11}
- *   (Rajesh you owe me one now)
- *
- * vineetg: Dec 2010
- *  -Off-by-one error when computing num_of_lines to flush
- *   This broke signal handling with bionic which uses synthetic sigret stub
- *
- * vineetg: Mar 2010
- *  -GCC can't generate ZOL for core cache flush loops.
- *   Conv them into iterations based as opposed to while (start < end) types
- *
- * Vineetg: July 2009
- *  -In I-cache flush routine we used to chk for aliasing for every line INV.
- *   Instead now we setup routines per cache geometry and invoke them
- *   via function pointers.
- *
- * Vineetg: Jan 2009
- *  -Cache Line flush routines used to flush an extra line beyond end addr
- *   because check was while (end >= start) instead of (end > start)
- *     =Some call sites had to work around by doing -1, -4 etc to end param
- *     =Some callers didnt care. This was spec bad in case of INV routines
- *      which would discard valid data (cause of the horrible ext2 bug
- *      in ARC IDE driver)
- *
- * vineetg: June 11th 2008: Fixed flush_icache_range( )
- *  -Since ARC700 caches are not coherent (I$ doesnt snoop D$) both need
- *   to be flushed, which it was not doing.
- *  -load_module( ) passes vmalloc addr (Kernel Virtual Addr) to the API,
- *   however ARC cache maintenance OPs require PHY addr. Thus need to do
- *   vmalloc_to_phy.
- *  -Also added optimisation there, that for range > PAGE SIZE we flush the
- *   entire cache in one shot rather than line by line. For e.g. a module
- *   with Code sz 600k, old code flushed 600k worth of cache (line-by-line),
- *   while cache is only 16 or 32k.
  */
 
 #include <linux/module.h>
@@ -142,54 +90,8 @@ dc_chk:
 }
 
 /*
- * 1. Validate the Cache Geomtery (compile time config matches hardware)
- * 2. If I-cache suffers from aliasing, setup work arounds (difft flush rtn)
- *    (aliasing D-cache configurations are not supported YET)
- * 3. Enable the Caches, setup default flush mode for D-Cache
- * 3. Calculate the SHMLBA used by user space
+ * Line Operation on {I,D}-Cache
  */
-void arc_cache_init(void)
-{
-	unsigned int __maybe_unused cpu = smp_processor_id();
-	char str[256];
-
-	printk(arc_cache_mumbojumbo(0, str, sizeof(str)));
-
-	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE)) {
-		struct cpuinfo_arc_cache *ic = &cpuinfo_arc700[cpu].icache;
-
-		if (!ic->ver)
-			panic("cache support enabled but non-existent cache\n");
-
-		if (ic->line_len != L1_CACHE_BYTES)
-			panic("ICache line [%d] != kernel Config [%d]",
-			      ic->line_len, L1_CACHE_BYTES);
-
-		if (ic->ver != CONFIG_ARC_MMU_VER)
-			panic("Cache ver [%d] doesn't match MMU ver [%d]\n",
-			      ic->ver, CONFIG_ARC_MMU_VER);
-	}
-
-	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {
-		struct cpuinfo_arc_cache *dc = &cpuinfo_arc700[cpu].dcache;
-		int handled;
-
-		if (!dc->ver)
-			panic("cache support enabled but non-existent cache\n");
-
-		if (dc->line_len != L1_CACHE_BYTES)
-			panic("DCache line [%d] != kernel Config [%d]",
-			      dc->line_len, L1_CACHE_BYTES);
-
-		/* check for D-Cache aliasing */
-		handled = IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);
-
-		if (dc->alias && !handled)
-			panic("Enable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
-		else if (!dc->alias && handled)
-			panic("Don't need CONFIG_ARC_CACHE_VIPT_ALIASING\n");
-	}
-}
 
 #define OP_INV		0x1
 #define OP_FLUSH	0x2
@@ -197,16 +99,55 @@ void arc_cache_init(void)
 #define OP_INV_IC	0x4
 
 /*
- * Common Helper for Line Operations on {I,D}-Cache
+ *		I-Cache Aliasing in ARC700 VIPT caches (MMU v1-v3)
+ *
+ * ARC VIPT I-cache uses vaddr to index into cache and paddr to match the tag.
+ * The orig Cache Management Module "CDU" only required paddr to invalidate a
+ * certain line since it sufficed as index in Non-Aliasing VIPT cache-geometry.
+ * Infact for distinct V1,V2,P: all of {V1-P},{V2-P},{P-P} would end up fetching
+ * the exact same line.
+ *
+ * However for larger Caches (way-size > page-size) - i.e. in Aliasing config,
+ * paddr alone could not be used to correctly index the cache.
+ *
+ * ------------------
+ * MMU v1/v2 (Fixed Page Size 8k)
+ * ------------------
+ * The solution was to provide CDU with these additonal vaddr bits. These
+ * would be bits [x:13], x would depend on cache-geometry, 13 comes from
+ * standard page size of 8k.
+ * H/w folks chose [17:13] to be a future safe range, and moreso these 5 bits
+ * of vaddr could easily be "stuffed" in the paddr as bits [4:0] since the
+ * orig 5 bits of paddr were anyways ignored by CDU line ops, as they
+ * represent the offset within cache-line. The adv of using this "clumsy"
+ * interface for additional info was no new reg was needed in CDU programming
+ * model.
+ *
+ * 17:13 represented the max num of bits passable, actual bits needed were
+ * fewer, based on the num-of-aliases possible.
+ * -for 2 alias possibility, only bit 13 needed (32K cache)
+ * -for 4 alias possibility, bits 14:13 needed (64K cache)
+ *
+ * ------------------
+ * MMU v3
+ * ------------------
+ * This ver of MMU supports variable page sizes (1k-16k): although Linux will
+ * only support 8k (default), 16k and 4k.
+ * However from hardware perspective, smaller page sizes aggrevate aliasing
+ * meaning more vaddr bits needed to disambiguate the cache-line-op ;
+ * the existing scheme of piggybacking won't work for certain configurations.
+ * Two new registers IC_PTAG and DC_PTAG inttoduced.
+ * "tag" bits are provided in PTAG, index bits in existing IVIL/IVDL/FLDL regs
  */
+
 static inline void __cache_line_loop(unsigned long paddr, unsigned long vaddr,
-				     unsigned long sz, const int cacheop)
+				     unsigned long sz, const int op)
 {
 	unsigned int aux_cmd, aux_tag;
 	int num_lines;
 	const int full_page_op = __builtin_constant_p(sz) && sz == PAGE_SIZE;
 
-	if (cacheop == OP_INV_IC) {
+	if (op == OP_INV_IC) {
 		aux_cmd = ARC_REG_IC_IVIL;
 #if (CONFIG_ARC_MMU_VER > 2)
 		aux_tag = ARC_REG_IC_PTAG;
@@ -214,7 +155,7 @@ static inline void __cache_line_loop(unsigned long paddr, unsigned long vaddr,
 	}
 	else {
 		/* d$ cmd: INV (discard or wback-n-discard) OR FLUSH (wback) */
-		aux_cmd = cacheop & OP_INV ? ARC_REG_DC_IVDL : ARC_REG_DC_FLDL;
+		aux_cmd = op & OP_INV ? ARC_REG_DC_IVDL : ARC_REG_DC_FLDL;
 #if (CONFIG_ARC_MMU_VER > 2)
 		aux_tag = ARC_REG_DC_PTAG;
 #endif
@@ -296,107 +237,60 @@ static inline void __after_dc_op(const int op, unsigned int reg)
 
 /*
  * Operation on Entire D-Cache
- * @cacheop = {OP_INV, OP_FLUSH, OP_FLUSH_N_INV}
+ * @op = {OP_INV, OP_FLUSH, OP_FLUSH_N_INV}
  * Note that constant propagation ensures all the checks are gone
  * in generated code
  */
-static inline void __dc_entire_op(const int cacheop)
+static inline void __dc_entire_op(const int op)
 {
 	unsigned int ctrl_reg;
 	int aux;
 
-	ctrl_reg = __before_dc_op(cacheop);
+	ctrl_reg = __before_dc_op(op);
 
-	if (cacheop & OP_INV)	/* Inv or flush-n-inv use same cmd reg */
+	if (op & OP_INV)	/* Inv or flush-n-inv use same cmd reg */
 		aux = ARC_REG_DC_IVDC;
 	else
 		aux = ARC_REG_DC_FLSH;
 
 	write_aux_reg(aux, 0x1);
 
-	__after_dc_op(cacheop, ctrl_reg);
+	__after_dc_op(op, ctrl_reg);
 }
 
 /* For kernel mappings cache operation: index is same as paddr */
 #define __dc_line_op_k(p, sz, op)	__dc_line_op(p, p, sz, op)
 
 /*
- * D-Cache : Per Line INV (discard or wback+discard) or FLUSH (wback)
+ * Operation on D-Cache: Per Line INV (discard or wback+discard) or FLUSH (wback)
  */
 static inline void __dc_line_op(unsigned long paddr, unsigned long vaddr,
-				unsigned long sz, const int cacheop)
+				unsigned long sz, const int op)
 {
 	unsigned long flags;
 	unsigned int ctrl_reg;
 
 	local_irq_save(flags);
 
-	ctrl_reg = __before_dc_op(cacheop);
+	ctrl_reg = __before_dc_op(op);
 
-	__cache_line_loop(paddr, vaddr, sz, cacheop);
+	__cache_line_loop(paddr, vaddr, sz, op);
 
-	__after_dc_op(cacheop, ctrl_reg);
+	__after_dc_op(op, ctrl_reg);
 
 	local_irq_restore(flags);
 }
 
 #else
 
-#define __dc_entire_op(cacheop)
-#define __dc_line_op(paddr, vaddr, sz, cacheop)
-#define __dc_line_op_k(paddr, sz, cacheop)
+#define __dc_entire_op(op)
+#define __dc_line_op(paddr, vaddr, sz, op)
+#define __dc_line_op_k(paddr, sz, op)
 
 #endif /* CONFIG_ARC_HAS_DCACHE */
 
-
 #ifdef CONFIG_ARC_HAS_ICACHE
 
-/*
- *		I-Cache Aliasing in ARC700 VIPT caches
- *
- * ARC VIPT I-cache uses vaddr to index into cache and paddr to match the tag.
- * The orig Cache Management Module "CDU" only required paddr to invalidate a
- * certain line since it sufficed as index in Non-Aliasing VIPT cache-geometry.
- * Infact for distinct V1,V2,P: all of {V1-P},{V2-P},{P-P} would end up fetching
- * the exact same line.
- *
- * However for larger Caches (way-size > page-size) - i.e. in Aliasing config,
- * paddr alone could not be used to correctly index the cache.
- *
- * ------------------
- * MMU v1/v2 (Fixed Page Size 8k)
- * ------------------
- * The solution was to provide CDU with these additonal vaddr bits. These
- * would be bits [x:13], x would depend on cache-geometry, 13 comes from
- * standard page size of 8k.
- * H/w folks chose [17:13] to be a future safe range, and moreso these 5 bits
- * of vaddr could easily be "stuffed" in the paddr as bits [4:0] since the
- * orig 5 bits of paddr were anyways ignored by CDU line ops, as they
- * represent the offset within cache-line. The adv of using this "clumsy"
- * interface for additional info was no new reg was needed in CDU programming
- * model.
- *
- * 17:13 represented the max num of bits passable, actual bits needed were
- * fewer, based on the num-of-aliases possible.
- * -for 2 alias possibility, only bit 13 needed (32K cache)
- * -for 4 alias possibility, bits 14:13 needed (64K cache)
- *
- * ------------------
- * MMU v3
- * ------------------
- * This ver of MMU supports variable page sizes (1k-16k): although Linux will
- * only support 8k (default), 16k and 4k.
- * However from hardware perspective, smaller page sizes aggrevate aliasing
- * meaning more vaddr bits needed to disambiguate the cache-line-op ;
- * the existing scheme of piggybacking won't work for certain configurations.
- * Two new registers IC_PTAG and DC_PTAG inttoduced.
- * "tag" bits are provided in PTAG, index bits in existing IVIL/IVDL/FLDL regs
- */
-
-/***********************************************************
- * Machine specific helper for per line I-Cache invalidate.
- */
-
 static inline void __ic_entire_inv(void)
 {
 	write_aux_reg(ARC_REG_IC_IVIC, 1);
@@ -721,3 +615,46 @@ SYSCALL_DEFINE3(cacheflush, uint32_t, start, uint32_t, sz, uint32_t, flags)
 	flush_cache_all();
 	return 0;
 }
+
+void arc_cache_init(void)
+{
+	unsigned int __maybe_unused cpu = smp_processor_id();
+	char str[256];
+
+	printk(arc_cache_mumbojumbo(0, str, sizeof(str)));
+
+	if (IS_ENABLED(CONFIG_ARC_HAS_ICACHE)) {
+		struct cpuinfo_arc_cache *ic = &cpuinfo_arc700[cpu].icache;
+
+		if (!ic->ver)
+			panic("cache support enabled but non-existent cache\n");
+
+		if (ic->line_len != L1_CACHE_BYTES)
+			panic("ICache line [%d] != kernel Config [%d]",
+			      ic->line_len, L1_CACHE_BYTES);
+
+		if (ic->ver != CONFIG_ARC_MMU_VER)
+			panic("Cache ver [%d] doesn't match MMU ver [%d]\n",
+			      ic->ver, CONFIG_ARC_MMU_VER);
+	}
+
+	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {
+		struct cpuinfo_arc_cache *dc = &cpuinfo_arc700[cpu].dcache;
+		int handled;
+
+		if (!dc->ver)
+			panic("cache support enabled but non-existent cache\n");
+
+		if (dc->line_len != L1_CACHE_BYTES)
+			panic("DCache line [%d] != kernel Config [%d]",
+			      dc->line_len, L1_CACHE_BYTES);
+
+		/* check for D-Cache aliasing */
+		handled = IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);
+
+		if (dc->alias && !handled)
+			panic("Enable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
+		else if (!dc->alias && handled)
+			panic("Disable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
+	}
+}
-- 
1.9.1
