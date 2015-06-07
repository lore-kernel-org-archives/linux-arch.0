From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 12/19] ARC: entry.S: Ensure that restore_regs is local to compilation unit
Date: Sun, 7 Jun 2015 14:08:16 +0530
Message-ID: <1433666303-26112-13-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:37834 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932807AbbFGIj6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:58 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

This fixes the possible link/relo errors, since restore_regs will be
provided by ISA code, but called from ARC common code.
The .L prefix reassures binutils that it will be in same compilation
unit.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/entry.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index a07cec4688ce..5995b11181fc 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -554,7 +554,7 @@ resume_user_mode_begin:
 	; Fast Path return to user mode if no pending work
 	GET_CURR_THR_INFO_FLAGS   r9
 	and.f  0,  r9, _TIF_WORK_MASK
-	bz     restore_regs
+	bz     .Lrestore_regs
 
 	; --- (Slow Path #1) task preemption ---
 	bbit0  r9, TIF_NEED_RESCHED, .Lchk_pend_signals
@@ -613,11 +613,11 @@ resume_kernel_mode:
 	; Can't preempt if preemption disabled
 	GET_CURR_THR_INFO_FROM_SP   r10
 	ld  r8, [r10, THREAD_INFO_PREEMPT_COUNT]
-	brne  r8, 0, restore_regs
+	brne  r8, 0, .Lrestore_regs
 
 	; check if this task's NEED_RESCHED flag set
 	ld  r9, [r10, THREAD_INFO_FLAGS]
-	bbit0  r9, TIF_NEED_RESCHED, restore_regs
+	bbit0  r9, TIF_NEED_RESCHED, .Lrestore_regs
 
 	; Invoke PREEMPTION
 	bl      preempt_schedule_irq
@@ -633,7 +633,7 @@ resume_kernel_mode:
 ; IRQ shd definitely not happen between now and rtie
 ; All 2 entry points to here already disable interrupts
 
-restore_regs :
+.Lrestore_regs:
 
 	TRACE_ASM_IRQ_ENABLE
 
-- 
1.9.1
