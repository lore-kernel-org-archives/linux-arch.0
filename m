From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 03/28] ARCv2: STAR 9000793984: Handle return from intr to Delay Slot
Date: Tue, 9 Jun 2015 17:18:03 +0530
Message-ID: <1433850508-26317-4-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51846 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbbFILvi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:51:38 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/asm-offsets.c |  1 +
 arch/arc/kernel/entry-arcv2.S | 50 +++++++++++++++++++++++++++++++++++++++++++
 arch/arc/kernel/setup.c       |  2 ++
 3 files changed, 53 insertions(+)

diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index 6c3aa0edb9b5..b9cf23313273 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -56,6 +56,7 @@ int main(void)
 	DEFINE(PT_r5, offsetof(struct pt_regs, r5));
 	DEFINE(PT_r6, offsetof(struct pt_regs, r6));
 	DEFINE(PT_r7, offsetof(struct pt_regs, r7));
+	DEFINE(PT_ret, offsetof(struct pt_regs, ret));
 
 	DEFINE(SZ_CALLEE_REGS, sizeof(struct callee_regs));
 	DEFINE(SZ_PT_REGS, sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index c59a396b7b98..bd7105d3172f 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -163,6 +163,9 @@ END(EV_TLBProtV)
 ;####### Return from Intr #######
 
 debug_marker_l1:
+	bbit1.nt r0, STATUS_DE_BIT, .Lintr_ret_to_delay_slot
+
+.Lisr_ret_fast_path:
 	; Handle special case #1: (Entry via Exception, Return via IRQ)
 	;
 	; Exception in U mode, preempted in kernel, Intr taken (K mode), orig
@@ -186,4 +189,51 @@ debug_marker_syscall:
 	EXCEPTION_EPILOGUE
 	rtie
 
+;####### Return from Intr to insn in delay slot #######
+
+; Handle special case #2: (Entry via Exception in Delay Slot, Return via IRQ)
+;
+; Intr returning to a Delay Slot (DS) insn
+; (since IRQ NOT allowed in DS in ARCv2, this can only happen if orig
+; entry was via Exception in DS which got preempted in kernel).
+;
+; IRQ RTIE won't reliably restore DE bit and/or BTA, needs handling
+.Lintr_ret_to_delay_slot:
+debug_marker_ds:
+
+	ld	r2, [@intr_to_DE_cnt]
+	add	r2, r2, 1
+	st	r2, [@intr_to_DE_cnt]
+
+	ld	r2, [sp, PT_ret]
+	ld	r3, [sp, PT_status32]
+
+	bic  	r0, r3, STATUS_U_MASK|STATUS_DE_MASK|STATUS_IE_MASK|STATUS_L_MASK
+	st	r0, [sp, PT_status32]
+
+	mov	r1, .Lintr_ret_to_delay_slot_2
+	st	r1, [sp, PT_ret]
+
+	st	r2, [sp, 0]
+	st	r3, [sp, 4]
+
+	b	.Lisr_ret_fast_path
+
+.Lintr_ret_to_delay_slot_2:
+	sub	sp, sp, SZ_PT_REGS
+	st	r9, [sp, -4]
+
+	ld	r9, [sp, 0]
+	sr	r9, [eret]
+
+	ld	r9, [sp, 4]
+	sr	r9, [erstatus]
+
+	ld	r9, [sp, 8]
+	sr	r9, [erbta]
+
+	ld	r9, [sp, -4]
+	add	sp, sp, SZ_PT_REGS
+	rtie
+
 END(ret_from_exception)
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index d6fe80070bbf..ca71cef4bafd 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -30,6 +30,8 @@
 
 #define FIX_PTR(x)  __asm__ __volatile__(";" : "+r"(x))
 
+unsigned int intr_to_DE_cnt;
+
 /* Part of U-boot ABI: see head.S */
 int __initdata uboot_tag;
 char __initdata *uboot_arg;
-- 
1.9.1
