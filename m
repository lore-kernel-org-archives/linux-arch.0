Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37985 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755172AbbL3Vwm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 16:52:42 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id E41D08E23B
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 21:52:41 +0000 (UTC)
Received: from redhat.com (vpn1-6-186.ams2.redhat.com [10.36.6.186])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBULqe8V020733
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 16:52:41 -0500
Date: Wed, 30 Dec 2015 15:25:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 21/34] metag: define __smp_xxx
Message-ID: <1451473761-30019-22-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, James Hogan <james.hogan@imgtec.com>, Ingo Molnar <mingo@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Ralf Baechle <ralf@linux-mips.org>, linux-metag@vger.kernel.org
Message-ID: <20151230132544.nNfWjc9L_tyZWHuxwUCpATC1rUN1az1QIkQs4c_p7Js@z>

This defines __smp_XXX barriers for metag,
for use by virtualization.

smp_XXX barriers are removed as they are
defined correctly by asm-generic/barriers.h

Note: as __smp_XX macros should not depend on CONFIG_SMP, they can not
use the existing fence() macro since that is defined differently between
SMP and !SMP.  For this reason, this patch introduces a wrapper
metag_fence() that doesn't depend on CONFIG_SMP.
fence() is then defined using that, depending on CONFIG_SMP.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/metag/include/asm/barrier.h | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/metag/include/asm/barrier.h b/arch/metag/include/asm/barrier.h
index b5b778b..84880c9 100644
--- a/arch/metag/include/asm/barrier.h
+++ b/arch/metag/include/asm/barrier.h
@@ -44,13 +44,6 @@ static inline void wr_fence(void)
 #define rmb()		barrier()
 #define wmb()		mb()
 
-#ifndef CONFIG_SMP
-#define fence()		do { } while (0)
-#define smp_mb()        barrier()
-#define smp_rmb()       barrier()
-#define smp_wmb()       barrier()
-#else
-
 #ifdef CONFIG_METAG_SMP_WRITE_REORDERING
 /*
  * Write to the atomic memory unlock system event register (command 0). This is
@@ -60,26 +53,31 @@ static inline void wr_fence(void)
  * incoherence). It is therefore ineffective if used after and on the same
  * thread as a write.
  */
-static inline void fence(void)
+static inline void metag_fence(void)
 {
 	volatile int *flushptr = (volatile int *) LINSYSEVENT_WR_ATOMIC_UNLOCK;
 	barrier();
 	*flushptr = 0;
 	barrier();
 }
-#define smp_mb()        fence()
-#define smp_rmb()       fence()
-#define smp_wmb()       barrier()
+#define __smp_mb()        metag_fence()
+#define __smp_rmb()       metag_fence()
+#define __smp_wmb()       barrier()
 #else
-#define fence()		do { } while (0)
-#define smp_mb()        barrier()
-#define smp_rmb()       barrier()
-#define smp_wmb()       barrier()
+#define metag_fence()		do { } while (0)
+#define __smp_mb()        barrier()
+#define __smp_rmb()       barrier()
+#define __smp_wmb()       barrier()
 #endif
+
+#ifdef CONFIG_SMP
+#define fence() metag_fence()
+#else
+#define fence()		do { } while (0)
 #endif
 
-#define smp_mb__before_atomic()	barrier()
-#define smp_mb__after_atomic()	barrier()
+#define __smp_mb__before_atomic()	barrier()
+#define __smp_mb__after_atomic()	barrier()
 
 #include <asm-generic/barrier.h>
 
-- 
MST

