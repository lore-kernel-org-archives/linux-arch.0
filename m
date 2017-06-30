Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36303 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751728AbdF3ABn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jun 2017 20:01:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5TNx5b8054971
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:43 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bcyr8yf70-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:42 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 29 Jun 2017 20:01:42 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC 12/26] arm64: Remove spin_unlock_wait() arch-specific definitions
Date: Thu, 29 Jun 2017 17:01:20 -0700
In-Reply-To: <20170629235918.GA6445@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com>
Message-ID: <1498780894-8253-12-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <20170630000120.0JGEW-UMoAfR2ZlyxDPF4UGGvG-qWHsf91LGSrOOnJ0@z>

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore removes the underlying arch-specific
arch_spin_unlock_wait().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/arm64/include/asm/spinlock.h | 58 ++++-----------------------------------
 1 file changed, 5 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index cae331d553f8..f445bd7f2b9f 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -26,58 +26,6 @@
  * The memory barriers are implicit with the load-acquire and store-release
  * instructions.
  */
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	unsigned int tmp;
-	arch_spinlock_t lockval;
-	u32 owner;
-
-	/*
-	 * Ensure prior spin_lock operations to other locks have completed
-	 * on this CPU before we test whether "lock" is locked.
-	 */
-	smp_mb();
-	owner = READ_ONCE(lock->owner) << 16;
-
-	asm volatile(
-"	sevl\n"
-"1:	wfe\n"
-"2:	ldaxr	%w0, %2\n"
-	/* Is the lock free? */
-"	eor	%w1, %w0, %w0, ror #16\n"
-"	cbz	%w1, 3f\n"
-	/* Lock taken -- has there been a subsequent unlock->lock transition? */
-"	eor	%w1, %w3, %w0, lsl #16\n"
-"	cbz	%w1, 1b\n"
-	/*
-	 * The owner has been updated, so there was an unlock->lock
-	 * transition that we missed. That means we can rely on the
-	 * store-release of the unlock operation paired with the
-	 * load-acquire of the lock operation to publish any of our
-	 * previous stores to the new lock owner and therefore don't
-	 * need to bother with the writeback below.
-	 */
-"	b	4f\n"
-"3:\n"
-	/*
-	 * Serialise against any concurrent lockers by writing back the
-	 * unlocked lock value
-	 */
-	ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-"	stxr	%w1, %w0, %2\n"
-	__nops(2),
-	/* LSE atomics */
-"	mov	%w1, %w0\n"
-"	cas	%w0, %w0, %2\n"
-"	eor	%w1, %w1, %w0\n")
-	/* Somebody else wrote to the lock, GOTO 10 and reload the value */
-"	cbnz	%w1, 2b\n"
-"4:"
-	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
-	: "r" (owner)
-	: "memory");
-}
 
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
@@ -176,7 +124,11 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	smp_mb(); /* See arch_spin_unlock_wait */
+	/*
+	 * Ensure prior spin_lock operations to other locks have completed
+	 * on this CPU before we test whether "lock" is locked.
+	 */
+	smp_mb(); /* ^^^ */
 	return !arch_spin_value_unlocked(READ_ONCE(*lock));
 }
 
-- 
2.5.2
