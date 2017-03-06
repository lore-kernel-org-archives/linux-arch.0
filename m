From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 29/33] x86/mm: add sync_global_pgds() for configuration with 5-level paging
Date: Mon,  6 Mar 2017 16:53:53 +0300
Message-ID: <20170306135357.3124-30-kirill.shutemov@linux.intel.com>
References: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170306135357.3124-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

This basically restores slightly modified version of original
sync_global_pgds() which we had before foldedl p4d was introduced.

The only modification is protection against 'address' overflow.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/init_64.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 7bdda6f1d135..5ba99090dc3c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -92,6 +92,42 @@ __setup("noexec32=", nonx32_setup);
  * When memory was added make sure all the processes MM have
  * suitable PGD entries in the local PGD level page.
  */
+#ifdef CONFIG_X86_5LEVEL
+void sync_global_pgds(unsigned long start, unsigned long end)
+{
+	unsigned long address;
+
+	for (address = start; address <= end && address >= start;
+			address += PGDIR_SIZE) {
+		const pgd_t *pgd_ref = pgd_offset_k(address);
+		struct page *page;
+
+		if (pgd_none(*pgd_ref))
+			continue;
+
+		spin_lock(&pgd_lock);
+		list_for_each_entry(page, &pgd_list, lru) {
+			pgd_t *pgd;
+			spinlock_t *pgt_lock;
+
+			pgd = (pgd_t *)page_address(page) + pgd_index(address);
+			/* the pgt_lock only for Xen */
+			pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
+			spin_lock(pgt_lock);
+
+			if (!pgd_none(*pgd_ref) && !pgd_none(*pgd))
+				BUG_ON(pgd_page_vaddr(*pgd)
+						!= pgd_page_vaddr(*pgd_ref));
+
+			if (pgd_none(*pgd))
+				set_pgd(pgd, *pgd_ref);
+
+			spin_unlock(pgt_lock);
+		}
+		spin_unlock(&pgd_lock);
+	}
+}
+#else
 void sync_global_pgds(unsigned long start, unsigned long end)
 {
 	unsigned long address;
@@ -135,6 +171,7 @@ void sync_global_pgds(unsigned long start, unsigned long end)
 		spin_unlock(&pgd_lock);
 	}
 }
+#endif
 
 /*
  * NOTE: This function is marked __ref because it calls __init function
-- 
2.11.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
