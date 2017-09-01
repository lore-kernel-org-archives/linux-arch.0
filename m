From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] locking/refcounts, x86/asm: Use unique .text section for
 refcount exceptions
Date: Fri, 1 Sep 2017 13:22:03 -0700
Message-ID: <20170901202203.GA48925@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35126 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbdIAUWF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2017 16:22:05 -0400
Received: by mail-pg0-f42.google.com with SMTP id 63so3384362pgc.2
        for <linux-arch@vger.kernel.org>; Fri, 01 Sep 2017 13:22:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, "Reshetova, Elena" <elena.reshetova@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Using .text.unlikely for refcount exceptions isn't safe because gcc may
move entire functions into .text.unlikely (e.g. in6_dev_get()), which
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

This creates a unique .text section and adds an additional test to the
exception handler to WARN in the case of having none of OF, SF, nor ZF
set so we can see things like this more easily in the future.

Reported-by: Mike Galbraith <efault@gmx.de>
Fixes: 7a46ec0e2f48 ("locking/refcounts, x86/asm: Implement fast refcount overflow protection")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig                  | 2 +-
 arch/x86/include/asm/refcount.h   | 2 +-
 arch/x86/mm/extable.c             | 7 ++++++-
 include/asm-generic/vmlinux.lds.h | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eaa8ff41f424..c6acdcdb3fc6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -56,7 +56,7 @@ config X86
 	select ARCH_HAS_MMIO_FLUSH
 	select ARCH_HAS_PMEM_API		if X86_64
 	# Causing hangs/crashes, see the commit that added this change for details.
-	select ARCH_HAS_REFCOUNT		if BROKEN
+	select ARCH_HAS_REFCOUNT
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index ff871210b9f2..4e44250e7d0d 100644
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
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index c076f710de4c..cf0d74b47ae0 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -66,12 +66,17 @@ bool ex_handler_refcount(const struct exception_table_entry *fixup,
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
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8acfc1e099e1..e549bff87c5b 100644
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
-- 
2.7.4


-- 
Kees Cook
Pixel Security
