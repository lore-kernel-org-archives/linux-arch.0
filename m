From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 07/19] ARC: entry.S: canonical'ize EXCEPTION_{PROLOGUE,EPILOGUE}
Date: Sun, 7 Jun 2015 14:08:11 +0530
Message-ID: <1433666303-26112-8-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:56898 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932775AbbFGIju (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:50 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

-EXCEPTION_EPILOGUE introduced
-EXCEPTION_PROLOGUE now also includes reg file saving

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry.h | 17 +----------------
 arch/arc/kernel/entry.S      |  4 ++--
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index 35c4111d8c80..e880a5f1b2e4 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -401,21 +401,6 @@
 	/* ARC700 doesn't provide auto-stack switching */
 	SWITCH_TO_KERNEL_STK
 
-	/* save the regfile */
-	SAVE_ALL_SYS
-.endm
-
-/*--------------------------------------------------------------
- * Save all registers used by Exceptions (TLB Miss, Prot-V, Mem err etc)
- * Requires SP to be already switched to kernel mode Stack
- * sp points to the next free element on the stack at exit of this macro.
- * Registers are pushed / popped in the order defined in struct ptregs
- * in asm/ptrace.h
- * Note that syscalls are implemented via TRAP which is also a exception
- * from CPU's point of view
- *-------------------------------------------------------------*/
-.macro SAVE_ALL_SYS
-
 	lr	r9, [ecr]
 	st      r9, [sp, 8]    /* ECR */
 	st      r0, [sp, 4]    /* orig_r0, needed only for sys calls */
@@ -446,7 +431,7 @@
  * for memory load operations. If used in that way interrupts are deffered
  * by hardware and that is not good.
  *-------------------------------------------------------------*/
-.macro RESTORE_ALL_SYS
+.macro EXCEPTION_EPILOGUE
 	POPAX	erbta
 	POPAX	lp_start
 	POPAX	lp_end
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 03a349520b55..d8ec722a936b 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -638,7 +638,7 @@ restore_regs :
 
 	; if Returning from Exception
 	bbit0  r10, STATUS_AE_BIT, not_exception
-	RESTORE_ALL_SYS
+	EXCEPTION_EPILOGUE
 	rtie
 
 	; Not Exception so maybe Interrupts (Level 1 or 2)
@@ -704,7 +704,7 @@ not_level1_interrupt:
 
 	;this case is for syscalls or Exceptions (with fake rtie)
 
-	RESTORE_ALL_SYS
+	EXCEPTION_EPILOGUE
 debug_marker_syscall:
 	rtie
 
-- 
1.9.1
