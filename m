From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 9/9] arm64: locking: replace read/write locks with generic qrwlock code
Date: Tue,  7 Jul 2015 18:24:25 +0100
Message-ID: <1436289865-2331-10-git-send-email-will.deacon@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50344 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932392AbbGGRZt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 13:25:49 -0400
In-Reply-To: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Waiman.Long@hp.com, peterz@infradead.org, mingo@redhat.com, Will Deacon <will.deacon@arm.com>

The queued rwlock implementation in asm-generic is actually pretty
decent, so remove our homebrew (unfair) rwlock implementation in
favour of the generic code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                      |   1 +
 arch/arm64/include/asm/qrwlock.h        |  30 ++++++++
 arch/arm64/include/asm/spinlock.h       | 122 +-------------------------------
 arch/arm64/include/asm/spinlock_types.h |  10 +--
 4 files changed, 33 insertions(+), 130 deletions(-)
 create mode 100644 arch/arm64/include/asm/qrwlock.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0f6edb14b7e4..b4ce331a43c8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -9,6 +9,7 @@ config ARM64
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
diff --git a/arch/arm64/include/asm/qrwlock.h b/arch/arm64/include/asm/qrwlock.h
new file mode 100644
index 000000000000..4b4a2aae4be1
--- /dev/null
+++ b/arch/arm64/include/asm/qrwlock.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2015 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_QRWLOCK_H
+#define __ASM_QRWLOCK_H
+
+#define arch_read_lock_flags(lock, flags)	arch_read_lock(lock)
+#define arch_write_lock_flags(lock, flags)	arch_write_lock(lock)
+
+#define arch_qrwlock_relax(lock)					\
+do {									\
+	asm volatile("ldxr	wzr, %0" :: "Q" (*(u32 *)&lock->cnts));	\
+	wfe();								\
+} while (0)
+
+#include <asm-generic/qrwlock.h>
+
+#endif /* __ASM_QRWLOCK_H */
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index cee128732435..cb04e479470a 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -109,126 +109,6 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 }
 #define arch_spin_is_contended	arch_spin_is_contended
 
-/*
- * Write lock implementation.
- *
- * Write locks set bit 31. Unlocking, is done by writing 0 since the lock is
- * exclusively held.
- *
- * The memory barriers are implicit with the load-acquire and store-release
- * instructions.
- */
-
-static inline void arch_write_lock(arch_rwlock_t *rw)
-{
-	unsigned int tmp;
-
-	asm volatile(
-	"	sevl\n"
-	"1:	wfe\n"
-	"2:	ldaxr	%w0, %1\n"
-	"	cbnz	%w0, 1b\n"
-	"	stxr	%w0, %w2, %1\n"
-	"	cbnz	%w0, 2b\n"
-	: "=&r" (tmp), "+Q" (rw->lock)
-	: "r" (0x80000000)
-	: "memory");
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *rw)
-{
-	unsigned int tmp;
-
-	asm volatile(
-	"	ldaxr	%w0, %1\n"
-	"	cbnz	%w0, 1f\n"
-	"	stxr	%w0, %w2, %1\n"
-	"1:\n"
-	: "=&r" (tmp), "+Q" (rw->lock)
-	: "r" (0x80000000)
-	: "memory");
-
-	return !tmp;
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *rw)
-{
-	asm volatile(
-	"	stlr	%w1, %0\n"
-	: "=Q" (rw->lock) : "r" (0) : "memory");
-}
-
-/* write_can_lock - would write_trylock() succeed? */
-#define arch_write_can_lock(x)		((x)->lock == 0)
-
-/*
- * Read lock implementation.
- *
- * It exclusively loads the lock value, increments it and stores the new value
- * back if positive and the CPU still exclusively owns the location. If the
- * value is negative, the lock is already held.
- *
- * During unlocking there may be multiple active read locks but no write lock.
- *
- * The memory barriers are implicit with the load-acquire and store-release
- * instructions.
- */
-static inline void arch_read_lock(arch_rwlock_t *rw)
-{
-	unsigned int tmp, tmp2;
-
-	asm volatile(
-	"	sevl\n"
-	"1:	wfe\n"
-	"2:	ldaxr	%w0, %2\n"
-	"	add	%w0, %w0, #1\n"
-	"	tbnz	%w0, #31, 1b\n"
-	"	stxr	%w1, %w0, %2\n"
-	"	cbnz	%w1, 2b\n"
-	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
-	:
-	: "memory");
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *rw)
-{
-	unsigned int tmp, tmp2;
-
-	asm volatile(
-	"1:	ldxr	%w0, %2\n"
-	"	sub	%w0, %w0, #1\n"
-	"	stlxr	%w1, %w0, %2\n"
-	"	cbnz	%w1, 1b\n"
-	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
-	:
-	: "memory");
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *rw)
-{
-	unsigned int tmp, tmp2 = 1;
-
-	asm volatile(
-	"	ldaxr	%w0, %2\n"
-	"	add	%w0, %w0, #1\n"
-	"	tbnz	%w0, #31, 1f\n"
-	"	stxr	%w1, %w0, %2\n"
-	"1:\n"
-	: "=&r" (tmp), "+r" (tmp2), "+Q" (rw->lock)
-	:
-	: "memory");
-
-	return !tmp2;
-}
-
-/* read_can_lock - would read_trylock() succeed? */
-#define arch_read_can_lock(x)		((x)->lock < 0x80000000)
-
-#define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
-#define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
-
-#define arch_spin_relax(lock)	cpu_relax()
-#define arch_read_relax(lock)	cpu_relax()
-#define arch_write_relax(lock)	cpu_relax()
+#include <asm/qrwlock.h>
 
 #endif /* __ASM_SPINLOCK_H */
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm/spinlock_types.h
index b8d383665f56..2d636be9c7ff 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -16,10 +16,6 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
-# error "please don't include this file directly"
-#endif
-
 #define TICKET_SHIFT	16
 
 typedef struct {
@@ -34,10 +30,6 @@ typedef struct {
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 , 0 }
 
-typedef struct {
-	volatile unsigned int lock;
-} arch_rwlock_t;
-
-#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+#include <asm-generic/qrwlock_types.h>
 
 #endif
-- 
2.1.4
