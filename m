From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 3/3] spinlock: inline code for all locking variants on s390
Date: Fri, 14 Aug 2009 14:58:04 +0200
Message-ID: <20090814125857.734010997@de.ibm.com>
References: <20090814125801.881618121@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:34659 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZHNM7I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2009 08:59:08 -0400
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate3.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7ECwxXv309428
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 12:58:59 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7ECwx5Z1765594
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 13:58:59 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7ECwwoe007333
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 13:58:59 +0100
Content-Disposition: inline; filename=03_spinlock_s390.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/spinlock.h |   34 ++++++++++++++++++++++++++++++++++
 include/linux/spinlock_api_smp.h |    2 +-
 2 files changed, 35 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/s390/include/asm/spinlock.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/spinlock.h
+++ linux-2.6/arch/s390/include/asm/spinlock.h
@@ -191,4 +191,38 @@ static inline int __raw_write_trylock(ra
 #define _raw_read_relax(lock)	cpu_relax()
 #define _raw_write_relax(lock)	cpu_relax()
 
+#if defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT) && \
+    !defined(CONFIG_DEBUG_SPINLOCK)
+
+#define __spin_lock_is_small
+#define __read_lock_is_small
+#define __write_lock_is_small
+#define __spin_lock_bh_is_small
+#define __read_lock_bh_is_small
+#define __write_lock_bh_is_small
+#define __spin_lock_irq_is_small
+#define __read_lock_irq_is_small
+#define __write_lock_irq_is_small
+#define __spin_lock_irqsave_is_small
+#define __read_lock_irqsave_is_small
+#define __write_lock_irqsave_is_small
+#define __spin_trylock_is_small
+#define __read_trylock_is_small
+#define __write_trylock_is_small
+#define __spin_trylock_bh_is_small
+#define __spin_unlock_is_small
+#define __read_unlock_is_small
+#define __write_unlock_is_small
+#define __spin_unlock_bh_is_small
+#define __read_unlock_bh_is_small
+#define __write_unlock_bh_is_small
+#define __spin_unlock_irq_is_small
+#define __read_unlock_irq_is_small
+#define __write_unlock_irq_is_small
+#define __spin_unlock_irqrestore_is_small
+#define __read_unlock_irqrestore_is_small
+#define __write_unlock_irqrestore_is_small
+
+#endif /* defined(SMP) && !defined(PREEMPT) && !defined(DEBUG_SPINLOCK) */
+
 #endif /* __ASM_SPINLOCK_H */

-- 
