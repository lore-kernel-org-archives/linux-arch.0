From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 8/9] arm64: cmpxchg: implement cmpxchg_relaxed
Date: Tue,  7 Jul 2015 18:24:24 +0100
Message-ID: <1436289865-2331-9-git-send-email-will.deacon@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50323 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757613AbbGGRZH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 13:25:07 -0400
In-Reply-To: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Waiman.Long@hp.com, peterz@infradead.org, mingo@redhat.com, Will Deacon <will.deacon@arm.com>

cmpxchg_relaxed offers an SMP-safe, barrier-less cmpxchg implementation
so we can define it in the same way that we implement cmpxchg_local on
arm64.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cmpxchg.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index d8c25b7b18fb..317bb7f6f92a 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -219,7 +219,7 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 	__ret; \
 })
 
-#define cmpxchg_local(ptr, o, n) \
+#define cmpxchg_relaxed(ptr, o, n) \
 ({ \
 	__typeof__(*(ptr)) __ret; \
 	__ret = (__typeof__(*(ptr))) \
@@ -228,6 +228,8 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 	__ret; \
 })
 
+#define cmpxchg_local	cmpxchg_relaxed
+
 #define cmpxchg_double(ptr1, ptr2, o1, o2, n1, n2) \
 ({\
 	int __ret;\
@@ -274,6 +276,6 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 #define cmpxchg64(ptr,o,n)		cmpxchg((ptr),(o),(n))
 #define cmpxchg64_local(ptr,o,n)	cmpxchg_local((ptr),(o),(n))
 
-#define cmpxchg64_relaxed(ptr,o,n)	cmpxchg_local((ptr),(o),(n))
+#define cmpxchg64_relaxed(ptr,o,n)	cmpxchg_relaxed((ptr),(o),(n))
 
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.1.4
