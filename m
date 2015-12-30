From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 05/34] powerpc: reuse asm-generic/barrier.h
Date: Wed, 30 Dec 2015 15:24:32 +0200
Message-ID: <1451473761-30019-6-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On powerpc read_barrier_depends, smp_read_barrier_depends
smp_store_mb(), smp_mb__before_atomic and smp_mb__after_atomic match the
asm-generic variants exactly. Drop the local definitions and pull in
asm-generic/barrier.h instead.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/powerpc/include/asm/barrier.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 0eca6ef..980ad0c 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -34,8 +34,6 @@
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); mb(); } while (0)
-
 #ifdef __SUBARCH_HAS_LWSYNC
 #    define SMPWMB      LWSYNC
 #else
@@ -60,9 +58,6 @@
 #define smp_wmb()	barrier()
 #endif /* CONFIG_SMP */
 
-#define read_barrier_depends()		do { } while (0)
-#define smp_read_barrier_depends()	do { } while (0)
-
 /*
  * This is a barrier which prevents following instructions from being
  * started until the value of the argument x is known.  For example, if
@@ -87,8 +82,8 @@ do {									\
 	___p1;								\
 })
 
-#define smp_mb__before_atomic()     smp_mb()
-#define smp_mb__after_atomic()      smp_mb()
 #define smp_mb__before_spinlock()   smp_mb()
 
+#include <asm-generic/barrier.h>
+
 #endif /* _ASM_POWERPC_BARRIER_H */
-- 
MST
