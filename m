Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:55661 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbdGPXAD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 Jul 2017 19:00:03 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/8] x86/dump_pagetables: Generalize address normalization
Date: Mon, 17 Jul 2017 01:59:47 +0300
Message-ID: <20170716225954.74185-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170716225954.74185-1-kirill.shutemov@linux.intel.com>
References: <20170716225954.74185-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170716225947.6M-1Pv3seZaAtBkzHspYpmxo1kmaXX4OKNd9Pk70o4s@z>

Modify normalize_addr to handle different sizes of virtual address
space.

It's preparation for enabling 5-level paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/dump_pagetables.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 0470826d2bdc..a824d575bb84 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -188,11 +188,12 @@ static void printk_prot(struct seq_file *m, pgprot_t prot, int level, bool dmsg)
  */
 static unsigned long normalize_addr(unsigned long u)
 {
-#ifdef CONFIG_X86_64
-	return (signed long)(u << 16) >> 16;
-#else
-	return u;
-#endif
+	int shift;
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return u;
+
+	shift = 64 - (__VIRTUAL_MASK_SHIFT + 1);
+	return (signed long)(u << shift) >> shift;
 }
 
 /*
-- 
2.11.0
