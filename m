From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 15/34] asm-generic: add __smp_XXX wrappers
Date: Wed, 30 Dec 2015 15:25:20 +0200
Message-ID: <1451473761-30019-16-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On !SMP, most architectures define their
barriers as compiler barriers.
On SMP, most need an actual barrier.

Make it possible to remove the code duplication for
!SMP by defining a low-level __smp_XXX barriers
which do not depend on the value of SMP, then
use them from asm-generic conditionally.

Besides reducing code duplication, these low level APIs will also be
useful for virtualization, where a barrier is sometimes needed even if
!SMP since we might be talking to another kernel on the same SMP system.

Both virtio and Xen drivers will benefit.

The smp_XXX variants should use __smp_XXX ones or barrier() depending on
SMP, identically for all architectures.

We keep ifndef guards around them for now - once all
architectures have been converted to use the generic
code, we'll be able to remove these.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/asm-generic/barrier.h | 91 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 987b2e0..8752964 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -54,22 +54,38 @@
 #define read_barrier_depends()		do { } while (0)
 #endif
 
+#ifndef __smp_mb
+#define __smp_mb()	mb()
+#endif
+
+#ifndef __smp_rmb
+#define __smp_rmb()	rmb()
+#endif
+
+#ifndef __smp_wmb
+#define __smp_wmb()	wmb()
+#endif
+
+#ifndef __smp_read_barrier_depends
+#define __smp_read_barrier_depends()	read_barrier_depends()
+#endif
+
 #ifdef CONFIG_SMP
 
 #ifndef smp_mb
-#define smp_mb()	mb()
+#define smp_mb()	__smp_mb()
 #endif
 
 #ifndef smp_rmb
-#define smp_rmb()	rmb()
+#define smp_rmb()	__smp_rmb()
 #endif
 
 #ifndef smp_wmb
-#define smp_wmb()	wmb()
+#define smp_wmb()	__smp_wmb()
 #endif
 
 #ifndef smp_read_barrier_depends
-#define smp_read_barrier_depends()	read_barrier_depends()
+#define smp_read_barrier_depends()	__smp_read_barrier_depends()
 #endif
 
 #else	/* !CONFIG_SMP */
@@ -92,23 +108,78 @@
 
 #endif	/* CONFIG_SMP */
 
+#ifndef __smp_store_mb
+#define __smp_store_mb(var, value)  do { WRITE_ONCE(var, value); __smp_mb(); } while (0)
+#endif
+
+#ifndef __smp_mb__before_atomic
+#define __smp_mb__before_atomic()	__smp_mb()
+#endif
+
+#ifndef __smp_mb__after_atomic
+#define __smp_mb__after_atomic()	__smp_mb()
+#endif
+
+#ifndef __smp_store_release
+#define __smp_store_release(p, v)					\
+do {									\
+	compiletime_assert_atomic_type(*p);				\
+	__smp_mb();							\
+	WRITE_ONCE(*p, v);						\
+} while (0)
+#endif
+
+#ifndef __smp_load_acquire
+#define __smp_load_acquire(p)						\
+({									\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	compiletime_assert_atomic_type(*p);				\
+	__smp_mb();							\
+	___p1;								\
+})
+#endif
+
+#ifdef CONFIG_SMP
+
+#ifndef smp_store_mb
+#define smp_store_mb(var, value)  __smp_store_mb(var, value)
+#endif
+
+#ifndef smp_mb__before_atomic
+#define smp_mb__before_atomic()	__smp_mb__before_atomic()
+#endif
+
+#ifndef smp_mb__after_atomic
+#define smp_mb__after_atomic()	__smp_mb__after_atomic()
+#endif
+
+#ifndef smp_store_release
+#define smp_store_release(p, v) __smp_store_release(p, v)
+#endif
+
+#ifndef smp_load_acquire
+#define smp_load_acquire(p) __smp_load_acquire(p)
+#endif
+
+#else	/* !CONFIG_SMP */
+
 #ifndef smp_store_mb
-#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); smp_mb(); } while (0)
+#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); barrier(); } while (0)
 #endif
 
 #ifndef smp_mb__before_atomic
-#define smp_mb__before_atomic()	smp_mb()
+#define smp_mb__before_atomic()	barrier()
 #endif
 
 #ifndef smp_mb__after_atomic
-#define smp_mb__after_atomic()	smp_mb()
+#define smp_mb__after_atomic()	barrier()
 #endif
 
 #ifndef smp_store_release
 #define smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	barrier();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 #endif
@@ -118,10 +189,12 @@ do {									\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	barrier();							\
 	___p1;								\
 })
 #endif
 
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
-- 
MST
