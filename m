From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 13/14] sparc: locks: remove redundant arch_*_relax operations
Date: Tue, 17 Sep 2013 16:07:45 +0100
Message-ID: <1379430466-30520-14-git-send-email-will.deacon@arm.com>
References: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41226 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752828Ab3IQPH6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Sep 2013 11:07:58 -0400
In-Reply-To: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for Sparc.

Acked-by: David S. Miller <davem@davemloft.net>
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
