From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 1/3] x86/mm: Provide pmdp_establish() helper
Date: Thu, 15 Jun 2017 17:52:22 +0300
Message-ID: <20170615145224.66200-2-kirill.shutemov@linux.intel.com>
References: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

We need an atomic way to setup pmd page table entry, avoiding races with
CPU setting dirty/accessed bits. This is required to implement
pmdp_invalidate() that doesn't loose these bits.

On PAE we have to use cmpxchg8b as we cannot assume what is value of new pmd and
setting it up half-by-half can expose broken corrupted entry to CPU.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/pgtable-3level.h | 18 ++++++++++++++++++
 arch/x86/include/asm/pgtable.h        | 14 ++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 50d35e3185f5..471c8a851363 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -180,6 +180,24 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *pmdp)
 #define native_pmdp_get_and_clear(xp) native_local_pmdp_get_and_clear(xp)
 #endif
 
+#ifndef pmdp_establish
+#define pmdp_establish pmdp_establish
+static inline pmd_t pmdp_establish(pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t old;
+
+	/*
+	 * We cannot assume what is value of pmd here, so there's no easy way
+	 * to set if half by half. We have to fall back to cmpxchg64.
+	 */
+	{
+		old = *pmdp;
+	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);
+
+	return old;
+}
+#endif
+
 #ifdef CONFIG_SMP
 union split_pud {
 	struct {
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index f5af95a0c6b8..a924fc6a96b9 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1092,6 +1092,20 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
 }
 
+#ifndef pmdp_establish
+#define pmdp_establish pmdp_establish
+static inline pmd_t pmdp_establish(pmd_t *pmdp, pmd_t pmd)
+{
+	if (IS_ENABLED(CONFIG_SMP)) {
+		return xchg(pmdp, pmd);
+	} else {
+		pmd_t old = *pmdp;
+		*pmdp = pmd;
+		return old;
+	}
+}
+#endif
+
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
  *
-- 
2.11.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
