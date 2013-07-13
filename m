From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH RFC 2/2] x86 qrwlock: Enable x86 to use queue read/write lock
Date: Fri, 12 Jul 2013 21:34:09 -0400
Message-ID: <1373679249-27123-3-git-send-email-Waiman.Long@hp.com>
References: <1373679249-27123-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373679249-27123-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Waiman Long <Waiman.Long@hp.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Richard Weinberger <richard@nod.at>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matt Fleming <matt.fleming@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Akinobu Mita <akinobu.mita@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Chandramouleeswaran, Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>
List-Id: linux-arch.vger.kernel.org

This patch makes the necessary changes at the x86 architecture specific
layer to enable the presence of the CONFIG_QUEUE_RWLOCK kernel option
to replace the plain read/write lock by the queue read/write lock.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/Kconfig                      |    3 +++
 arch/x86/include/asm/spinlock.h       |    2 ++
 arch/x86/include/asm/spinlock_types.h |    4 ++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b32ebf9..638dbaa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2344,6 +2344,9 @@ config X86_DMA_REMAP
 	bool
 	depends on STA2X11
 
+config ARCH_QUEUE_RWLOCK
+	def_bool y
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 33692ea..613a4ff 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -137,6 +137,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 		cpu_relax();
 }
 
+#ifndef CONFIG_QUEUE_RWLOCK
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
@@ -219,6 +220,7 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 	asm volatile(LOCK_PREFIX WRITE_LOCK_ADD(%1) "%0"
 		     : "+m" (rw->write) : "i" (RW_LOCK_BIAS) : "memory");
 }
+#endif /* CONFIG_QUEUE_RWLOCK */
 
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
index ad0ad07..afacd36 100644
--- a/arch/x86/include/asm/spinlock_types.h
+++ b/arch/x86/include/asm/spinlock_types.h
@@ -28,6 +28,10 @@ typedef struct arch_spinlock {
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
 
+#ifdef CONFIG_QUEUE_RWLOCK
+#include <asm-generic/qrwlock.h>
+#else
 #include <asm/rwlock.h>
+#endif
 
 #endif /* _ASM_X86_SPINLOCK_TYPES_H */
-- 
1.7.1
