From: Steve Capper <steve.capper@linaro.org>
Subject: [RFC PATCH V5 6/6] arm64: mm: Enable RCU fast_gup
Date: Tue,  6 May 2014 16:30:09 +0100
Message-ID: <1399390209-1756-7-git-send-email-steve.capper@linaro.org>
References: <1399390209-1756-1-git-send-email-steve.capper@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1399390209-1756-1-git-send-email-steve.capper@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: anders.roxell@linaro.org, peterz@infradead.org, gary.robertson@linaro.org, will.deacon@arm.com, Steve Capper <steve.capper@linaro.org>, akpm@linux-foundation.org, christoffer.dall@linaro.org
List-Id: linux-arch.vger.kernel.org

Activate the RCU fast_gup for ARM64. We also need to force THP splits
to broadcast an IPI s.t. we block in the fast_gup page walker. As THP
splits are comparatively rare, this should not lead to a noticeable
performance degradation.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/pgtable.h |  8 +++++++-
 arch/arm64/mm/flush.c            | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2420390..5168949 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -95,6 +95,9 @@ config GENERIC_CALIBRATE_DELAY
 config ZONE_DMA
 	def_bool y
 
+config HAVE_RCU_GUP
+	def_bool y
+
 config ARCH_DMA_ADDR_T_64BIT
 	def_bool y
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 90c811f..126ed77e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -244,7 +244,13 @@ static inline pmd_t pte_pmd(pte_t pte)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
 #define pmd_trans_splitting(pmd)	pte_special(pmd_pte(pmd))
-#endif
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#define __HAVE_ARCH_PMDP_SPLITTING_FLUSH
+struct vm_area_struct;
+void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned long address,
+			  pmd_t *pmdp);
+#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index e4193e3..ddf96c1 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -103,3 +103,22 @@ EXPORT_SYMBOL(flush_dcache_page);
  */
 EXPORT_SYMBOL(flush_cache_all);
 EXPORT_SYMBOL(flush_icache_range);
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+static void thp_splitting_flush_sync(void *arg)
+{
+}
+
+void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned long address,
+			  pmd_t *pmdp)
+{
+	pmd_t pmd = pmd_mksplitting(*pmdp);
+	VM_BUG_ON(address & ~PMD_MASK);
+	set_pmd_at(vma->vm_mm, address, pmdp, pmd);
+
+	/* dummy IPI to serialise against fast_gup */
+	smp_call_function(thp_splitting_flush_sync, NULL, 1);
+}
+#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
1.8.1.4
