From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V5 09/15] x86/ptrace: Provide pt_regs helper for entry/exit
Date: Thu, 23 Jul 2020 00:00:03 +0200
Message-ID: <20200722220520.258511584@linutronix.de>
References: <20200722215954.464281930@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8-bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:52622 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733138AbgGVWLf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 18:11:35 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>, Sean Christopherson <sean.j.christopherson@intel.com>

From: Thomas Gleixner <tglx@linutronix.de>

As a preparatory step for moving the syscall and interrupt entry/exit
handling into generic code, provide a pt_regs helper which retrieves the
interrupt state from pt_regs. This is required to check whether interrupts
are reenabled by return from interrupt/exception.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>

---
V4: Remove the syscall nr and return value helpers as they alredy exist
---
 arch/x86/include/asm/ptrace.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -209,6 +209,11 @@ static inline void user_stack_pointer_se
 	regs->sp = val;
 }
 
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !(regs->flags & X86_EFLAGS_IF);
+}
+
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
 extern const char *regs_query_register_name(unsigned int offset);
