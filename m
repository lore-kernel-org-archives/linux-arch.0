Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:27547 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752877AbdCFN75 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Mar 2017 08:59:57 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 12/33] x86/mm: add support of p4d_t in vmalloc_fault()
Date: Mon,  6 Mar 2017 16:53:36 +0300
Message-ID: <20170306135357.3124-13-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170306135336.bwHxR1rIxqmhr0Lfd86klg5Xow5lut1IlZ1i0sQYl58@z>

With 4-level paging copying happens on p4d level, as we have pgd_none()
always false when p4d_t folded.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/fault.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 605fd5e8e048..fcc887f607c2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -435,6 +435,7 @@ void vmalloc_sync_all(void)
 static noinline int vmalloc_fault(unsigned long address)
 {
 	pgd_t *pgd, *pgd_ref;
+	p4d_t *p4d, *p4d_ref;
 	pud_t *pud, *pud_ref;
 	pmd_t *pmd, *pmd_ref;
 	pte_t *pte, *pte_ref;
@@ -462,13 +463,26 @@ static noinline int vmalloc_fault(unsigned long address)
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
