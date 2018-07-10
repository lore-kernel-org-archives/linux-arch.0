Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:33775 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732461AbeGJWc0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Jul 2018 18:32:26 -0400
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v2 11/27] x86/mm: Modify ptep_set_wrprotect and pmdp_set_wrprotect for _PAGE_DIRTY_SW
Date: Tue, 10 Jul 2018 15:26:23 -0700
Message-ID: <20180710222639.8241-12-yu-cheng.yu@intel.com>
In-Reply-To: <20180710222639.8241-1-yu-cheng.yu@intel.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20180710222623.HkCJXatsRWi6JyAEifGDzOh4XiEa-EzdeE6-CyZzrL8@z>

Update ptep_set_wrprotect() and pmdp_set_wrprotect() for
_PAGE_DIRTY_SW.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/pgtable.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index ecbd3539a864..456a864aa605 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1170,7 +1170,18 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
+	pte_t pte;
+
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
+	pte = *ptep;
+
+	/*
+	 * On platforms before CET, other threads could race to
+	 * create a RO and _PAGE_DIRTY_HW PTE again.  However,
+	 * on CET platforms, this is safe without a TLB flush.
+	 */
+	pte = pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
+	set_pte_at(mm, addr, ptep, pte);
 }
 
 #define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
@@ -1220,7 +1231,18 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
+	pmd_t pmd;
+
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
+	pmd = *pmdp;
+
+	/*
+	 * On platforms before CET, other threads could race to
+	 * create a RO and _PAGE_DIRTY_HW PMD again.  However,
+	 * on CET platforms, this is safe without a TLB flush.
+	 */
+	pmd = pmd_move_flags(pmd, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
+	set_pmd_at(mm, addr, pmdp, pmd);
 }
 
 #define pud_write pud_write
-- 
2.17.1
