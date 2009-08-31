From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 9/9] spinlock: inline code for all locking variants on s390
Date: Mon, 31 Aug 2009 14:43:39 +0200
Message-ID: <20090831124419.319518405@de.ibm.com>
References: <20090831124330.014480226@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.17.164]:39352 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZHaMoT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2009 08:44:19 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7VCiLY4003487
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 12:44:21 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7VCiL5s2740444
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 14:44:21 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7VCiJDs010798
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 14:44:21 +0200
Content-Disposition: inline; filename=spinlock_s390.diff
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
 
+#define __always_inline__spin_lock
+#define __always_inline__read_lock
+#define __always_inline__write_lock
+#define __always_inline__spin_lock_bh
+#define __always_inline__read_lock_bh
+#define __always_inline__write_lock_bh
+#define __always_inline__spin_lock_irq
+#define __always_inline__read_lock_irq
+#define __always_inline__write_lock_irq
+#define __always_inline__spin_lock_irqsave
+#define __always_inline__read_lock_irqsave
+#define __always_inline__write_lock_irqsave
+#define __always_inline__spin_trylock
+#define __always_inline__read_trylock
+#define __always_inline__write_trylock
+#define __always_inline__spin_trylock_bh
+#define __always_inline__spin_unlock
+#define __always_inline__read_unlock
+#define __always_inline__write_unlock
+#define __always_inline__spin_unlock_bh
+#define __always_inline__read_unlock_bh
+#define __always_inline__write_unlock_bh
+#define __always_inline__spin_unlock_irq
+#define __always_inline__read_unlock_irq
+#define __always_inline__write_unlock_irq
+#define __always_inline__spin_unlock_irqrestore
+#define __always_inline__read_unlock_irqrestore
+#define __always_inline__write_unlock_irqrestore
+
 #endif /* __ASM_SPINLOCK_H */

-- 
