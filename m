Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:45185 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030189AbWISLTx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Sep 2006 07:19:53 -0400
Date: Tue, 19 Sep 2006 13:19:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/3] Directed yield: direct yield of spinlocks for powerpc.
Message-ID: <20060919111950.GD21713@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: mingo@elte.hu, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 2/3] Directed yield: direct yield of spinlocks for powerpc.

Powerpc already has a directed yield for CONFIG_PREEMPT="n". To make
it work with CONFIG_PREEMPT="y" as well the _raw_{spin,read,write}_relax
primitives need to be defined to call __spin_yield() for spinlocks and
__rw_yield() for rw-locks.

Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-powerpc/spinlock.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/include/asm-powerpc/spinlock.h linux-2.6-patched/include/asm-powerpc/spinlock.h
--- linux-2.6/include/asm-powerpc/spinlock.h	2006-09-19 12:59:35.000000000 +0200
+++ linux-2.6-patched/include/asm-powerpc/spinlock.h	2006-09-19 12:59:35.000000000 +0200
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
