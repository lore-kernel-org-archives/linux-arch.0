From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 08/14] metag: locks: remove redundant arch_*_relax operations
Date: Tue, 17 Sep 2013 16:07:40 +0100
Message-ID: <1379430466-30520-9-git-send-email-will.deacon@arm.com>
References: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41214 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752759Ab3IQPH6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Sep 2013 11:07:58 -0400
In-Reply-To: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>

Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for metag. This patch also removes the
duplicate definitions of arch_{read,write}_lock_flags.

Acked-by: James Hogan <james.hogan@imgtec.com>
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
