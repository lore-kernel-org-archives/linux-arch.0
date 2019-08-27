Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730127AbfH0NSo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:44 -0400
From: Will Deacon <will@kernel.org>
Subject: [PATCH 6/6] arm64: kvm: Replace hardcoded '1' with SYS_PAR_EL1_F
Date: Tue, 27 Aug 2019 14:18:18 +0100
Message-ID: <20190827131818.14724-7-will@kernel.org>
In-Reply-To: <20190827131818.14724-1-will@kernel.org>
References: <20190827131818.14724-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20190827131818.NekOfK_Eu_PzJ6d5Mu7KCdWPgPodrGKI_4Mcz7KB6sc@z>

Now that we have a definition for the 'F' field of PAR_EL1, use that
instead of coding the immediate directly.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index adaf266d8de8..bd978ad71936 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -264,7 +264,7 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
 	tmp = read_sysreg(par_el1);
 	write_sysreg(par, par_el1);
 
-	if (unlikely(tmp & 1))
+	if (unlikely(tmp & SYS_PAR_EL1_F))
 		return false; /* Translation failed, back to guest */
 
 	/* Convert PAR to HPFAR format */
-- 
2.11.0
