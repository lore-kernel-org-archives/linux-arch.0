From: lizf@kernel.org
Subject: [PATCH 3.4 129/176] vm: add VM_FAULT_SIGSEGV handling support
Date: Thu,  9 Apr 2015 16:46:17 +0800
Message-ID: <1428569224-23820-129-git-send-email-lizf@kernel.org>
References: <1428569028-23762-1-git-send-email-lizf@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43121 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483AbbDII4X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Apr 2015 04:56:23 -0400
In-Reply-To: <1428569028-23762-1-git-send-email-lizf@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, Zefan Li <lizefan@huawei.com>

From: Linus Torvalds <torvalds@linux-foundation.org>

3.4.107-rc1 review patch.  If anyone has any objections, please let me know.

------------------


commit 33692f27597fcab536d7cbbcc8f52905133e4aa7 upstream.

The core VM already knows about VM_FAULT_SIGBUS, but cannot return a
"you should SIGSEGV" error, because the SIGSEGV case was generally
handled by the caller - usually the architecture fault handler.

That results in lots of duplication - all the architecture fault
handlers end up doing very similar "look up vma, check permissions, do
retries etc" - but it generally works.  However, there are cases where
the VM actually wants to SIGSEGV, and applications _expect_ SIGSEGV.

In particular, when accessing the stack guard page, libsigsegv expects a
SIGSEGV.  And it usually got one, because the stack growth is handled by
that duplicated architecture fault handler.

However, when the generic VM layer started propagating the error return
from the stack expansion in commit fee7e49d4514 ("mm: propagate error
from stack expansion even for guard page"), that now exposed the
existing VM_FAULT_SIGBUS result to user space.  And user space really
expected SIGSEGV, not SIGBUS.

To fix that case, we need to add a VM_FAULT_SIGSEGV, and teach all those
duplicate architecture fault handlers about it.  They all already have
the code to handle SIGSEGV, so it's about just tying that new return
value to the existing code, but it's all a bit annoying.

This is the mindless minimal patch to do this.  A more extensive patch
would be to try to gather up the mostly shared fault handling logic into
one generic helper routine, and long-term we really should do that
cleanup.

Just from this patch, you can generally see that most architectures just
copied (directly or indirectly) the old x86 way of doing things, but in
the meantime that original x86 model has been improved to hold the VM
semaphore for shorter times etc and to handle VM_FAULT_RETRY and other
"newer" things, so it would be a good idea to bring all those
improvements to the generic case and teach other architectures about
them too.

Reported-and-tested-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Jan Engelhardt <jengelh@inai.de>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # "s390 still compiles and boots"
Cc: linux-arch@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.2:
 - Adjust filenames, context
 - Drop arc, metag, nios2 and lustre changes
 - For sh, patch both 32-bit and 64-bit implementations to use goto bad_area
 - For s390, pass int_code and trans_exc_code as arguments to do_no_context()
   and do_sigsegv()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
[lizf: Backported to 3.4: adjust context in arch/power/mm/fault.c]
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 arch/alpha/mm/fault.c                   | 2 ++
 arch/avr32/mm/fault.c                   | 2 ++
 arch/cris/mm/fault.c                    | 2 ++
 arch/frv/mm/fault.c                     | 2 ++
 arch/ia64/mm/fault.c                    | 2 ++
 arch/m32r/mm/fault.c                    | 2 ++
 arch/m68k/mm/fault.c                    | 2 ++
 arch/microblaze/mm/fault.c              | 2 ++
 arch/mips/mm/fault.c                    | 2 ++
 arch/mn10300/mm/fault.c                 | 2 ++
 arch/openrisc/mm/fault.c                | 2 ++
 arch/parisc/mm/fault.c                  | 2 ++
 arch/powerpc/mm/fault.c                 | 6 +++++-
 arch/powerpc/platforms/cell/spu_fault.c | 2 +-
 arch/s390/mm/fault.c                    | 7 +++++++
 arch/score/mm/fault.c                   | 2 ++
 arch/sh/mm/fault_32.c                   | 2 ++
 arch/sh/mm/tlbflush_64.c                | 2 ++
 arch/sparc/mm/fault_32.c                | 2 ++
 arch/sparc/mm/fault_64.c                | 2 ++
 arch/tile/mm/fault.c                    | 2 ++
 arch/um/kernel/trap.c                   | 2 ++
 arch/x86/mm/fault.c                     | 2 ++
 arch/xtensa/mm/fault.c                  | 2 ++
 include/linux/mm.h                      | 5 +++--
 mm/ksm.c                                | 2 +-
 mm/memory.c                             | 4 ++--
 27 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 5eecab1..f153733 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -149,6 +149,8 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/avr32/mm/fault.c b/arch/avr32/mm/fault.c
index f7040a1..632b649 100644
--- a/arch/avr32/mm/fault.c
+++ b/arch/avr32/mm/fault.c
@@ -136,6 +136,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/cris/mm/fault.c b/arch/cris/mm/fault.c
index b4760d8..b07c00c 100644
--- a/arch/cris/mm/fault.c
+++ b/arch/cris/mm/fault.c
@@ -167,6 +167,8 @@ do_page_fault(unsigned long address, struct pt_regs *regs,
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/frv/mm/fault.c b/arch/frv/mm/fault.c
index 331c1e2..8545496 100644
--- a/arch/frv/mm/fault.c
+++ b/arch/frv/mm/fault.c
@@ -166,6 +166,8 @@ asmlinkage void do_page_fault(int datammu, unsigned long esr0, unsigned long ear
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 02d29c2..3c820ea 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -162,6 +162,8 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 		 */
 		if (fault & VM_FAULT_OOM) {
 			goto out_of_memory;
+		} else if (fault & VM_FAULT_SIGSEGV) {
+			goto bad_area;
 		} else if (fault & VM_FAULT_SIGBUS) {
 			signal = SIGBUS;
 			goto bad_area;
diff --git a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
index 3cdfa9c..06827fc 100644
--- a/arch/m32r/mm/fault.c
+++ b/arch/m32r/mm/fault.c
@@ -198,6 +198,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 6b020a8..8646409 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -146,6 +146,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto map_err;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto bus_err;
 		BUG();
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index c38a265..c7fe3da 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -214,6 +214,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index c14f6df..5c9ba6a 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -155,6 +155,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/mn10300/mm/fault.c b/arch/mn10300/mm/fault.c
index 90f346f..eb411b3 100644
--- a/arch/mn10300/mm/fault.c
+++ b/arch/mn10300/mm/fault.c
@@ -255,6 +255,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index a5dce82..162abfb 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -163,6 +163,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 18162ce..a9b765a 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -210,6 +210,8 @@ good_area:
 		 */
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto bad_area;
 		BUG();
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 08ffcf5..3d30a4a 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -419,7 +419,11 @@ good_area:
 	 */
 	fault = handle_mm_fault(mm, vma, address, flags);
 	if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
-		int rc = mm_fault_error(regs, address, fault);
+		int rc;
+
+		if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
+		rc = mm_fault_error(regs, address, fault);
 		if (rc >= MM_FAULT_RETURN)
 			return rc;
 	}
diff --git a/arch/powerpc/platforms/cell/spu_fault.c b/arch/powerpc/platforms/cell/spu_fault.c
index 641e727..62f3e4e 100644
--- a/arch/powerpc/platforms/cell/spu_fault.c
+++ b/arch/powerpc/platforms/cell/spu_fault.c
@@ -75,7 +75,7 @@ int spu_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
 		if (*flt & VM_FAULT_OOM) {
 			ret = -ENOMEM;
 			goto out_unlock;
-		} else if (*flt & VM_FAULT_SIGBUS) {
+		} else if (*flt & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV)) {
 			ret = -EFAULT;
 			goto out_unlock;
 		}
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index f2b11ee..f22603d 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -237,6 +237,13 @@ static noinline void do_fault_error(struct pt_regs *regs, int fault)
 				do_no_context(regs);
 			else
 				pagefault_out_of_memory();
+		} else if (fault & VM_FAULT_SIGSEGV) {
+			/* Kernel mode? Handle exceptions or die */
+			if (!user_mode(regs))
+				do_no_context(regs, int_code, trans_exc_code);
+			else
+				do_sigsegv(regs, int_code, SEGV_MAPERR,
+					   trans_exc_code);
 		} else if (fault & VM_FAULT_SIGBUS) {
 			/* Kernel mode? Handle exceptions or die */
 			if (!(regs->psw.mask & PSW_MASK_PSTATE))
diff --git a/arch/score/mm/fault.c b/arch/score/mm/fault.c
index 47b600e..b3744ca 100644
--- a/arch/score/mm/fault.c
+++ b/arch/score/mm/fault.c
@@ -110,6 +110,8 @@ survive:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/sh/mm/fault_32.c b/arch/sh/mm/fault_32.c
index e99b104..a491963 100644
--- a/arch/sh/mm/fault_32.c
+++ b/arch/sh/mm/fault_32.c
@@ -206,6 +206,8 @@ good_area:
 			goto out_of_memory;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		BUG();
 	}
 	if (fault & VM_FAULT_MAJOR) {
diff --git a/arch/sh/mm/tlbflush_64.c b/arch/sh/mm/tlbflush_64.c
index 11c5a18..92f0df9 100644
--- a/arch/sh/mm/tlbflush_64.c
+++ b/arch/sh/mm/tlbflush_64.c
@@ -194,6 +194,8 @@ good_area:
 			goto out_of_memory;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		BUG();
 	}
 
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index df3155a..5c6238d 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -300,6 +300,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 1387aca..0dc7b90 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -443,6 +443,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/tile/mm/fault.c b/arch/tile/mm/fault.c
index 22e58f5..a362926 100644
--- a/arch/tile/mm/fault.c
+++ b/arch/tile/mm/fault.c
@@ -433,6 +433,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index dafc947..f79ffc9 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -69,6 +69,8 @@ good_area:
 		if (unlikely(fault & VM_FAULT_ERROR)) {
 			if (fault & VM_FAULT_OOM) {
 				goto out_of_memory;
+			} else if (fault & VM_FAULT_SIGSEGV) {
+				goto out;
 			} else if (fault & VM_FAULT_SIGBUS) {
 				err = -EACCES;
 				goto out;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 4a0a2e8..b723f2e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -887,6 +887,8 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
 			     VM_FAULT_HWPOISON_LARGE))
 			do_sigbus(regs, error_code, address, fault);
+		else if (fault & VM_FAULT_SIGSEGV)
+			bad_area_nosemaphore(regs, error_code, address);
 		else
 			BUG();
 	}
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index b17885a..b3877be 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -108,6 +108,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dacfd4a..ceebf63 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -841,6 +841,7 @@ static inline int page_mapped(struct page *page)
 #define VM_FAULT_WRITE	0x0008	/* Special case for get_user_pages */
 #define VM_FAULT_HWPOISON 0x0010	/* Hit poisoned small page */
 #define VM_FAULT_HWPOISON_LARGE 0x0020  /* Hit poisoned large page. Index encoded in upper bits */
+#define VM_FAULT_SIGSEGV 0x0040
 
 #define VM_FAULT_NOPAGE	0x0100	/* ->fault installed the pte, not return page */
 #define VM_FAULT_LOCKED	0x0200	/* ->fault locked the returned page */
@@ -848,8 +849,8 @@ static inline int page_mapped(struct page *page)
 
 #define VM_FAULT_HWPOISON_LARGE_MASK 0xf000 /* encodes hpage index for large hwpoison */
 
-#define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | \
-			 VM_FAULT_HWPOISON_LARGE)
+#define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
+			 VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)
 
 /* Encode hstate index for a hwpoisoned large page */
 #define VM_FAULT_SET_HINDEX(x) ((x) << 12)
diff --git a/mm/ksm.c b/mm/ksm.c
index 47c8853..77c7118 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -342,7 +342,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 		else
 			ret = VM_FAULT_WRITE;
 		put_page(page);
-	} while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS | VM_FAULT_OOM)));
+	} while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
 	/*
 	 * We must loop because handle_mm_fault() may back out if there's
 	 * any difficulty e.g. if pte accessed bit gets updated concurrently.
diff --git a/mm/memory.c b/mm/memory.c
index c9c93e2..f573cec 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1787,7 +1787,7 @@ int __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 						else
 							return -EFAULT;
 					}
-					if (ret & VM_FAULT_SIGBUS)
+					if (ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV))
 						return i ? i : -EFAULT;
 					BUG();
 				}
@@ -1891,7 +1891,7 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 			return -ENOMEM;
 		if (ret & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))
 			return -EHWPOISON;
-		if (ret & VM_FAULT_SIGBUS)
+		if (ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV))
 			return -EFAULT;
 		BUG();
 	}
-- 
1.9.1
