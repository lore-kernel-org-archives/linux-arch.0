Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39134 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVSuq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:50:46 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 03/20] mmiowb: Hook up mmiowb helpers to spinlocks and generic I/O accessors
Date: Fri, 22 Feb 2019 18:50:09 +0000
Message-ID: <20190222185026.10973-4-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190222185009.2hoWwrHahWkVUbd5YAiniFY43mIbKBro6ljiQQIhbzA@z>

Removing explicit calls to mmiowb() from driver code means that we must
now call into the generic mmiowb_spin_{lock,unlock}() functions from the
core spinlock code. In order to elide barriers following critical
sections without any I/O writes, we also hook into the asm-generic I/O
routines.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/io.h        |  3 ++-
 include/linux/spinlock.h        | 11 ++++++++++-
 kernel/locking/spinlock_debug.c |  6 +++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 303871651f8a..bc490a746602 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -19,6 +19,7 @@
 #include <asm-generic/iomap.h>
 #endif
 
+#include <asm/mmiowb.h>
 #include <asm-generic/pci_iomap.h>
 
 #ifndef mmiowb
@@ -49,7 +50,7 @@
 
 /* serialize device access against a spin_unlock, usually handled there. */
 #ifndef __io_aw
-#define __io_aw()      barrier()
+#define __io_aw()      mmiowb_set_pending()
 #endif
 
 #ifndef __io_pbw
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index e089157dcf97..4298b1b31d9b 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -57,6 +57,7 @@
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
 #include <asm/barrier.h>
+#include <asm/mmiowb.h>
 
 
 /*
@@ -177,6 +178,7 @@ do {								\
 static inline void do_raw_spin_lock(raw_spinlock_t *lock) __acquires(lock)
 {
 	__acquire(lock);
+	mmiowb_spin_lock();
 	arch_spin_lock(&lock->raw_lock);
 }
 
@@ -188,16 +190,23 @@ static inline void
 do_raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long *flags) __acquires(lock)
 {
 	__acquire(lock);
+	mmiowb_spin_lock();
 	arch_spin_lock_flags(&lock->raw_lock, *flags);
 }
 
 static inline int do_raw_spin_trylock(raw_spinlock_t *lock)
 {
-	return arch_spin_trylock(&(lock)->raw_lock);
+	int ret = arch_spin_trylock(&(lock)->raw_lock);
+
+	if (ret)
+		mmiowb_spin_lock();
+
+	return ret;
 }
 
 static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 {
+	mmiowb_spin_unlock();
 	arch_spin_unlock(&lock->raw_lock);
 	__release(lock);
 }
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 9aa0fccd5d43..654484b6e70c 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -109,6 +109,7 @@ static inline void debug_spin_unlock(raw_spinlock_t *lock)
  */
 void do_raw_spin_lock(raw_spinlock_t *lock)
 {
+	mmiowb_spin_lock();
 	debug_spin_lock_before(lock);
 	arch_spin_lock(&lock->raw_lock);
 	debug_spin_lock_after(lock);
@@ -118,8 +119,10 @@ int do_raw_spin_trylock(raw_spinlock_t *lock)
 {
 	int ret = arch_spin_trylock(&lock->raw_lock);
 
-	if (ret)
+	if (ret) {
+		mmiowb_spin_lock();
 		debug_spin_lock_after(lock);
+	}
 #ifndef CONFIG_SMP
 	/*
 	 * Must not happen on UP:
@@ -131,6 +134,7 @@ int do_raw_spin_trylock(raw_spinlock_t *lock)
 
 void do_raw_spin_unlock(raw_spinlock_t *lock)
 {
+	mmiowb_spin_unlock();
 	debug_spin_unlock(lock);
 	arch_spin_unlock(&lock->raw_lock);
 }
-- 
2.11.0
