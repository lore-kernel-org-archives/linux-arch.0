Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752311AbdJ0Kva (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Oct 2017 06:51:30 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v4 05/28] arm64: fpsimd: Simplify uses of {set,clear}_ti_thread_flag()
Date: Fri, 27 Oct 2017 11:50:47 +0100
Message-ID: <1509101470-7881-6-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com>
References: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20171027105047.4YjQL9gSFYQmhIWGZ-UWGs-QACL2b2JYAsuSD8ANmF0@z>

The existing FPSIMD context switch code contains a couple of
instances of {set,clear}_ti_thread(task_thread_info(task)).  Since
there are thread flag manipulators that operate directly on
task_struct, this verbosity isn't strictly needed.

For consistency, this patch simplifies the affected calls.  This
should have no impact on behaviour.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/fpsimd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5d547de..7a865c8 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -159,11 +159,9 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 		if (__this_cpu_read(fpsimd_last_state) == st
 		    && st->cpu == smp_processor_id())
-			clear_ti_thread_flag(task_thread_info(next),
-					     TIF_FOREIGN_FPSTATE);
+			clear_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
 		else
-			set_ti_thread_flag(task_thread_info(next),
-					   TIF_FOREIGN_FPSTATE);
+			set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
 	}
 }
 
-- 
2.1.4
