From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 1/3] asm-generic/atomic.h: ARCH_HAS_ATOMIC_OR -> CONFIG_ARCH_HAS_ATOMIC_OR
Date: Thu, 9 Jul 2015 13:43:17 +0530
Message-ID: <1436429599-10762-2-git-send-email-vgupta@synopsys.com>
References: <1436429599-10762-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:41015 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751419AbbGIINz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 04:13:55 -0400
In-Reply-To: <1436429599-10762-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Since this is not backed by a Kconfig option, remove CONFIG_ prefix

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/atomic.h | 2 +-
 include/linux/atomic.h       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 1973ad2b13f4..1a1cdab6e702 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -104,7 +104,7 @@ ATOMIC_OP(and, &)
 #endif
 
 #ifndef atomic_set_mask
-#define CONFIG_ARCH_HAS_ATOMIC_OR
+#define ARCH_HAS_ATOMIC_OR
 ATOMIC_OP(or, |)
 #define atomic_set_mask(i, v)	atomic_or((i), (v))
 #endif
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 5b08a8540ecf..195881eec33e 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -111,7 +111,7 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 }
 #endif
 
-#ifndef CONFIG_ARCH_HAS_ATOMIC_OR
+#ifndef ARCH_HAS_ATOMIC_OR
 static inline void atomic_or(int i, atomic_t *v)
 {
 	int old;
@@ -122,7 +122,7 @@ static inline void atomic_or(int i, atomic_t *v)
 		new = old | i;
 	} while (atomic_cmpxchg(v, old, new) != old);
 }
-#endif /* #ifndef CONFIG_ARCH_HAS_ATOMIC_OR */
+#endif /* #ifndef ARCH_HAS_ATOMIC_OR */
 
 #include <asm-generic/atomic-long.h>
 #ifdef CONFIG_GENERIC_ATOMIC64
-- 
1.9.1
