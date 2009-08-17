From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 2/3] spinlock: allow inlined spinlocks
Date: Mon, 17 Aug 2009 17:46:18 +0200
Message-ID: <20090817154618.GA16009@osiris.boeblingen.de.ibm.com>
References: <20090814125801.881618121@de.ibm.com>
 <20090814125857.181021997@de.ibm.com>
 <20090816175750.GA5808@osiris.boeblingen.de.ibm.com>
 <alpine.LFD.2.01.0908161101470.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:48196 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbZHQPq4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Aug 2009 11:46:56 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.14.3/8.13.8) with ESMTP id n7HFkKkb157474
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2009 15:46:20 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com [9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7HFkKjv2326764
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2009 17:46:20 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7HFkJfj004989
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2009 17:46:20 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0908161101470.3162@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>

On Sun, Aug 16, 2009 at 11:22:45AM -0700, Linus Torvalds wrote:
> Other things going on, but here goes:
> > > +#ifdef __spin_lock_is_small
> > > +#define _spin_lock(lock) __spin_lock(lock)
> > > +#else
> > > +void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);
> > > +#endif
> 
> The above repeats many times, and I found that irritating. I think you 
> should be able to get rid of a _lot_ of that by doing it like this instead
> 
> 	extern void __lockfunc _spin_lock(spinlock_t *lock) __acquires(lock);
> 	... plain declarations for all cases, no #ifdef's ...
> 
> and then at the end you just do
> 
> 	#ifdef __spin_lock_is_small
> 	  #define _spin_lock(lock) __spin_lock(lock)         
> 	#endif
> 	..
> 
> and at least make that repeating section be composed of simpler and 
> smaller entries.

Well, I decided to go for the ifdef variant, because that allows to easily
ifdef all functions in kernel/spinlock.c:

With

#ifdef __spin_lock_is_small
#define _spin_lock(lock) __spin_lock(lock)         
#endif

We can do this:

+#ifndef _spin_lock
 void __lockfunc _spin_lock(spinlock_t *lock)
 {
 	__spin_lock(lock);
 }
 EXPORT_SYMBOL(_spin_lock);
+#endif

In addition this allows to overrule architecture settings by adding ifdefs
in one common place instead of requiring each architecture to get it right:

+#ifndef CONFIG_DEBUG_SPINLOCK
+#ifndef CONFIG_GENERIC_LOCKBREAK
+
+#ifdef __spin_lock_is_small
+#define _spin_lock(lock) __spin_lock(lock)
+#endif
+ [...]

This should also address Ingo's concerns.

Does this look ok now?

---
 include/linux/spinlock_api_smp.h |  119 +++++++++++++++++++++++++++++++++++++++
 kernel/spinlock.c                |   56 ++++++++++++++++++
 2 files changed, 175 insertions(+)

Index: linux-2.6/kernel/spinlock.c
===================================================================
--- linux-2.6.orig/kernel/spinlock.c
+++ linux-2.6/kernel/spinlock.c
@@ -21,23 +21,29 @@
 #include <linux/debug_locks.h>
 #include <linux/module.h>
 
+#ifndef _spin_trylock
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
 	return __spin_trylock(lock);
 }
 EXPORT_SYMBOL(_spin_trylock);
+#endif
 
+#ifndef _read_trylock
 int __lockfunc _read_trylock(rwlock_t *lock)
 {
 	return __read_trylock(lock);
 }
 EXPORT_SYMBOL(_read_trylock);
+#endif
 
+#ifndef _write_trylock
 int __lockfunc _write_trylock(rwlock_t *lock)
 {
 	return __write_trylock(lock);
 }
 EXPORT_SYMBOL(_write_trylock);
+#endif
 
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
@@ -46,77 +52,101 @@ EXPORT_SYMBOL(_write_trylock);
  */
 #if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
 
+#ifndef _read_lock
 void __lockfunc _read_lock(rwlock_t *lock)
 {
 	__read_lock(lock);
 }
 EXPORT_SYMBOL(_read_lock);
+#endif
 
+#ifndef _spin_lock_irqsave
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 {
 	return __spin_lock_irqsave(lock);
 }
 EXPORT_SYMBOL(_spin_lock_irqsave);
+#endif
 
+#ifndef _spin_lock_irq
 void __lockfunc _spin_lock_irq(spinlock_t *lock)
 {
 	__spin_lock_irq(lock);
 }
 EXPORT_SYMBOL(_spin_lock_irq);
+#endif
 
+#ifndef _spin_lock_bh
 void __lockfunc _spin_lock_bh(spinlock_t *lock)
 {
 	__spin_lock_bh(lock);
 }
 EXPORT_SYMBOL(_spin_lock_bh);
+#endif
 
+#ifndef _read_lock_irqsave
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 {
 	return __read_lock_irqsave(lock);
 }
 EXPORT_SYMBOL(_read_lock_irqsave);
+#endif
 
+#ifndef _read_lock_irq
 void __lockfunc _read_lock_irq(rwlock_t *lock)
 {
 	__read_lock_irq(lock);
 }
 EXPORT_SYMBOL(_read_lock_irq);
+#endif
 
+#ifndef _read_lock_bh
 void __lockfunc _read_lock_bh(rwlock_t *lock)
 {
 	__read_lock_bh(lock);
 }
 EXPORT_SYMBOL(_read_lock_bh);
+#endif
 
+#ifndef _write_lock_irqsave
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
 {
 	return __write_lock_irqsave(lock);
 }
 EXPORT_SYMBOL(_write_lock_irqsave);
+#endif
 
+#ifndef _write_lock_irq
 void __lockfunc _write_lock_irq(rwlock_t *lock)
 {
 	__write_lock_irq(lock);
 }
 EXPORT_SYMBOL(_write_lock_irq);
+#endif
 
+#ifndef _write_lock_bh
 void __lockfunc _write_lock_bh(rwlock_t *lock)
 {
 	__write_lock_bh(lock);
 }
 EXPORT_SYMBOL(_write_lock_bh);
+#endif
 
+#ifndef _spin_lock
 void __lockfunc _spin_lock(spinlock_t *lock)
 {
 	__spin_lock(lock);
 }
 EXPORT_SYMBOL(_spin_lock);
+#endif
 
+#ifndef _write_lock
 void __lockfunc _write_lock(rwlock_t *lock)
 {
 	__write_lock(lock);
 }
 EXPORT_SYMBOL(_write_lock);
+#endif
 
 #else /* CONFIG_PREEMPT: */
 
@@ -242,83 +272,109 @@ EXPORT_SYMBOL(_spin_lock_nest_lock);
 
 #endif
 
+#ifndef _spin_unlock
 void __lockfunc _spin_unlock(spinlock_t *lock)
 {
 	__spin_unlock(lock);
 }
 EXPORT_SYMBOL(_spin_unlock);
+#endif
 
+#ifndef _write_unlock
 void __lockfunc _write_unlock(rwlock_t *lock)
 {
 	__write_unlock(lock);
 }
 EXPORT_SYMBOL(_write_unlock);
+#endif
 
+#ifndef _read_unlock
 void __lockfunc _read_unlock(rwlock_t *lock)
 {
 	__read_unlock(lock);
 }
 EXPORT_SYMBOL(_read_unlock);
+#endif
 
+#ifndef _spin_unlock_irqrestore
 void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 {
 	__spin_unlock_irqrestore(lock, flags);
 }
 EXPORT_SYMBOL(_spin_unlock_irqrestore);
+#endif
 
+#ifndef _spin_unlock_irq
 void __lockfunc _spin_unlock_irq(spinlock_t *lock)
 {
 	__spin_unlock_irq(lock);
 }
 EXPORT_SYMBOL(_spin_unlock_irq);
+#endif
 
+#ifndef _spin_unlock_bh
 void __lockfunc _spin_unlock_bh(spinlock_t *lock)
 {
 	__spin_unlock_bh(lock);
 }
 EXPORT_SYMBOL(_spin_unlock_bh);
+#endif
 
+#ifndef _read_unlock_irqrestore
 void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
 	__read_unlock_irqrestore(lock, flags);
 }
 EXPORT_SYMBOL(_read_unlock_irqrestore);
+#endif
 
+#ifndef _read_unlock_irq
 void __lockfunc _read_unlock_irq(rwlock_t *lock)
 {
 	__read_unlock_irq(lock);
 }
 EXPORT_SYMBOL(_read_unlock_irq);
+#endif
 
+#ifndef _read_unlock_bh
 void __lockfunc _read_unlock_bh(rwlock_t *lock)
 {
 	__read_unlock_bh(lock);
 }
 EXPORT_SYMBOL(_read_unlock_bh);
+#endif
 
+#ifndef _write_unlock_irqrestore
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
 	__write_unlock_irqrestore(lock, flags);
 }
 EXPORT_SYMBOL(_write_unlock_irqrestore);
+#endif
 
+#ifndef _write_unlock_irq
 void __lockfunc _write_unlock_irq(rwlock_t *lock)
 {
 	__write_unlock_irq(lock);
 }
 EXPORT_SYMBOL(_write_unlock_irq);
+#endif
 
+#ifndef _write_unlock_bh
 void __lockfunc _write_unlock_bh(rwlock_t *lock)
 {
 	__write_unlock_bh(lock);
 }
 EXPORT_SYMBOL(_write_unlock_bh);
+#endif
 
+#ifndef _spin_trylock_bh
 int __lockfunc _spin_trylock_bh(spinlock_t *lock)
 {
 	return __spin_trylock_bh(lock);
 }
 EXPORT_SYMBOL(_spin_trylock_bh);
+#endif
 
 notrace int in_lock_functions(unsigned long addr)
 {
Index: linux-2.6/include/linux/spinlock_api_smp.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock_api_smp.h
+++ linux-2.6/include/linux/spinlock_api_smp.h
@@ -60,6 +60,125 @@ void __lockfunc _read_unlock_irqrestore(
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
 
+#ifndef CONFIG_DEBUG_SPINLOCK
+#ifndef CONFIG_GENERIC_LOCKBREAK
+
+#ifdef __spin_lock_is_small
+#define _spin_lock(lock) __spin_lock(lock)
+#endif
+
+#ifdef __read_lock_is_small
+#define _read_lock(lock) __read_lock(lock)
+#endif
+
+#ifdef __write_lock_is_small
+#define _write_lock(lock) __write_lock(lock)
+#endif
+
+#ifdef __spin_lock_bh_is_small
+#define _spin_lock_bh(lock) __spin_lock_bh(lock)
+#endif
+
+#ifdef __read_lock_bh_is_small
+#define _read_lock_bh(lock) __read_lock_bh(lock)
+#endif
+
+#ifdef __write_lock_bh_is_small
+#define _write_lock_bh(lock) __write_lock_bh(lock)
+#endif
+
+#ifdef __spin_lock_irq_is_small
+#define _spin_lock_irq(lock) __spin_lock_irq(lock)
+#endif
+
+#ifdef __read_lock_irq_is_small
+#define _read_lock_irq(lock) __read_lock_irq(lock)
+#endif
+
+#ifdef __write_lock_irq_is_small
+#define _write_lock_irq(lock) __write_lock_irq(lock)
+#endif
+
+#ifdef __spin_lock_irqsave_is_small
+#define _spin_lock_irqsave(lock) __spin_lock_irqsave(lock)
+#endif
+
+#ifdef __read_lock_irqsave_is_small
+#define _read_lock_irqsave(lock) __read_lock_irqsave(lock)
+#endif
+
+#ifdef __write_lock_irqsave_is_small
+#define _write_lock_irqsave(lock) __write_lock_irqsave(lock)
+#endif
+
+#endif /* !CONFIG_GENERIC_LOCKBREAK */
+
+#ifdef __spin_trylock_is_small
+#define _spin_trylock(lock) __spin_trylock(lock)
+#endif
+
+#ifdef __read_trylock_is_small
+#define _read_trylock(lock) __read_trylock(lock)
+#endif
+
+#ifdef __write_trylock_is_small
+#define _write_trylock(lock) __write_trylock(lock)
+#endif
+
+#ifdef __spin_trylock_bh_is_small
+#define _spin_trylock_bh(lock) __spin_trylock_bh(lock)
+#endif
+
+#ifdef __spin_unlock_is_small
+#define _spin_unlock(lock) __spin_unlock(lock)
+#endif
+
+#ifdef __read_unlock_is_small
+#define _read_unlock(lock) __read_unlock(lock)
+#endif
+
+#ifdef __write_unlock_is_small
+#define _write_unlock(lock) __write_unlock(lock)
+#endif
+
+#ifdef __spin_unlock_bh_is_small
+#define _spin_unlock_bh(lock) __spin_unlock_bh(lock)
+#endif
+
+#ifdef __read_unlock_bh_is_small
+#define _read_unlock_bh(lock) __read_unlock_bh(lock)
+#endif
+
+#ifdef __write_unlock_bh_is_small
+#define _write_unlock_bh(lock) __write_unlock_bh(lock)
+#endif
+
+#ifdef __spin_unlock_irq_is_small
+#define _spin_unlock_irq(lock) __spin_unlock_irq(lock)
+#endif
+
+#ifdef __read_unlock_irq_is_small
+#define _read_unlock_irq(lock) __read_unlock_irq(lock)
+#endif
+
+#ifdef __write_unlock_irq_is_small
+#define _write_unlock_irq(lock) __write_unlock_irq(lock)
+#endif
+
+#ifdef __spin_unlock_irqrestore_is_small
+#define _spin_unlock_irqrestore(lock, flags) __spin_unlock_irqrestore(lock, flags)
+#endif
+
+#ifdef __read_unlock_irqrestore_is_small
+#define _read_unlock_irqrestore(lock, flags) __read_unlock_irqrestore(lock, flags)
+#endif
+
+#ifdef __write_unlock_irqrestore_is_small
+#define _write_unlock_irqrestore(lock, flags) __write_unlock_irqrestore(lock, flags)
+#endif
+
+#endif /* CONFIG_DEBUG_SPINLOCK */
+
 static inline int __spin_trylock(spinlock_t *lock)
 {
 	preempt_disable();
