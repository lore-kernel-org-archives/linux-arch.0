From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 15/16] sparc: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 18:17:36 +0100
Message-ID: <1371835057-19335-16-git-send-email-will.deacon@arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49338 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423412Ab3FURRr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:47 -0400
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, David Miller <davem@davemloft.net>

The arch_{spin,read,write}_relax macros are not used anywhere in the
kernel and are typically just aliases for cpu_relax().

This patch removes the unused definitions for Sparc.

Cc: David Miller <davem@davemloft.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/sparc/include/asm/spinlock_32.h | 4 ----
 arch/sparc/include/asm/spinlock_64.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/sparc/include/asm/spinlock_32.h b/arch/sparc/include/asm/spinlock_32.h
index bcc98fc..180c8f3 100644
--- a/arch/sparc/include/asm/spinlock_32.h
+++ b/arch/sparc/include/asm/spinlock_32.h
@@ -188,10 +188,6 @@ static inline int __arch_read_trylock(arch_rwlock_t *rw)
 #define arch_read_lock_flags(rw, flags)   arch_read_lock(rw)
 #define arch_write_lock_flags(rw, flags)  arch_write_lock(rw)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #define arch_read_can_lock(rw) (!((rw)->lock & 0xff))
 #define arch_write_can_lock(rw) (!(rw)->lock)
 
diff --git a/arch/sparc/include/asm/spinlock_64.h b/arch/sparc/include/asm/spinlock_64.h
index 9689176..f3b7a88 100644
--- a/arch/sparc/include/asm/spinlock_64.h
+++ b/arch/sparc/include/asm/spinlock_64.h
@@ -216,10 +216,6 @@ static int inline arch_write_trylock(arch_rwlock_t *lock)
 #define arch_read_can_lock(rw)		(!((rw)->lock & 0x80000000UL))
 #define arch_write_can_lock(rw)	(!(rw)->lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC64_SPINLOCK_H) */
-- 
1.8.2.2
