Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752145AbdF3ABp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jun 2017 20:01:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5TNxlKU094629
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:45 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bcy9rggf0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:44 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 29 Jun 2017 20:01:43 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC 13/26] blackfin: Remove spin_unlock_wait() arch-specific definitions
Date: Thu, 29 Jun 2017 17:01:21 -0700
In-Reply-To: <20170629235918.GA6445@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com>
Message-ID: <1498780894-8253-13-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net
Message-ID: <20170630000121.wu2c75WxlZsiwsPiJgr-NIC9vlSluuIPv1SVrQgKnUI@z>

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore removes the underlying arch-specific
arch_spin_unlock_wait().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Steven Miao <realmz6@gmail.com>
Cc: <adi-buildroot-devel@lists.sourceforge.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/blackfin/include/asm/spinlock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/blackfin/include/asm/spinlock.h b/arch/blackfin/include/asm/spinlock.h
index c58f4a83ed6f..f6431439d15d 100644
--- a/arch/blackfin/include/asm/spinlock.h
+++ b/arch/blackfin/include/asm/spinlock.h
@@ -48,11 +48,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	__raw_spin_unlock_asm(&lock->lock);
 }
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, !VAL);
-}
-
 static inline int arch_read_can_lock(arch_rwlock_t *rw)
 {
 	return __raw_uncached_fetch_asm(&rw->lock) > 0;
-- 
2.5.2
