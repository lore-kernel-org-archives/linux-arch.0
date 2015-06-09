From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 04/28] ARCv2: STAR 9000808988: signals involving Delay Slot
Date: Tue, 9 Jun 2015 17:18:04 +0530
Message-ID: <1433850508-26317-5-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:33096 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753833AbbFILuY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:50:24 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Reported by Anton as LTP:munmap01 failing with Illegal Instruction
Exception.

   --------------------->8--------------------------------------
   mmap2(NULL, 24576, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x200d2000
   munmap(0x200d2000, 24576)               = 0
   --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=0x200d2000}
   ---
   potentially unexpected fatal signal 4.
   Path: /munmap01
   CPU: 0 PID: 61 Comm: munmap01 Not tainted 3.13.0-g5d5c46d9a556 #8
   task: 9f1a8000 ti: 9f154000 task.ti: 9f154000

   [ECR   ]: 0x00020100 => Illegal Insn
   [EFA   ]: 0x0001354c
   [BLINK ]: 0x200515d4
   [ERET  ]: 0x1354c
       @off 0x1354c in [/munmap01]
       VMA: 0x00010000 to 0x00018000
   [STAT32]: 0x800802c0
   ...
   --------------------->8--------------------------------------

The issue was
1. munmap01 accessed unmapped memory (on purpose) with signal handler
   installed for SIGSEGV

2. The faulting instruction happened to be in Delay Slot
   00011864 <main>:
      11908:	bl.d       13284 <tst_resm>
      1190c:	stb        r16,[r2]

3. kernel sets up the reg file for signal handler and correctly clears
   the DE bit in pt_regs->status32 placeholder

4. However RESTORE_CALLEE_SAVED_USER macro is not adjusted for ARCv2,
   and it over-writes the above with orig/stale value of status32

5. After RTIE, userspace signal handler executes a non branch
   instruction with DE bit set, triggering Illegal Instruction Exception.

Reported-by: Anton Kolesov <akolesov@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry.h  | 17 ++++++++++-------
 arch/arc/kernel/asm-offsets.c |  2 ++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index 29d0ab6e10f5..ad7860c5ce15 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -125,8 +125,6 @@
 	POP	r13
 .endm
 
-#define OFF_USER_R25_FROM_R24	(SZ_CALLEE_REGS + SZ_PT_REGS - 8)/4
-
 /*--------------------------------------------------------------
  * Collect User Mode callee regs as struct callee_regs - needed by
  * fork/do_signal/unaligned-access-emulation.
@@ -139,12 +137,13 @@
  *-------------------------------------------------------------*/
 .macro SAVE_CALLEE_SAVED_USER
 
+	mov	r12, sp		; save SP as ref to pt_regs
 	SAVE_R13_TO_R24
 
 #ifdef CONFIG_ARC_CURR_IN_REG
-	; Retrieve orig r25 and save it on stack
-	ld.as   r12, [sp, OFF_USER_R25_FROM_R24]
-	st.a    r12, [sp, -4]
+	; Retrieve orig r25 and save it with rest of callee_regs
+	ld.as   r12, [r12, PT_user_r25]
+	PUSH	r12
 #else
 	PUSH	r25
 #endif
@@ -191,12 +190,16 @@
 .macro RESTORE_CALLEE_SAVED_USER
 
 #ifdef CONFIG_ARC_CURR_IN_REG
-	ld.ab   r12, [sp, 4]
-	st.as   r12, [sp, OFF_USER_R25_FROM_R24]
+	POP	r12
 #else
 	POP	r25
 #endif
 	RESTORE_R24_TO_R13
+
+	; SP is back to start of pt_regs
+#ifdef CONFIG_ARC_CURR_IN_REG
+	st.as   r12, [sp, PT_user_r25]
+#endif
 .endm
 
 /*--------------------------------------------------------------
diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index b9cf23313273..605281f5b301 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -60,5 +60,7 @@ int main(void)
 
 	DEFINE(SZ_CALLEE_REGS, sizeof(struct callee_regs));
 	DEFINE(SZ_PT_REGS, sizeof(struct pt_regs));
+	DEFINE(PT_user_r25, offsetof(struct pt_regs, user_r25));
+
 	return 0;
 }
-- 
1.9.1
