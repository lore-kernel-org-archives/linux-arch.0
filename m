Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39669 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465AbbL3Tfr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 14:35:47 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 1FEC68F506
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 19:35:45 +0000 (UTC)
Received: from redhat.com (vpn1-6-186.ams2.redhat.com [10.36.6.186])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBUJZh3O011751
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 14:35:44 -0500
Date: Wed, 30 Dec 2015 15:25:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 16/34] powerpc: define __smp_xxx
Message-ID: <1451473761-30019-17-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20151230132523.v5K3nsNCoQB-cLlKKX_cL0QEUeeHxF0UTA7GiFg5avA@z>

This defines __smp_XXX barriers for powerpc
for use by virtualization.

smp_XXX barriers are removed as they are
defined correctly by asm-generic/barriers.h

This reduces the amount of arch-specific boiler-plate code.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/powerpc/include/asm/barrier.h | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 980ad0c..c0deafc 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -44,19 +44,11 @@
 #define dma_rmb()	__lwsync()
 #define dma_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
 
-#ifdef CONFIG_SMP
-#define smp_lwsync()	__lwsync()
+#define __smp_lwsync()	__lwsync()
 
-#define smp_mb()	mb()
-#define smp_rmb()	__lwsync()
-#define smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
-#else
-#define smp_lwsync()	barrier()
-
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
-#endif /* CONFIG_SMP */
+#define __smp_mb()	mb()
+#define __smp_rmb()	__lwsync()
+#define __smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
 
 /*
  * This is a barrier which prevents following instructions from being
@@ -67,18 +59,18 @@
 #define data_barrier(x)	\
 	asm volatile("twi 0,%0,0; isync" : : "r" (x) : "memory");
 
-#define smp_store_release(p, v)						\
+#define __smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	smp_lwsync();							\
+	__smp_lwsync();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 
-#define smp_load_acquire(p)						\
+#define __smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	smp_lwsync();							\
+	__smp_lwsync();							\
 	___p1;								\
 })
 
-- 
MST

