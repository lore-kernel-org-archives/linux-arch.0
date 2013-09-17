From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 11/14] s390: locks: remove redundant arch_*_relax operations
Date: Tue, 17 Sep 2013 16:07:43 +0100
Message-ID: <1379430466-30520-12-git-send-email-will.deacon@arm.com>
References: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41242 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752840Ab3IQPID (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Sep 2013 11:08:03 -0400
In-Reply-To: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

Now that the arch_{read,write}_relax macros default to cpu_relax(),
remove the redundant definitions for S390.

Since S390 provides an arch_spin_relax implementation, that function is
left alone and additionally defined as a macro, so the LOCKBREAK code
will pick it up.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/s390/include/asm/spinlock.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index 701fe8c..944f4cd 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -43,6 +43,7 @@ extern void arch_spin_lock_wait(arch_spinlock_t *);
 extern void arch_spin_lock_wait_flags(arch_spinlock_t *, unsigned long flags);
 extern int arch_spin_trylock_retry(arch_spinlock_t *);
 extern void arch_spin_relax(arch_spinlock_t *lock);
+#define arch_spin_relax arch_spin_relax
 
 static inline void arch_spin_lock(arch_spinlock_t *lp)
 {
@@ -170,7 +171,4 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 	return _raw_write_trylock_retry(rw);
 }
 
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
-
 #endif /* __ASM_SPINLOCK_H */
-- 
1.8.2.2
