From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 16/19] ARC: entry.S: use single EXCEPTION_PROLOGUE
Date: Sun, 7 Jun 2015 14:08:20 +0530
Message-ID: <1433666303-26112-17-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Returning from pure kernel mode and exception mode use the same code
anyways. Remove one the duplicate blocks

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/entry-compact.S | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arc/kernel/entry-compact.S b/arch/arc/kernel/entry-compact.S
index abc62cd10a8c..15d457b4403a 100644
--- a/arch/arc/kernel/entry-compact.S
+++ b/arch/arc/kernel/entry-compact.S
@@ -321,14 +321,11 @@ END(call_do_page_fault)
 	; decide that.
 
 	; if Returning from Exception
-	bbit0  r10, STATUS_AE_BIT, not_exception
-	EXCEPTION_EPILOGUE
-	rtie
+	btst   r10, STATUS_AE_BIT
+	bnz    .Lexcep_ret
 
 	; Not Exception so maybe Interrupts (Level 1 or 2)
 
-not_exception:
-
 #ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
 
 	; Level 2 interrupt return Path - from hardware standpoint
@@ -377,16 +374,17 @@ not_level2_interrupt:
 
 #endif
 
-	bbit0  r10, STATUS_A1_BIT, not_level1_interrupt
+	bbit0  r10, STATUS_A1_BIT, .Lpure_k_mode_ret
 
 	;return from level 1
 	INTERRUPT_EPILOGUE 1
 debug_marker_l1:
 	rtie
 
-not_level1_interrupt:
+.Lexcep_ret:
+.Lpure_k_mode_ret:
 
-	;this case is for syscalls or Exceptions (with fake rtie)
+	;this case is for syscalls or Exceptions or pure kernel mode
 
 	EXCEPTION_EPILOGUE
 debug_marker_syscall:
-- 
1.9.1
