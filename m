Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:62415 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbaENTIK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 15:08:10 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 01/27] arm64: Override defaults from generic/tlb.h
Date: Wed, 14 May 2014 20:59:33 +0200
Message-ID: <1400093999-18703-2-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Steve Capper <steve.capper@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@suse.cz>, linux-arm-kernel@lists.infradead.org
Message-ID: <20140514185933.QxnX9txibe6Gi2Lk62rI9hVFrLkZZh2qwaumgZqrbL8@z>

Make sure to not conflict with the defaults provided
by generic/tlb.h.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm64/include/asm/tlb.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 80e2c08..65a474d 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -19,7 +19,14 @@
 #ifndef __ASM_TLB_H
 #define __ASM_TLB_H
 
+/* These defines are needed to override the defaults from asm-generic/tlb.h */
 #define  __tlb_remove_pmd_tlb_entry __tlb_remove_pmd_tlb_entry
+#define tlb_start_vma tlb_start_vma
+#define tlb_end_vma tlb_end_vma
+#define __tlb_remove_tlb_entry __tlb_remove_tlb_entry
+#define tlb_flush tlb_flush
+#define __pte_free_tlb __pte_free_tlb
+#define __pmd_free_tlb __pmd_free_tlb
 
 #include <asm-generic/tlb.h>
 
-- 
1.8.4.2

