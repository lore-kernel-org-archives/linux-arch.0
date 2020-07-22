Return-Path: <SRS0=ngws=BB=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:52622 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733151AbgGVWLj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 18:11:39 -0400
Message-ID: <20200722220520.602603691@linutronix.de>
Date: Thu, 23 Jul 2020 00:00:06 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V5 12/15] x86/entry: Cleanup idtentry_entry/exit_user
References: <20200722215954.464281930@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>, Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID: <20200722220006.OaU8TW9az9wOdFaX9nC_321TaTM8uJnavYglUIrNQmA@z>

From: Thomas Gleixner <tglx@linutronix.de>

Cleanup the temporary defines and use irqentry_ instead of idtentry_.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>

---
 arch/x86/include/asm/idtentry.h |    4 ----
 arch/x86/kernel/cpu/mce/core.c  |    4 ++--
 arch/x86/kernel/traps.c         |   18 +++++++++---------
 3 files changed, 11 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,10 +11,6 @@
 
 #include <asm/irq_stack.h>
 
-/* Temporary define */
-#define idtentry_enter_user	irqentry_enter_from_user_mode
-#define idtentry_exit_user	irqentry_exit_to_user_mode
-
 typedef struct idtentry_state {
 	bool exit_rcu;
 } idtentry_state_t;
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1927,11 +1927,11 @@ static __always_inline void exc_machine_
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
-	idtentry_enter_user(regs);
+	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 	machine_check_vector(regs);
 	instrumentation_end();
-	idtentry_exit_user(regs);
+	irqentry_exit_to_user_mode(regs);
 }
 
 #ifdef CONFIG_X86_64
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -638,18 +638,18 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		return;
 
 	/*
-	 * idtentry_enter_user() uses static_branch_{,un}likely() and therefore
-	 * can trigger INT3, hence poke_int3_handler() must be done
-	 * before. If the entry came from kernel mode, then use nmi_enter()
-	 * because the INT3 could have been hit in any context including
-	 * NMI.
+	 * irqentry_enter_from_user_mode() uses static_branch_{,un}likely()
+	 * and therefore can trigger INT3, hence poke_int3_handler() must
+	 * be done before. If the entry came from kernel mode, then use
+	 * nmi_enter() because the INT3 could have been hit in any context
+	 * including NMI.
 	 */
 	if (user_mode(regs)) {
-		idtentry_enter_user(regs);
+		irqentry_enter_from_user_mode(regs);
 		instrumentation_begin();
 		do_int3_user(regs);
 		instrumentation_end();
-		idtentry_exit_user(regs);
+		irqentry_exit_to_user_mode(regs);
 	} else {
 		nmi_enter();
 		instrumentation_begin();
@@ -901,12 +901,12 @@ static __always_inline void exc_debug_us
 	 */
 	WARN_ON_ONCE(!user_mode(regs));
 
-	idtentry_enter_user(regs);
+	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	handle_debug(regs, dr6, true);
 	instrumentation_end();
-	idtentry_exit_user(regs);
+	irqentry_exit_to_user_mode(regs);
 }
 
 #ifdef CONFIG_X86_64
