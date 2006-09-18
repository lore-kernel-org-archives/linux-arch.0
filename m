Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:8423 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965091AbWIRMVr
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 08:21:47 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id k8ICLkt0131150
	for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2006 12:21:46 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8ICQTZR2928838
	for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2006 14:26:29 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8ICLcOP004051
	for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2006 14:21:44 +0200
Date: Mon, 18 Sep 2006 14:21:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Fwd: [patch 2/3] Directed yield: direct yield of spinlocks for powerpc.
Message-ID: <20060918122136.GE3290@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, mingo@elte.hu, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 2/3] Directed yield: direct yield of spinlocks for powerpc.

In order to implement a spinlock that yields the cpu in favour of
the current lock holder cpu_relax variants for spinlocks and
read/write locks are needed. The new _raw_spin_relax, _raw_read_relax
and _raw_write_relax primitives have an additional argument: the
pointer to the lock structure.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-powerpc/spinlock.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/include/asm-powerpc/spinlock.h linux-2.6-patched/include/asm-powerpc/spinlock.h
--- linux-2.6/include/asm-powerpc/spinlock.h	2006-09-18 14:12:04.000000000 +0200
+++ linux-2.6-patched/include/asm-powerpc/spinlock.h	2006-09-18 14:12:04.000000000 +0200
@@ -285,9 +285,9 @@ static __inline__ void __raw_write_unloc
 	rw->lock = 0;
 }
 
-#define _raw_spin_relax(lock)	cpu_relax()
-#define _raw_read_relax(lock)	cpu_relax()
-#define _raw_write_relax(lock)	cpu_relax()
+#define _raw_spin_relax(lock)	__spin_yield(lock)
+#define _raw_read_relax(lock)	__rw_yield(lock)
+#define _raw_write_relax(lock)	__rw_yield(lock)
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */

----- End forwarded message -----

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
