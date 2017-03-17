Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:2801 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbdCQTkG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Mar 2017 15:40:06 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 4/6] x86/kasan: Prepare clear_pgds() to switch to <asm-generic/pgtable-nop4d.h>
Date: Fri, 17 Mar 2017 21:55:13 +0300
Message-ID: <20170317185515.8636-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170317185515.8636-1-kirill.shutemov@linux.intel.com>
References: <20170317185515.8636-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170317185513.3-emtduySdr0yGMFfYLgOf27Z6qsVSyOsgzsfJLM7Mw@z>

With folded p4d, pgd_clear() is nop. Change clear_pgds() to use
p4d_clear() instead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 arch/x86/mm/kasan_init_64.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0a56059a95c7..b775ffd7989d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -35,8 +35,19 @@ static int __init map_range(struct range *range)
 static void __init clear_pgds(unsigned long start,
 			unsigned long end)
 {
-	for (; start < end; start += PGDIR_SIZE)
-		pgd_clear(pgd_offset_k(start));
+	pgd_t *pgd;
+
+	for (; start < end; start += PGDIR_SIZE) {
+		pgd = pgd_offset_k(start);
+		/*
+		 * With folded p4d, pgd_clear() is nop, use p4d_clear()
+		 * instead.
+		 */
+		if (CONFIG_PGTABLE_LEVELS < 5)
+			p4d_clear(p4d_offset(pgd, start));
+		else
+			pgd_clear(pgd);
+	}
 }
 
 static void __init kasan_map_early_shadow(pgd_t *pgd)
-- 
2.11.0
