Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757720AbcAJOUR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Jan 2016 09:20:17 -0500
Date: Sun, 10 Jan 2016 16:20:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 26/41] xtensa: define __smp_xxx
Message-ID: <1452426622-4471-27-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Message-ID: <20160110142009.y0CXpXYvUwTmGNoEVEOi-qMcski2t9kmCIoSePVWuFA@z>

This defines __smp_xxx barriers for xtensa,
for use by virtualization.

smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/xtensa/include/asm/barrier.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/barrier.h b/arch/xtensa/include/asm/barrier.h
index 5b88774..956596e 100644
--- a/arch/xtensa/include/asm/barrier.h
+++ b/arch/xtensa/include/asm/barrier.h
@@ -13,8 +13,8 @@
 #define rmb() barrier()
 #define wmb() mb()
 
-#define smp_mb__before_atomic()		barrier()
-#define smp_mb__after_atomic()		barrier()
+#define __smp_mb__before_atomic()		barrier()
+#define __smp_mb__after_atomic()		barrier()
 
 #include <asm-generic/barrier.h>
 
-- 
MST

