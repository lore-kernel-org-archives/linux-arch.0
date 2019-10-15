From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 5/5] asm-generic/mm: stub out p{4,
 d}d_clear_bad() if __PAGETABLE_P{4, u}D_FOLDED
Date: Tue, 15 Oct 2019 12:19:26 -0700
Message-ID: <20191015191926.9281-6-vgupta@synopsys.com>
References: <20191015191926.9281-1-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191015191926.9281-1-vgupta@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This removes the code for 2 level paging as seen on ARC

| bloat-o-meter2 vmlinux-D-elide-p4d_free_tlb vmlinux-E-elide-p?d_clear_bad
| add/remove: 0/2 grow/shrink: 0/0 up/down: 0/-40 (-40)
| function                                     old     new   delta
| pud_clear_bad                                 20       -     -20
| p4d_clear_bad                                 20       -     -20
| Total: Before=4136930, After=4136890, chg -1.000000%

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/pgtable.h | 11 +++++++++++
 mm/pgtable-generic.c          |  8 ++++++++
 2 files changed, 19 insertions(+)

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
index 532c29276fce..a5edddc3846a 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -24,18 +24,26 @@ void pgd_clear_bad(pgd_t *pgd)
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
 
+/*
+ * Note that below can't be stubed out for nopmd case:
+ * pmd folding is special and typically pmd_* macros refet to upper level
+ */
 void pmd_clear_bad(pmd_t *pmd)
 {
 	pmd_ERROR(*pmd);
-- 
2.20.1
