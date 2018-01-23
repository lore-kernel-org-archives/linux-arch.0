From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 07/10] signal/powerpc: Remove unnecessary signal_code parameter of do_send_trap
Date: Tue, 23 Jan 2018 15:07:16 -0600
Message-ID: <20180123210719.10456-7-ebiederm@xmission.com>
References: <87607s5lra.fsf_-_@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:46708 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeAWVJO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jan 2018 16:09:14 -0500
In-Reply-To: <87607s5lra.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>

signal_code is always TRAP_HWBKPT

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/include/asm/debug.h |  2 +-
 arch/powerpc/kernel/process.c    |  6 +++---
 arch/powerpc/kernel/traps.c      | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index 14e71ff6579e..fc97404de0a3 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -49,7 +49,7 @@ void set_breakpoint(struct arch_hw_breakpoint *brk);
 void __set_breakpoint(struct arch_hw_breakpoint *brk);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
-			 unsigned long error_code, int signal_code, int brkpt);
+			 unsigned long error_code, int brkpt);
 #else
 
 extern void do_break(struct pt_regs *regs, unsigned long address,
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 72be0c32e902..bfb48cf56bc3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -601,11 +601,11 @@ EXPORT_SYMBOL(flush_all_to_thread);
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 void do_send_trap(struct pt_regs *regs, unsigned long address,
-		  unsigned long error_code, int signal_code, int breakpt)
+		  unsigned long error_code, int breakpt)
 {
 	siginfo_t info;
 
-	current->thread.trap_nr = signal_code;
+	current->thread.trap_nr = TRAP_HWBKPT;
 	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
 			11, SIGSEGV) == NOTIFY_STOP)
 		return;
@@ -613,7 +613,7 @@ void do_send_trap(struct pt_regs *regs, unsigned long address,
 	/* Deliver the signal to userspace */
 	info.si_signo = SIGTRAP;
 	info.si_errno = breakpt;	/* breakpoint or watchpoint id */
-	info.si_code = signal_code;
+	info.si_code = TRAP_HWBKPT;
 	info.si_addr = (void __user *)address;
 	force_sig_info(SIGTRAP, &info, current);
 }
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f2e6e1838952..c93f1e6a9fff 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1750,34 +1750,34 @@ static void handle_debug(struct pt_regs *regs, unsigned long debug_status)
 #ifdef CONFIG_PPC_ADV_DEBUG_DAC_RANGE
 		current->thread.debug.dbcr2 &= ~DBCR2_DAC12MODE;
 #endif
-		do_send_trap(regs, mfspr(SPRN_DAC1), debug_status, TRAP_HWBKPT,
+		do_send_trap(regs, mfspr(SPRN_DAC1), debug_status,
 			     5);
 		changed |= 0x01;
 	}  else if (debug_status & (DBSR_DAC2R | DBSR_DAC2W)) {
 		dbcr_dac(current) &= ~(DBCR_DAC2R | DBCR_DAC2W);
-		do_send_trap(regs, mfspr(SPRN_DAC2), debug_status, TRAP_HWBKPT,
+		do_send_trap(regs, mfspr(SPRN_DAC2), debug_status,
 			     6);
 		changed |= 0x01;
 	}  else if (debug_status & DBSR_IAC1) {
 		current->thread.debug.dbcr0 &= ~DBCR0_IAC1;
 		dbcr_iac_range(current) &= ~DBCR_IAC12MODE;
-		do_send_trap(regs, mfspr(SPRN_IAC1), debug_status, TRAP_HWBKPT,
+		do_send_trap(regs, mfspr(SPRN_IAC1), debug_status,
 			     1);
 		changed |= 0x01;
 	}  else if (debug_status & DBSR_IAC2) {
 		current->thread.debug.dbcr0 &= ~DBCR0_IAC2;
-		do_send_trap(regs, mfspr(SPRN_IAC2), debug_status, TRAP_HWBKPT,
+		do_send_trap(regs, mfspr(SPRN_IAC2), debug_status,
 			     2);
 		changed |= 0x01;
 	}  else if (debug_status & DBSR_IAC3) {
 		current->thread.debug.dbcr0 &= ~DBCR0_IAC3;
 		dbcr_iac_range(current) &= ~DBCR_IAC34MODE;
-		do_send_trap(regs, mfspr(SPRN_IAC3), debug_status, TRAP_HWBKPT,
+		do_send_trap(regs, mfspr(SPRN_IAC3), debug_status,
 			     3);
 		changed |= 0x01;
 	}  else if (debug_status & DBSR_IAC4) {
 		current->thread.debug.dbcr0 &= ~DBCR0_IAC4;
-		do_send_trap(regs, mfspr(SPRN_IAC4), debug_status, TRAP_HWBKPT,
+		do_send_trap(regs, mfspr(SPRN_IAC4), debug_status,
 			     4);
 		changed |= 0x01;
 	}
-- 
2.14.1
