From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 34/34] virtio_ring: use __smp_store_mb
Date: Wed, 30 Dec 2015 15:26:35 +0200
Message-ID: <1451473761-30019-35-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32797 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819AbbL3N0j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 08:26:39 -0500
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>

We need a full barrier after writing out event index, using
__smp_store_mb there seems better than open-coding.  As usual, we need a
wrapper to account for strong barriers.

It's tempting to use this in vhost as well, for that, we'll
need a variant of smp_store_mb that works on __user pointers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h  | 12 ++++++++++++
 drivers/virtio/virtio_ring.c | 15 +++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 528cf81..8ff0c25 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -45,6 +45,18 @@ static inline void virtio_wmb(bool weak_barriers)
 		wmb();
 }
 
+static inline void virtio_store_mb(bool weak_barriers,
+				   __virtio16 *p, __virtio16 v)
+{
+	if (weak_barriers)
+		__smp_store_mb(*p, v);
+	else
+	{
+		WRITE_ONCE(*p, v);
+		mb();
+	}
+}
+
 /* a load + acquire barrier, but only guaranteed to order reads */
 static inline __virtio16 virtio_load_acquire_rmb(bool weak_barriers,
 						 __virtio16 *p)
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index edc01d0..9befa32 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -517,10 +517,10 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
-	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
-		vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, vq->last_used_idx);
-		virtio_mb(vq->weak_barriers);
-	}
+	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
+		virtio_store_mb(vq->weak_barriers,
+				&vring_used_event(&vq->vring),
+				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
 
 #ifdef DEBUG
 	vq->last_add_time_valid = false;
@@ -653,8 +653,11 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	}
 	/* TODO: tune this threshold */
 	bufs = (u16)(vq->avail_idx_shadow - vq->last_used_idx) * 3 / 4;
-	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs);
-	virtio_mb(vq->weak_barriers);
+
+	virtio_store_mb(vq->weak_barriers,
+			&vring_used_event(&vq->vring),
+			cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs));
+
 	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->vring.used->idx) - vq->last_used_idx) > bufs)) {
 		END_USE(vq);
 		return false;
-- 
MST
