From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 7/7] x86/entry/64: extend register clearing on syscall entry to lower registers
Date: Fri, 30 Mar 2018 11:37:20 +0200
Message-ID: <20180330093720.6780-8-linux@dominikbrodowski.net>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330093720.6780-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

To reduce the chance that random user space content leaks down the call
chain in registers, also clear lower registers on syscall entry:

For 64bit syscalls, extend the register clearing in PUSH_AND_CLEAR_REGS
to %dx and %cx. This should not hurt at all, also on the other callers
of that macro. We do not need to clear %rdi and %rsi for syscall entry,
as those registers are used to pass the parameters to do_syscall_64().

For the 32bit compat syscalls, do_int80_syscall_32() and
do_fast_syscall_32() each only take one parameter. Therefore, extend the
register clearing to %dx, %cx, and %si in entry_SYSCALL_compat and
entry_INT80_compat.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/calling.h         | 2 ++
 arch/x86/entry/entry_64_compat.S | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index be63330c5511..593812a4c29e 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -114,7 +114,9 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq   %rsi		/* pt_regs->si */
 	.endif
 	pushq	\rdx		/* pt_regs->dx */
+	xorl	%edx, %edx	/* nosepc   dx */
 	pushq   %rcx		/* pt_regs->cx */
+	xorl	%ecx, %ecx	/* nosepc   cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
 	xorl	%r8d, %r8d	/* nospec   r8 */
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 08425c42f8b7..23e0945959e5 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -220,8 +220,11 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
+	xorl	%esi, %esi		/* nosepc   si */
 	pushq	%rdx			/* pt_regs->dx */
+	xorl	%edx, %edx		/* nosepc   dx */
 	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
+	xorl	%ecx, %ecx		/* nosepc   cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
@@ -365,8 +368,11 @@ ENTRY(entry_INT80_compat)
 
 	pushq	(%rdi)			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
+	xorl	%esi, %esi		/* nosepc   si */
 	pushq	%rdx			/* pt_regs->dx */
+	xorl	%edx, %edx		/* nosepc   dx */
 	pushq	%rcx			/* pt_regs->cx */
+	xorl	%ecx, %ecx		/* nosepc   cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
 	pushq   $0			/* pt_regs->r8  = 0 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
-- 
2.16.3
