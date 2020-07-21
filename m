Return-Path: <SRS0=7mXE=BA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:37466 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgGULIr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:47 -0400
Message-ID: <20200721110809.215553545@linutronix.de>
Date: Tue, 21 Jul 2020 12:57:15 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V4 09/15] x86/ptrace: Provide pt_regs helper for entry/exit
References: <20200721105706.030914876@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <20200721105715.Qaxr_5cQBEKGhEPrbIPv1g17HgKb8SlF_5P-5ocjEWI@z>

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
