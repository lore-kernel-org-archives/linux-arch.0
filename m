Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:8609 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934223AbdBQOOC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Feb 2017 09:14:02 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 17/33] x86/kasan: prepare clear_pgds() to switch to <asm-generic/pgtable-nop4d.h>
Date: Fri, 17 Feb 2017 17:13:12 +0300
Message-ID: <20170217141328.164563-18-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170217141328.164563-1-kirill.shutemov@linux.intel.com>
References: <20170217141328.164563-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170217141312.m4iLvODLcwomLS5WqTXU31k0y1lp5nJqV9Mjek0HTRg@z>

With folded p4d, pgd_clear() is nop. Change clear_pgds() to use
p4d_clear() instead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 arch/x86/mm/kasan_init_64.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0493c17b8a51..72ffe4c55c2d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -31,8 +31,15 @@ static int __init map_range(struct range *range)
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
