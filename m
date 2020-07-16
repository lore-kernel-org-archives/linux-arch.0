From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 07/13] x86/ptrace: Provide pt_regs helpers for entry/exit
Date: Thu, 16 Jul 2020 20:22:15 +0200
Message-ID: <20200716185424.658427667@linutronix.de>
References: <20200716182208.180916541@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8-bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:35274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgGPTuw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 15:50:52 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

As a preparatory step for moving the syscall and interrupt entry/exit
handling into generic code, provide pt_regs helpers which allow to:

  - Retrieve the syscall number from pt_regs
  - Retrieve the syscall return value from pt_regs
  - Retrieve the interrupt state from pt_regs to check whether interrupts
    are reenabled by return from interrupt/exception.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/ptrace.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -209,6 +209,21 @@ static inline void user_stack_pointer_se
 	regs->sp = val;
 }
 
+static inline unsigned long regs_syscall_nr(struct pt_regs *regs)
+{
+	return regs->orig_ax;
+}
+
+static inline long regs_syscall_retval(struct pt_regs *regs)
+{
+	return regs->ax;
+}
+
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !(regs->flags & X86_EFLAGS_IF);
+}
+
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
 extern const char *regs_query_register_name(unsigned int offset);
