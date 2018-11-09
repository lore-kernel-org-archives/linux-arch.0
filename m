From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] dma-mapping: return errors from dma_map_page and dma_map_attrs
Date: Fri,  9 Nov 2018 09:46:32 +0100
Message-ID: <20181109084632.22848-3-hch@lst.de>
References: <20181109084632.22848-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109084632.22848-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The current DMA API map_page and map_single routines use a very bad API
pattern that makes error checking hard.  The calls to them are far too
many and too complex to easily change that, but the relatively new _attr
variants that take an additional attributs argument only have a few
callers and can be changed easily.  So here we change them to return
an errno value, and return the dma address by reference to allow for
much saner error checking.

In the long run we should move existing callers of dma_map_page and
dma_map_single to these _attr variants with a 0 attrs argument to get
the better API everywhere, but without a single flag day.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API.txt                     |  4 +-
 drivers/crypto/caam/caamalg.c                 |  8 +--
 drivers/crypto/caam/caamalg_qi2.c             | 13 ++--
 drivers/crypto/caam/caamhash.c                |  8 +--
 drivers/crypto/talitos.c                      |  4 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c           | 19 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 20 +++---
 .../ethernet/cavium/thunder/nicvf_queues.c    | 27 ++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 11 +---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  5 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 11 +---
 drivers/net/ethernet/intel/igb/igb_main.c     | 11 +---
 drivers/net/ethernet/intel/igc/igc_main.c     | 11 +---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 +---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  5 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 11 +---
 .../ethernet/netronome/nfp/nfp_net_common.c   | 12 ++--
 include/linux/dma-mapping.h                   | 62 +++++++++++++------
 18 files changed, 109 insertions(+), 145 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index ac66ae2509a9..2a9069907470 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -439,10 +439,10 @@ See also dma_map_single().
 
 ::
 
-	dma_addr_t
+	int	
 	dma_map_single_attrs(struct device *dev, void *cpu_addr, size_t size,
 			     enum dma_data_direction dir,
-			     unsigned long attrs)
+			     unsigned long attrs, dma_addr_t *dma_handle);
 
 	void
 	dma_unmap_single_attrs(struct device *dev, dma_addr_t dma_addr,
diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 869f092432de..cbcd55fda24f 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -3022,11 +3022,9 @@ static int caam_init_common(struct caam_ctx *ctx, struct caam_alg_entry *caam,
 	else
 		ctx->dir = DMA_TO_DEVICE;
 
-	dma_addr = dma_map_single_attrs(ctx->jrdev, ctx->sh_desc_enc,
-					offsetof(struct caam_ctx,
-						 sh_desc_enc_dma),
-					ctx->dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (dma_mapping_error(ctx->jrdev, dma_addr)) {
+	if (dma_map_single_attrs(ctx->jrdev, ctx->sh_desc_enc,
+			offsetof(struct caam_ctx, sh_desc_enc_dma),
+			ctx->dir, DMA_ATTR_SKIP_CPU_SYNC, &dma_addr)) {
 		dev_err(ctx->jrdev, "unable to map key, shared descriptors\n");
 		caam_jr_free(ctx->jrdev);
 		return -ENOMEM;
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 7d8ac0222fa3..9453dca56798 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -1336,10 +1336,9 @@ static int caam_cra_init(struct caam_ctx *ctx, struct caam_alg_entry *caam,
 	ctx->dev = caam->dev;
 	ctx->dir = uses_dkp ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
 
-	dma_addr = dma_map_single_attrs(ctx->dev, ctx->flc,
-					offsetof(struct caam_ctx, flc_dma),
-					ctx->dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (dma_mapping_error(ctx->dev, dma_addr)) {
+	if (dma_map_single_attrs(ctx->dev, ctx->flc,
+			offsetof(struct caam_ctx, flc_dma),
+			ctx->dir, DMA_ATTR_SKIP_CPU_SYNC, &dma_addr)) {
 		dev_err(ctx->dev, "unable to map key, shared descriptors\n");
 		return -ENOMEM;
 	}
@@ -4272,10 +4271,8 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 
 	ctx->dev = caam_hash->dev;
 
-	dma_addr = dma_map_single_attrs(ctx->dev, ctx->flc, sizeof(ctx->flc),
-					DMA_BIDIRECTIONAL,
-					DMA_ATTR_SKIP_CPU_SYNC);
-	if (dma_mapping_error(ctx->dev, dma_addr)) {
+	if (dma_map_single_attrs(ctx->dev, ctx->flc, sizeof(ctx->flc),
+			DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC, &dma_addr)) {
 		dev_err(ctx->dev, "unable to map shared descriptors\n");
 		return -ENOMEM;
 	}
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 46924affa0bd..e0bc10ab891e 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -1693,11 +1693,9 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 	priv = dev_get_drvdata(ctx->jrdev->parent);
 	ctx->dir = priv->era >= 6 ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
 
-	dma_addr = dma_map_single_attrs(ctx->jrdev, ctx->sh_desc_update,
-					offsetof(struct caam_hash_ctx,
-						 sh_desc_update_dma),
-					ctx->dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (dma_mapping_error(ctx->jrdev, dma_addr)) {
+	if (dma_map_single_attrs(ctx->jrdev, ctx->sh_desc_update,
+			offsetof(struct caam_hash_ctx, sh_desc_update_dma),
+			ctx->dir, DMA_ATTR_SKIP_CPU_SYNC, &dma_addr)) {
 		dev_err(ctx->jrdev, "unable to map shared descriptors\n");
 		caam_jr_free(ctx->jrdev);
 		return -ENOMEM;
diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 6988012deca4..1b0f816994bf 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -110,10 +110,12 @@ static void __map_single_talitos_ptr(struct device *dev,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	dma_addr_t dma_addr = dma_map_single_attrs(dev, data, len, dir, attrs);
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
+	dma_addr_t dma_addr;
 
+	/* XXX: this driver badly needs error handling. */
+	dma_map_single_attrs(dev, data, len, dir, attrs, &dma_addr);
 	to_talitos_ptr(ptr, dma_addr, len, is_sec1);
 }
 
diff --git a/drivers/gpu/drm/i915/i915_gem_gtt.c b/drivers/gpu/drm/i915/i915_gem_gtt.c
index 56c7f8637311..49a0c275546b 100644
--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
@@ -566,12 +566,9 @@ static int __setup_page_dma(struct i915_address_space *vm,
 	if (unlikely(!p->page))
 		return -ENOMEM;
 
-	p->daddr = dma_map_page_attrs(vm->dma,
-				      p->page, 0, PAGE_SIZE,
-				      PCI_DMA_BIDIRECTIONAL,
-				      DMA_ATTR_SKIP_CPU_SYNC |
-				      DMA_ATTR_NO_WARN);
-	if (unlikely(dma_mapping_error(vm->dma, p->daddr))) {
+	if (dma_map_page_attrs(vm->dma, p->page, 0, PAGE_SIZE,
+			PCI_DMA_BIDIRECTIONAL,
+			DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_WARN, &p->daddr)) {
 		vm_free_page(vm, p->page);
 		return -ENOMEM;
 	}
@@ -651,12 +648,10 @@ setup_scratch_page(struct i915_address_space *vm, gfp_t gfp)
 		if (unlikely(!page))
 			goto skip;
 
-		addr = dma_map_page_attrs(vm->dma,
-					  page, 0, size,
-					  PCI_DMA_BIDIRECTIONAL,
-					  DMA_ATTR_SKIP_CPU_SYNC |
-					  DMA_ATTR_NO_WARN);
-		if (unlikely(dma_mapping_error(vm->dma, addr)))
+		if (unlikely(dma_map_page_attrs(vm->dma, page, 0, size,
+				PCI_DMA_BIDIRECTIONAL,
+				DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_WARN,
+				&addr)))
 			goto free_page;
 
 		if (unlikely(!IS_ALIGNED(addr, size)))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index dd85d790f638..b94e13499d68 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -662,9 +662,8 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 	if (!page)
 		return NULL;
 
-	*mapping = dma_map_page_attrs(dev, page, 0, PAGE_SIZE, bp->rx_dir,
-				      DMA_ATTR_WEAK_ORDERING);
-	if (dma_mapping_error(dev, *mapping)) {
+	if (dma_map_page_attrs(dev, page, 0, PAGE_SIZE, bp->rx_dir,
+			DMA_ATTR_WEAK_ORDERING, mapping)) {
 		__free_page(page);
 		return NULL;
 	}
@@ -682,11 +681,9 @@ static inline u8 *__bnxt_alloc_rx_data(struct bnxt *bp, dma_addr_t *mapping,
 	if (!data)
 		return NULL;
 
-	*mapping = dma_map_single_attrs(&pdev->dev, data + bp->rx_dma_offset,
-					bp->rx_buf_use_size, bp->rx_dir,
-					DMA_ATTR_WEAK_ORDERING);
-
-	if (dma_mapping_error(&pdev->dev, *mapping)) {
+	if (dma_map_single_attrs(&pdev->dev, data + bp->rx_dma_offset,
+			bp->rx_buf_use_size, bp->rx_dir, DMA_ATTR_WEAK_ORDERING,
+			mapping)) {
 		kfree(data);
 		data = NULL;
 	}
@@ -787,10 +784,9 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 			return -ENOMEM;
 	}
 
-	mapping = dma_map_page_attrs(&pdev->dev, page, offset,
-				     BNXT_RX_PAGE_SIZE, PCI_DMA_FROMDEVICE,
-				     DMA_ATTR_WEAK_ORDERING);
-	if (dma_mapping_error(&pdev->dev, mapping)) {
+	if (dma_map_page_attrs(&pdev->dev, page, offset,
+			BNXT_RX_PAGE_SIZE, PCI_DMA_FROMDEVICE,
+			DMA_ATTR_WEAK_ORDERING, &mapping)) {
 		__free_page(page);
 		return -EIO;
 	}
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 187a249ff2d1..fd762b5b233d 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -213,17 +213,18 @@ static inline int nicvf_alloc_rcv_buffer(struct nicvf *nic, struct rbdr *rbdr,
 	if (rbdr->is_xdp && pgcache && pgcache->dma_addr) {
 		*rbuf = pgcache->dma_addr;
 	} else {
+		dma_addr_t addr;
 		/* HW will ensure data coherency, CPU sync not required */
-		*rbuf = (u64)dma_map_page_attrs(&nic->pdev->dev, nic->rb_page,
-						nic->rb_page_offset, buf_len,
-						DMA_FROM_DEVICE,
-						DMA_ATTR_SKIP_CPU_SYNC);
-		if (dma_mapping_error(&nic->pdev->dev, (dma_addr_t)*rbuf)) {
+		if (dma_map_page_attrs(&nic->pdev->dev, nic->rb_page,
+				nic->rb_page_offset, buf_len, DMA_FROM_DEVICE,
+				DMA_ATTR_SKIP_CPU_SYNC, &addr)) {
 			if (!nic->rb_page_offset)
 				__free_pages(nic->rb_page, 0);
 			nic->rb_page = NULL;
 			return -ENOMEM;
 		}
+
+		*rbuf = addr;
 		if (pgcache)
 			pgcache->dma_addr = *rbuf + XDP_PACKET_HEADROOM;
 		nic->rb_page_offset += buf_len;
@@ -1576,10 +1577,9 @@ int nicvf_sq_append_skb(struct nicvf *nic, struct snd_queue *sq,
 	qentry = nicvf_get_nxt_sqentry(sq, qentry);
 	size = skb_is_nonlinear(skb) ? skb_headlen(skb) : skb->len;
 	/* HW will ensure data coherency, CPU sync not required */
-	dma_addr = dma_map_page_attrs(&nic->pdev->dev, virt_to_page(skb->data),
-				      offset_in_page(skb->data), size,
-				      DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
-	if (dma_mapping_error(&nic->pdev->dev, dma_addr)) {
+	if (dma_map_page_attrs(&nic->pdev->dev, virt_to_page(skb->data),
+			offset_in_page(skb->data), size, DMA_TO_DEVICE,
+			DMA_ATTR_SKIP_CPU_SYNC, &dma_addr)) {
 		nicvf_rollback_sq_desc(sq, qentry, subdesc_cnt);
 		return 0;
 	}
@@ -1597,12 +1597,9 @@ int nicvf_sq_append_skb(struct nicvf *nic, struct snd_queue *sq,
 
 		qentry = nicvf_get_nxt_sqentry(sq, qentry);
 		size = skb_frag_size(frag);
-		dma_addr = dma_map_page_attrs(&nic->pdev->dev,
-					      skb_frag_page(frag),
-					      frag->page_offset, size,
-					      DMA_TO_DEVICE,
-					      DMA_ATTR_SKIP_CPU_SYNC);
-		if (dma_mapping_error(&nic->pdev->dev, dma_addr)) {
+		if (dma_map_page_attrs(&nic->pdev->dev, skb_frag_page(frag),
+				frag->page_offset, size, DMA_TO_DEVICE,
+				DMA_ATTR_SKIP_CPU_SYNC, &dma_addr)) {
 			/* Free entire chain of mapped buffers
 			 * here 'i' = frags mapped + above mapped skb->data
 			 */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index aef3c89ee79c..1d1515197bf7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1535,15 +1535,8 @@ static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
 	}
 
 	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
-				 i40e_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE,
-				 I40E_RX_DMA_ATTR);
-
-	/* if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
+	if (dma_map_page_attrs(rx_ring->dev, page, 0, i40e_rx_pg_size(rx_ring),
+			DMA_FROM_DEVICE, I40E_RX_DMA_ATTR, &dma)) {
 		__free_pages(page, i40e_rx_pg_order(rx_ring));
 		rx_ring->rx_stats.alloc_page_failed++;
 		return false;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index add1e457886d..f950160c7e45 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -88,9 +88,8 @@ static int i40e_xsk_umem_dma_map(struct i40e_vsi *vsi, struct xdp_umem *umem)
 
 	dev = &pf->pdev->dev;
 	for (i = 0; i < umem->npgs; i++) {
-		dma = dma_map_page_attrs(dev, umem->pgs[i], 0, PAGE_SIZE,
-					 DMA_BIDIRECTIONAL, I40E_RX_DMA_ATTR);
-		if (dma_mapping_error(dev, dma))
+		if (dma_map_page_attrs(dev, umem->pgs[i], 0, PAGE_SIZE,
+				DMA_BIDIRECTIONAL, I40E_RX_DMA_ATTR, &dma))
 			goto out_unmap;
 
 		umem->pages[i].dma = dma;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index fb9bfad96daf..e973985faf49 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -827,15 +827,8 @@ static bool iavf_alloc_mapped_page(struct iavf_ring *rx_ring,
 	}
 
 	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
-				 iavf_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE,
-				 IAVF_RX_DMA_ATTR);
-
-	/* if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
+	if (dma_map_page_attrs(rx_ring->dev, page, 0, iavf_rx_pg_size(rx_ring),
+			DMA_FROM_DEVICE, IAVF_RX_DMA_ATTR, &dma)) {
 		__free_pages(page, iavf_rx_pg_order(rx_ring));
 		rx_ring->rx_stats.alloc_page_failed++;
 		return false;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5df88ad8ac81..355bdd0004d4 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8439,15 +8439,8 @@ static bool igb_alloc_mapped_page(struct igb_ring *rx_ring,
 	}
 
 	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
-				 igb_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE,
-				 IGB_RX_DMA_ATTR);
-
-	/* if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
+	if (dma_map_page_attrs(rx_ring->dev, page, 0, igb_rx_pg_size(rx_ring),
+			DMA_FROM_DEVICE, IGB_RX_DMA_ATTR, &dma)) {
 		__free_pages(page, igb_rx_pg_order(rx_ring));
 
 		rx_ring->rx_stats.alloc_failed++;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9d85707e8a81..d2cbc65cf291 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1505,15 +1505,8 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
 	}
 
 	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
-				 igc_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE,
-				 IGC_RX_DMA_ATTR);
-
-	/* if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
+	if (dma_map_page_attrs(rx_ring->dev, page, 0, igc_rx_pg_size(rx_ring),
+			DMA_FROM_DEVICE, IGC_RX_DMA_ATTR, &dma)) {
 		__free_page(page);
 
 		rx_ring->rx_stats.alloc_failed++;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 113b38e0defb..03f172b1ec4d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1542,16 +1542,8 @@ static bool ixgbe_alloc_mapped_page(struct ixgbe_ring *rx_ring,
 	}
 
 	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
-				 ixgbe_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE,
-				 IXGBE_RX_DMA_ATTR);
-
-	/*
-	 * if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
+	if (dma_map_page_attrs(rx_ring->dev, page, 0, ixgbe_rx_pg_size(rx_ring),
+			DMA_FROM_DEVICE, IXGBE_RX_DMA_ATTR, &dma)) {
 		__free_pages(page, ixgbe_rx_pg_order(rx_ring));
 
 		rx_ring->rx_stats.alloc_rx_page_failed++;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 65c3e2c979d4..9de8e4890acb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -75,9 +75,8 @@ static int ixgbe_xsk_umem_dma_map(struct ixgbe_adapter *adapter,
 	dma_addr_t dma;
 
 	for (i = 0; i < umem->npgs; i++) {
-		dma = dma_map_page_attrs(dev, umem->pgs[i], 0, PAGE_SIZE,
-					 DMA_BIDIRECTIONAL, IXGBE_RX_DMA_ATTR);
-		if (dma_mapping_error(dev, dma))
+		if (dma_map_page_attrs(dev, umem->pgs[i], 0, PAGE_SIZE,
+				DMA_BIDIRECTIONAL, IXGBE_RX_DMA_ATTR, &dma))
 			goto out_unmap;
 
 		umem->pages[i].dma = dma;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 5e47ede7e832..966fefb32ad5 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -620,14 +620,9 @@ static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
 	}
 
 	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
-				 ixgbevf_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE, IXGBEVF_RX_DMA_ATTR);
-
-	/* if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
+	if (dma_map_page_attrs(rx_ring->dev, page, 0,
+			ixgbevf_rx_pg_size(rx_ring), DMA_FROM_DEVICE,
+			IXGBEVF_RX_DMA_ATTR, &dma)) {
 		__free_pages(page, ixgbevf_rx_pg_order(rx_ring));
 
 		rx_ring->rx_stats.alloc_rx_page_failed++;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 6bddfcfdec34..933b3cfe2234 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -60,11 +60,13 @@ void nfp_net_get_fw_version(struct nfp_net_fw_version *fw_ver,
 	put_unaligned_le32(reg, fw_ver);
 }
 
-static dma_addr_t nfp_net_dma_map_rx(struct nfp_net_dp *dp, void *frag)
+static int nfp_net_dma_map_rx(struct nfp_net_dp *dp, void *frag,
+		dma_addr_t *dma_handle)
 {
 	return dma_map_single_attrs(dp->dev, frag + NFP_NET_RX_BUF_HEADROOM,
 				    dp->fl_bufsz - NFP_NET_RX_BUF_NON_DATA,
-				    dp->rx_dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+				    dp->rx_dma_dir, DMA_ATTR_SKIP_CPU_SYNC,
+				    dma_handle);
 }
 
 static void
@@ -1188,8 +1190,7 @@ static void *nfp_net_rx_alloc_one(struct nfp_net_dp *dp, dma_addr_t *dma_addr)
 		return NULL;
 	}
 
-	*dma_addr = nfp_net_dma_map_rx(dp, frag);
-	if (dma_mapping_error(dp->dev, *dma_addr)) {
+	if (nfp_net_dma_map_rx(dp, frag, dma_addr)) {
 		nfp_net_free_frag(frag, dp->xdp_prog);
 		nn_dp_warn(dp, "Failed to map DMA RX buffer\n");
 		return NULL;
@@ -1215,8 +1216,7 @@ static void *nfp_net_napi_alloc_one(struct nfp_net_dp *dp, dma_addr_t *dma_addr)
 		frag = page_address(page);
 	}
 
-	*dma_addr = nfp_net_dma_map_rx(dp, frag);
-	if (dma_mapping_error(dp->dev, *dma_addr)) {
+	if (nfp_net_dma_map_rx(dp, frag, dma_addr)) {
 		nfp_net_free_frag(frag, dp->xdp_prog);
 		nn_dp_warn(dp, "Failed to map DMA RX buffer\n");
 		return NULL;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c08779649ac0..d70bded7aea8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -224,22 +224,37 @@ static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 }
 #endif
 
-static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
-					      size_t size,
-					      enum dma_data_direction dir,
-					      unsigned long attrs)
+static __must_check inline int
+dma_map_single_attrs(struct device *dev, void *ptr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs,
+		dma_addr_t *dma_handle)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	debug_dma_map_single(dev, ptr, size);
+	*dma_handle = ops->map_page(dev, virt_to_page(ptr), offset_in_page(ptr),
+			size, dir, attrs);
+	if (*dma_handle == DMA_MAPPING_ERROR)
+		return -ENOMEM;
+
+	debug_dma_map_page(dev, virt_to_page(ptr), offset_in_page(ptr), size,
+			dir, *dma_handle, true);
+	return 0;
+}
+
+static inline dma_addr_t dma_map_single(struct device *dev, void *ptr,
+		size_t size, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_map_single(dev, ptr, size);
-	addr = ops->map_page(dev, virt_to_page(ptr),
-			     offset_in_page(ptr), size,
-			     dir, attrs);
-	debug_dma_map_page(dev, virt_to_page(ptr),
-			   offset_in_page(ptr), size,
-			   dir, addr, true);
+	addr = ops->map_page(dev, virt_to_page(ptr), offset_in_page(ptr), size,
+			dir, 0);
+	debug_dma_map_page(dev, virt_to_page(ptr), offset_in_page(ptr), size,
+			dir, addr, true);
 	return addr;
 }
 
@@ -287,19 +302,30 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 
-static inline dma_addr_t dma_map_page_attrs(struct device *dev,
-					    struct page *page,
-					    size_t offset, size_t size,
-					    enum dma_data_direction dir,
-					    unsigned long attrs)
+static __must_check inline int
+dma_map_page_attrs(struct device *dev, struct page *page, size_t offset,
+		size_t size, enum dma_data_direction dir, unsigned long attrs,
+		dma_addr_t *dma_handle)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	*dma_handle = ops->map_page(dev, page, offset, size, dir, attrs);
+	if (*dma_handle == DMA_MAPPING_ERROR)
+		return -ENOMEM;
+	debug_dma_map_page(dev, page, offset, size, dir, *dma_handle, false);
+	return 0;
+}
+
+static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
+		size_t offset, size_t size, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
-	addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	addr = ops->map_page(dev, page, offset, size, dir, 0);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
-
 	return addr;
 }
 
@@ -428,11 +454,9 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 
 }
 
-#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
 #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
-#define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
 #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
 
 static inline void
-- 
2.19.1
