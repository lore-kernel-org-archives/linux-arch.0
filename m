From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 22/34] mips: define __smp_XXX
Date: Wed, 30 Dec 2015 15:25:48 +0200
Message-ID: <1451473761-30019-23-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dbueso@suse.de>, Andrey Konovalov <andreyknvl@google.com>, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

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
