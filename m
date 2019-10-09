Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:55048 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731916AbfJIW1I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 18:27:08 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 3/3] asm-generic/mm: stub out p{4,d}d_clear_bad() if __PAGETABLE_P{4,u}D_FOLDED
Date: Wed,  9 Oct 2019 15:26:58 -0700
Message-ID: <20191009222658.961-4-vgupta@synopsys.com>
In-Reply-To: <20191009222658.961-1-vgupta@synopsys.com>
References: <20191009222658.961-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20191009222658.tPvnTOhjtcd7NyN9wpsJXBBO3G10RE2DM01ijrbZp2o@z>

This removes the code for 2 level paging as seen on ARC

| bloat-o-meter2 vmlinux-D-elide-p4d_free_tlb vmlinux-E-elide-p?d_clear_bad
| add/remove: 0/2 grow/shrink: 0/0 up/down: 0/-22 (-22)
| function                                     old     new   delta
| pud_clear_bad                                 20       -     -20
| p4d_clear_bad                                 20       -     -20
| Total: Before=4137104, After=4137082, chg -1.000000%

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/pgtable.h | 11 +++++++++++
 mm/pgtable-generic.c          |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 818691846c90..9cdcbc7c0b7b 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -558,8 +558,19 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
  * Do the tests inline, but report and clear the bad entry in mm/memory.c.
  */
 void pgd_clear_bad(pgd_t *);
+
+#ifndef __PAGETABLE_P4D_FOLDED
 void p4d_clear_bad(p4d_t *);
+#else
+#define p4d_clear_bad(p4d)        do { } while (0)
+#endif
+
+#ifndef __PAGETABLE_PUD_FOLDED
 void pud_clear_bad(pud_t *);
+#else
+#define pud_clear_bad(p4d)        do { } while (0)
+#endif
+
 void pmd_clear_bad(pmd_t *);
 
 static inline int pgd_none_or_clear_bad(pgd_t *pgd)
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 532c29276fce..856dc3bb77e6 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -24,17 +24,21 @@ void pgd_clear_bad(pgd_t *pgd)
 	pgd_clear(pgd);
 }
 
+#ifndef __PAGETABLE_P4D_FOLDED
 void p4d_clear_bad(p4d_t *p4d)
 {
 	p4d_ERROR(*p4d);
 	p4d_clear(p4d);
 }
+#endif
 
+#ifndef __PAGETABLE_PUD_FOLDED
 void pud_clear_bad(pud_t *pud)
 {
 	pud_ERROR(*pud);
 	pud_clear(pud);
 }
+#endif
 
 void pmd_clear_bad(pmd_t *pmd)
 {
-- 
2.20.1
