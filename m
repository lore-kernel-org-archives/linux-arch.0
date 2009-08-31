From: tip-bot for Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [tip:core/locking] locking: Inline spinlock code for all locking variants on s390
Date: Mon, 31 Aug 2009 17:08:33 GMT
Message-ID: <tip-b62e180cae6bd82e246d871a1e44e03f8019d421@git.kernel.org>
References: <20090831124419.319518405@de.ibm.com>
Reply-To: mingo@redhat.com, a.p.zijlstra@chello.nl,
	  torvalds@linux-foundation.org, schwidefsky@de.ibm.com,
	  ehrhardt@linux.vnet.ibm.com, arnd@arndb.de,
	  akpm@linux-foundation.org, heiko.carstens@de.ibm.com,
	  tglx@linutronix.de, zippel@linux-m68k.org,
	  linux-kernel@vger.kernel.org, hpa@zytor.com, paulus@samba.org,
	  horsth@linux.vnet.ibm.com, davem@davemloft.net,
	  benh@kernel.crashing.org, geert@linux-m68k.org,
	  linux-arch@vger.kernel.org, nickpiggin@yahoo.com.au,
	  mingo@elte.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33046 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbZHaRLR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 31 Aug 2009 13:11:17 -0400
In-Reply-To: <20090831124419.319518405@de.ibm.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: mingo@redhat.com, torvalds@linux-foundation.org, a.p.zijlstra@chello.nl, schwidefsky@de.ibm.com, ehrhardt@linux.vnet.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, zippel@linux-m68k.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com, paulus@samba.org, horsth@linux.vnet.ibm.com, davem@davemloft.net, benh@kernel.crashing.org, geert@linux-m68k.org, linux-arch@vger.kernel.org, mingo@elte.hu, nickpiggin@yahoo.com.au

Commit-ID:  b62e180cae6bd82e246d871a1e44e03f8019d421
Gitweb:     http://git.kernel.org/tip/b62e180cae6bd82e246d871a1e44e03f8019d421
Author:     Heiko Carstens <heiko.carstens@de.ibm.com>
AuthorDate: Mon, 31 Aug 2009 14:43:39 +0200
Committer:  Ingo Molnar <mingo@elte.hu>
CommitDate: Mon, 31 Aug 2009 18:08:51 +0200

locking: Inline spinlock code for all locking variants on s390

Speeds up several benchmarks in a measurable way, so inline
all spin-lock variants by default.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Horst Hartmann <horsth@linux.vnet.ibm.com>
Cc: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: <linux-arch@vger.kernel.org>
LKML-Reference: <20090831124419.319518405@de.ibm.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>


---
 arch/s390/include/asm/spinlock.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index c9af0d1..41ce686 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -191,4 +191,33 @@ static inline int __raw_write_trylock(raw_rwlock_t *rw)
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
