From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 3/3] ARC: provide atomic_or() and define ARCH_HAS_ATOMIC_OR
Date: Thu, 9 Jul 2015 13:43:19 +0530
Message-ID: <1436429599-10762-4-git-send-email-vgupta@synopsys.com>
References: <1436429599-10762-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:33329 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbbGIIOF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 04:14:05 -0400
In-Reply-To: <1436429599-10762-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 03484cb4d16d..fab27dbc562b 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -141,10 +141,19 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 	ATOMIC_OP(op, c_op, asm_op)					\
 	ATOMIC_OP_RETURN(op, c_op, asm_op)
 
+/* atomic_add(), atomic_add_return() */
 ATOMIC_OPS(add, +=, add)
+
+/* atomic_sub(), atomic_sub_return() */
 ATOMIC_OPS(sub, -=, sub)
+
+/* atomic_and() */
 ATOMIC_OP(and, &=, and)
 
+#define ARCH_HAS_ATOMIC_OR
+/* atomic_or() */
+ATOMIC_OP(or, |=, or)
+
 #define atomic_clear_mask(mask, v) atomic_and(~(mask), (v))
 
 #undef ATOMIC_OPS
-- 
1.9.1
