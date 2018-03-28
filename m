Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58800 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeC1Mbx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Mar 2018 08:31:53 -0400
From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v7 2/4] arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
Date: Wed, 28 Mar 2018 18:01:20 +0530
Message-ID: <1522240282-12104-3-git-send-email-cpandya@codeaurora.org>
In-Reply-To: <1522240282-12104-1-git-send-email-cpandya@codeaurora.org>
References: <1522240282-12104-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <20180328123120.E13400u9gYaXrlwCpd1sBzfFjqgbKfMrauLrWOR0kQw@z>

Add an interface to invalidate intermediate page tables
from TLB for kernel.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/include/asm/tlbflush.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 9e82dd7..6a4816d 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -209,6 +209,12 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 	dsb(ish);
 }
 
+static inline void __flush_tlb_kernel_pgtable(unsigned long addr)
+{
+	addr >>= 12;
+	__tlbi(vaae1is, addr);
+	dsb(ish);
+}
 #endif
 
 #endif
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
