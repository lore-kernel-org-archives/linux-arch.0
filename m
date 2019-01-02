From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 4/4] virtio: use dependent_ptr_mb
Date: Wed, 2 Jan 2019 15:58:03 -0500
Message-ID: <20190102205715.14054-5-mst@redhat.com>
References: <20190102205715.14054-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190102205715.14054-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Use dependent_ptr_mb which is - on some architectures -
more light-weight than an rmb.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 814b395007b2..2d320396eff8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -702,6 +702,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 	void *ret;
 	unsigned int i;
 	u16 last_used;
+	bool more;
 
 	START_USE(vq);
 
@@ -710,14 +711,15 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 		return NULL;
 	}
 
-	if (!more_used(vq)) {
+	more = more_used(vq);
+	if (!more) {
 		pr_debug("No more buffers in queue\n");
 		END_USE(vq);
 		return NULL;
 	}
 
 	/* Only get used array entries after they have been exposed by host. */
-	virtio_rmb(vq->weak_barriers);
+	vq = dependent_ptr_mb(vq, more);
 
 	last_used = (vq->last_used_idx & (vq->vring.num - 1));
 	i = virtio32_to_cpu(_vq->vdev, vq->vring.used->ring[last_used].id);
-- 
MST
