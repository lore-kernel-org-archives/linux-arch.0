From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 0/8] Allow inlined spinlocks again V5
Date: Sat, 29 Aug 2009 15:59:07 +0200
Message-ID: <20090829135906.GA11215@osiris.boeblingen.de.ibm.com>
References: <20090829102115.638224800@de.ibm.com>
 <20090829111642.GA17951@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate7.de.ibm.com ([195.212.17.167]:55057 "EHLO
	mtagate7.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbZH2N7M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2009 09:59:12 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7TDx95H028875
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 13:59:09 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com [9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7TDx9n12470042
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 15:59:09 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7TDx7jh024201
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 15:59:09 +0200
Content-Disposition: inline
In-Reply-To: <20090829111642.GA17951@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

On Sat, Aug 29, 2009 at 01:16:42PM +0200, Ingo Molnar wrote:
> * Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > This patch set allows to have inlined spinlocks again.
> > 
> > V5: simplify ifdefs as pointed out by Linus. Fix architecture compile
> >     breakages caused by this change.
> > 
> > Linus, Ingo, do you still have objections?
> 
> Ok, this looks pretty clean.
> 
> Two small comments. One (small) worry is that the configuration 
> space of this construct:
> 
> +#define __spin_lock_is_small
> [...]
> 
> Is 2^28.
> 
> Could we perhaps shape this in a form that makes it 'formally' a 
> manually tuned inlining decision - where we already accept such kind 
> of per function decisions and know how to handle them?
> 
> I.e. rename it to something like:
> 
>   #define __always_inline__write_unlock_irqrestore
> 
> That way it fits into our existing forced-inlining attributes 
> (visually and name-space wise), which means the addition of 'inline' 
> or '__forced_inline', or the removal of such attributes.

Ok, I'll wait for more comments and post an updated version.

> The other comment i have: you dont seem to have preserved the 
> current auto-inlining of spin_lock() we did before, have you? 
> Without that this patchset causes a (small) performance regression 
> on every architectures but s390.

I assume you're talking of spin_unlock() and not spin_lock()?

It still gets inlined (spinlock.h):

/*
 * We inline the unlock functions in the nondebug case:
 */
#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
	!defined(CONFIG_SMP)
# define spin_unlock(lock)              _spin_unlock(lock)
[...]
#else
# define spin_unlock(lock) \
	do {__raw_spin_unlock(&(lock)->raw_lock); __release(lock); } while (0)
[...]

Or in other words, specifying __spin_lock_is_small causes only that the
out-of-line variant doesn't get generated anymore.
It gets inlined regardless (if config options allow).

Now this could be simplified/cleanup by doing something like this:

/*
 * We inline the unlock functions in the nondebug case:
 */
#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
	!defined(CONFIG_SMP)
# define spin_unlock(lock)              _spin_unlock(lock)
[...]
#else
# define spin_unlock(lock) \
	do {__raw_spin_unlock(&(lock)->raw_lock); __release(lock); } while (0)
[...]

However it sucks a bit that we have two different ways to force inlining.
So we could and probably should simplify this. The patch below (untested)
would do that:

---
 include/linux/spinlock.h         |   46 +++++----------------------------------
 include/linux/spinlock_api_smp.h |   12 ++++++++++
 2 files changed, 18 insertions(+), 40 deletions(-)

Index: linux-2.6/include/linux/spinlock.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock.h
+++ linux-2.6/include/linux/spinlock.h
@@ -259,50 +259,16 @@ static inline void smp_mb__after_lock(vo
 
 #define spin_lock_irq(lock)		_spin_lock_irq(lock)
 #define spin_lock_bh(lock)		_spin_lock_bh(lock)
-
 #define read_lock_irq(lock)		_read_lock_irq(lock)
 #define read_lock_bh(lock)		_read_lock_bh(lock)
-
 #define write_lock_irq(lock)		_write_lock_irq(lock)
 #define write_lock_bh(lock)		_write_lock_bh(lock)
-
-/*
- * We inline the unlock functions in the nondebug case:
- */
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
-	!defined(CONFIG_SMP)
-# define spin_unlock(lock)		_spin_unlock(lock)
-# define read_unlock(lock)		_read_unlock(lock)
-# define write_unlock(lock)		_write_unlock(lock)
-# define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
-# define read_unlock_irq(lock)		_read_unlock_irq(lock)
-# define write_unlock_irq(lock)		_write_unlock_irq(lock)
-#else
-# define spin_unlock(lock) \
-    do {__raw_spin_unlock(&(lock)->raw_lock); __release(lock); } while (0)
-# define read_unlock(lock) \
-    do {__raw_read_unlock(&(lock)->raw_lock); __release(lock); } while (0)
-# define write_unlock(lock) \
-    do {__raw_write_unlock(&(lock)->raw_lock); __release(lock); } while (0)
-# define spin_unlock_irq(lock)			\
-do {						\
-	__raw_spin_unlock(&(lock)->raw_lock);	\
-	__release(lock);			\
-	local_irq_enable();			\
-} while (0)
-# define read_unlock_irq(lock)			\
-do {						\
-	__raw_read_unlock(&(lock)->raw_lock);	\
-	__release(lock);			\
-	local_irq_enable();			\
-} while (0)
-# define write_unlock_irq(lock)			\
-do {						\
-	__raw_write_unlock(&(lock)->raw_lock);	\
-	__release(lock);			\
-	local_irq_enable();			\
-} while (0)
-#endif
+#define spin_unlock(lock)		_spin_unlock(lock)
+#define read_unlock(lock)		_read_unlock(lock)
+#define write_unlock(lock)		_write_unlock(lock)
+#define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
+#define read_unlock_irq(lock)		_read_unlock_irq(lock)
+#define write_unlock_irq(lock)		_write_unlock_irq(lock)
 
 #define spin_unlock_irqrestore(lock, flags)		\
 	do {						\
Index: linux-2.6/include/linux/spinlock_api_smp.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock_api_smp.h
+++ linux-2.6/include/linux/spinlock_api_smp.h
@@ -60,6 +60,18 @@ void __lockfunc _read_unlock_irqrestore(
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
 
+/*
+ * We inline the unlock functions in the nondebug case:
+ */
+#if !defined(CONFIG_DEBUG_SPINLOCK) && !defined(CONFIG_PREEMPT)
+#define __spin_unlock_is_small
+#define __read_unlock_is_small
+#define __write_unlock_is_small
+#define __spin_unlock_irq_is_small
+#define __read_unlock_irq_is_small
+#define __write_unlock_irq_is_small
+#endif
+
 #ifndef CONFIG_DEBUG_SPINLOCK
 #ifndef CONFIG_GENERIC_LOCKBREAK
 
