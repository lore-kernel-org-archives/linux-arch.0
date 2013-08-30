From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 02/11] xtensa: fix arch spinlock function names
Date: Fri, 30 Aug 2013 19:34:54 +0400
Message-ID: <1377876903-27860-3-git-send-email-jcmvbkbc@gmail.com>
References: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:57033 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab3H3PfQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:16 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so1878025lbi.1
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:14 -0700 (PDT)
In-Reply-To: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/spinlock.h       |   31 ++++++++++++++++-------------
 arch/xtensa/include/asm/spinlock_types.h |   20 +++++++++++++++++++
 2 files changed, 37 insertions(+), 14 deletions(-)
 create mode 100644 arch/xtensa/include/asm/spinlock_types.h

diff --git a/arch/xtensa/include/asm/spinlock.h b/arch/xtensa/include/asm/spinlock.h
index 0397590..1d95fa5 100644
--- a/arch/xtensa/include/asm/spinlock.h
+++ b/arch/xtensa/include/asm/spinlock.h
@@ -28,13 +28,13 @@
  *    1         somebody owns the spinlock
  */
 
-#define __raw_spin_is_locked(x) ((x)->slock != 0)
-#define __raw_spin_unlock_wait(lock) \
-	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
+#define arch_spin_is_locked(x) ((x)->slock != 0)
+#define arch_spin_unlock_wait(lock) \
+	do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
 
-#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
-static inline void __raw_spin_lock(raw_spinlock_t *lock)
+static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	unsigned long tmp;
 
@@ -51,7 +51,7 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 
 /* Returns 1 if the lock is obtained, 0 otherwise. */
 
-static inline int __raw_spin_trylock(raw_spinlock_t *lock)
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
 	unsigned long tmp;
 
@@ -67,7 +67,7 @@ static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 	return tmp == 0 ? 1 : 0;
 }
 
-static inline void __raw_spin_unlock(raw_spinlock_t *lock)
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	unsigned long tmp;
 
@@ -96,9 +96,9 @@ static inline void __raw_spin_unlock(raw_spinlock_t *lock)
  *  0x80000000  one writer owns the rwlock, no other writers, no readers
  */
 
-#define __raw_write_can_lock(x)  ((x)->lock == 0)
+#define arch_write_can_lock(x)  ((x)->lock == 0)
 
-static inline void __raw_write_lock(raw_rwlock_t *rw)
+static inline void arch_write_lock(arch_rwlock_t *rw)
 {
 	unsigned long tmp;
 
@@ -116,7 +116,7 @@ static inline void __raw_write_lock(raw_rwlock_t *rw)
 
 /* Returns 1 if the lock is obtained, 0 otherwise. */
 
-static inline int __raw_write_trylock(raw_rwlock_t *rw)
+static inline int arch_write_trylock(arch_rwlock_t *rw)
 {
 	unsigned long tmp;
 
@@ -133,7 +133,7 @@ static inline int __raw_write_trylock(raw_rwlock_t *rw)
 	return tmp == 0 ? 1 : 0;
 }
 
-static inline void __raw_write_unlock(raw_rwlock_t *rw)
+static inline void arch_write_unlock(arch_rwlock_t *rw)
 {
 	unsigned long tmp;
 
@@ -145,7 +145,7 @@ static inline void __raw_write_unlock(raw_rwlock_t *rw)
 			: "memory");
 }
 
-static inline void __raw_read_lock(raw_rwlock_t *rw)
+static inline void arch_read_lock(arch_rwlock_t *rw)
 {
 	unsigned long tmp;
 	unsigned long result;
@@ -164,7 +164,7 @@ static inline void __raw_read_lock(raw_rwlock_t *rw)
 
 /* Returns 1 if the lock is obtained, 0 otherwise. */
 
-static inline int __raw_read_trylock(raw_rwlock_t *rw)
+static inline int arch_read_trylock(arch_rwlock_t *rw)
 {
 	unsigned long result;
 	unsigned long tmp;
@@ -184,7 +184,7 @@ static inline int __raw_read_trylock(raw_rwlock_t *rw)
 	return result == 0;
 }
 
-static inline void __raw_read_unlock(raw_rwlock_t *rw)
+static inline void arch_read_unlock(arch_rwlock_t *rw)
 {
 	unsigned long tmp1, tmp2;
 
@@ -199,4 +199,7 @@ static inline void __raw_read_unlock(raw_rwlock_t *rw)
 			: "memory");
 }
 
+#define arch_read_lock_flags(lock, flags)	arch_read_lock(lock)
+#define arch_write_lock_flags(lock, flags)	arch_write_lock(lock)
+
 #endif	/* _XTENSA_SPINLOCK_H */
diff --git a/arch/xtensa/include/asm/spinlock_types.h b/arch/xtensa/include/asm/spinlock_types.h
new file mode 100644
index 0000000..7ec5ce1
--- /dev/null
+++ b/arch/xtensa/include/asm/spinlock_types.h
@@ -0,0 +1,20 @@
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int slock;
+} arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile unsigned int lock;
+} arch_rwlock_t;
+
+#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
-- 
1.7.7.6
