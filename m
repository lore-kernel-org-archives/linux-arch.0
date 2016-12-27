From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 12/29] x86/mm: add support of p4d_t in vmalloc_fault()
Date: Tue, 27 Dec 2016 04:53:56 +0300
Message-ID: <20161227015413.187403-13-kirill.shutemov@linux.intel.com>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

With 4-level paging copying happens on p4d level, as we have pgd_none()
always false when p4d_t folded.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/fault.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 59104b78e8a7..b4bcf2dac4a9 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -434,6 +434,7 @@ void vmalloc_sync_all(void)
 static noinline int vmalloc_fault(unsigned long address)
 {
 	pgd_t *pgd, *pgd_ref;
+	p4d_t *p4d, *p4d_ref;
 	pud_t *pud, *pud_ref;
 	pmd_t *pmd, *pmd_ref;
 	pte_t *pte, *pte_ref;
@@ -461,13 +462,26 @@ static noinline int vmalloc_fault(unsigned long address)
 		BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
 	}
 
+	/* With 4-level paging copying happens on p4d level. */
+	p4d = p4d_offset(pgd, address);
+	p4d_ref = p4d_offset(pgd_ref, address);
+	if (p4d_none(*p4d_ref))
+		return -1;
+
+	if (p4d_none(*p4d)) {
+		set_p4d(p4d, *p4d_ref);
+		arch_flush_lazy_mmu_mode();
+	} else {
+		BUG_ON(p4d_pfn(*p4d) != p4d_pfn(*p4d_ref));
+	}
+
 	/*
 	 * Below here mismatches are bugs because these lower tables
 	 * are shared:
 	 */
 
-	pud = pud_offset(pgd, address);
-	pud_ref = pud_offset(pgd_ref, address);
+	pud = pud_offset(p4d, address);
+	pud_ref = pud_offset(p4d_ref, address);
 	if (pud_none(*pud_ref))
 		return -1;
 
-- 
2.11.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
