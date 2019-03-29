Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:43820 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfC2PVX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2019 11:21:23 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v2 1/5] locking/qspinlock: Make arch_mcs_spin_unlock_contended more generic
Date: Fri, 29 Mar 2019 11:20:02 -0400
Message-ID: <20190329152006.110370-2-alex.kogan@oracle.com>
In-Reply-To: <20190329152006.110370-1-alex.kogan@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190329152002.Dl1OD8_cESL2P8_j35NHsDGrj1YbuQCfIxaqW8I_oF4@z>

The arch_mcs_spin_unlock_contended macro should accept the value to be
stored into the lock argument as another argument. This allows using the
same macro in cases where the value to be stored is different from 1.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 arch/arm/include/asm/mcs_spinlock.h | 4 ++--
 kernel/locking/mcs_spinlock.h       | 6 +++---
 kernel/locking/qspinlock.c          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
index 529d2cf4d06f..ae6d763477f4 100644
--- a/arch/arm/include/asm/mcs_spinlock.h
+++ b/arch/arm/include/asm/mcs_spinlock.h
@@ -14,9 +14,9 @@ do {									\
 		wfe();							\
 } while (0)								\
 
-#define arch_mcs_spin_unlock_contended(lock)				\
+#define arch_mcs_spin_unlock_contended(lock, val)			\
 do {									\
-	smp_store_release(lock, 1);					\
+	smp_store_release(lock, (val));					\
 	dsb_sev();							\
 } while (0)
 
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 5e10153b4d3c..bc6d3244e1af 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -41,8 +41,8 @@ do {									\
  * operations in the critical section has been completed before
  * unlocking.
  */
-#define arch_mcs_spin_unlock_contended(l)				\
-	smp_store_release((l), 1)
+#define arch_mcs_spin_unlock_contended(l, val)				\
+	smp_store_release((l), (val))
 #endif
 
 /*
@@ -115,7 +115,7 @@ void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 	}
 
 	/* Pass lock to next waiter. */
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_spin_unlock_contended(&next->locked, 1);
 }
 
 #endif /* __LINUX_MCS_SPINLOCK_H */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 5e9247dc2515..5941ce3527ce 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -558,7 +558,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_spin_unlock_contended(&next->locked, 1);
 	pv_kick_node(lock, next);
 
 release:
-- 
2.11.0 (Apple Git-81)
