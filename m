From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 22/29] x86/mm: extend kasan to support 5-level paging
Date: Tue, 27 Dec 2016 04:54:06 +0300
Message-ID: <20161227015413.187403-23-kirill.shutemov@linux.intel.com>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62082 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756060AbcL0Bzh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Dec 2016 20:55:37 -0500
In-Reply-To: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

This patch bring support fo non-folded additional page table level.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/kasan_init_64.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 2964de48e177..e37504e94e8f 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -50,8 +50,18 @@ static void __init kasan_map_early_shadow(pgd_t *pgd)
 	unsigned long end = KASAN_SHADOW_END;
 
 	for (i = pgd_index(start); start < end; i++) {
-		pgd[i] = __pgd(__pa_nodebug(kasan_zero_pud)
-				| _KERNPG_TABLE);
+		switch (CONFIG_PGTABLE_LEVELS) {
+		case 4:
+			pgd[i] = __pgd(__pa_nodebug(kasan_zero_pud) |
+					_KERNPG_TABLE);
+			break;
+		case 5:
+			pgd[i] = __pgd(__pa_nodebug(kasan_zero_p4d) |
+					_KERNPG_TABLE);
+			break;
+		default:
+			BUILD_BUG();
+		}
 		start += PGDIR_SIZE;
 	}
 }
@@ -79,6 +89,7 @@ void __init kasan_early_init(void)
 	pteval_t pte_val = __pa_nodebug(kasan_zero_page) | __PAGE_KERNEL;
 	pmdval_t pmd_val = __pa_nodebug(kasan_zero_pte) | _KERNPG_TABLE;
 	pudval_t pud_val = __pa_nodebug(kasan_zero_pmd) | _KERNPG_TABLE;
+	p4dval_t p4d_val = __pa_nodebug(kasan_zero_pud) | _KERNPG_TABLE;
 
 	for (i = 0; i < PTRS_PER_PTE; i++)
 		kasan_zero_pte[i] = __pte(pte_val);
@@ -89,6 +100,9 @@ void __init kasan_early_init(void)
 	for (i = 0; i < PTRS_PER_PUD; i++)
 		kasan_zero_pud[i] = __pud(pud_val);
 
+	for (i = 0; CONFIG_PGTABLE_LEVELS >= 5 && i < PTRS_PER_P4D; i++)
+		kasan_zero_p4d[i] = __p4d(p4d_val);
+
 	kasan_map_early_shadow(early_level4_pgt);
 	kasan_map_early_shadow(init_level4_pgt);
 }
-- 
2.11.0
