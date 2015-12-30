Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57111 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755226AbbL3Vwn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 16:52:43 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id AFA1542E5DD
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 21:52:43 +0000 (UTC)
Received: from redhat.com (vpn1-6-186.ams2.redhat.com [10.36.6.186])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBULqgFO020737
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 16:52:43 -0500
Date: Wed, 30 Dec 2015 15:25:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 22/34] mips: define __smp_xxx
Message-ID: <1451473761-30019-23-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dbueso@suse.de>, Andrey Konovalov <andreyknvl@google.com>, linux-mips@linux-mips.org
Message-ID: <20151230132548.knyTNYk6n1lw8tyMdQ3997NadY5t0OO2gyqc-tj2pqc@z>

This defines __smp_XXX barriers for mips,
for use by virtualization.

smp_XXX barriers are removed as they are
defined correctly by asm-generic/barriers.h

Note: the only exception is smp_mb__before_llsc which is mips-specific.
We define both the __smp_mb__before_llsc variant (for use in
asm/barriers.h) and smp_mb__before_llsc (for use elsewhere on this
architecture).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/mips/include/asm/barrier.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 3eac4b9..d296633 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -85,20 +85,20 @@
 #define wmb()		fast_wmb()
 #define rmb()		fast_rmb()
 
-#if defined(CONFIG_WEAK_ORDERING) && defined(CONFIG_SMP)
+#if defined(CONFIG_WEAK_ORDERING)
 # ifdef CONFIG_CPU_CAVIUM_OCTEON
-#  define smp_mb()	__sync()
-#  define smp_rmb()	barrier()
-#  define smp_wmb()	__syncw()
+#  define __smp_mb()	__sync()
+#  define __smp_rmb()	barrier()
+#  define __smp_wmb()	__syncw()
 # else
-#  define smp_mb()	__asm__ __volatile__("sync" : : :"memory")
-#  define smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
-#  define smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
+#  define __smp_mb()	__asm__ __volatile__("sync" : : :"memory")
+#  define __smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
+#  define __smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
 # endif
 #else
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
+#define __smp_mb()	barrier()
+#define __smp_rmb()	barrier()
+#define __smp_wmb()	barrier()
 #endif
 
 #if defined(CONFIG_WEAK_REORDERING_BEYOND_LLSC) && defined(CONFIG_SMP)
@@ -111,6 +111,7 @@
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #define smp_mb__before_llsc() smp_wmb()
+#define __smp_mb__before_llsc() __smp_wmb()
 /* Cause previous writes to become visible on all CPUs as soon as possible */
 #define nudge_writes() __asm__ __volatile__(".set push\n\t"		\
 					    ".set arch=octeon\n\t"	\
@@ -118,11 +119,12 @@
 					    ".set pop" : : : "memory")
 #else
 #define smp_mb__before_llsc() smp_llsc_mb()
+#define __smp_mb__before_llsc() smp_llsc_mb()
 #define nudge_writes() mb()
 #endif
 
-#define smp_mb__before_atomic()	smp_mb__before_llsc()
-#define smp_mb__after_atomic()	smp_llsc_mb()
+#define __smp_mb__before_atomic()	__smp_mb__before_llsc()
+#define __smp_mb__after_atomic()	smp_llsc_mb()
 
 #include <asm-generic/barrier.h>
 
-- 
MST

