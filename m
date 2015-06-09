From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 06/28] ARCv2: MMUv4: TLB programming Model changes
Date: Tue, 9 Jun 2015 17:18:06 +0530
Message-ID: <1433850508-26317-7-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51812 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbbFILuQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:50:16 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig               |  5 ++++
 arch/arc/include/asm/arcregs.h |  2 +-
 arch/arc/include/asm/mmu.h     | 24 ++++++++++++++++++-
 arch/arc/include/asm/pgtable.h | 10 ++++++++
 arch/arc/mm/tlb.c              | 54 +++++++++++++++++++++++++++++++++++++++---
 arch/arc/mm/tlbex.S            | 24 +++++++++++++++++++
 6 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index f72398847b5b..6568977bb302 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -267,6 +267,7 @@ choice
 	prompt "MMU Version"
 	default ARC_MMU_V3 if ARC_CPU_770
 	default ARC_MMU_V2 if ARC_CPU_750D
+	default ARC_MMU_V4 if ARC_CPU_HS
 
 config ARC_MMU_V1
 	bool "MMU v1"
@@ -287,6 +288,10 @@ config ARC_MMU_V3
 	  Variable Page size (1k-16k), var JTLB size 128 x (2 or 4)
 	  Shared Address Spaces (SASID)
 
+config ARC_MMU_V4
+	bool "MMU v4"
+	depends on ISA_ARCV2
+
 endchoice
 
 
diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index d77362dbb864..3a56cd00c59e 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -325,7 +325,7 @@ struct bcr_generic {
  */
 
 struct cpuinfo_arc_mmu {
-	unsigned int ver:4, pg_sz_k:8, pad:8, u_dtlb:6, u_itlb:6;
+	unsigned int ver:4, pg_sz_k:8, s_pg_sz_m:8, u_dtlb:6, u_itlb:6;
 	unsigned int num_tlb:16, sets:12, ways:4;
 };
 
diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
index 8c84ae98c337..0f9c3eb5327e 100644
--- a/arch/arc/include/asm/mmu.h
+++ b/arch/arc/include/asm/mmu.h
@@ -15,24 +15,41 @@
 #define CONFIG_ARC_MMU_VER 2
 #elif defined(CONFIG_ARC_MMU_V3)
 #define CONFIG_ARC_MMU_VER 3
+#elif defined(CONFIG_ARC_MMU_V4)
+#define CONFIG_ARC_MMU_VER 4
 #endif
 
 /* MMU Management regs */
 #define ARC_REG_MMU_BCR		0x06f
+#if (CONFIG_ARC_MMU_VER < 4)
 #define ARC_REG_TLBPD0		0x405
 #define ARC_REG_TLBPD1		0x406
 #define ARC_REG_TLBINDEX	0x407
 #define ARC_REG_TLBCOMMAND	0x408
 #define ARC_REG_PID		0x409
 #define ARC_REG_SCRATCH_DATA0	0x418
+#else
+#define ARC_REG_TLBPD0		0x460
+#define ARC_REG_TLBPD1		0x461
+#define ARC_REG_TLBINDEX	0x464
+#define ARC_REG_TLBCOMMAND	0x465
+#define ARC_REG_PID		0x468
+#define ARC_REG_SCRATCH_DATA0	0x46c
+#endif
 
 /* Bits in MMU PID register */
-#define MMU_ENABLE		(1 << 31)	/* Enable MMU for process */
+#define __TLB_ENABLE		(1 << 31)
+#define __PROG_ENABLE		(1 << 30)
+#define MMU_ENABLE		(__TLB_ENABLE | __PROG_ENABLE)
 
 /* Error code if probe fails */
 #define TLB_LKUP_ERR		0x80000000
 
+#if (CONFIG_ARC_MMU_VER < 4)
 #define TLB_DUP_ERR	(TLB_LKUP_ERR | 0x00000001)
+#else
+#define TLB_DUP_ERR	(TLB_LKUP_ERR | 0x40000000)
+#endif
 
 /* TLB Commands */
 #define TLBWrite    0x1
@@ -45,6 +62,11 @@
 #define TLBIVUTLB   0x6		/* explicitly inv uTLBs */
 #endif
 
+#if (CONFIG_ARC_MMU_VER >= 4)
+#define TLBInsertEntry	0x7
+#define TLBDeleteEntry	0x8
+#endif
+
 #ifndef __ASSEMBLY__
 
 typedef struct {
diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 9615fe1701c6..1281718802f7 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -72,8 +72,18 @@
 #define _PAGE_READ          (1<<3)	/* Page has user read perm (H) */
 #define _PAGE_ACCESSED      (1<<4)	/* Page is accessed (S) */
 #define _PAGE_MODIFIED      (1<<5)	/* Page modified (dirty) (S) */
+
+#if (CONFIG_ARC_MMU_VER >= 4)
+#define _PAGE_WTHRU         (1<<7)	/* Page cache mode write-thru (H) */
+#endif
+
 #define _PAGE_GLOBAL        (1<<8)	/* Page is global (H) */
 #define _PAGE_PRESENT       (1<<9)	/* TLB entry is valid (H) */
+
+#if (CONFIG_ARC_MMU_VER >= 4)
+#define _PAGE_SZ            (1<<10)	/* Page Size indicator (H) */
+#endif
+
 #define _PAGE_SHARED_CODE   (1<<11)	/* Shared Code page with cmn vaddr
 					   usable for shared TLB entries (H) */
 #endif
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 914d8e0c0318..2c7ce8bb7475 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -113,6 +113,8 @@ static inline void __tlb_entry_erase(void)
 	write_aux_reg(ARC_REG_TLBCOMMAND, TLBWrite);
 }
 
+#if (CONFIG_ARC_MMU_VER < 4)
+
 static inline unsigned int tlb_entry_lkup(unsigned long vaddr_n_asid)
 {
 	unsigned int idx;
@@ -210,6 +212,28 @@ static void tlb_entry_insert(unsigned int pd0, unsigned int pd1)
 	write_aux_reg(ARC_REG_TLBCOMMAND, TLBWrite);
 }
 
+#else	/* CONFIG_ARC_MMU_VER >= 4) */
+
+static void utlb_invalidate(void)
+{
+	/* No need since uTLB is always in sync with JTLB */
+}
+
+static void tlb_entry_erase(unsigned int vaddr_n_asid)
+{
+	write_aux_reg(ARC_REG_TLBPD0, vaddr_n_asid | _PAGE_PRESENT);
+	write_aux_reg(ARC_REG_TLBCOMMAND, TLBDeleteEntry);
+}
+
+static void tlb_entry_insert(unsigned int pd0, unsigned int pd1)
+{
+	write_aux_reg(ARC_REG_TLBPD0, pd0);
+	write_aux_reg(ARC_REG_TLBPD1, pd1);
+	write_aux_reg(ARC_REG_TLBCOMMAND, TLBInsertEntry);
+}
+
+#endif
+
 /*
  * Un-conditionally (without lookup) erase the entire MMU contents
  */
@@ -582,6 +606,17 @@ void read_decode_mmu_bcr(void)
 #endif
 	} *mmu3;
 
+	struct bcr_mmu_4 {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int ver:8, sasid:1, sz1:4, sz0:4, res:2, pae:1,
+		     n_ways:2, n_entry:2, n_super:2, u_itlb:3, u_dtlb:3;
+#else
+	/*           DTLB      ITLB      JES        JE         JA      */
+	unsigned int u_dtlb:3, u_itlb:3, n_super:2, n_entry:2, n_ways:2,
+		     pae:1, res:2, sz0:4, sz1:4, sasid:1, ver:8;
+#endif
+	} *mmu4;
+
 	tmp = read_aux_reg(ARC_REG_MMU_BCR);
 	mmu->ver = (tmp >> 24);
 
@@ -592,13 +627,21 @@ void read_decode_mmu_bcr(void)
 		mmu->ways = 1 << mmu2->ways;
 		mmu->u_dtlb = mmu2->u_dtlb;
 		mmu->u_itlb = mmu2->u_itlb;
-	} else {
+	} else if (mmu->ver == 3) {
 		mmu3 = (struct bcr_mmu_3 *)&tmp;
 		mmu->pg_sz_k = 1 << (mmu3->pg_sz - 1);
 		mmu->sets = 1 << mmu3->sets;
 		mmu->ways = 1 << mmu3->ways;
 		mmu->u_dtlb = mmu3->u_dtlb;
 		mmu->u_itlb = mmu3->u_itlb;
+	} else {
+		mmu4 = (struct bcr_mmu_4 *)&tmp;
+		mmu->pg_sz_k = 1 << (mmu4->sz0 - 1);
+		mmu->s_pg_sz_m = 1 << (mmu4->sz1 - 11);
+		mmu->sets = 64 << mmu4->n_entry;
+		mmu->ways = mmu4->n_ways * 2;
+		mmu->u_dtlb = mmu4->u_dtlb * 4;
+		mmu->u_itlb = mmu4->u_itlb * 4;
 	}
 
 	mmu->num_tlb = mmu->sets * mmu->ways;
@@ -608,10 +651,15 @@ char *arc_mmu_mumbojumbo(int cpu_id, char *buf, int len)
 {
 	int n = 0;
 	struct cpuinfo_arc_mmu *p_mmu = &cpuinfo_arc700[cpu_id].mmu;
+	char super_pg[64] = "";
+
+	if (p_mmu->s_pg_sz_m)
+		scnprintf(super_pg, 64, "%dM Super Page%s, ",
+			  p_mmu->s_pg_sz_m, " (not used)");
 
 	n += scnprintf(buf + n, len - n,
-		      "MMU [v%x]\t: %dk PAGE, JTLB %d (%dx%d), uDTLB %d, uITLB %d %s\n",
-		       p_mmu->ver, p_mmu->pg_sz_k,
+		      "MMU [v%x]\t: %dk PAGE, %sJTLB %d (%dx%d), uDTLB %d, uITLB %d %s\n",
+		       p_mmu->ver, p_mmu->pg_sz_k, super_pg,
 		       p_mmu->num_tlb, p_mmu->sets, p_mmu->ways,
 		       p_mmu->u_dtlb, p_mmu->u_itlb,
 		       IS_ENABLED(CONFIG_ARC_MMU_SASID) ? ",SASID" : "");
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index 00c8d7f772bc..8624ebd7114e 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -44,6 +44,7 @@
 #include <asm/processor.h>
 #include <asm/tlb-mmu1.h>
 
+#ifdef CONFIG_ISA_ARCOMPACT
 ;-----------------------------------------------------------------
 ; ARC700 Exception Handling doesn't auto-switch stack and it only provides
 ; ONE scratch AUX reg "ARC_REG_SCRATCH_DATA0"
@@ -121,6 +122,24 @@ ex_saved_reg1:
 #endif
 .endm
 
+#else	/* ARCv2 */
+
+.macro TLBMISS_FREEUP_REGS
+	PUSH  r0
+	PUSH  r1
+	PUSH  r2
+	PUSH  r3
+.endm
+
+.macro TLBMISS_RESTORE_REGS
+	POP   r3
+	POP   r2
+	POP   r1
+	POP   r0
+.endm
+
+#endif
+
 ;============================================================================
 ;  Troubleshooting Stuff
 ;============================================================================
@@ -239,6 +258,7 @@ ex_saved_reg1:
 ; Commit the TLB entry into MMU
 
 .macro COMMIT_ENTRY_TO_MMU
+#if (CONFIG_ARC_MMU_VER < 4)
 
 	/* Get free TLB slot: Set = computed from vaddr, way = random */
 	sr  TLBGetIndex, [ARC_REG_TLBCOMMAND]
@@ -249,6 +269,10 @@ ex_saved_reg1:
 #else
 	sr TLBWrite, [ARC_REG_TLBCOMMAND]
 #endif
+
+#else
+	sr TLBInsertEntry, [ARC_REG_TLBCOMMAND]
+#endif
 .endm
 
 
-- 
1.9.1
