From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC 19/26] mn10300: Remove spin_unlock_wait() arch-specific definitions
Date: Thu, 29 Jun 2017 17:01:27 -0700
Message-ID: <1498780894-8253-19-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752165AbdF3ABp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jun 2017 20:01:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5TNx6PH141755
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:45 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bd40jjfjh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:45 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 29 Jun 2017 20:01:43 -0400
In-Reply-To: <20170629235918.GA6445@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore removes the underlying arch-specific
arch_spin_unlock_wait().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: <linux-am33-list@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/mn10300/include/asm/spinlock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mn10300/include/asm/spinlock.h b/arch/mn10300/include/asm/spinlock.h
index 9c7b8f7942d8..fe413b41df6c 100644
--- a/arch/mn10300/include/asm/spinlock.h
+++ b/arch/mn10300/include/asm/spinlock.h
@@ -26,11 +26,6 @@
 
 #define arch_spin_is_locked(x)	(*(volatile signed char *)(&(x)->slock) != 0)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->slock, !VAL);
-}
-
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	asm volatile(
-- 
2.5.2
