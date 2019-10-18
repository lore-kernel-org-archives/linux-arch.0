Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [217.140.110.172] ([217.140.110.172]:47188 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2505494AbfJRR1c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 13:27:32 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v3 11/12] arm64: BTI: Reset BTYPE when skipping emulated instructions
Date: Fri, 18 Oct 2019 18:25:44 +0100
Message-ID: <1571419545-20401-12-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1571419545-20401-1-git-send-email-Dave.Martin@arm.com>
References: <1571419545-20401-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <richard.henderson@linaro.org>, Sudakshina Das <sudi.das@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191018172544.1niO2ETIOXlzTjALE0-cHXCa7JSRQhRSONoRt3-EKx4@z>

Since normal execution of any non-branch instruction resets the
PSTATE BTYPE field to 0, so do the same thing when emulating a
trapped instruction.

Branches don't trap directly, so we should never need to assign a
non-zero value to BTYPE here.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since v2:

 * Drop (u64) case when masking out PSR_BTYPE_MASK in
   arm64_skip_faulting_instruction().

   PSTATE may grow, but we should address this more generally rather
   than with point hacks in this series.
---
 arch/arm64/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 3af2768..5c46a7b 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -331,6 +331,8 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 
 	if (regs->pstate & PSR_MODE32_BIT)
 		advance_itstate(regs);
+	else
+		regs->pstate &= ~PSR_BTYPE_MASK;
 }
 
 static LIST_HEAD(undef_hook);
-- 
2.1.4
