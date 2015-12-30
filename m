From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 18/34] arm: define __smp_XXX
Date: Wed, 30 Dec 2015 15:25:32 +0200
Message-ID: <1451473761-30019-19-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
