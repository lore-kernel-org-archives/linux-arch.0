From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 08/16] m32r: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 18:17:29 +0100
Message-ID: <1371835057-19335-9-git-send-email-will.deacon@arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49355 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423453Ab3FURR6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:58 -0400
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Hirokazu Takata <takata@linux-m32r.org>

The arch_{spin,read,write}_relax macros are not used anywhere in the
kernel and are typically just aliases for cpu_relax().

This patch removes the unused definitions for m32r.

Cc: Hirokazu Takata <takata@linux-m32r.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/m32r/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/m32r/include/asm/spinlock.h b/arch/m32r/include/asm/spinlock.h
index fa13694..3112249 100644
--- a/arch/m32r/include/asm/spinlock.h
+++ b/arch/m32r/include/asm/spinlock.h
@@ -320,8 +320,4 @@ static inline int arch_write_trylock(arch_rwlock_t *lock)
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif	/* _ASM_M32R_SPINLOCK_H */
-- 
1.8.2.2
