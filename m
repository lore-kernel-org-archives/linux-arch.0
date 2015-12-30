Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57128 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755277AbbL3Vwt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 16:52:49 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 0DED472
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 21:52:49 +0000 (UTC)
Received: from redhat.com (vpn1-6-186.ams2.redhat.com [10.36.6.186])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBULqlon019804
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 16:52:48 -0500
Date: Wed, 30 Dec 2015 15:26:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 25/34] sparc: define __smp_xxx
Message-ID: <1451473761-30019-26-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrey Konovalov <andreyknvl@google.com>, sparclinux@vger.kernel.org
Message-ID: <20151230132601.T-E3pUlgkRU6tj8pD11C1H6C7_g-lIWvmonPwios3NA@z>

This defines __smp_XXX barriers for sparc,
for use by virtualization.

smp_XXX barriers are removed as they are
defined correctly by asm-generic/barriers.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sparc/include/asm/barrier_64.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/barrier_64.h b/arch/sparc/include/asm/barrier_64.h
index 26c3f72..c9f6ee6 100644
--- a/arch/sparc/include/asm/barrier_64.h
+++ b/arch/sparc/include/asm/barrier_64.h
@@ -37,14 +37,14 @@ do {	__asm__ __volatile__("ba,pt	%%xcc, 1f\n\t" \
 #define rmb()	__asm__ __volatile__("":::"memory")
 #define wmb()	__asm__ __volatile__("":::"memory")
 
-#define smp_store_release(p, v)						\
+#define __smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 
-#define smp_load_acquire(p)						\
+#define __smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
@@ -52,8 +52,8 @@ do {									\
 	___p1;								\
 })
 
-#define smp_mb__before_atomic()	barrier()
-#define smp_mb__after_atomic()	barrier()
+#define __smp_mb__before_atomic()	barrier()
+#define __smp_mb__after_atomic()	barrier()
 
 #include <asm-generic/barrier.h>
 
-- 
MST

