Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ip4-83-240-67-251.cust.nbox.cz ([83.240.67.251]:59645 "EHLO
	ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754310AbbCQInr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Mar 2015 04:43:47 -0400
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 140/175] vm: add VM_FAULT_SIGSEGV handling support
Date: Tue, 17 Mar 2015 09:41:58 +0100
Message-ID: <1868445f57222c177ff2b3ea31f002c1b7eabb08.1426581621.git.jslaby@suse.cz>
In-Reply-To: <a48f1a6bfc3ee997dfd719eaecb44a05477b93e2.1426581620.git.jslaby@suse.cz>
References: <a48f1a6bfc3ee997dfd719eaecb44a05477b93e2.1426581620.git.jslaby@suse.cz>
In-Reply-To: <cover.1426581620.git.jslaby@suse.cz>
References: <cover.1426581620.git.jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Message-ID: <20150317084158.125EDEsWaB4KBywsf-tudzkVDvVHMQ7ZPVGqyEqm5XU@z>

From: Linus Torvalds <torvalds@linux-foundation.org>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Cc: stable@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
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
 arch/powerpc/platforms/cell/spu_fault.c      | 2 +-
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
 mm/memory.c                                  | 5 +++--
 29 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 98838a05ba6d..9d0ac091a52a 100644
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
index 0c14d8a52683..6d4094986cc4 100644
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
index 0eca93327195..d223a8b57c1e 100644
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
index 1790f22e71a2..2686a7aa8ec8 100644
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
index 9a66372fc7c7..ec4917ddf678 100644
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
index 7225dad87094..ba5ba7accd0d 100644
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
index e9c6a8014bd6..e3d4d4890104 100644
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
index eb1d61f68725..f0eef0491f77 100644
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
index 332680e5ebf2..2de5dc695a87 100644
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
index fa4cf52aa7a6..d46a5ebb7570 100644
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
index becc42bb1849..70ab5d664332 100644
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
index 3516cbdf1ee9..0c2cc5d39c8e 100644
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
index 0703acf7d327..230ac20ae794 100644
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
index 0293588d5b8c..0dda59ccc98d 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -226,6 +226,8 @@ good_area:
 		 */
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto bad_area;
 		BUG();
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 51ab9e7e6c39..010fabf3828c 100644
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
diff --git a/arch/powerpc/platforms/cell/spu_fault.c b/arch/powerpc/platforms/cell/spu_fault.c
index 641e7273d75a..62f3e4e48a0b 100644
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
index fc6679210d83..b53f37fbe056 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -244,6 +244,12 @@ static noinline void do_fault_error(struct pt_regs *regs, int fault)
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
index 52238983527d..6860beb2a280 100644
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
index 541dc6101508..a58fec9b55e0 100644
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
index 59dbd4645725..163c78712110 100644
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
index 603e462a210e..c7009d7762b1 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -446,6 +446,8 @@ good_area:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGSEGV)
+			goto bad_area;
 		else if (fault & VM_FAULT_SIGBUS)
 			goto do_sigbus;
 		BUG();
diff --git a/arch/tile/mm/fault.c b/arch/tile/mm/fault.c
index 6c0571216a9d..c6d2a76d91a8 100644
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
index 5c3aef74237f..06ab0ebe0a0f 100644
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
index 31dceb131c46..814a25d88738 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -866,6 +866,8 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
 			     VM_FAULT_HWPOISON_LARGE))
 			do_sigbus(regs, error_code, address, fault);
+		else if (fault & VM_FAULT_SIGSEGV)
+			bad_area_nosemaphore(regs, error_code, address);
 		else
 			BUG();
 	}
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 70fa7bc42b4a..38278337d85e 100644
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
index 3ff664ce7503..37b14f39551e 100644
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
index 306f0d4ce7e3..f5965a923d44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -886,6 +886,7 @@ static inline int page_mapped(struct page *page)
 #define VM_FAULT_WRITE	0x0008	/* Special case for get_user_pages */
 #define VM_FAULT_HWPOISON 0x0010	/* Hit poisoned small page */
 #define VM_FAULT_HWPOISON_LARGE 0x0020  /* Hit poisoned large page. Index encoded in upper bits */
+#define VM_FAULT_SIGSEGV 0x0040
 
 #define VM_FAULT_NOPAGE	0x0100	/* ->fault installed the pte, not return page */
 #define VM_FAULT_LOCKED	0x0200	/* ->fault locked the returned page */
@@ -894,8 +895,9 @@ static inline int page_mapped(struct page *page)
 
 #define VM_FAULT_HWPOISON_LARGE_MASK 0xf000 /* encodes hpage index for large hwpoison */
 
-#define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | \
-			 VM_FAULT_FALLBACK | VM_FAULT_HWPOISON_LARGE)
+#define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
+			 VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
+			 VM_FAULT_FALLBACK)
 
 /* Encode hstate index for a hwpoisoned large page */
 #define VM_FAULT_SET_HINDEX(x) ((x) << 12)
diff --git a/mm/ksm.c b/mm/ksm.c
index 29cbd06c4884..b61ad555184f 100644
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
diff --git a/mm/memory.c b/mm/memory.c
index cf05415c25a6..7c11dd8b9571 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1836,7 +1836,8 @@ long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 						else
 							return -EFAULT;
 					}
-					if (ret & VM_FAULT_SIGBUS)
+					if (ret & (VM_FAULT_SIGBUS |
+							VM_FAULT_SIGSEGV))
 						return i ? i : -EFAULT;
 					BUG();
 				}
@@ -1946,7 +1947,7 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 			return -ENOMEM;
 		if (ret & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))
 			return -EHWPOISON;
-		if (ret & VM_FAULT_SIGBUS)
+		if (ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV))
 			return -EFAULT;
 		BUG();
 	}
-- 
2.3.0

