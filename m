From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 01/14] ARC: locks: remove redundant arch_*_relax operations
Date: Tue, 12 Nov 2013 16:47:39 +0000
Message-ID: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40203 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753106Ab3KLQsO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Nov 2013 11:48:14 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for ARC.

Acked-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arc/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
index b6a8c2dfbe6e..a7211e411018 100644
--- a/arch/arc/include/asm/spinlock.h
+++ b/arch/arc/include/asm/spinlock.h
@@ -144,8 +144,4 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 #define arch_read_lock_flags(lock, flags)	arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags)	arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* __ASM_SPINLOCK_H */
-- 
1.8.2.2
