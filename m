From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 20/34] ia64: define __smp_XXX
Date: Wed, 30 Dec 2015 15:25:40 +0200
Message-ID: <1451473761-30019-21-git-send-email-mst@redhat.com>
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
Cc: linux-arch@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Davidlohr Bueso <dbueso@suse.de>, virtualization@lists.linux-foundation.org, Andrey Konovalov <andreyknvl@google.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

This defines __smp_XXX barriers for ia64,
for use by virtualization.

smp_XXX barriers are removed as they are
defined correctly by asm-generic/barriers.h

This reduces the amount of arch-specific boiler-plate code.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/ia64/include/asm/barrier.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/include/asm/barrier.h b/arch/ia64/include/asm/barrier.h
index 2f93348..588f161 100644
--- a/arch/ia64/include/asm/barrier.h
+++ b/arch/ia64/include/asm/barrier.h
@@ -42,28 +42,24 @@
 #define dma_rmb()	mb()
 #define dma_wmb()	mb()
 
-#ifdef CONFIG_SMP
-# define smp_mb()	mb()
-#else
-# define smp_mb()	barrier()
-#endif
+# define __smp_mb()	mb()
 
-#define smp_mb__before_atomic()	barrier()
-#define smp_mb__after_atomic()	barrier()
+#define __smp_mb__before_atomic()	barrier()
+#define __smp_mb__after_atomic()	barrier()
 
 /*
  * IA64 GCC turns volatile stores into st.rel and volatile loads into ld.acq no
  * need for asm trickery!
  */
 
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
-- 
MST
