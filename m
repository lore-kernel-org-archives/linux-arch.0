From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.2 134/152] vm: add VM_FAULT_SIGSEGV handling support
Date: Tue, 17 Feb 2015 01:46:53 +0000
Message-ID: <lsq.1424137613.461742024@decadent.org.uk>
References: <lsq.1424137613.308090640@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33679 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751876AbbBQBu4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Feb 2015 20:50:56 -0500
Content-Disposition: inline
In-Reply-To: <lsq.1424137613.308090640@decadent.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>, Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

3.2.67-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

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
---
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -150,6 +150,8 @@ do_page_fault(unsigned long address, uns
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
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
--- a/arch/cris/mm/fault.c
+++ b/arch/cris/mm/fault.c
@@ -166,6 +166,8 @@ do_page_fault(unsigned long address, str
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
--- a/arch/frv/mm/fault.c
+++ b/arch/frv/mm/fault.c
@@ -167,6 +167,8 @@ asmlinkage void do_page_fault(int datamm
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -163,6 +163,8 @@ ia64_do_page_fault (unsigned long addres
 		 */
 		if (fault & VM_FAULT_OOM) {
 			goto out_of_memory;
+		} else if (fault & VM_FAULT_SIGSEGV) {
+			goto bad_area;
 		} else if (fault & VM_FAULT_SIGBUS) {
 			signal = SIGBUS;
 			goto bad_area;
--- a/arch/m32r/mm/fault.c
+++ b/arch/m32r/mm/fault.c
@@ -199,6 +199,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -147,6 +147,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto map_err;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto bus_err;
 		BUG();
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -215,6 +215,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -149,6 +149,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
--- a/arch/mn10300/mm/fault.c
+++ b/arch/mn10300/mm/fault.c
@@ -256,6 +256,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
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
--- a/arch/powerpc/platforms/cell/spu_fault.c
+++ b/arch/powerpc/platforms/cell/spu_fault.c
@@ -75,7 +75,7 @@ int spu_handle_mm_fault(struct mm_struct
 		if (*flt & VM_FAULT_OOM) {
 			ret = -ENOMEM;
 			goto out_unlock;
-		} else if (*flt & VM_FAULT_SIGBUS) {
+		} else if (*flt & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV)) {
 			ret = -EFAULT;
 			goto out_unlock;
 		}
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -312,6 +312,8 @@ good_area:
 	 */
 	ret = handle_mm_fault(mm, vma, address, is_write ? FAULT_FLAG_WRITE : 0);
 	if (unlikely(ret & VM_FAULT_ERROR)) {
+		if (ret & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		if (ret & VM_FAULT_OOM)
 			goto out_of_memory;
 		else if (ret & VM_FAULT_SIGBUS)
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -249,6 +249,13 @@ static noinline void do_fault_error(stru
 				do_no_context(regs, int_code, trans_exc_code);
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
--- a/arch/sh/mm/tlbflush_64.c
+++ b/arch/sh/mm/tlbflush_64.c
@@ -195,6 +195,8 @@ good_area:
 			goto out_of_memory;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		BUG();
 	}
 
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -294,6 +294,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -435,6 +435,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
--- a/arch/tile/mm/fault.c
+++ b/arch/tile/mm/fault.c
@@ -424,6 +424,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
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
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -877,6 +877,8 @@ mm_fault_error(struct pt_regs *regs, uns
 		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
 			     VM_FAULT_HWPOISON_LARGE))
 			do_sigbus(regs, error_code, address, fault);
+		else if (fault & VM_FAULT_SIGSEGV)
+			bad_area_nosemaphore(regs, error_code, address);
 		else
 			BUG();
 	}
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -109,6 +109,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -840,6 +840,7 @@ static inline int page_mapped(struct pag
 #define VM_FAULT_WRITE	0x0008	/* Special case for get_user_pages */
 #define VM_FAULT_HWPOISON 0x0010	/* Hit poisoned small page */
 #define VM_FAULT_HWPOISON_LARGE 0x0020  /* Hit poisoned large page. Index encoded in upper bits */
+#define VM_FAULT_SIGSEGV 0x0040
 
 #define VM_FAULT_NOPAGE	0x0100	/* ->fault installed the pte, not return page */
 #define VM_FAULT_LOCKED	0x0200	/* ->fault locked the returned page */
@@ -847,8 +848,8 @@ static inline int page_mapped(struct pag
 
 #define VM_FAULT_HWPOISON_LARGE_MASK 0xf000 /* encodes hpage index for large hwpoison */
 
-#define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | \
-			 VM_FAULT_HWPOISON_LARGE)
+#define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
+			 VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)
 
 /* Encode hstate index for a hwpoisoned large page */
 #define VM_FAULT_SET_HINDEX(x) ((x) << 12)
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1767,7 +1767,7 @@ int __get_user_pages(struct task_struct
 						else
 							return -EFAULT;
 					}
-					if (ret & VM_FAULT_SIGBUS)
+					if (ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV))
 						return i ? i : -EFAULT;
 					BUG();
 				}
@@ -1871,7 +1871,7 @@ int fixup_user_fault(struct task_struct
 			return -ENOMEM;
 		if (ret & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))
 			return -EHWPOISON;
-		if (ret & VM_FAULT_SIGBUS)
+		if (ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV))
 			return -EFAULT;
 		BUG();
 	}
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -342,7 +342,7 @@ static int break_ksm(struct vm_area_stru
 		else
 			ret = VM_FAULT_WRITE;
 		put_page(page);
-	} while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS | VM_FAULT_OOM)));
+	} while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
 	/*
 	 * We must loop because handle_mm_fault() may back out if there's
 	 * any difficulty e.g. if pte accessed bit gets updated concurrently.
