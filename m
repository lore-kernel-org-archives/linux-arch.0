Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22302 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbdC0Qai (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Mar 2017 12:30:38 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 8/8] x86/espfix: Add support 5-level paging
Date: Mon, 27 Mar 2017 19:29:25 +0300
Message-ID: <20170327162925.16092-9-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
References: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170327162925.RpS193B3FAYHhpJ-VWixhK9kNFa-zHQ2_sx4fWe_nyY@z>

We don't need extra virtual address space for ESPFIX, so it stays within
one PUD page table for both 4- and 5-level paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/espfix_64.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index 04f89caef9c4..8e598a1ad986 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -50,11 +50,11 @@
 #define ESPFIX_STACKS_PER_PAGE	(PAGE_SIZE/ESPFIX_STACK_SIZE)
 
 /* There is address space for how many espfix pages? */
-#define ESPFIX_PAGE_SPACE	(1UL << (PGDIR_SHIFT-PAGE_SHIFT-16))
+#define ESPFIX_PAGE_SPACE	(1UL << (P4D_SHIFT-PAGE_SHIFT-16))
 
 #define ESPFIX_MAX_CPUS		(ESPFIX_STACKS_PER_PAGE * ESPFIX_PAGE_SPACE)
 #if CONFIG_NR_CPUS > ESPFIX_MAX_CPUS
-# error "Need more than one PGD for the ESPFIX hack"
+# error "Need more virtual address space for the ESPFIX hack"
 #endif
 
 #define PGALLOC_GFP (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO)
@@ -121,11 +121,13 @@ static void init_espfix_random(void)
 
 void __init init_espfix_bsp(void)
 {
-	pgd_t *pgd_p;
+	pgd_t *pgd;
+	p4d_t *p4d;
 
 	/* Install the espfix pud into the kernel page directory */
-	pgd_p = &init_level4_pgt[pgd_index(ESPFIX_BASE_ADDR)];
-	pgd_populate(&init_mm, pgd_p, (pud_t *)espfix_pud_page);
+	pgd = &init_level4_pgt[pgd_index(ESPFIX_BASE_ADDR)];
+	p4d = p4d_alloc(&init_mm, pgd, ESPFIX_BASE_ADDR);
+	p4d_populate(&init_mm, p4d, espfix_pud_page);
 
 	/* Randomize the locations */
 	init_espfix_random();
-- 
2.11.0
