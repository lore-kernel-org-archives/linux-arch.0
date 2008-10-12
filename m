From: Nick Piggin <npiggin@suse.de>
Subject: [patch] mutex: optimise generic mutex implementations
Date: Sun, 12 Oct 2008 07:46:34 +0200
Message-ID: <20081012054634.GA12535@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:58149 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbYJLFrM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 12 Oct 2008 01:47:12 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org

Speed up generic mutex implementations.

- atomic operations which both modify the variable and return something imply
  full smp memory barriers before and after the memory operations involved
  (failing atomic_cmpxchg, atomic_add_unless, etc don't imply a barrier because
  they don't modify the target). See Documentation/atomic_ops.txt.
  So remove extra barriers and branches.
  
- All architectures support atomic_cmpxchg. This has no relation to
  __HAVE_ARCH_CMPXCHG. We can just take the atomic_cmpxchg path unconditionally

This reduces a simple single threaded fastpath lock+unlock test from 590 cycles
to 203 cycles on a ppc970 system.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/include/asm-generic/mutex-dec.h
===================================================================
--- linux-2.6.orig/include/asm-generic/mutex-dec.h
+++ linux-2.6/include/asm-generic/mutex-dec.h
@@ -22,8 +22,6 @@ __mutex_fastpath_lock(atomic_t *count, v
 {
 	if (unlikely(atomic_dec_return(count) < 0))
 		fail_fn(count);
-	else
-		smp_mb();
 }
 
 /**
@@ -41,10 +39,7 @@ __mutex_fastpath_lock_retval(atomic_t *c
 {
 	if (unlikely(atomic_dec_return(count) < 0))
 		return fail_fn(count);
-	else {
-		smp_mb();
-		return 0;
-	}
+	return 0;
 }
 
 /**
@@ -63,7 +58,6 @@ __mutex_fastpath_lock_retval(atomic_t *c
 static inline void
 __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
 {
-	smp_mb();
 	if (unlikely(atomic_inc_return(count) <= 0))
 		fail_fn(count);
 }
@@ -98,15 +92,9 @@ __mutex_fastpath_trylock(atomic_t *count
 	 * just as efficient (and simpler) as a 'destructive' probing of
 	 * the mutex state would be.
 	 */
-#ifdef __HAVE_ARCH_CMPXCHG
-	if (likely(atomic_cmpxchg(count, 1, 0) == 1)) {
-		smp_mb();
+	if (likely(atomic_cmpxchg(count, 1, 0) == 1))
 		return 1;
-	}
 	return 0;
-#else
-	return fail_fn(count);
-#endif
 }
 
 #endif
Index: linux-2.6/include/asm-generic/mutex-xchg.h
===================================================================
--- linux-2.6.orig/include/asm-generic/mutex-xchg.h
+++ linux-2.6/include/asm-generic/mutex-xchg.h
@@ -27,8 +27,6 @@ __mutex_fastpath_lock(atomic_t *count, v
 {
 	if (unlikely(atomic_xchg(count, 0) != 1))
 		fail_fn(count);
-	else
-		smp_mb();
 }
 
 /**
@@ -46,10 +44,7 @@ __mutex_fastpath_lock_retval(atomic_t *c
 {
 	if (unlikely(atomic_xchg(count, 0) != 1))
 		return fail_fn(count);
-	else {
-		smp_mb();
-		return 0;
-	}
+	return 0;
 }
 
 /**
@@ -67,7 +62,6 @@ __mutex_fastpath_lock_retval(atomic_t *c
 static inline void
 __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
 {
-	smp_mb();
 	if (unlikely(atomic_xchg(count, 1) != 0))
 		fail_fn(count);
 }
@@ -110,7 +104,6 @@ __mutex_fastpath_trylock(atomic_t *count
 		if (prev < 0)
 			prev = 0;
 	}
-	smp_mb();
 
 	return prev;
 }
