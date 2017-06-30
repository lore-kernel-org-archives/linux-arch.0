Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751886AbdF3ABo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jun 2017 20:01:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5TNx4FJ043691
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:43 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bd8cwpht7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:01:43 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 29 Jun 2017 20:01:42 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC 10/26] arc: Remove spin_unlock_wait() arch-specific definitions
Date: Thu, 29 Jun 2017 17:01:18 -0700
In-Reply-To: <20170629235918.GA6445@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com>
Message-ID: <1498780894-8253-10-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org
Message-ID: <20170630000118.TTxZbNi4f3meOv5oHdirzQsP6nckzSbr8mjHRtPKl6g@z>

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore removes the underlying arch-specific
arch_spin_unlock_wait().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: <linux-snps-arc@lists.infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/arc/include/asm/spinlock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
index 233d5ffe6ec7..a325e6a36523 100644
--- a/arch/arc/include/asm/spinlock.h
+++ b/arch/arc/include/asm/spinlock.h
@@ -16,11 +16,6 @@
 #define arch_spin_is_locked(x)	((x)->slock != __ARCH_SPIN_LOCK_UNLOCKED__)
 #define arch_spin_lock_flags(lock, flags)	arch_spin_lock(lock)
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->slock, !VAL);
-}
-
 #ifdef CONFIG_ARC_HAS_LLSC
 
 static inline void arch_spin_lock(arch_spinlock_t *lock)
-- 
2.5.2
