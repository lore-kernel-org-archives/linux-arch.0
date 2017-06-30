From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC 22/26] s390: Remove spin_unlock_wait() arch-specific definitions
Date: Thu, 29 Jun 2017 17:01:30 -0700
Message-ID: <1498780894-8253-22-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53617 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752276AbdF3ABq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jun 2017 20:01:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5TNx8AB098078
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:45 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bcsuww2j9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:45 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 29 Jun 2017 20:01:44 -0400
In-Reply-To: <20170629235918.GA6445@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore removes the underlying arch-specific
arch_spin_unlock_wait().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: <linux-s390@vger.kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/s390/include/asm/spinlock.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index f7838ecd83c6..217ee5210c32 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -98,13 +98,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lp)
 		: "cc", "memory");
 }
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	while (arch_spin_is_locked(lock))
-		arch_spin_relax(lock);
-	smp_acquire__after_ctrl_dep();
-}
-
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
-- 
2.5.2
