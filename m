Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:7262 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727204AbeH2MYS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 08:24:18 -0400
From: Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 5/6] x86/alternatives: use temporary mm for text poking
Date: Wed, 29 Aug 2018 01:11:46 -0700
Message-ID: <20180829081147.184610-6-namit@vmware.com>
In-Reply-To: <20180829081147.184610-1-namit@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180829081146.VJUFXPnEWs60Dn0ZiEFpyXDNJissxtC6nDOXb4EIe14@z>

text_poke() can potentially compromise the security as it sets temporary
PTEs in the fixmap. These PTEs might be used to rewrite the kernel code
from other cores accidentally or maliciously, if an attacker gains the
ability to write onto kernel memory.

Moreover, since remote TLBs are not flushed after the temporary PTEs are
removed, the time-window in which the code is writable is not limited if
the fixmap PTEs - maliciously or accidentally - are cached in the TLB.

To address these potential security hazards, we use a temporary mm for
patching the code. Unfortunately, the temporary-mm cannot be initialized
early enough during the init, and as a result x86_late_time_init() needs
to use text_poke() before it can be initialized. text_poke() therefore
keeps the two poking versions - using fixmap and using temporary mm -
and uses them accordingly.

More adventurous developers can try to reorder the init sequence or use
text_poke_early() instead of text_poke() to remove the use of fixmap for
patching completely.

Finally, text_poke() is also not conservative enough when mapping pages,
as it always tries to map 2 pages, even when a single one is sufficient.
So try to be more conservative, and do not map more than needed.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/alternative.c | 154 +++++++++++++++++++++++++++++-----
 1 file changed, 133 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 916c11b410c4..0feac3dfabe9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -11,6 +11,7 @@
 #include <linux/stop_machine.h>
 #include <linux/slab.h>
 #include <linux/kdebug.h>
+#include <linux/mmu_context.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -674,6 +675,113 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 	return addr;
 }
 
+/**
+ * text_poke_fixmap - poke using the fixmap.
+ *
+ * Fallback function for poking the text using the fixmap. It is used during
+ * early boot and in the rare case in which initialization of safe poking fails.
+ *
+ * Poking in this manner should be avoided, since it allows other cores to use
+ * the fixmap entries, and can be exploited by an attacker to overwrite the code
+ * (assuming he gained the write access through another bug).
+ */
+static void text_poke_fixmap(void *addr, const void *opcode, size_t len,
+			     struct page *pages[2])
+{
+	u8 *vaddr;
+
+	set_fixmap(FIX_TEXT_POKE0, page_to_phys(pages[0]));
+	if (pages[1])
+		set_fixmap(FIX_TEXT_POKE1, page_to_phys(pages[1]));
+	vaddr = (u8 *)fix_to_virt(FIX_TEXT_POKE0);
+	memcpy(vaddr + offset_in_page(addr), opcode, len);
+
+	/*
+	 * clear_fixmap() performs a TLB flush, so no additional TLB
+	 * flush is needed.
+	 */
+	clear_fixmap(FIX_TEXT_POKE0);
+	if (pages[1])
+		clear_fixmap(FIX_TEXT_POKE1);
+	sync_core();
+	/* Could also do a CLFLUSH here to speed up CPU recovery; but
+	   that causes hangs on some VIA CPUs. */
+}
+
+__ro_after_init struct mm_struct *poking_mm;
+__ro_after_init unsigned long poking_addr;
+
+/**
+ * text_poke_safe() - Pokes the text using a separate address space.
+ *
+ * This is the preferable way for patching the kernel after boot, as it does not
+ * allow other cores to accidentally or maliciously modify the code using the
+ * temporary PTEs.
+ */
+static void text_poke_safe(void *addr, const void *opcode, size_t len,
+			   struct page *pages[2])
+{
+	temporary_mm_state_t prev;
+	pte_t pte, *ptep;
+	spinlock_t *ptl;
+
+	/*
+	 * The lock is not really needed, but this allows to avoid open-coding.
+	 */
+	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
+
+	pte = mk_pte(pages[0], PAGE_KERNEL);
+	set_pte_at(poking_mm, poking_addr, ptep, pte);
+
+	if (pages[1]) {
+		pte = mk_pte(pages[1], PAGE_KERNEL);
+		set_pte_at(poking_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
+	}
+
+	/*
+	 * Loading the temporary mm behaves as a compiler barrier, which
+	 * guarantees that the PTE will be set at the time memcpy() is done.
+	 */
+	prev = use_temporary_mm(poking_mm);
+
+	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
+
+	/*
+	 * Ensure that the PTE is only cleared after copying is done by using a
+	 * compiler barrier.
+	 */
+	barrier();
+
+	pte_clear(poking_mm, poking_addr, ptep);
+
+	/*
+	 * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
+	 * as it also flushes the corresponding "user" address spaces, which
+	 * does not exist.
+	 *
+	 * Poking, however, is already very inefficient since it does not try to
+	 * batch updates, so we ignore this problem for the time being.
+	 *
+	 * Since the PTEs do not exist in other kernel address-spaces, we do
+	 * not use __flush_tlb_one_kernel(), which when PTI is on would cause
+	 * more unwarranted TLB flushes.
+	 */
+	__flush_tlb_one_user(poking_addr);
+	if (pages[1]) {
+		pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + 1);
+		__flush_tlb_one_user(poking_addr + PAGE_SIZE);
+	}
+
+	/*
+	 * Loading the previous page-table hierarchy requires a serializing
+	 * instruction that already allows the core to see the updated version.
+	 * Xen-PV is assumed to serialize execution in a similar manner.
+	 */
+	unuse_temporary_mm(prev);
+
+	pte_unmap_unlock(ptep, ptl);
+}
+
 /**
  * text_poke - Update instructions on a live kernel
  * @addr: address to modify
@@ -689,42 +797,46 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
  */
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
+	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
+	struct page *pages[2] = {0};
 	unsigned long flags;
-	char *vaddr;
-	struct page *pages[2];
-	int i;
 
 	/*
-	 * While boot memory allocator is runnig we cannot use struct
-	 * pages as they are not yet initialized.
+	 * While boot memory allocator is running we cannot use struct pages as
+	 * they are not yet initialized.
 	 */
 	BUG_ON(!after_bootmem);
 	lockdep_assert_held(&text_mutex);
 
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
-		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
+		if (cross_page_boundary)
+			pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
 	} else {
 		pages[0] = virt_to_page(addr);
 		WARN_ON(!PageReserved(pages[0]));
-		pages[1] = virt_to_page(addr + PAGE_SIZE);
+		if (cross_page_boundary)
+			pages[1] = virt_to_page(addr + PAGE_SIZE);
 	}
 	BUG_ON(!pages[0]);
 	local_irq_save(flags);
-	set_fixmap(FIX_TEXT_POKE0, page_to_phys(pages[0]));
-	if (pages[1])
-		set_fixmap(FIX_TEXT_POKE1, page_to_phys(pages[1]));
-	vaddr = (char *)fix_to_virt(FIX_TEXT_POKE0);
-	memcpy(&vaddr[(unsigned long)addr & ~PAGE_MASK], opcode, len);
-	clear_fixmap(FIX_TEXT_POKE0);
-	if (pages[1])
-		clear_fixmap(FIX_TEXT_POKE1);
-	local_flush_tlb();
-	sync_core();
-	/* Could also do a CLFLUSH here to speed up CPU recovery; but
-	   that causes hangs on some VIA CPUs. */
-	for (i = 0; i < len; i++)
-		BUG_ON(((char *)addr)[i] != ((char *)opcode)[i]);
+
+	/*
+	 * During initial boot, it is hard to initialize poking_mm due to
+	 * dependencies in boot order.
+	 */
+	if (poking_mm)
+		text_poke_safe(addr, opcode, len, pages);
+	else
+		text_poke_fixmap(addr, opcode, len, pages);
+
+	/*
+	 * To be on the safe side, do the comparison before enabling IRQs, as it
+	 * was done before. However, it makes more sense to allow the callers to
+	 * deal with potential failures and not to panic so easily.
+	 */
+	BUG_ON(memcmp(addr, opcode, len));
+
 	local_irq_restore(flags);
 	return addr;
 }
-- 
2.17.1
