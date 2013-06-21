From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 01/16] alpha: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 18:17:22 +0100
Message-ID: <1371835057-19335-2-git-send-email-will.deacon@arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49302 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423375Ab3FURRo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:44 -0400
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Matt Turner <mattst88@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>

The arch_{spin,read,write}_relax macros are not used anywhere in the
kernel and are typically just aliases for cpu_relax().

This patch removes the unused definitions for Alpha.

Cc: Matt Turner <mattst88@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/alpha/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/alpha/include/asm/spinlock.h b/arch/alpha/include/asm/spinlock.h
index 3bba21e..37b570d 100644
--- a/arch/alpha/include/asm/spinlock.h
+++ b/arch/alpha/include/asm/spinlock.h
@@ -168,8 +168,4 @@ static inline void arch_write_unlock(arch_rwlock_t * lock)
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* _ALPHA_SPINLOCK_H */
-- 
1.8.2.2
