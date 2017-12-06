From: <gregkh@linuxfoundation.org>
Subject: Patch "locking/refcounts, x86/asm: Use unique .text section for refcount exceptions" has been added to the 4.14-stable tree
Date: Wed, 06 Dec 2017 18:26:02 +0100
Message-ID: <15125811628183@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbdLFR0I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Dec 2017 12:26:08 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: keescook@chromium.org, alexander.levin@verizon.com, ard.biesheuvel@linaro.org, efault@gmx.de, elena.reshetova@intel.com, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de, torvalds@linux-foundation.org
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    locking/refcounts, x86/asm: Use unique .text section for refcount exceptions

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     locking-refcounts-x86-asm-use-unique-.text-section-for-refcount-exceptions.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Wed Dec  6 18:04:41 CET 2017
From: Kees Cook <keescook@chromium.org>
Date: Sat, 2 Sep 2017 13:09:45 -0700
Subject: locking/refcounts, x86/asm: Use unique .text section for refcount exceptions

From: Kees Cook <keescook@chromium.org>


[ Upstream commit 564c9cc84e2adf8a6671c1937f0a9fe3da2a4b0e ]

Using .text.unlikely for refcount exceptions isn't safe because gcc may
move entire functions into .text.unlikely (e.g. in6_dev_dev()), which
would cause any uses of a protected refcount_t function to stay inline
with the function, triggering the protection unconditionally:

        .section        .text.unlikely,"ax",@progbits
        .type   in6_dev_get, @function
in6_dev_getx:
.LFB4673:
        .loc 2 4128 0
        .cfi_startproc
...
        lock; incl 480(%rbx)
        js 111f
        .pushsection .text.unlikely
111:    lea 480(%rbx), %rcx
112:    .byte 0x0f, 0xff
.popsection
113:

This creates a unique .text..refcount section and adds an additional
test to the exception handler to WARN in the case of having none of OF,
SF, nor ZF set so we can see things like this more easily in the future.

The double dot for the section name keeps it out of the TEXT_MAIN macro
namespace, to avoid collisions and so it can be put at the end with
text.unlikely to keep the cold code together.

See commit:

  cb87481ee89db ("kbuild: linker script do not match C names unless LD_DEAD_CODE_DATA_ELIMINATION is configured")

... which matches C names: [a-zA-Z0-9_] but not ".".

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Elena <elena.reshetova@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch <linux-arch@vger.kernel.org>
Fixes: 7a46ec0e2f48 ("locking/refcounts, x86/asm: Implement fast refcount overflow protection")
Link: http://lkml.kernel.org/r/1504382986-49301-2-git-send-email-keescook@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/refcount.h   |    2 +-
 arch/x86/mm/extable.c             |    7 ++++++-
 include/asm-generic/vmlinux.lds.h |    1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -15,7 +15,7 @@
  * back to the regular execution flow in .text.
  */
 #define _REFCOUNT_EXCEPTION				\
-	".pushsection .text.unlikely\n"			\
+	".pushsection .text..refcount\n"		\
 	"111:\tlea %[counter], %%" _ASM_CX "\n"		\
 	"112:\t" ASM_UD0 "\n"				\
 	ASM_UNREACHABLE					\
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -67,12 +67,17 @@ bool ex_handler_refcount(const struct ex
 	 * wrapped around) will be set. Additionally, seeing the refcount
 	 * reach 0 will set ZF (Zero Flag: result was zero). In each of
 	 * these cases we want a report, since it's a boundary condition.
-	 *
+	 * The SF case is not reported since it indicates post-boundary
+	 * manipulations below zero or above INT_MAX. And if none of the
+	 * flags are set, something has gone very wrong, so report it.
 	 */
 	if (regs->flags & (X86_EFLAGS_OF | X86_EFLAGS_ZF)) {
 		bool zero = regs->flags & X86_EFLAGS_ZF;
 
 		refcount_error_report(regs, zero ? "hit zero" : "overflow");
+	} else if ((regs->flags & X86_EFLAGS_SF) == 0) {
+		/* Report if none of OF, ZF, nor SF are set. */
+		refcount_error_report(regs, "unexpected saturation");
 	}
 
 	return true;
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -459,6 +459,7 @@
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
+		*(.text..refcount)					\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\


Patches currently in stable-queue which might be from keescook@chromium.org are

queue-4.14/locking-refcounts-x86-asm-use-unique-.text-section-for-refcount-exceptions.patch
queue-4.14/locking-refcounts-x86-asm-enable-config_arch_has_refcount.patch
