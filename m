Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45985 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbCSWgl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2015 18:36:41 -0400
From: Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 18/80] vm: add VM_FAULT_SIGSEGV handling support
Date: Thu, 19 Mar 2015 15:35:06 -0700
Message-ID: <1426804568-2907-19-git-send-email-kamal@canonical.com>
In-Reply-To: <1426804568-2907-1-git-send-email-kamal@canonical.com>
References: <1426804568-2907-1-git-send-email-kamal@canonical.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Kamal Mostafa <kamal@canonical.com>
Message-ID: <20150319223506.vq4V9jTY6imytFjMWXI6c4fgMsg1swY3nPoif7Ow-N8@z>

3.13.11-ckt17 -stable review patch.  If anyone has any objections, please let me know.

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
[ kamal: omitted for 3.13-stable:
  arch/nios2/mm/fault.c arch/powerpc/mm/copro_fault.c mm/gup.c ]
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/alpha/mm/fault.c                        | 2 ++
 arch/arc/mm/fault.c                          | 2 ++
 arch/avr32/mm/fault.c                        | 2 ++
 arch/cris/mm/fault.c                         | 2 ++
 arch/frv/mm/fault.c                          | 2 ++
 arch/ia64/mm/fault.c                         | 2 ++
 arch/m32r/mm/fault.c                         | 2 ++
 arch/m68k/mm/fault.c                         | 2 ++
 arch/metag/mm/fault.c                        | 2 ++
 arch/microblaze/mm/fault.c                   | 2 ++
 arch/mips/mm/fault.c                         | 2 ++
 arch/mn10300/mm/fault.c                      | 2 ++
 arch/openrisc/mm/fault.c                     | 2 ++
 arch/parisc/mm/fault.c                       | 2 ++
 arch/powerpc/mm/fault.c                      | 2 ++
 arch/s390/mm/fault.c                         | 6 ++++++
 arch/score/mm/fault.c                        | 2 ++
 arch/sh/mm/fault.c                           | 2 ++
 arch/sparc/mm/fault_32.c                     | 2 ++
 arch/sparc/mm/fault_64.c                     | 2 ++
 arch/tile/mm/fault.c                         | 2 ++
 arch/um/kernel/trap.c                        | 2 ++
 arch/x86/mm/fault.c                          | 2 ++
 arch/xtensa/mm/fault.c                       | 2 ++
 drivers/staging/lustre/lustre/llite/vvp_io.c | 2 +-
 include/linux/mm.h                           | 6 ++++--
 mm/ksm.c                                     | 2 +-
 27 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 98838a0..9d0ac09 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -156,6 +156,8 @@ retry:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 9c69552..15879a1 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -162,6 +162,8 @@ good_area:
 	/* TBD: switch to pagefault_out_of_memory() */
 	if (fault & VM_FAULT_OOM)
 		goto out_of_memory;
+	else if (fault & VM_FAULT_SIGSEV)
+		goto bad_area;
 	else if (fault & VM_FAULT_SIGBUS)
 		goto do_sigbus;
 
diff --git a/arch/avr32/mm/fault.c b/arch/avr32/mm/fault.c
index 0eca933..d223a8b 100644
--- a/arch/avr32/mm/fault.c
+++ b/arch/avr32/mm/fault.c
@@ -142,6 +142,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/cris/mm/fault.c b/arch/cris/mm/fault.c
index 1790f22..2686a7a 100644
--- a/arch/cris/mm/fault.c
+++ b/arch/cris/mm/fault.c
@@ -176,6 +176,8 @@ retry:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/frv/mm/fault.c b/arch/frv/mm/fault.c
index 9a66372..ec4917d 100644
--- a/arch/frv/mm/fault.c
+++ b/arch/frv/mm/fault.c
@@ -168,6 +168,8 @@ asmlinkage void do_page_fault(int datammu, unsigned long esr0, unsigned long ear
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 7225dad..ba5ba7a 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -172,6 +172,8 @@ retry:
 		 */
 		if (fault & VM_FAULT_OOM) {
 			goto out_of_memory;
+		} else if (fault & VM_FAULT_SIGSEGV) {
+			goto bad_area;
 		} else if (fault & VM_FAULT_SIGBUS) {
 			signal = SIGBUS;
 			goto bad_area;
diff --git a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
index e9c6a80..e3d4d48901 100644
--- a/arch/m32r/mm/fault.c
+++ b/arch/m32r/mm/fault.c
@@ -200,6 +200,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index eb1d61f..f0eef04 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -153,6 +153,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto map_err;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto bus_err;
 		BUG();
diff --git a/arch/metag/mm/fault.c b/arch/metag/mm/fault.c
index 332680e..2de5dc6 100644
--- a/arch/metag/mm/fault.c
+++ b/arch/metag/mm/fault.c
@@ -141,6 +141,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index fa4cf52..d46a5eb 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -224,6 +224,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index becc42b..70ab5d6 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -158,6 +158,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/mn10300/mm/fault.c b/arch/mn10300/mm/fault.c
index 3516cbd..0c2cc5d 100644
--- a/arch/mn10300/mm/fault.c
+++ b/arch/mn10300/mm/fault.c
@@ -262,6 +262,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 0703acf..230ac20 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -171,6 +171,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index d72197f..d27e388 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -256,6 +256,8 @@ good_area:
 		 */
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto bad_area;
 		BUG();
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 51ab9e7..010fabf 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -432,6 +432,8 @@ good_area:
 	 */
 	fault = handle_mm_fault(mm, vma, address, flags);
 	if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
+		if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		rc = mm_fault_error(regs, address, fault);
 		if (rc >= MM_FAULT_RETURN)
 			goto bail;
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index d95265b2..8e95432 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -239,6 +239,12 @@ static noinline void do_fault_error(struct pt_regs *regs, int fault)
 				do_no_context(regs);
 			else
 				pagefault_out_of_memory();
+		} else if (fault & VM_FAULT_SIGSEGV) {
+			/* Kernel mode? Handle exceptions or die */
+			if (!user_mode(regs))
+				do_no_context(regs);
+			else
+				do_sigsegv(regs, SEGV_MAPERR);
 		} else if (fault & VM_FAULT_SIGBUS) {
 			/* Kernel mode? Handle exceptions or die */
 			if (!user_mode(regs))
diff --git a/arch/score/mm/fault.c b/arch/score/mm/fault.c
index 52238983..6860beb 100644
--- a/arch/score/mm/fault.c
+++ b/arch/score/mm/fault.c
@@ -114,6 +114,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 541dc61..a58fec9 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -353,6 +353,8 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 	} else {
 		if (fault & VM_FAULT_SIGBUS)
 			do_sigbus(regs, error_code, address);
+		else if (fault & VM_FAULT_SIGSEGV)
+			bad_area(regs, error_code, address);
 		else
 			BUG();
 	}
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 59dbd46..163c787 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -252,6 +252,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 45a413e..0d6de79 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -448,6 +448,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/tile/mm/fault.c b/arch/tile/mm/fault.c
index 6c05712..c6d2a76 100644
--- a/arch/tile/mm/fault.c
+++ b/arch/tile/mm/fault.c
@@ -444,6 +444,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 974b874..53b8320 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -80,6 +80,8 @@ good_area:
 		if (unlikely(fault & VM_FAULT_ERROR)) {
 			if (fault & VM_FAULT_OOM) {
 				goto out_of_memory;
+			} else if (fault & VM_FAULT_SIGSEGV) {
+				goto out;
 			} else if (fault & VM_FAULT_SIGBUS) {
 				err = -EACCES;
 				goto out;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1ca1605..7e14055 100644
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
index 70fa7bc..3827833 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -117,6 +117,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/drivers/staging/lustre/lustre/llite/vvp_io.c b/drivers/staging/lustre/lustre/llite/vvp_io.c
index 3ff664c..37b14f3 100644
--- a/drivers/staging/lustre/lustre/llite/vvp_io.c
+++ b/drivers/staging/lustre/lustre/llite/vvp_io.c
@@ -601,7 +601,7 @@ static int vvp_io_kernel_fault(struct vvp_fault_io *cfio)
 		return 0;
 	}
 
-	if (cfio->fault.ft_flags & VM_FAULT_SIGBUS) {
+	if (cfio->fault.ft_flags & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV)) {
 		CDEBUG(D_PAGE, "got addr %p - SIGBUS\n", vmf->virtual_address);
 		return -EFAULT;
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c61755d..bc205d8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -972,6 +972,7 @@ static inline int page_mapped(struct page *page)
 #define VM_FAULT_WRITE	0x0008	/* Special case for get_user_pages */
 #define VM_FAULT_HWPOISON 0x0010	/* Hit poisoned small page */
 #define VM_FAULT_HWPOISON_LARGE 0x0020  /* Hit poisoned large page. Index encoded in upper bits */
+#define VM_FAULT_SIGSEGV 0x0040
 
 #define VM_FAULT_NOPAGE	0x0100	/* ->fault installed the pte, not return page */
 #define VM_FAULT_LOCKED	0x0200	/* ->fault locked the returned page */
@@ -980,8 +981,9 @@ static inline int page_mapped(struct page *page)
 
 #define VM_FAULT_HWPOISON_LARGE_MASK 0xf000 /* encodes hpage index for large hwpoison */
 
-#define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | \
-			 VM_FAULT_FALLBACK | VM_FAULT_HWPOISON_LARGE)
+#define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
+			 VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
+			 VM_FAULT_FALLBACK)
 
 /* Encode hstate index for a hwpoisoned large page */
 #define VM_FAULT_SET_HINDEX(x) ((x) << 12)
diff --git a/mm/ksm.c b/mm/ksm.c
index 418b8ca..813a1d9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -376,7 +376,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 		else
 			ret = VM_FAULT_WRITE;
 		put_page(page);
-	} while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS | VM_FAULT_OOM)));
+	} while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
 	/*
 	 * We must loop because handle_mm_fault() may back out if there's
 	 * any difficulty e.g. if pte accessed bit gets updated concurrently.
-- 
1.9.1

