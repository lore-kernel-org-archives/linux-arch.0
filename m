Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:48974 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbdCMFv3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Mar 2017 01:51:29 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 20/26] x86/espfix: support 5-level paging
Date: Mon, 13 Mar 2017 08:50:14 +0300
Message-ID: <20170313055020.69655-21-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170313055014.-DCrPTZt9qqRSonlm2pee02ODccIMfM5C3oW4BPq-NU@z>

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
