From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 15/19] ARC: entry.S: micro-optimize Trap handler
Date: Sun, 7 Jun 2015 14:08:19 +0530
Message-ID: <1433666303-26112-16-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Elide the need to re-read ECR in Trap handler by ensuring that
EXCEPTION_PROLOGUE does that at the very end just before returning
to Trap handler

ARCv2 EXCEPTION_PROLOGUE already did that, so same for ARcompact and the
common trap handler adjusted to use cached ECR

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry-compact.h | 5 +++--
 arch/arc/kernel/entry.S              | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index 6c0a81b598d2..8b65eb36655a 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -181,8 +181,6 @@
 	/* ARC700 doesn't provide auto-stack switching */
 	SWITCH_TO_KERNEL_STK
 
-	lr	r9, [ecr]
-	st      r9, [sp, 8]    /* ECR */
 	st      r0, [sp, 4]    /* orig_r0, needed only for sys calls */
 
 	/* Restore r9 used to code the early prologue */
@@ -198,6 +196,9 @@
 	PUSHAX	lp_end
 	PUSHAX	lp_start
 	PUSHAX	erbta
+
+	lr	r9, [ecr]
+	st      r9, [sp, PT_event]    /* EV_Trap expects r9 to have ECR */
 .endm
 
 /*--------------------------------------------------------------
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 603266eb75e1..f7a82fd4d601 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -258,8 +258,8 @@ ENTRY(EV_Trap)
 	EXCEPTION_PROLOGUE
 
 	;============ TRAP 1   :breakpoints
-	lr     r10, [ecr]
-	bmsk.f 0, r10, 7
+	; Check ECR for trap with arg (PROLOGUE ensures r9 has ECR)
+	bmsk.f 0, r9, 7
 	bnz    trap_with_param
 
 	;============ TRAP  (no param): syscall top level
-- 
1.9.1
