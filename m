Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56539 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbbL3Vrk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 16:47:40 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id D9A2D42E5C5
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 21:47:39 +0000 (UTC)
Received: from redhat.com (vpn1-6-186.ams2.redhat.com [10.36.6.186])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBULlcgM000766
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 16:47:39 -0500
Date: Wed, 30 Dec 2015 15:25:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 18/34] arm: define __smp_xxx
Message-ID: <1451473761-30019-19-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Russell King <linux@arm.linux.org.uk>, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <20151230132532.pzMI9n6AXBJQQy2iG-1hGRoOuMwqicOw0QpNxEYf_Bw@z>

This defines __smp_XXX barriers for arm,
for use by virtualization.

smp_XXX barriers are removed as they are
defined correctly by asm-generic/barriers.h

This reduces the amount of arch-specific boiler-plate code.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/arm/include/asm/barrier.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 31152e8..112cc1a 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -60,15 +60,9 @@ extern void arm_heavy_mb(void);
 #define dma_wmb()	barrier()
 #endif
 
-#ifndef CONFIG_SMP
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
-#else
-#define smp_mb()	dmb(ish)
-#define smp_rmb()	smp_mb()
-#define smp_wmb()	dmb(ishst)
-#endif
+#define __smp_mb()	dmb(ish)
+#define __smp_rmb()	__smp_mb()
+#define __smp_wmb()	dmb(ishst)
 
 #include <asm-generic/barrier.h>
 
-- 
MST

