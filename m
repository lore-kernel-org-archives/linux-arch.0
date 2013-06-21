From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 09/16] metag: locks: remove unused arch_*_relax operations
Date: Fri, 21 Jun 2013 18:17:30 +0100
Message-ID: <1371835057-19335-10-git-send-email-will.deacon@arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49318 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423392Ab3FURRp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:45 -0400
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, James Hogan <james.hogan@imgtec.com>

The arch_{spin,read,write}_relax macros are not used anywhere in the
kernel and are typically just aliases for cpu_relax().

This patch removes the unused definitions for Metag, including duplicate
definitions of arch_{read,write}_lock_flags.

Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/metag/include/asm/spinlock.h        | 4 ----
 arch/metag/include/asm/spinlock_lnkget.h | 7 -------
 2 files changed, 11 deletions(-)

diff --git a/arch/metag/include/asm/spinlock.h b/arch/metag/include/asm/spinlock.h
index 86a7cf3..15cf4ff 100644
--- a/arch/metag/include/asm/spinlock.h
+++ b/arch/metag/include/asm/spinlock.h
@@ -15,8 +15,4 @@
 #define	arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define	arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* __ASM_SPINLOCK_H */
diff --git a/arch/metag/include/asm/spinlock_lnkget.h b/arch/metag/include/asm/spinlock_lnkget.h
index ad8436f..73d0345 100644
--- a/arch/metag/include/asm/spinlock_lnkget.h
+++ b/arch/metag/include/asm/spinlock_lnkget.h
@@ -239,11 +239,4 @@ static inline int arch_read_can_lock(arch_rwlock_t *rw)
 	return tmp;
 }
 
-#define	arch_read_lock_flags(lock, flags) arch_read_lock(lock)
-#define	arch_write_lock_flags(lock, flags) arch_write_lock(lock)
-
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* __ASM_SPINLOCK_LNKGET_H */
-- 
1.8.2.2
