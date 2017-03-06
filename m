Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22784 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752673AbdCFN5o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Mar 2017 08:57:44 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 17/33] x86/kasan: prepare clear_pgds() to switch to <asm-generic/pgtable-nop4d.h>
Date: Mon,  6 Mar 2017 16:53:41 +0300
Message-ID: <20170306135357.3124-18-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170306135341.l224tik3PaVhvkVEVJiK2oPZhuzwoXw1vonzFlFRHR4@z>

With folded p4d, pgd_clear() is nop. Change clear_pgds() to use
p4d_clear() instead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 arch/x86/mm/kasan_init_64.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 8d63d7a104c3..733f8ba6a01f 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -32,8 +32,15 @@ static int __init map_range(struct range *range)
 static void __init clear_pgds(unsigned long start,
 			unsigned long end)
 {
-	for (; start < end; start += PGDIR_SIZE)
-		pgd_clear(pgd_offset_k(start));
+	pgd_t *pgd;
+
+	for (; start < end; start += PGDIR_SIZE) {
+		pgd = pgd_offset_k(start);
+		if (CONFIG_PGTABLE_LEVELS < 5)
+			p4d_clear(p4d_offset(pgd, start));
+		else
+			pgd_clear(pgd);
+	}
 }
 
 static void __init kasan_map_early_shadow(pgd_t *pgd)
-- 
2.11.0
