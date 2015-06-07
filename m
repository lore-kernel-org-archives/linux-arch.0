From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 11/19] ARC: entry.S: comments cleanup
Date: Sun, 7 Jun 2015 14:08:15 +0530
Message-ID: <1433666303-26112-12-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37833 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932792AbbFGIjx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:53 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/entry.S | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index b120f3e1e13e..a07cec4688ce 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -322,13 +322,8 @@ ENTRY(EV_TLBProtV)
 
 	EXCEPTION_PROLOGUE
 
-	;---------(3) Save some more regs-----------------
-	;  vineetg: Mar 6th: Random Seg Fault issue #1
-	;  ecr and efa were not saved in case an Intr sneaks in
-	;  after fake rtie
-
 	lr  r2, [ecr]
-	lr  r0, [efa]	; Faulting Data address
+	lr  r0, [efa]	; Faulting Data address (not part of pt_regs saved above)
 
 	; Exception auto-disables further Intr/exceptions.
 	; Re-enable them by pretending to return from exception
@@ -336,7 +331,7 @@ ENTRY(EV_TLBProtV)
 
 	FAKE_RET_FROM_EXCPN
 
-	mov   r1, sp
+	mov   r1, sp	; Handle to pt_regs
 
 	;------ (5) Type of Protection Violation? ----------
 	;
@@ -415,8 +410,11 @@ ENTRY(EV_Extension)
 	b   ret_from_exception
 END(EV_Extension)
 
-;######################### System Call Tracing #########################
+;################ Trap Handling (Syscall, Breakpoint) ##################
 
+; ---------------------------------------------
+; syscall Tracing
+; ---------------------------------------------
 tracesys:
 	; save EFA in case tracer wants the PC of traced task
 	; using ERET won't work since next-PC has already committed
@@ -459,10 +457,9 @@ tracesys_exit:
 	b   ret_from_exception ; NOT ret_from_system_call at is saves r0 which
 	; we'd done before calling post hook above
 
-;################### Break Point TRAP ##########################
-
-	; ======= (5b) Trap is due to Break-Point =========
-
+; ---------------------------------------------
+; Breakpoint TRAP
+; ---------------------------------------------
 trap_with_param:
 
 	; stop_pc info by gdb needs this info
@@ -490,36 +487,33 @@ trap_with_param:
 
 	b   ret_from_exception
 
-;##################### Trap Handling ##############################
-;
-; EV_Trap caused by TRAP_S and TRAP0 instructions.
-;------------------------------------------------------------------
-;   (1) System Calls
-;       :parameters in r0-r7.
-;       :r8 has the system call number
-;   (2) Break Points
-;------------------------------------------------------------------
+; ---------------------------------------------
+; syscall TRAP
+; ABI: (r0-r7) upto 8 args, (r8) syscall number
+; ---------------------------------------------
 
 ENTRY(EV_Trap)
 
 	EXCEPTION_PROLOGUE
 
-	;------- (4) What caused the Trap --------------
+	;============ TRAP 1   :breakpoints
 	lr     r10, [ecr]
 	bmsk.f 0, r10, 7
 	bnz    trap_with_param
 
-	; ======= (5a) Trap is due to System Call ========
+	;============ TRAP  (no param): syscall top level
 
+	; First return from Exception to pure K mode (Exception/IRQs renabled)
 	FAKE_RET_FROM_EXCPN
 
-	; If syscall tracing ongoing, invoke pre-pos-hooks
+	; If syscall tracing ongoing, invoke pre-post-hooks
 	GET_CURR_THR_INFO_FLAGS   r10
 	btst r10, TIF_SYSCALL_TRACE
 	bnz tracesys  ; this never comes back
 
-	;============ This is normal System Call case ==========
-	; Sys-call num shd not exceed the total system calls avail
+	;============ Normal syscall case
+
+	; syscall num shd not exceed the total system calls avail
 	cmp     r8,  NR_syscalls
 	mov.hi  r0, -ENOSYS
 	bhi     ret_from_system_call
-- 
1.9.1
