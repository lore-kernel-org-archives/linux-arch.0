From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 8/8] spinlock: inline code for all locking variants on s390
Date: Sat, 29 Aug 2009 12:21:23 +0200
Message-ID: <20090829102158.902928776@de.ibm.com>
References: <20090829102115.638224800@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:39350 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbZH2KWY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2009 06:22:24 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate5.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7TAMBew325090
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 10:22:16 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7TAM1Dp2969734
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 11:22:01 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7TALxRT009524
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 11:22:01 +0100
Content-Disposition: inline; filename=03_spinlock_s390.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <be>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/spinlock.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

Index: linux-2.6/arch/s390/include/asm/spinlock.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/spinlock.h
+++ linux-2.6/arch/s390/include/asm/spinlock.h
@@ -191,4 +191,33 @@ static inline int __raw_write_trylock(ra
 #define _raw_read_relax(lock)	cpu_relax()
 #define _raw_write_relax(lock)	cpu_relax()
 
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
 #endif /* __ASM_SPINLOCK_H */

-- 
