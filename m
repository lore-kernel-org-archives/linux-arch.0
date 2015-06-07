From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 14/19] ARC: entry.S: move some code around for cache locality in return path
Date: Sun, 7 Jun 2015 14:08:18 +0530
Message-ID: <1433666303-26112-15-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:37835 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751323AbbFGIkK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:40:10 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/entry-compact.S |  2 +
 arch/arc/kernel/entry.S         | 98 +++++++++++++++++++++--------------------
 2 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/arch/arc/kernel/entry-compact.S b/arch/arc/kernel/entry-compact.S
index bf611ec9a017..abc62cd10a8c 100644
--- a/arch/arc/kernel/entry-compact.S
+++ b/arch/arc/kernel/entry-compact.S
@@ -391,3 +391,5 @@ not_level1_interrupt:
 	EXCEPTION_EPILOGUE
 debug_marker_syscall:
 	rtie
+
+END(ret_from_exception)
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 75cdc56351d9..603266eb75e1 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -24,6 +24,55 @@
  *------------------------------------------------------------------
  */
 
+;################### Special Sys Call Wrappers ##########################
+
+ENTRY(sys_clone_wrapper)
+	SAVE_CALLEE_SAVED_USER
+	bl  @sys_clone
+	DISCARD_CALLEE_SAVED_USER
+
+	GET_CURR_THR_INFO_FLAGS   r10
+	btst r10, TIF_SYSCALL_TRACE
+	bnz  tracesys_exit
+
+	b ret_from_system_call
+END(sys_clone_wrapper)
+
+ENTRY(ret_from_fork)
+	; when the forked child comes here from the __switch_to function
+	; r0 has the last task pointer.
+	; put last task in scheduler queue
+	bl   @schedule_tail
+
+	ld   r9, [sp, PT_status32]
+	brne r9, 0, 1f
+
+	jl.d [r14]		; kernel thread entry point
+	mov  r0, r13		; (see PF_KTHREAD block in copy_thread)
+
+1:
+	; Return to user space
+	; 1. Any forked task (Reach here via BRne above)
+	; 2. First ever init task (Reach here via return from JL above)
+	;    This is the historic "kernel_execve" use-case, to return to init
+	;    user mode, in a round about way since that is always done from
+	;    a kernel thread which is executed via JL above but always returns
+	;    out whenever kernel_execve (now inline do_fork()) is involved
+	b    ret_from_exception
+END(ret_from_fork)
+
+#ifdef CONFIG_ARC_DW2_UNWIND
+; Workaround for bug 94179 (STAR ):
+; Despite -fasynchronous-unwind-tables, linker is not making dwarf2 unwinder
+; section (.debug_frame) as loadable. So we force it here.
+; This also fixes STAR 9000487933 where the prev-workaround (objcopy --setflag)
+; would not work after a clean build due to kernel build system dependencies.
+.section .debug_frame, "wa",@progbits
+
+; Reset to .text as this file is included in entry-<isa>.S
+.section .text, "ax",@progbits
+#endif
+
 ;################### Non TLB Exception Handling #############################
 
 ; ---------------------------------------------
@@ -338,53 +387,6 @@ resume_kernel_mode:
 #endif
 
 	b	.Lrestore_regs
-END(ret_from_exception)
-
-ENTRY(ret_from_fork)
-	; when the forked child comes here from the __switch_to function
-	; r0 has the last task pointer.
-	; put last task in scheduler queue
-	bl   @schedule_tail
-
-	ld   r9, [sp, PT_status32]
-	brne r9, 0, 1f
-
-	jl.d [r14]		; kernel thread entry point
-	mov  r0, r13		; (see PF_KTHREAD block in copy_thread)
-
-1:
-	; Return to user space
-	; 1. Any forked task (Reach here via BRne above)
-	; 2. First ever init task (Reach here via return from JL above)
-	;    This is the historic "kernel_execve" use-case, to return to init
-	;    user mode, in a round about way since that is always done from
-	;    a kernel thread which is executed via JL above but always returns
-	;    out whenever kernel_execve (now inline do_fork()) is involved
-	b    ret_from_exception
-END(ret_from_fork)
 
-;################### Special Sys Call Wrappers ##########################
-
-ENTRY(sys_clone_wrapper)
-	SAVE_CALLEE_SAVED_USER
-	bl  @sys_clone
-	DISCARD_CALLEE_SAVED_USER
-
-	GET_CURR_THR_INFO_FLAGS   r10
-	btst r10, TIF_SYSCALL_TRACE
-	bnz  tracesys_exit
-
-	b ret_from_system_call
-END(sys_clone_wrapper)
-
-#ifdef CONFIG_ARC_DW2_UNWIND
-; Workaround for bug 94179 (STAR ):
-; Despite -fasynchronous-unwind-tables, linker is not making dwarf2 unwinder
-; section (.debug_frame) as loadable. So we force it here.
-; This also fixes STAR 9000487933 where the prev-workaround (objcopy --setflag)
-; would not work after a clean build due to kernel build system dependencies.
-.section .debug_frame, "wa",@progbits
+##### DONT ADD CODE HERE - .Lrestore_regs actually follows in entry-<isa>.S
 
-; Reset to .text as this file is included in entry-<isa>.S
-.section .text, "ax",@progbits
-#endif
-- 
1.9.1
