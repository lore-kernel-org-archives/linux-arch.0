Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:38594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfJJSqF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 14:46:05 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v2 12/12] KVM: arm64: BTI: Reset BTYPE when skipping emulated instructions
Date: Thu, 10 Oct 2019 19:44:40 +0100
Message-ID: <1570733080-21015-13-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Mark Brown <broonie@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <richard.henderson@linaro.org>, Sudakshina Das <sudi.das@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191010184440.EOMUEMUYcdTrZ1HDWi77XAt36n6VDhmnJ3p1hO-zHDU@z>

Since normal execution of any non-branch instruction resets the
PSTATE BTYPE field to 0, so do the same thing when emulating a
trapped instruction.

Branches don't trap directly, so we should never need to assign a
non-zero value to BTYPE here.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index d69c1ef..33957a12 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -452,8 +452,10 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
 {
 	if (vcpu_mode_is_32bit(vcpu))
 		kvm_skip_instr32(vcpu, is_wide_instr);
-	else
+	else {
 		*vcpu_pc(vcpu) += 4;
+		*vcpu_cpsr(vcpu) &= ~(u64)PSR_BTYPE_MASK;
+	}
 
 	/* advance the singlestep state machine */
 	*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
-- 
2.1.4
