From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 30/34] virtio_ring: update weak barriers to use __smp_XXX
Date: Wed, 30 Dec 2015 15:26:21 +0200
Message-ID: <1451473761-30019-31-git-send-email-mst@redhat.com>
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

virtio ring uses smp_wmb on SMP and wmb on !SMP,
the reason for the later being that it might be
talking to another kernel on the same SMP machine.

This is exactly what __smp_XXX barriers do,
so switch to these instead of homegrown ifdef hacks.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 67e06fe..71176be 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -12,7 +12,7 @@
  * anyone care?
  *
  * For virtio_pci on SMP, we don't need to order with respect to MMIO
- * accesses through relaxed memory I/O windows, so smp_mb() et al are
+ * accesses through relaxed memory I/O windows, so __smp_mb() et al are
  * sufficient.
  *
  * For using virtio to talk to real devices (eg. other heterogeneous
@@ -21,11 +21,10 @@
  * actually quite cheap.
  */
 
-#ifdef CONFIG_SMP
 static inline void virtio_mb(bool weak_barriers)
 {
 	if (weak_barriers)
-		smp_mb();
+		__smp_mb();
 	else
 		mb();
 }
@@ -33,7 +32,7 @@ static inline void virtio_mb(bool weak_barriers)
 static inline void virtio_rmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		smp_rmb();
+		__smp_rmb();
 	else
 		rmb();
 }
@@ -41,26 +40,10 @@ static inline void virtio_rmb(bool weak_barriers)
 static inline void virtio_wmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		smp_wmb();
+		__smp_wmb();
 	else
 		wmb();
 }
-#else
-static inline void virtio_mb(bool weak_barriers)
-{
-	mb();
-}
-
-static inline void virtio_rmb(bool weak_barriers)
-{
-	rmb();
-}
-
-static inline void virtio_wmb(bool weak_barriers)
-{
-	wmb();
-}
-#endif
 
 struct virtio_device;
 struct virtqueue;
-- 
MST
