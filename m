From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 02/16] arc: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 18:17:23 +0100
Message-ID: <1371835057-19335-3-git-send-email-will.deacon@arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49321 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423320Ab3FURRp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:45 -0400
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Vineet Gupta <vgupta@synopsys.com>

The arch_{spin,read,write}_relax macros are not used anywhere in the
kernel and are typically just aliases for cpu_relax().

This patch removes the unused definitions for Arc.

Cc: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arc/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
index f158197..fddced5 100644
--- a/arch/arc/include/asm/spinlock.h
+++ b/arch/arc/include/asm/spinlock.h
@@ -137,8 +137,4 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 #define arch_read_lock_flags(lock, flags)	arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags)	arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* __ASM_SPINLOCK_H */
-- 
1.8.2.2
