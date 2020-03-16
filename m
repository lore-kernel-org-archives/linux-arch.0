Return-Path: <SRS0=yjua=5B=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:52268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732228AbgCPQvT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 12:51:19 -0400
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v10 09/13] arm64: BTI: Reset BTYPE when skipping emulated instructions
Date: Mon, 16 Mar 2020 16:50:51 +0000
Message-ID: <20200316165055.31179-10-broonie@kernel.org>
In-Reply-To: <20200316165055.31179-1-broonie@kernel.org>
References: <20200316165055.31179-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>, Mark Brown <broonie@kernel.org>
Message-ID: <20200316165051.3Olic7pZqcH--_Mkmbs2m9sa1dPHiGRza4F-Rc-sgJE@z>

From: Dave Martin <Dave.Martin@arm.com>

Since normal execution of any non-branch instruction resets the
PSTATE BTYPE field to 0, so do the same thing when emulating a
trapped instruction.

Branches don't trap directly, so we should never need to assign a
non-zero value to BTYPE here.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 3c986c8ca204..10d6451b2776 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -340,6 +340,8 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 
 	if (compat_user_mode(regs))
 		advance_itstate(regs);
+	else
+		regs->pstate &= ~PSR_BTYPE_MASK;
 }
 
 static LIST_HEAD(undef_hook);
-- 
2.20.1
