From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 33/34] virtio: use __smp_load_acquire/__smp_store_release
Date: Wed, 30 Dec 2015 15:26:32 +0200
Message-ID: <1451473761-30019-34-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55780 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022AbbL3N0f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 08:26:35 -0500
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>

virtio ring entries have exactly the acquire/release
semantics:
	- reading used index acquires a ring entry from host
	- updating the available index releases it to host

Thus when using weak barriers (as most people do), __smp_load_acquire
and __smp_store_release will do exactly the right thing to synchronize
with the host.

In fact, QEMU already uses __atomic_thread_fence(__ATOMIC_ACQUIRE) and
__atomic_thread_fence(__ATOMIC_RELEASE);
Documentation/circular-buffers.txt suggests smp_load_acquire and
smp_store_release for head and tail updates.

Since we have to worry about strong barrier users,
let's add APIs to wrap these, and use in virtio_ring.c:
in case of the string barriers, we fall back on
rmb/wmb as previously.

It is tempting to use this in vhost as well,
this needs a bit more work to make acquire/release macros
work on __user pointers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h  | 26 ++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c | 20 ++++++++++----------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 71176be..528cf81 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -45,6 +45,32 @@ static inline void virtio_wmb(bool weak_barriers)
 		wmb();
 }
 
+/* a load + acquire barrier, but only guaranteed to order reads */
+static inline __virtio16 virtio_load_acquire_rmb(bool weak_barriers,
+						 __virtio16 *p)
+{
+	if (weak_barriers)
+		return __smp_load_acquire(p);
+	else {
+		__virtio16 v = READ_ONCE(*p);
+		rmb();
+		return v;
+	}
+}
+
+/* a release barrier + store, but only guaranteed to order writes */
+static inline void virtio_store_release_wmb(bool weak_barriers,
+					    __virtio16 *p, __virtio16 v)
+{
+	if (weak_barriers)
+		__smp_store_release(p, v);
+	else {
+		wmb();
+		WRITE_ONCE(*p, v);
+		return;
+	}
+}
+
 struct virtio_device;
 struct virtqueue;
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ee663c4..edc01d0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -244,11 +244,11 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	avail = vq->avail_idx_shadow & (vq->vring.num - 1);
 	vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
 
+	vq->avail_idx_shadow++;
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
-	virtio_wmb(vq->weak_barriers);
-	vq->avail_idx_shadow++;
-	vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
+	virtio_store_release_wmb(vq->weak_barriers, &vq->vring.avail->idx,
+				 cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow));
 	vq->num_added++;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
@@ -453,9 +453,10 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 	vq->vq.num_free++;
 }
 
-static inline bool more_used(const struct vring_virtqueue *vq)
+static inline
+bool more_used(const struct vring_virtqueue *vq, __virtio16 used_idx)
 {
-	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev, vq->vring.used->idx);
+	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev, used_idx);
 }
 
 /**
@@ -488,15 +489,14 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 		return NULL;
 	}
 
-	if (!more_used(vq)) {
+	/* Only get used array entries after they have been exposed by host. */
+	if (!more_used(vq, virtio_load_acquire_rmb(vq->weak_barriers,
+						   &vq->vring.used->idx))) {
 		pr_debug("No more buffers in queue\n");
 		END_USE(vq);
 		return NULL;
 	}
 
-	/* Only get used array entries after they have been exposed by host. */
-	virtio_rmb(vq->weak_barriers);
-
 	last_used = (vq->last_used_idx & (vq->vring.num - 1));
 	i = virtio32_to_cpu(_vq->vdev, vq->vring.used->ring[last_used].id);
 	*len = virtio32_to_cpu(_vq->vdev, vq->vring.used->ring[last_used].len);
@@ -704,7 +704,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!more_used(vq)) {
+	if (!more_used(vq, vq->vring.used->idx)) {
 		pr_debug("virtqueue interrupt with no work for %p\n", vq);
 		return IRQ_NONE;
 	}
-- 
MST
