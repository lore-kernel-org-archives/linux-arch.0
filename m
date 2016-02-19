From: Dan Streetman <dan.streetman@canonical.com>
Subject: [PATCH] locking/qspinlock: move __ARCH_SPIN_LOCK_UNLOCKED to qspinlock_types.h
Date: Fri, 19 Feb 2016 13:49:27 -0500
Message-ID: <1455907767-17821-1-git-send-email-dan.streetman@canonical.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52518 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423636AbcBSSv7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Feb 2016 13:51:59 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hpe.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Streetman <dan.streetman@canonical.com>, Dan Streetman <ddstreet@ieee.org>

Move __ARCH_SPIN_LOCK_UNLOCKED definition from qspinlock.h into
qspinlock_types.h.

The definition of __ARCH_SPIN_LOCK_UNLOCKED comes from the build arch's
include files; but on x86 when CONFIG_QUEUED_SPINLOCKS is set, it just
it's defined in asm-generic/qspinlock.h.  In most cases, this doesn't
matter because linux/spinlock.h includes asm/spinlock.h, which for x86
includes asm-generic/qspinlock.h.  However, any code that only includes
linux/mutex.h will break, because it only includes asm/spinlock_types.h.

For example, this breaks systemtap, which only includes mutex.h.

Signed-off-by: Dan Streetman <dan.streetman@canonical.com>
Cc: Dan Streetman <ddstreet@ieee.org>
---
 include/asm-generic/qspinlock.h       | 5 -----
 include/asm-generic/qspinlock_types.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 39e1cb2..35a52a8 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -120,11 +120,6 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
 #endif
 
 /*
- * Initializier
- */
-#define	__ARCH_SPIN_LOCK_UNLOCKED	{ ATOMIC_INIT(0) }
-
-/*
  * Remapping spinlock architecture specific functions to the corresponding
  * queued spinlock functions.
  */
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 85f888e..034acd0 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -33,6 +33,11 @@ typedef struct qspinlock {
 } arch_spinlock_t;
 
 /*
+ * Initializier
+ */
+#define	__ARCH_SPIN_LOCK_UNLOCKED	{ ATOMIC_INIT(0) }
+
+/*
  * Bitfields in the atomic value:
  *
  * When NR_CPUS < 16K
-- 
2.5.0
