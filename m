From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 2/3] spinlock: allow inlined spinlocks
Date: Fri, 14 Aug 2009 14:58:03 +0200
Message-ID: <20090814125857.181021997@de.ibm.com>
References: <20090814125801.881618121@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:36780 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbZHNM7A (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2009 08:59:00 -0400
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7ECwxXJ055526
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 12:58:59 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7ECwwYw1630272
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 13:58:58 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7ECwvDb014684
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 13:58:58 +0100
Content-Disposition: inline; filename=02_spinlock_ifdef.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This allows an architecture to specify per lock variant if the
locking code should be kept out-of-line or inlined.

If an architecure wants out-of-line locking code no change is
needed. To force inlining of e.g. spin_lock() the line

#define __spin_lock_is_small

needs to be added to arch/<whatever>/include/asm/spinlock.h

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/spinlock_api_smp.h |  146 ++++++++++++++++++++++++++++++++++++++-
 kernel/spinlock.c                |   56 ++++++++++++++
 2 files changed, 199 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/spinlock_api_smp.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock_api_smp.h
+++ linux-2.6/include/linux/spinlock_api_smp.h
@@ -19,46 +19,186 @@ int in_lock_functions(unsigned long addr
 
 #define assert_spin_locked(x)	BUG_ON(!spin_is_locked(x))
 
-void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);
 void __lockfunc _spin_lock_nested(spinlock_t *lock, int subclass)
 							__acquires(lock);
 void __lockfunc _spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *map)
 							__acquires(lock);
+unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
+							__acquires(lock);
+
+#ifdef __spin_lock_is_small
+#define _spin_lock(lock) __spin_lock(lock)
+#else
+void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);
+#endif
+
+#ifdef __read_lock_is_small
+#define _read_lock(lock) __read_lock(lock)
+#else
 void __lockfunc _read_lock(rwlock_t *lock)		__acquires(lock);
+#endif
+
+#ifdef __write_lock_is_small
+#define _write_lock(lock) __write_lock(lock)
+#else
 void __lockfunc _write_lock(rwlock_t *lock)		__acquires(lock);
+#endif
+
+#ifdef __spin_lock_bh_is_small
+#define _spin_lock_bh(lock) __spin_lock_bh(lock)
+#else
 void __lockfunc _spin_lock_bh(spinlock_t *lock)		__acquires(lock);
+#endif
+
+#ifdef __read_lock_bh_is_small
+#define _read_lock_bh(lock) __read_lock_bh(lock)
+#else
 void __lockfunc _read_lock_bh(rwlock_t *lock)		__acquires(lock);
+#endif
+
+#ifdef __write_lock_bh_is_small
+#define _write_lock_bh(lock) __write_lock_bh(lock)
+#else
 void __lockfunc _write_lock_bh(rwlock_t *lock)		__acquires(lock);
+#endif
+
+#ifdef __spin_lock_irq_is_small
+#define _spin_lock_irq(lock) __spin_lock_irq(lock)
+#else
 void __lockfunc _spin_lock_irq(spinlock_t *lock)	__acquires(lock);
+#endif
+
+#ifdef __read_lock_irq_is_small
+#define _read_lock_irq(lock) __read_lock_irq(lock)
+#else
 void __lockfunc _read_lock_irq(rwlock_t *lock)		__acquires(lock);
+#endif
+
+#ifdef __write_lock_irq_is_small
+#define _write_lock_irq(lock) __write_lock_irq(lock)
+#else
 void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(lock);
+#endif
+
+#ifdef __spin_lock_irqsave_is_small
+#define _spin_lock_irqsave(lock) __spin_lock_irqsave(lock)
+#else
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 							__acquires(lock);
-unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
-							__acquires(lock);
+#endif
+
+#ifdef __read_lock_irqsave_is_small
+#define _read_lock_irqsave(lock) __read_lock_irqsave(lock)
+#else
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
+#endif
+
+#ifdef __write_lock_irqsave_is_small
+#define _write_lock_irqsave(lock) __write_lock_irqsave(lock)
+#else
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
+#endif
+
+#ifdef __spin_trylock_is_small
+#define _spin_trylock(lock) __spin_trylock(lock)
+#else
 int __lockfunc _spin_trylock(spinlock_t *lock);
+#endif
+
+#ifdef __read_trylock_is_small
+#define _read_trylock(lock) __read_trylock(lock)
+#else
 int __lockfunc _read_trylock(rwlock_t *lock);
+#endif
+
+#ifdef __write_trylock_is_small
+#define _write_trylock(lock) __write_trylock(lock)
+#else
 int __lockfunc _write_trylock(rwlock_t *lock);
+#endif
+
+#ifdef __spin_trylock_bh_is_small
+#define _spin_trylock_bh(lock) __spin_trylock_bh(lock)
+#else
 int __lockfunc _spin_trylock_bh(spinlock_t *lock);
+#endif
+
+#ifdef __spin_unlock_is_small
+#define _spin_unlock(lock) __spin_unlock(lock)
+#else
 void __lockfunc _spin_unlock(spinlock_t *lock)		__releases(lock);
+#endif
+
+#ifdef __read_unlock_is_small
+#define _read_unlock(lock) __read_unlock(lock)
+#else
 void __lockfunc _read_unlock(rwlock_t *lock)		__releases(lock);
+#endif
+
+#ifdef __write_unlock_is_small
+#define _write_unlock(lock) __write_unlock(lock)
+#else
 void __lockfunc _write_unlock(rwlock_t *lock)		__releases(lock);
+#endif
+
+#ifdef __spin_unlock_bh_is_small
+#define _spin_unlock_bh(lock) __spin_unlock_bh(lock)
+#else
 void __lockfunc _spin_unlock_bh(spinlock_t *lock)	__releases(lock);
+#endif
+
+#ifdef __read_unlock_bh_is_small
+#define _read_unlock_bh(lock) __read_unlock_bh(lock)
+#else
 void __lockfunc _read_unlock_bh(rwlock_t *lock)		__releases(lock);
+#endif
+
+#ifdef __write_unlock_bh_is_small
+#define _write_unlock_bh(lock) __write_unlock_bh(lock)
+#else
 void __lockfunc _write_unlock_bh(rwlock_t *lock)	__releases(lock);
+#endif
+
+#ifdef __spin_unlock_irq_is_small
+#define _spin_unlock_irq(lock) __spin_unlock_irq(lock)
+#else
 void __lockfunc _spin_unlock_irq(spinlock_t *lock)	__releases(lock);
+#endif
+
+#ifdef __read_unlock_irq_is_small
+#define _read_unlock_irq(lock) __read_unlock_irq(lock)
+#else
 void __lockfunc _read_unlock_irq(rwlock_t *lock)	__releases(lock);
+#endif
+
+#ifdef __write_unlock_irq_is_small
+#define _write_unlock_irq(lock) __write_unlock_irq(lock)
+#else
 void __lockfunc _write_unlock_irq(rwlock_t *lock)	__releases(lock);
+#endif
+
+#ifdef __spin_unlock_irqrestore_is_small
+#define _spin_unlock_irqrestore(lock, flags) __spin_unlock_irqrestore(lock, flags)
+#else
 void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 							__releases(lock);
+#endif
+
+#ifdef __read_unlock_irqrestore_is_small
+#define _read_unlock_irqrestore(lock, flags) __read_unlock_irqrestore(lock, flags)
+#else
 void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
+#endif
+
+#ifdef __write_unlock_irqrestore_is_small
+#define _write_unlock_irqrestore(lock, flags) __write_unlock_irqrestore(lock, flags)
+#else
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
+#endif
 
 static inline int __spin_trylock(spinlock_t *lock)
 {
Index: linux-2.6/kernel/spinlock.c
===================================================================
--- linux-2.6.orig/kernel/spinlock.c
+++ linux-2.6/kernel/spinlock.c
@@ -21,23 +21,29 @@
 #include <linux/debug_locks.h>
 #include <linux/module.h>
 
+#ifndef __spin_trylock_is_small
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
 	return __spin_trylock(lock);
 }
 EXPORT_SYMBOL(_spin_trylock);
+#endif
 
+#ifndef __read_trylock_is_small
 int __lockfunc _read_trylock(rwlock_t *lock)
 {
 	return __read_trylock(lock);
 }
 EXPORT_SYMBOL(_read_trylock);
+#endif
 
+#ifndef __write_trylock_is_small
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
 
+#ifndef __read_lock_is_small
 void __lockfunc _read_lock(rwlock_t *lock)
 {
 	__read_lock(lock);
 }
 EXPORT_SYMBOL(_read_lock);
+#endif
 
+#ifndef __spin_lock_irqsave_is_small
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 {
 	return __spin_lock_irqsave(lock);
 }
 EXPORT_SYMBOL(_spin_lock_irqsave);
+#endif
 
+#ifndef __spin_lock_irq_is_small
 void __lockfunc _spin_lock_irq(spinlock_t *lock)
 {
 	__spin_lock_irq(lock);
 }
 EXPORT_SYMBOL(_spin_lock_irq);
+#endif
 
+#ifndef __spin_lock_bh_is_small
 void __lockfunc _spin_lock_bh(spinlock_t *lock)
 {
 	__spin_lock_bh(lock);
 }
 EXPORT_SYMBOL(_spin_lock_bh);
+#endif
 
+#ifndef __read_lock_irqsave_is_small
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 {
 	return __read_lock_irqsave(lock);
 }
 EXPORT_SYMBOL(_read_lock_irqsave);
+#endif
 
+#ifndef __read_lock_irq_is_small
 void __lockfunc _read_lock_irq(rwlock_t *lock)
 {
 	__read_lock_irq(lock);
 }
 EXPORT_SYMBOL(_read_lock_irq);
+#endif
 
+#ifndef __read_lock_bh_is_small
 void __lockfunc _read_lock_bh(rwlock_t *lock)
 {
 	__read_lock_bh(lock);
 }
 EXPORT_SYMBOL(_read_lock_bh);
+#endif
 
+#ifndef __write_lock_irqsave_is_small
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
 {
 	return __write_lock_irqsave(lock);
 }
 EXPORT_SYMBOL(_write_lock_irqsave);
+#endif
 
+#ifndef __write_lock_irq_is_small
 void __lockfunc _write_lock_irq(rwlock_t *lock)
 {
 	__write_lock_irq(lock);
 }
 EXPORT_SYMBOL(_write_lock_irq);
+#endif
 
+#ifndef __write_lock_bh_is_small
 void __lockfunc _write_lock_bh(rwlock_t *lock)
 {
 	__write_lock_bh(lock);
 }
 EXPORT_SYMBOL(_write_lock_bh);
+#endif
 
+#ifndef __spin_lock_is_small
 void __lockfunc _spin_lock(spinlock_t *lock)
 {
 	__spin_lock(lock);
 }
 EXPORT_SYMBOL(_spin_lock);
+#endif
 
+#ifndef __write_lock_is_small
 void __lockfunc _write_lock(rwlock_t *lock)
 {
 	__write_lock(lock);
 }
 EXPORT_SYMBOL(_write_lock);
+#endif
 
 #else /* CONFIG_PREEMPT: */
 
@@ -242,83 +272,109 @@ EXPORT_SYMBOL(_spin_lock_nest_lock);
 
 #endif
 
+#ifndef __spin_unlock_is_small
 void __lockfunc _spin_unlock(spinlock_t *lock)
 {
 	__spin_unlock(lock);
 }
 EXPORT_SYMBOL(_spin_unlock);
+#endif
 
+#ifndef __write_unlock_is_small
 void __lockfunc _write_unlock(rwlock_t *lock)
 {
 	__write_unlock(lock);
 }
 EXPORT_SYMBOL(_write_unlock);
+#endif
 
+#ifndef __read_unlock_is_small
 void __lockfunc _read_unlock(rwlock_t *lock)
 {
 	__read_unlock(lock);
 }
 EXPORT_SYMBOL(_read_unlock);
+#endif
 
+#ifndef __spin_unlock_irqrestore_is_small
 void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 {
 	__spin_unlock_irqrestore(lock, flags);
 }
 EXPORT_SYMBOL(_spin_unlock_irqrestore);
+#endif
 
+#ifndef __spin_unlock_irq_is_small
 void __lockfunc _spin_unlock_irq(spinlock_t *lock)
 {
 	__spin_unlock_irq(lock);
 }
 EXPORT_SYMBOL(_spin_unlock_irq);
+#endif
 
+#ifndef __spin_unlock_bh_is_small
 void __lockfunc _spin_unlock_bh(spinlock_t *lock)
 {
 	__spin_unlock_bh(lock);
 }
 EXPORT_SYMBOL(_spin_unlock_bh);
+#endif
 
+#ifndef __read_unlock_irqrestore_is_small
 void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
 	__read_unlock_irqrestore(lock, flags);
 }
 EXPORT_SYMBOL(_read_unlock_irqrestore);
+#endif
 
+#ifndef __read_unlock_irq_is_small
 void __lockfunc _read_unlock_irq(rwlock_t *lock)
 {
 	__read_unlock_irq(lock);
 }
 EXPORT_SYMBOL(_read_unlock_irq);
+#endif
 
+#ifndef __read_unlock_bh_is_small
 void __lockfunc _read_unlock_bh(rwlock_t *lock)
 {
 	__read_unlock_bh(lock);
 }
 EXPORT_SYMBOL(_read_unlock_bh);
+#endif
 
+#ifndef __write_unlock_irqrestore_is_small
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
 	__write_unlock_irqrestore(lock, flags);
 }
 EXPORT_SYMBOL(_write_unlock_irqrestore);
+#endif
 
+#ifndef __write_unlock_irq_is_small
 void __lockfunc _write_unlock_irq(rwlock_t *lock)
 {
 	__write_unlock_irq(lock);
 }
 EXPORT_SYMBOL(_write_unlock_irq);
+#endif
 
+#ifndef __write_unlock_bh_is_small
 void __lockfunc _write_unlock_bh(rwlock_t *lock)
 {
 	__write_unlock_bh(lock);
 }
 EXPORT_SYMBOL(_write_unlock_bh);
+#endif
 
+#ifndef __spin_trylock_bh_is_small
 int __lockfunc _spin_trylock_bh(spinlock_t *lock)
 {
 	return __spin_trylock_bh(lock);
 }
 EXPORT_SYMBOL(_spin_trylock_bh);
+#endif
 
 notrace int in_lock_functions(unsigned long addr)
 {

-- 
