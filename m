From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC 23/26] sh: Remove spin_unlock_wait() arch-specific definitions
Date: Thu, 29 Jun 2017 17:01:31 -0700
Message-ID: <1498780894-8253-23-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752232AbdF3ABq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jun 2017 20:01:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5TNx7OA141832
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:45 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bd40jjfk6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:45 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 29 Jun 2017 20:01:44 -0400
In-Reply-To: <20170629235918.GA6445@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore removes the underlying arch-specific
arch_spin_unlock_wait().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: <linux-sh@vger.kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/sh/include/asm/spinlock-cas.h  | 5 -----
 arch/sh/include/asm/spinlock-llsc.h | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/sh/include/asm/spinlock-cas.h b/arch/sh/include/asm/spinlock-cas.h
index c46e8cc7b515..5ed7dbbd94ff 100644
--- a/arch/sh/include/asm/spinlock-cas.h
+++ b/arch/sh/include/asm/spinlock-cas.h
@@ -29,11 +29,6 @@ static inline unsigned __sl_cas(volatile unsigned *p, unsigned old, unsigned new
 #define arch_spin_is_locked(x)		((x)->lock <= 0)
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, VAL > 0);
-}
-
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	while (!__sl_cas(&lock->lock, 1, 0));
diff --git a/arch/sh/include/asm/spinlock-llsc.h b/arch/sh/include/asm/spinlock-llsc.h
index cec78143fa83..f77263aae760 100644
--- a/arch/sh/include/asm/spinlock-llsc.h
+++ b/arch/sh/include/asm/spinlock-llsc.h
@@ -21,11 +21,6 @@
 #define arch_spin_is_locked(x)		((x)->lock <= 0)
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, VAL > 0);
-}
-
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
-- 
2.5.2
