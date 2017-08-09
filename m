Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47270 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbdHIMHi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Aug 2017 08:07:38 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 16/27] arm64/sve: Preserve SVE registers around kernel-mode NEON use
Date: Wed,  9 Aug 2017 13:05:22 +0100
Message-ID: <1502280338-23002-17-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20170809120522.d-q2UDnnF0JQg5QETFQc-JqwvZ5qIyrRMnzLzhkqW68@z>

Kernel-mode NEON will corrupt the SVE vector registers, due to the
way they alias the FPSIMD vector registers in the hardware.

This patch ensures that any live SVE register content for the task
is saved by kernel_neon_begin().  The data will be restored in the
usual way on return to userspace.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 955c873..b7fb836 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -758,8 +758,10 @@ void kernel_neon_begin(void)
 	__this_cpu_write(kernel_neon_busy, true);
 
 	/* Save unsaved task fpsimd state, if any: */
-	if (current->mm && !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
-		fpsimd_save_state(&current->thread.fpsimd_state);
+	if (current->mm) {
+		task_fpsimd_save();
+		set_thread_flag(TIF_FOREIGN_FPSTATE);
+	}
 
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	__this_cpu_write(fpsimd_last_state, NULL);
-- 
2.1.4
