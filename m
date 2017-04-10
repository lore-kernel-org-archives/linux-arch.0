From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
Date: Tue, 11 Apr 2017 01:35:04 +0400
Message-ID: <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0071.outbound.protection.outlook.com ([104.47.37.71]:52224
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752940AbdDJVf5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Apr 2017 17:35:57 -0400
In-Reply-To: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jan Glauber <jglauber@cavium.com>

From: Jan Glauber <jglauber@cavium.com>

Ported from x86_64 with paravirtualization support removed.

Signed-off-by: Jan Glauber <jglauber@cavium.com>

Note. This patch removes protection from direct inclusion of
arch/arm64/include/asm/spinlock_types.h. It's done because
kernel/locking/qrwlock.c file does it thru the header
include/asm-generic/qrwlock_types.h. Until now the only user
of qrwlock.c was x86, and there's no such protection too.

I'm not happy to remove the protection, but if it's OK for x86,
it should be also OK for arm64. If not, I think we'd fix it
for x86, and add the protection there too.

Yury

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/Kconfig                      |  2 ++
 arch/arm64/include/asm/qrwlock.h        |  7 +++++++
 arch/arm64/include/asm/qspinlock.h      | 20 ++++++++++++++++++++
 arch/arm64/include/asm/spinlock.h       | 12 ++++++++++++
 arch/arm64/include/asm/spinlock_types.h | 14 +++++++++++---
 5 files changed, 52 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/qrwlock.h
 create mode 100644 arch/arm64/include/asm/qspinlock.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f2b0b52..ac1c170 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -24,6 +24,8 @@ config ARM64
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_RWLOCKS
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
diff --git a/arch/arm64/include/asm/qrwlock.h b/arch/arm64/include/asm/qrwlock.h
new file mode 100644
index 0000000..626f6eb
--- /dev/null
+++ b/arch/arm64/include/asm/qrwlock.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_ARM64_QRWLOCK_H
+#define _ASM_ARM64_QRWLOCK_H
+
+#include <asm-generic/qrwlock_types.h>
+#include <asm-generic/qrwlock.h>
+
+#endif /* _ASM_ARM64_QRWLOCK_H */
diff --git a/arch/arm64/include/asm/qspinlock.h b/arch/arm64/include/asm/qspinlock.h
new file mode 100644
index 0000000..98f50fc
--- /dev/null
+++ b/arch/arm64/include/asm/qspinlock.h
@@ -0,0 +1,20 @@
+#ifndef _ASM_ARM64_QSPINLOCK_H
+#define _ASM_ARM64_QSPINLOCK_H
+
+#include <asm-generic/qspinlock_types.h>
+
+#define	queued_spin_unlock queued_spin_unlock
+/**
+ * queued_spin_unlock - release a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ *
+ * A smp_store_release() on the least-significant byte.
+ */
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	smp_store_release((u8 *)lock, 0);
+}
+
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_ARM64_QSPINLOCK_H */
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index cae331d..3771339 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -20,6 +20,10 @@
 #include <asm/spinlock_types.h>
 #include <asm/processor.h>
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#else
+
 /*
  * Spinlock implementation.
  *
@@ -187,6 +191,12 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 }
 #define arch_spin_is_contended	arch_spin_is_contended
 
+#endif /* CONFIG_QUEUED_SPINLOCKS */
+
+#ifdef CONFIG_QUEUED_RWLOCKS
+#include <asm/qrwlock.h>
+#else
+
 /*
  * Write lock implementation.
  *
@@ -351,6 +361,8 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 /* read_can_lock - would read_trylock() succeed? */
 #define arch_read_can_lock(x)		((x)->lock < 0x80000000)
 
+#endif /* CONFIG_QUEUED_RWLOCKS */
+
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm/spinlock_types.h
index 55be59a..0f0f156 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -16,9 +16,9 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
-# error "please don't include this file directly"
-#endif
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock_types.h>
+#else
 
 #include <linux/types.h>
 
@@ -36,10 +36,18 @@ typedef struct {
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 , 0 }
 
+#endif /* CONFIG_QUEUED_SPINLOCKS */
+
+#ifdef CONFIG_QUEUED_RWLOCKS
+#include <asm-generic/qrwlock_types.h>
+#else
+
 typedef struct {
 	volatile unsigned int lock;
 } arch_rwlock_t;
 
 #define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
 
+#endif /* CONFIG_QUEUED_RWLOCKS */
+
 #endif
-- 
2.7.4
