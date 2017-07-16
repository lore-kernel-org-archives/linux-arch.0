From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/8] x86/dump_pagetables: Generalize address normalization
Date: Mon, 17 Jul 2017 01:59:47 +0300
Message-ID: <20170716225954.74185-2-kirill.shutemov@linux.intel.com>
References: <20170716225954.74185-1-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170716225954.74185-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
