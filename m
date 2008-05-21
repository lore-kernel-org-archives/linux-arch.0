From: Nick Piggin <npiggin@suse.de>
Subject: [rfc] add io barriers, remove mmiowb
Date: Wed, 21 May 2008 17:28:55 +0200
Message-ID: <20080521152855.GE8897@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:36367 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761989AbYEUP25 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 May 2008 11:28:57 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, jbarnes@virtuousgeek.org, Linus Torvalds <torvalds@linux-foundation.org>


With mmiowb, ia64 introduced a completely new type of barrier and subtly
redefined existing barriers, unfortunately. I still hold a faint hope of
fixing this up some day. This is how I'm proposing to do it.

Traditionally, mb() is thought of as "provide a total ordering of all
RAM and device memory accesses at this point", and wmb() as "provide a
total ordering of all RAM and device memory stores at this point".

However, on sn2, this is rather expensive because that platform can
reorder stores to device memory at the chipset, so a mb or wmb would
have to interact with chipset registers. Apparently this penalty was
deemed too high, because mb and wmb were weakened, and  mmiowb was
introduced to solve the problem.

mb and wmb are now no longer guaranteed to order system memory operations
with device memory stores. mmiowb has been introduced to provide this
ordering (when combined with a mb, wmb, or spin_unlock). Unfortunately,
it appears to be rather less well understood among both users and
implementors than even the old memory barrier scheme. It also subtly
breaks existing code that uses mb or wmb (if only on sn2). I really think
it is not a good solution.

The alternative I propose is to restore mb and wmb to their full strength.
This does mean that sn2 has to do the equivalent of mb+mmiowb, wmb+mmiowb
respectively, but that's the price you pay for weak memory ordering.

A large number of callers of wmb actually only appear to want io/io ordering,
so if we introduce io_ barrier variants, then we can actually avoid wmb
in many cases, and the remainder of them genuinely require io/ram ordering,
so sn2 really needs mmiowb there anyway.

io_*mb variants can be optimised on other platforms too, which is a plus.

This patch sketches an implementation for x86, powerpc, ia64, and attempts
to convert all mmiowb() in drivers into their appropriate wmb/io_wmb barrier.

---
Index: linux-2.6/include/asm-ia64/system.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/system.h
+++ linux-2.6/include/asm-ia64/system.h
@@ -82,15 +82,19 @@ extern struct ia64_boot_param {
  * it's (presumably) much slower than mf and (b) mf.a is supported for
  * sequential memory pages only.
  */
-#define mb()	ia64_mf()
-#define rmb()	mb()
+#define mb()	do { ia64_mf(); mmiowb(); } while (0)
+#define rmb()	ia64_mf()
 #define wmb()	mb()
 #define read_barrier_depends()	do { } while(0)
 
+#define io_mb()		ia64_mf()
+#define io_rmb()	io_mb()
+#define io_wmb()	io_mb()
+
 #ifdef CONFIG_SMP
-# define smp_mb()	mb()
-# define smp_rmb()	rmb()
-# define smp_wmb()	wmb()
+# define smp_mb()	ia64_mf()
+# define smp_rmb()	smp_mb()
+# define smp_wmb()	smp_mb()
 # define smp_read_barrier_depends()	read_barrier_depends()
 #else
 # define smp_mb()	barrier()
Index: linux-2.6/include/asm-powerpc/system.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/system.h
+++ linux-2.6/include/asm-powerpc/system.h
@@ -38,6 +38,10 @@
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define read_barrier_depends()  do { } while(0)
 
+#define io_mb()		__asm__ __volatile__ ("eieio" : : : "memory")
+#define io_rmb()	__asm__ __volatile__ ("eieio" : : : "memory")
+#define io_wmb()	barrier()
+
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
 
 #ifdef __KERNEL__
Index: linux-2.6/include/asm-x86/system.h
===================================================================
--- linux-2.6.orig/include/asm-x86/system.h
+++ linux-2.6/include/asm-x86/system.h
@@ -330,6 +330,10 @@ void default_idle(void);
 #define wmb()	asm volatile("sfence" ::: "memory")
 #endif
 
+#define io_mb()		mb()
+#define io_rmb()	rmb()
+#define io_wmb()	wmb()
+
 /**
  * read_barrier_depends - Flush all pending reads that subsequents reads
  * depend on.
Index: linux-2.6/drivers/net/wireless/b43/main.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43/main.c
+++ linux-2.6/drivers/net/wireless/b43/main.c
@@ -357,7 +357,7 @@ static void b43_ram_write(struct b43_wld
 		val = swab32(val);
 
 	b43_write32(dev, B43_MMIO_RAM_CONTROL, offset);
-	mmiowb();
+	io_wmb();
 	b43_write32(dev, B43_MMIO_RAM_DATA, val);
 }
 
@@ -583,9 +583,9 @@ static void b43_tsf_write_locked(struct 
 		u32 hi = (tsf & 0xFFFFFFFF00000000ULL) >> 32;
 
 		b43_write32(dev, B43_MMIO_REV3PLUS_TSF_LOW, 0);
-		mmiowb();
+		io_wmb();
 		b43_write32(dev, B43_MMIO_REV3PLUS_TSF_HIGH, hi);
-		mmiowb();
+		io_wmb();
 		b43_write32(dev, B43_MMIO_REV3PLUS_TSF_LOW, lo);
 	} else {
 		u16 v0 = (tsf & 0x000000000000FFFFULL);
@@ -594,13 +594,13 @@ static void b43_tsf_write_locked(struct 
 		u16 v3 = (tsf & 0xFFFF000000000000ULL) >> 48;
 
 		b43_write16(dev, B43_MMIO_TSF_0, 0);
-		mmiowb();
+		io_wmb();
 		b43_write16(dev, B43_MMIO_TSF_3, v3);
-		mmiowb();
+		io_wmb();
 		b43_write16(dev, B43_MMIO_TSF_2, v2);
-		mmiowb();
+		io_wmb();
 		b43_write16(dev, B43_MMIO_TSF_1, v1);
-		mmiowb();
+		io_wmb();
 		b43_write16(dev, B43_MMIO_TSF_0, v0);
 	}
 }
@@ -1605,7 +1605,7 @@ static void b43_beacon_update_trigger_wo
 		/* The handler might have updated the IRQ mask. */
 		b43_write32(dev, B43_MMIO_GEN_IRQ_MASK,
 			    dev->irq_savedstate);
-		mmiowb();
+		wmb();
 		spin_unlock_irq(&wl->irq_lock);
 	}
 	mutex_unlock(&wl->mutex);
@@ -1713,7 +1713,7 @@ static void b43_interrupt_tasklet(struct
 			       dma_reason[2], dma_reason[3],
 			       dma_reason[4], dma_reason[5]);
 			b43_controller_restart(dev, "DMA error");
-			mmiowb();
+			wmb();
 			spin_unlock_irqrestore(&dev->wl->irq_lock, flags);
 			return;
 		}
@@ -1759,7 +1759,7 @@ static void b43_interrupt_tasklet(struct
 		handle_irq_transmit_status(dev);
 
 	b43_interrupt_enable(dev, dev->irq_savedstate);
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&dev->wl->irq_lock, flags);
 }
 
@@ -1817,7 +1817,7 @@ static irqreturn_t b43_interrupt_handler
 	dev->irq_reason = reason;
 	tasklet_schedule(&dev->isr_tasklet);
       out:
-	mmiowb();
+	wmb();
 	spin_unlock(&dev->wl->irq_lock);
 
 	return ret;
@@ -3295,7 +3295,7 @@ static int b43_op_config(struct ieee8021
 
 	spin_lock_irqsave(&wl->irq_lock, flags);
 	b43_interrupt_enable(dev, savedirqs);
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&wl->irq_lock, flags);
       out_unlock_mutex:
 	mutex_unlock(&wl->mutex);
Index: linux-2.6/drivers/net/wireless/b43/phy.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43/phy.c
+++ linux-2.6/drivers/net/wireless/b43/phy.c
@@ -2428,7 +2428,7 @@ u8 b43_radio_aci_scan(struct b43_wldev *
 void b43_nrssi_hw_write(struct b43_wldev *dev, u16 offset, s16 val)
 {
 	b43_phy_write(dev, B43_PHY_NRSSILT_CTRL, offset);
-	mmiowb();
+	io_wmb();
 	b43_phy_write(dev, B43_PHY_NRSSILT_DATA, (u16) val);
 }
 
Index: linux-2.6/drivers/net/wireless/b43/sysfs.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43/sysfs.c
+++ linux-2.6/drivers/net/wireless/b43/sysfs.c
@@ -122,7 +122,7 @@ static ssize_t b43_attr_interfmode_store
 		b43err(wldev->wl, "Interference Mitigation not "
 		       "supported by device\n");
 	}
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&wldev->wl->irq_lock, flags);
 	mutex_unlock(&wldev->wl->mutex);
 
Index: linux-2.6/drivers/infiniband/hw/ipath/ipath_iba6120.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/ipath/ipath_iba6120.c
+++ linux-2.6/drivers/infiniband/hw/ipath/ipath_iba6120.c
@@ -1351,7 +1351,7 @@ static void ipath_pe_put_tid(struct ipat
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_scratch, 0xfeeddeaf);
 	writel(pa, tidp32);
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_scratch, 0xdeadbeef);
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(tidlockp, flags);
 }
 
@@ -1395,7 +1395,7 @@ static void ipath_pe_put_tid_2(struct ip
 	}
 	tidx = tidptr - dd->ipath_egrtidbase;
 	writel(pa, tidp32);
-	mmiowb();
+	wmb();
 }
 
 
Index: linux-2.6/drivers/infiniband/hw/ipath/ipath_iba7220.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/ipath/ipath_iba7220.c
+++ linux-2.6/drivers/infiniband/hw/ipath/ipath_iba7220.c
@@ -1733,7 +1733,7 @@ static void ipath_7220_put_tid(struct ip
 		writeq(chippa, tidptr);
 	} else
 		writeq(pa, tidptr);
-	mmiowb();
+	wmb();
 }
 
 /**
Index: linux-2.6/drivers/infiniband/hw/ipath/ipath_sd7220.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/ipath/ipath_sd7220.c
+++ linux-2.6/drivers/infiniband/hw/ipath/ipath_sd7220.c
@@ -1036,14 +1036,14 @@ static int ipath_sd_setvals(struct ipath
 	for (idx = 0; idx < NUM_DDS_REGS; ++idx) {
 		data = ((dds_reg_map & 0xF) << 4) | TX_FAST_ELT;
 		writeq(data, iaddr + idx);
-		mmiowb();
+		wmb();
 		ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
 		dds_reg_map >>= 4;
 		for (midx = 0; midx < DDS_ROWS; ++midx) {
 			u64 __iomem *daddr = taddr + ((midx << 4) + idx);
 			data = dds_init_vals[midx].reg_vals[idx];
 			writeq(data, daddr);
-			mmiowb();
+			wmb();
 			ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
 		} /* End inner for (vals for this reg, each row) */
 	} /* end outer for (regs to be stored) */
@@ -1065,13 +1065,13 @@ static int ipath_sd_setvals(struct ipath
 		didx = idx + min_idx;
 		/* Store the next RXEQ register address */
 		writeq(rxeq_init_vals[idx].rdesc, iaddr + didx);
-		mmiowb();
+		wmb();
 		ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
 		/* Iterate through RXEQ values */
 		for (vidx = 0; vidx < 4; vidx++) {
 			data = rxeq_init_vals[idx].rdata[vidx];
 			writeq(data, taddr + (vidx << 6) + idx);
-			mmiowb();
+			wmb();
 			ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
 		}
 	} /* end outer for (Reg-writes for RXEQ) */
Index: linux-2.6/drivers/infiniband/hw/mlx4/qp.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/mlx4/qp.c
+++ linux-2.6/drivers/infiniband/hw/mlx4/qp.c
@@ -1638,7 +1638,7 @@ out:
 		 * Make sure doorbells don't leak out of SQ spinlock
 		 * and reach the HCA out of order.
 		 */
-		mmiowb();
+		wmb();
 
 		stamp_send_wqe(qp, stamp, size * 16);
 
Index: linux-2.6/drivers/infiniband/hw/mthca/mthca_cmd.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ linux-2.6/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -294,7 +294,7 @@ static int mthca_cmd_post(struct mthca_d
 	 * Make sure that our HCR writes don't get mixed in with
 	 * writes from another CPU starting a FW command.
 	 */
-	mmiowb();
+	wmb();
 
 	mutex_unlock(&dev->cmd.hcr_mutex);
 	return err;
Index: linux-2.6/drivers/infiniband/hw/mthca/mthca_cq.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/mthca/mthca_cq.c
+++ linux-2.6/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -216,7 +216,7 @@ static inline void update_cons_index(str
 		 * Make sure doorbells don't leak out of CQ spinlock
 		 * and reach the HCA out of order:
 		 */
-		mmiowb();
+		wmb();
 	}
 }
 
Index: linux-2.6/drivers/infiniband/hw/mthca/mthca_qp.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/mthca/mthca_qp.c
+++ linux-2.6/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1825,7 +1825,7 @@ out:
 		 * Make sure doorbells don't leak out of SQ spinlock
 		 * and reach the HCA out of order:
 		 */
-		mmiowb();
+		wmb();
 	}
 
 	qp->sq.next_ind = ind;
@@ -1940,7 +1940,7 @@ out:
 	 * Make sure doorbells don't leak out of RQ spinlock and reach
 	 * the HCA out of order:
 	 */
-	mmiowb();
+	wmb();
 
 	spin_unlock_irqrestore(&qp->rq.lock, flags);
 	return err;
@@ -2180,7 +2180,7 @@ out:
 	 * Make sure doorbells don't leak out of SQ spinlock and reach
 	 * the HCA out of order:
 	 */
-	mmiowb();
+	wmb();
 
 	spin_unlock_irqrestore(&qp->sq.lock, flags);
 	return err;
Index: linux-2.6/drivers/infiniband/hw/mthca/mthca_srq.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/mthca/mthca_srq.c
+++ linux-2.6/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -587,7 +587,7 @@ int mthca_tavor_post_srq_recv(struct ib_
 	 * Make sure doorbells don't leak out of SRQ spinlock and
 	 * reach the HCA out of order:
 	 */
-	mmiowb();
+	wmb();
 
 	spin_unlock_irqrestore(&srq->lock, flags);
 	return err;
Index: linux-2.6/drivers/memstick/host/jmb38x_ms.c
===================================================================
--- linux-2.6.orig/drivers/memstick/host/jmb38x_ms.c
+++ linux-2.6/drivers/memstick/host/jmb38x_ms.c
@@ -622,7 +622,7 @@ static void jmb38x_ms_reset(struct jmb38
 	}
 
 	writel(HOST_CONTROL_RESET, host->addr + HOST_CONTROL);
-	mmiowb();
+	io_wmb();
 	writel(INT_STATUS_ALL, host->addr + INT_SIGNAL_ENABLE);
 	writel(INT_STATUS_ALL, host->addr + INT_STATUS_ENABLE);
 }
@@ -899,7 +899,7 @@ static void jmb38x_ms_remove(struct pci_
 
 		writel(0, host->addr + INT_SIGNAL_ENABLE);
 		writel(0, host->addr + INT_STATUS_ENABLE);
-		mmiowb();
+		wmb();
 		dev_dbg(&jm->pdev->dev, "interrupts off\n");
 		spin_lock_irqsave(&host->lock, flags);
 		if (host->req) {
Index: linux-2.6/drivers/misc/ioc4.c
===================================================================
--- linux-2.6.orig/drivers/misc/ioc4.c
+++ linux-2.6/drivers/misc/ioc4.c
@@ -156,7 +156,7 @@ ioc4_clock_calibrate(struct ioc4_driver_
 
 	/* Reset to power-on state */
 	writel(0, &idd->idd_misc_regs->int_out.raw);
-	mmiowb();
+	io_wmb();
 
 	/* Set up square wave */
 	int_out.raw = 0;
@@ -164,7 +164,7 @@ ioc4_clock_calibrate(struct ioc4_driver_
 	int_out.fields.mode = IOC4_INT_OUT_MODE_TOGGLE;
 	int_out.fields.diag = 0;
 	writel(int_out.raw, &idd->idd_misc_regs->int_out.raw);
-	mmiowb();
+	io_wmb();
 
 	/* Check square wave period averaged over some number of cycles */
 	do {
Index: linux-2.6/drivers/misc/tifm_7xx1.c
===================================================================
--- linux-2.6.orig/drivers/misc/tifm_7xx1.c
+++ linux-2.6/drivers/misc/tifm_7xx1.c
@@ -397,7 +397,7 @@ static void tifm_7xx1_remove(struct pci_
 	fm->eject = tifm_7xx1_dummy_eject;
 	fm->has_ms_pif = tifm_7xx1_dummy_has_ms_pif;
 	writel(TIFM_IRQ_SETALL, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
-	mmiowb();
+	wmb();
 	free_irq(dev->irq, fm);
 
 	tifm_remove_adapter(fm);
Index: linux-2.6/drivers/mmc/host/sdhci.c
===================================================================
--- linux-2.6.orig/drivers/mmc/host/sdhci.c
+++ linux-2.6/drivers/mmc/host/sdhci.c
@@ -809,7 +809,7 @@ static void sdhci_request(struct mmc_hos
 	} else
 		sdhci_send_command(host, mrq->cmd);
 
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -861,7 +861,7 @@ static void sdhci_set_ios(struct mmc_hos
 	if(host->chip->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
 		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -901,7 +901,7 @@ static void sdhci_enable_sdio_irq(struct
 	writel(ier, host->ioaddr + SDHCI_INT_ENABLE);
 	writel(ier, host->ioaddr + SDHCI_SIGNAL_ENABLE);
 
-	mmiowb();
+	wmb();
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
@@ -995,7 +995,7 @@ static void sdhci_tasklet_finish(unsigne
 	sdhci_deactivate_led(host);
 #endif
 
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	mmc_request_done(host->mmc, mrq);
@@ -1028,7 +1028,7 @@ static void sdhci_timeout_timer(unsigned
 		}
 	}
 
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -1183,7 +1183,7 @@ static irqreturn_t sdhci_irq(int irq, vo
 
 	result = IRQ_HANDLED;
 
-	mmiowb();
+	wmb();
 out:
 	spin_unlock(&host->lock);
 
@@ -1269,7 +1269,7 @@ static int sdhci_resume (struct pci_dev 
 		if (ret)
 			return ret;
 		sdhci_init(chip->hosts[i]);
-		mmiowb();
+		wmb();
 		ret = mmc_resume_host(chip->hosts[i]->mmc);
 		if (ret)
 			return ret;
@@ -1528,7 +1528,7 @@ static int __devinit sdhci_probe_slot(st
 		goto reset;
 #endif
 
-	mmiowb();
+	wmb();
 
 	mmc_add_host(mmc);
 
Index: linux-2.6/drivers/mmc/host/tifm_sd.c
===================================================================
--- linux-2.6.orig/drivers/mmc/host/tifm_sd.c
+++ linux-2.6/drivers/mmc/host/tifm_sd.c
@@ -888,7 +888,7 @@ static int tifm_sd_initialize_host(struc
 	struct tifm_dev *sock = host->dev;
 
 	writel(0, sock->addr + SOCK_MMCSD_INT_ENABLE);
-	mmiowb();
+	io_wmb();
 	host->clk_div = 61;
 	host->clk_freq = 20000000;
 	writel(TIFM_MMCSD_RESET, sock->addr + SOCK_MMCSD_SYSTEM_CONTROL);
@@ -940,7 +940,7 @@ static int tifm_sd_initialize_host(struc
 	writel(TIFM_MMCSD_CERR | TIFM_MMCSD_BRS | TIFM_MMCSD_EOC
 	       | TIFM_MMCSD_ERRMASK,
 	       sock->addr + SOCK_MMCSD_INT_ENABLE);
-	mmiowb();
+	wmb();
 
 	return 0;
 }
@@ -1006,7 +1006,7 @@ static void tifm_sd_remove(struct tifm_d
 	spin_lock_irqsave(&sock->lock, flags);
 	host->eject = 1;
 	writel(0, sock->addr + SOCK_MMCSD_INT_ENABLE);
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&sock->lock, flags);
 
 	tasklet_kill(&host->finish_tasklet);
Index: linux-2.6/drivers/net/bnx2.c
===================================================================
--- linux-2.6.orig/drivers/net/bnx2.c
+++ linux-2.6/drivers/net/bnx2.c
@@ -2880,7 +2880,7 @@ next_rx:
 
 	REG_WR(bp, MB_RX_CID_ADDR + BNX2_L2CTX_HOST_BSEQ, bnapi->rx_prod_bseq);
 
-	mmiowb();
+	wmb();
 
 	return rx_pkt;
 
@@ -5886,7 +5886,7 @@ bnx2_start_xmit(struct sk_buff *skb, str
 	REG_WR16(bp, bp->tx_bidx_addr, prod);
 	REG_WR(bp, bp->tx_bseq_addr, bp->tx_prod_bseq);
 
-	mmiowb();
+	wmb();
 
 	bp->tx_prod = prod;
 	dev->trans_start = jiffies;
Index: linux-2.6/drivers/net/bnx2x.c
===================================================================
--- linux-2.6.orig/drivers/net/bnx2x.c
+++ linux-2.6/drivers/net/bnx2x.c
@@ -1046,7 +1046,7 @@ next_cqe:
 	REG_WR(bp, BAR_TSTRORM_INTMEM +
 	       TSTORM_RCQ_PROD_OFFSET(bp->port, fp->index), sw_comp_prod);
 
-	mmiowb(); /* keep prod updates ordered */
+	wmb(); /* keep prod updates ordered */
 
 	fp->rx_pkt += rx_pkt;
 	fp->rx_calls++;
@@ -9413,7 +9413,7 @@ static int bnx2x_start_xmit(struct sk_bu
 		cpu_to_le32(le32_to_cpu(fp->hw_tx_prods->packets_prod) + 1);
 	DOORBELL(bp, fp_index, 0);
 
-	mmiowb();
+	wmb();
 
 	fp->tx_bd_prod = bd_prod;
 	dev->trans_start = jiffies;
Index: linux-2.6/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.orig/drivers/net/e1000/e1000_main.c
+++ linux-2.6/drivers/net/e1000/e1000_main.c
@@ -3222,8 +3222,8 @@ e1000_tx_queue(struct e1000_adapter *ada
 	tx_ring->next_to_use = i;
 	writel(i, adapter->hw.hw_addr + tx_ring->tdt);
 	/* we need this if more than one processor can write to our tail
-	 * at a time, it syncronizes IO on IA64/Altix systems */
-	mmiowb();
+	 * at a time */
+	wmb();
 }
 
 /**
Index: linux-2.6/drivers/net/e1000e/netdev.c
===================================================================
--- linux-2.6.orig/drivers/net/e1000e/netdev.c
+++ linux-2.6/drivers/net/e1000e/netdev.c
@@ -3467,9 +3467,9 @@ static void e1000_tx_queue(struct e1000_
 	writel(i, adapter->hw.hw_addr + tx_ring->tail);
 	/*
 	 * we need this if more than one processor can write to our tail
-	 * at a time, it synchronizes IO on IA64/Altix systems
+	 * at a time.
 	 */
-	mmiowb();
+	wmb();
 }
 
 #define MINIMUM_DHCP_PACKET_SIZE 282
Index: linux-2.6/drivers/net/igb/igb_main.c
===================================================================
--- linux-2.6.orig/drivers/net/igb/igb_main.c
+++ linux-2.6/drivers/net/igb/igb_main.c
@@ -2637,8 +2637,8 @@ static inline void igb_tx_queue_adv(stru
 	tx_ring->next_to_use = i;
 	writel(i, adapter->hw.hw_addr + tx_ring->tail);
 	/* we need this if more than one processor can write to our tail
-	 * at a time, it syncronizes IO on IA64/Altix systems */
-	mmiowb();
+	 * at a time */
+	wmb();
 }
 
 static int __igb_maybe_stop_tx(struct net_device *netdev,
Index: linux-2.6/drivers/net/ipg.c
===================================================================
--- linux-2.6.orig/drivers/net/ipg.c
+++ linux-2.6/drivers/net/ipg.c
@@ -1965,7 +1965,7 @@ static int ipg_nic_hard_start_xmit(struc
 
 	sp->tx_current++;
 
-	mmiowb();
+	wmb();
 
 	ipg_w32(IPG_DC_TX_DMA_POLL_NOW, DMA_CTRL);
 
Index: linux-2.6/drivers/net/mlx4/cmd.c
===================================================================
--- linux-2.6.orig/drivers/net/mlx4/cmd.c
+++ linux-2.6/drivers/net/mlx4/cmd.c
@@ -190,7 +190,7 @@ static int mlx4_cmd_post(struct mlx4_dev
 	 * Make sure that our HCR writes don't get mixed in with
 	 * writes from another CPU starting a FW command.
 	 */
-	mmiowb();
+	wmb();
 
 	cmd->toggle = cmd->toggle ^ 1;
 
Index: linux-2.6/drivers/net/pcnet32.c
===================================================================
--- linux-2.6.orig/drivers/net/pcnet32.c
+++ linux-2.6/drivers/net/pcnet32.c
@@ -1407,7 +1407,7 @@ static int pcnet32_poll(struct napi_stru
 
 		/* Set interrupt enable. */
 		lp->a.write_csr(ioaddr, CSR0, CSR0_INTEN);
-		mmiowb();
+		wmb();
 		spin_unlock_irqrestore(&lp->lock, flags);
 	}
 	return work_done;
@@ -2594,7 +2594,7 @@ pcnet32_interrupt(int irq, void *dev_id)
 			val = lp->a.read_csr(ioaddr, CSR3);
 			val |= 0x5f00;
 			lp->a.write_csr(ioaddr, CSR3, val);
-			mmiowb();
+			wmb();
 			__netif_rx_schedule(dev, &lp->napi);
 			break;
 		}
Index: linux-2.6/drivers/net/s2io.c
===================================================================
--- linux-2.6.orig/drivers/net/s2io.c
+++ linux-2.6/drivers/net/s2io.c
@@ -4285,7 +4285,7 @@ static int s2io_xmit(struct sk_buff *skb
 
 	writeq(val64, &tx_fifo->List_Control);
 
-	mmiowb();
+	wmb();
 
 	put_off++;
 	if (put_off == fifo->tx_curr_put_info.fifo_len + 1)
Index: linux-2.6/drivers/net/sc92031.c
===================================================================
--- linux-2.6.orig/drivers/net/sc92031.c
+++ linux-2.6/drivers/net/sc92031.c
@@ -261,7 +261,7 @@ enum PMConfigBits {
  * use of mdelay() at _sc92031_reset.
  * Functions prefixed with _sc92031_ must be called with the lock held;
  * functions prefixed with sc92031_ must be called without the lock held.
- * Use mmiowb() before unlocking if the hardware was written to.
+ * Use wmb() before unlocking if the hardware was written to.
  */
 
 /* Locking rules for the interrupt:
@@ -371,7 +371,7 @@ static void sc92031_disable_interrupts(s
 	/* stop interrupts */
 	iowrite32(0, port_base + IntrMask);
 	_sc92031_dummy_read(port_base);
-	mmiowb();
+	wmb();
 
 	/* wait for any concurrent interrupt/tasklet to finish */
 	synchronize_irq(dev->irq);
@@ -389,7 +389,7 @@ static void sc92031_enable_interrupts(st
 	wmb();
 
 	iowrite32(IntrBits, port_base + IntrMask);
-	mmiowb();
+	wmb();
 }
 
 static void _sc92031_disable_tx_rx(struct net_device *dev)
@@ -880,7 +880,7 @@ out:
 	rmb();
 
 	iowrite32(intr_mask, port_base + IntrMask);
-	mmiowb();
+	wmb();
 
 	spin_unlock(&priv->lock);
 }
@@ -914,7 +914,7 @@ out_none:
 	rmb();
 
 	iowrite32(intr_mask, port_base + IntrMask);
-	mmiowb();
+	wmb();
 
 	return IRQ_NONE;
 }
@@ -988,7 +988,7 @@ static int sc92031_start_xmit(struct sk_
 	iowrite32(priv->tx_bufs_dma_addr + entry * TX_BUF_SIZE,
 			port_base + TxAddr0 + entry * 4);
 	iowrite32(tx_status, port_base + TxStatus0 + entry * 4);
-	mmiowb();
+	wmb();
 
 	dev->trans_start = jiffies;
 
@@ -1036,7 +1036,7 @@ static int sc92031_open(struct net_devic
 	spin_lock_bh(&priv->lock);
 
 	_sc92031_reset(dev);
-	mmiowb();
+	wmb();
 
 	spin_unlock_bh(&priv->lock);
 	sc92031_enable_interrupts(dev);
@@ -1072,7 +1072,7 @@ static int sc92031_stop(struct net_devic
 
 	_sc92031_disable_tx_rx(dev);
 	_sc92031_tx_clear(dev);
-	mmiowb();
+	wmb();
 
 	spin_unlock_bh(&priv->lock);
 
@@ -1093,7 +1093,7 @@ static void sc92031_set_multicast_list(s
 
 	_sc92031_set_mar(dev);
 	_sc92031_set_rx_config(dev);
-	mmiowb();
+	wmb();
 
 	spin_unlock_bh(&priv->lock);
 }
@@ -1110,7 +1110,7 @@ static void sc92031_tx_timeout(struct ne
 	priv->tx_timeouts++;
 
 	_sc92031_reset(dev);
-	mmiowb();
+	wmb();
 
 	spin_unlock(&priv->lock);
 
@@ -1147,7 +1147,7 @@ static int sc92031_ethtool_get_settings(
 
 	output_status = _sc92031_mii_read(port_base, MII_OutputStatus);
 	_sc92031_mii_scan(port_base);
-	mmiowb();
+	wmb();
 
 	spin_unlock_bh(&priv->lock);
 
@@ -1318,7 +1318,7 @@ static int sc92031_ethtool_set_wol(struc
 
 	priv->pm_config = pm_config;
 	iowrite32(pm_config, port_base + PMConfig);
-	mmiowb();
+	wmb();
 
 	spin_unlock_bh(&priv->lock);
 
@@ -1344,7 +1344,7 @@ static int sc92031_ethtool_nway_reset(st
 
 out:
 	_sc92031_mii_scan(port_base);
-	mmiowb();
+	wmb();
 
 	spin_unlock_bh(&priv->lock);
 
@@ -1535,7 +1535,7 @@ static int sc92031_suspend(struct pci_de
 
 	_sc92031_disable_tx_rx(dev);
 	_sc92031_tx_clear(dev);
-	mmiowb();
+	wmb();
 
 	spin_unlock_bh(&priv->lock);
 
@@ -1560,7 +1560,7 @@ static int sc92031_resume(struct pci_dev
 	spin_lock_bh(&priv->lock);
 
 	_sc92031_reset(dev);
-	mmiowb();
+	wmb();
 
 	spin_unlock_bh(&priv->lock);
 	sc92031_enable_interrupts(dev);
Index: linux-2.6/drivers/net/sfc/falcon_io.h
===================================================================
--- linux-2.6.orig/drivers/net/sfc/falcon_io.h
+++ linux-2.6/drivers/net/sfc/falcon_io.h
@@ -77,16 +77,16 @@ static inline void falcon_write(struct e
 	spin_lock_irqsave(&efx->biu_lock, flags);
 #ifdef FALCON_USE_QWORD_IO
 	_falcon_writeq(efx, value->u64[0], reg + 0);
-	wmb();
+	io_wmb();
 	_falcon_writeq(efx, value->u64[1], reg + 8);
 #else
 	_falcon_writel(efx, value->u32[0], reg + 0);
 	_falcon_writel(efx, value->u32[1], reg + 4);
 	_falcon_writel(efx, value->u32[2], reg + 8);
-	wmb();
+	io_wmb();
 	_falcon_writel(efx, value->u32[3], reg + 12);
 #endif
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&efx->biu_lock, flags);
 }
 
@@ -105,10 +105,10 @@ static inline void falcon_write_sram(str
 	_falcon_writeq(efx, value->u64[0], reg + 0);
 #else
 	_falcon_writel(efx, value->u32[0], reg + 0);
-	wmb();
+	io_wmb();
 	_falcon_writel(efx, value->u32[1], reg + 4);
 #endif
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&efx->biu_lock, flags);
 }
 
Index: linux-2.6/drivers/net/sky2.c
===================================================================
--- linux-2.6.orig/drivers/net/sky2.c
+++ linux-2.6/drivers/net/sky2.c
@@ -976,7 +976,7 @@ static inline void sky2_put_idx(struct s
 	sky2_write16(hw, Y2_QADDR(q, PREF_UNIT_PUT_IDX), idx);
 
 	/* Synchronize I/O on since next processor may write to tail */
-	mmiowb();
+	wmb();
 }
 
 
@@ -1098,7 +1098,7 @@ stopped:
 
 	/* reset the Rx prefetch unit */
 	sky2_write32(hw, Y2_QADDR(rxq, PREF_UNIT_CTRL), PREF_UNIT_RST_SET);
-	mmiowb();
+	wmb();
 }
 
 /* Clean out receive buffer area, assumes receiver hardware stopped */
Index: linux-2.6/drivers/net/tg3.c
===================================================================
--- linux-2.6.orig/drivers/net/tg3.c
+++ linux-2.6/drivers/net/tg3.c
@@ -641,7 +641,7 @@ static void tg3_restart_ints(struct tg3 
 {
 	tw32_mailbox(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW,
 		     tp->last_tag << 24);
-	mmiowb();
+	wmb();
 
 	/* When doing tagged status, this work check is unnecessary.
 	 * The last_tag we write above tells the chip which piece of
@@ -3811,7 +3811,7 @@ next_pkt_nopost:
 		tw32_rx_mbox(MAILBOX_RCV_JUMBO_PROD_IDX + TG3_64BIT_REG_LOW,
 			     sw_idx);
 	}
-	mmiowb();
+	wmb();
 
 	return received;
 }
@@ -4402,7 +4402,7 @@ static int tg3_start_xmit(struct sk_buff
 	}
 
 out_unlock:
-    	mmiowb();
+    	wmb();
 
 	dev->trans_start = jiffies;
 
@@ -4613,7 +4613,7 @@ static int tg3_start_xmit_dma_bug(struct
 	}
 
 out_unlock:
-    	mmiowb();
+    	wmb();
 
 	dev->trans_start = jiffies;
 
Index: linux-2.6/drivers/net/wireless/b43legacy/ilt.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43legacy/ilt.c
+++ linux-2.6/drivers/net/wireless/b43legacy/ilt.c
@@ -315,14 +315,14 @@ const u16 b43legacy_ilt_sigmasqr2[B43leg
 void b43legacy_ilt_write(struct b43legacy_wldev *dev, u16 offset, u16 val)
 {
 	b43legacy_phy_write(dev, B43legacy_PHY_ILT_G_CTRL, offset);
-	mmiowb();
+	io_wmb();
 	b43legacy_phy_write(dev, B43legacy_PHY_ILT_G_DATA1, val);
 }
 
 void b43legacy_ilt_write32(struct b43legacy_wldev *dev, u16 offset, u32 val)
 {
 	b43legacy_phy_write(dev, B43legacy_PHY_ILT_G_CTRL, offset);
-	mmiowb();
+	io_wmb();
 	b43legacy_phy_write(dev, B43legacy_PHY_ILT_G_DATA2,
 			    (val & 0xFFFF0000) >> 16);
 	b43legacy_phy_write(dev, B43legacy_PHY_ILT_G_DATA1,
Index: linux-2.6/drivers/net/wireless/b43legacy/main.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43legacy/main.c
+++ linux-2.6/drivers/net/wireless/b43legacy/main.c
@@ -240,7 +240,7 @@ static void b43legacy_ram_write(struct b
 		val = swab32(val);
 
 	b43legacy_write32(dev, B43legacy_MMIO_RAM_CONTROL, offset);
-	mmiowb();
+	io_wmb();
 	b43legacy_write32(dev, B43legacy_MMIO_RAM_DATA, val);
 }
 
@@ -317,14 +317,14 @@ void b43legacy_shm_write32(struct b43leg
 		if (offset & 0x0003) {
 			/* Unaligned access */
 			b43legacy_shm_control_word(dev, routing, offset >> 2);
-			mmiowb();
+			io_wmb();
 			b43legacy_write16(dev,
 					  B43legacy_MMIO_SHM_DATA_UNALIGNED,
 					  (value >> 16) & 0xffff);
-			mmiowb();
+			io_wmb();
 			b43legacy_shm_control_word(dev, routing,
 						   (offset >> 2) + 1);
-			mmiowb();
+			io_wmb();
 			b43legacy_write16(dev, B43legacy_MMIO_SHM_DATA,
 					  value & 0xffff);
 			return;
@@ -332,7 +332,7 @@ void b43legacy_shm_write32(struct b43leg
 		offset >>= 2;
 	}
 	b43legacy_shm_control_word(dev, routing, offset);
-	mmiowb();
+	io_wmb();
 	b43legacy_write32(dev, B43legacy_MMIO_SHM_DATA, value);
 }
 
@@ -344,7 +344,7 @@ void b43legacy_shm_write16(struct b43leg
 		if (offset & 0x0003) {
 			/* Unaligned access */
 			b43legacy_shm_control_word(dev, routing, offset >> 2);
-			mmiowb();
+			io_wmb();
 			b43legacy_write16(dev,
 					  B43legacy_MMIO_SHM_DATA_UNALIGNED,
 					  value);
@@ -353,7 +353,7 @@ void b43legacy_shm_write16(struct b43leg
 		offset >>= 2;
 	}
 	b43legacy_shm_control_word(dev, routing, offset);
-	mmiowb();
+	io_wmb();
 	b43legacy_write16(dev, B43legacy_MMIO_SHM_DATA, value);
 }
 
@@ -447,7 +447,7 @@ static void b43legacy_time_lock(struct b
 	status = b43legacy_read32(dev, B43legacy_MMIO_MACCTL);
 	status |= B43legacy_MACCTL_TBTTHOLD;
 	b43legacy_write32(dev, B43legacy_MMIO_MACCTL, status);
-	mmiowb();
+	wmb();
 }
 
 static void b43legacy_time_unlock(struct b43legacy_wldev *dev)
@@ -470,10 +470,10 @@ static void b43legacy_tsf_write_locked(s
 		u32 hi = (tsf & 0xFFFFFFFF00000000ULL) >> 32;
 
 		b43legacy_write32(dev, B43legacy_MMIO_REV3PLUS_TSF_LOW, 0);
-		mmiowb();
+		io_wmb();
 		b43legacy_write32(dev, B43legacy_MMIO_REV3PLUS_TSF_HIGH,
 				    hi);
-		mmiowb();
+		io_wmb();
 		b43legacy_write32(dev, B43legacy_MMIO_REV3PLUS_TSF_LOW,
 				    lo);
 	} else {
@@ -483,13 +483,13 @@ static void b43legacy_tsf_write_locked(s
 		u16 v3 = (tsf & 0xFFFF000000000000ULL) >> 48;
 
 		b43legacy_write16(dev, B43legacy_MMIO_TSF_0, 0);
-		mmiowb();
+		io_wmb();
 		b43legacy_write16(dev, B43legacy_MMIO_TSF_3, v3);
-		mmiowb();
+		io_wmb();
 		b43legacy_write16(dev, B43legacy_MMIO_TSF_2, v2);
-		mmiowb();
+		io_wmb();
 		b43legacy_write16(dev, B43legacy_MMIO_TSF_1, v1);
-		mmiowb();
+		io_wmb();
 		b43legacy_write16(dev, B43legacy_MMIO_TSF_0, v0);
 	}
 }
@@ -1271,7 +1271,7 @@ static void b43legacy_interrupt_tasklet(
 			       dma_reason[2], dma_reason[3],
 			       dma_reason[4], dma_reason[5]);
 			b43legacy_controller_restart(dev, "DMA error");
-			mmiowb();
+			wmb();
 			spin_unlock_irqrestore(&dev->wl->irq_lock, flags);
 			return;
 		}
@@ -1321,7 +1321,7 @@ static void b43legacy_interrupt_tasklet(
 		handle_irq_transmit_status(dev);
 
 	b43legacy_interrupt_enable(dev, dev->irq_savedstate);
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&dev->wl->irq_lock, flags);
 }
 
@@ -1414,7 +1414,7 @@ static irqreturn_t b43legacy_interrupt_h
 	dev->irq_reason = reason;
 	tasklet_schedule(&dev->isr_tasklet);
 out:
-	mmiowb();
+	wmb();
 	spin_unlock(&dev->wl->irq_lock);
 
 	return ret;
@@ -2661,7 +2661,7 @@ static int b43legacy_op_dev_config(struc
 
 	spin_lock_irqsave(&wl->irq_lock, flags);
 	b43legacy_interrupt_enable(dev, savedirqs);
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&wl->irq_lock, flags);
 out_unlock_mutex:
 	mutex_unlock(&wl->mutex);
Index: linux-2.6/drivers/net/wireless/b43legacy/phy.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43legacy/phy.c
+++ linux-2.6/drivers/net/wireless/b43legacy/phy.c
@@ -132,7 +132,7 @@ u16 b43legacy_phy_read(struct b43legacy_
 void b43legacy_phy_write(struct b43legacy_wldev *dev, u16 offset, u16 val)
 {
 	b43legacy_write16(dev, B43legacy_MMIO_PHY_CONTROL, offset);
-	mmiowb();
+	io_wmb();
 	b43legacy_write16(dev, B43legacy_MMIO_PHY_DATA, val);
 }
 
Index: linux-2.6/drivers/net/wireless/b43legacy/pio.h
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43legacy/pio.h
+++ linux-2.6/drivers/net/wireless/b43legacy/pio.h
@@ -96,7 +96,7 @@ void b43legacy_pio_write(struct b43legac
 		       u16 offset, u16 value)
 {
 	b43legacy_write16(queue->dev, queue->mmio_base + offset, value);
-	mmiowb();
+	wmb();
 }
 
 
Index: linux-2.6/drivers/net/wireless/b43legacy/radio.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43legacy/radio.c
+++ linux-2.6/drivers/net/wireless/b43legacy/radio.c
@@ -95,7 +95,7 @@ void b43legacy_radio_lock(struct b43lega
 	B43legacy_WARN_ON(status & B43legacy_MACCTL_RADIOLOCK);
 	status |= B43legacy_MACCTL_RADIOLOCK;
 	b43legacy_write32(dev, B43legacy_MMIO_MACCTL, status);
-	mmiowb();
+	wmb();
 	udelay(10);
 }
 
@@ -108,7 +108,7 @@ void b43legacy_radio_unlock(struct b43le
 	B43legacy_WARN_ON(!(status & B43legacy_MACCTL_RADIOLOCK));
 	status &= ~B43legacy_MACCTL_RADIOLOCK;
 	b43legacy_write32(dev, B43legacy_MMIO_MACCTL, status);
-	mmiowb();
+	wmb();
 }
 
 u16 b43legacy_radio_read16(struct b43legacy_wldev *dev, u16 offset)
@@ -141,7 +141,7 @@ u16 b43legacy_radio_read16(struct b43leg
 void b43legacy_radio_write16(struct b43legacy_wldev *dev, u16 offset, u16 val)
 {
 	b43legacy_write16(dev, B43legacy_MMIO_RADIO_CONTROL, offset);
-	mmiowb();
+	io_wmb();
 	b43legacy_write16(dev, B43legacy_MMIO_RADIO_DATA_LOW, val);
 }
 
@@ -333,7 +333,7 @@ u8 b43legacy_radio_aci_scan(struct b43le
 void b43legacy_nrssi_hw_write(struct b43legacy_wldev *dev, u16 offset, s16 val)
 {
 	b43legacy_phy_write(dev, B43legacy_PHY_NRSSILT_CTRL, offset);
-	mmiowb();
+	io_wmb();
 	b43legacy_phy_write(dev, B43legacy_PHY_NRSSILT_DATA, (u16)val);
 }
 
Index: linux-2.6/drivers/net/wireless/b43legacy/sysfs.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43legacy/sysfs.c
+++ linux-2.6/drivers/net/wireless/b43legacy/sysfs.c
@@ -143,7 +143,7 @@ static ssize_t b43legacy_attr_interfmode
 	if (err)
 		b43legacyerr(wldev->wl, "Interference Mitigation not "
 		       "supported by device\n");
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&wldev->wl->irq_lock, flags);
 	mutex_unlock(&wldev->wl->mutex);
 
Index: linux-2.6/drivers/scsi/qla1280.c
===================================================================
--- linux-2.6.orig/drivers/scsi/qla1280.c
+++ linux-2.6/drivers/scsi/qla1280.c
@@ -2994,7 +2994,7 @@ qla1280_64bit_start_scsi(struct scsi_qla
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
 	/* Enforce mmio write ordering; see comment in qla1280_isp_cmd(). */
-	mmiowb();
+	wmb();
 
  out:
 	if (status)
@@ -3244,7 +3244,7 @@ qla1280_32bit_start_scsi(struct scsi_qla
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
 	/* Enforce mmio write ordering; see comment in qla1280_isp_cmd(). */
-	mmiowb();
+	wmb();
 
 out:
 	if (status)
@@ -3356,19 +3356,19 @@ qla1280_isp_cmd(struct scsi_qla_host *ha
 
 	/*
 	 * Update request index to mailbox4 (Request Queue In).
-	 * The mmiowb() ensures that this write is ordered with writes by other
-	 * CPUs.  Without the mmiowb(), it is possible for the following:
+	 * The wmb() ensures that this write is ordered with writes by other
+	 * CPUs.  Without the wmb(), it is possible for the following:
 	 *    CPUA posts write of index 5 to mailbox4
 	 *    CPUA releases host lock
 	 *    CPUB acquires host lock
 	 *    CPUB posts write of index 6 to mailbox4
 	 *    On PCI bus, order reverses and write of 6 posts, then index 5,
 	 *       causing chip to issue full queue of stale commands
-	 * The mmiowb() prevents future writes from crossing the barrier.
+	 * The wmb() prevents future writes from crossing the barrier.
 	 * See Documentation/DocBook/deviceiobook.tmpl for more information.
 	 */
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	mmiowb();
+	wmb();
 
 	LEAVE("qla1280_isp_cmd");
 }
Index: linux-2.6/drivers/serial/serial_txx9.c
===================================================================
--- linux-2.6.orig/drivers/serial/serial_txx9.c
+++ linux-2.6/drivers/serial/serial_txx9.c
@@ -252,7 +252,7 @@ static void serial_txx9_initialize(struc
 	sio_out(up, TXX9_SIFCR, TXX9_SIFCR_SWRST);
 	/* TX4925 BUG WORKAROUND.  Accessing SIOC register
 	 * immediately after soft reset causes bus error. */
-	mmiowb();
+	io_wmb();
 	udelay(1);
 	while ((sio_in(up, TXX9_SIFCR) & TXX9_SIFCR_SWRST) && --tmout)
 		udelay(1);
Index: linux-2.6/drivers/ssb/pci.c
===================================================================
--- linux-2.6.orig/drivers/ssb/pci.c
+++ linux-2.6/drivers/ssb/pci.c
@@ -279,7 +279,7 @@ static int sprom_do_write(struct ssb_bus
 		else if (i % 2)
 			ssb_printk(".");
 		writew(sprom[i], bus->mmio + SSB_SPROM_BASE + (i * 2));
-		mmiowb();
+		io_wmb();
 		msleep(20);
 	}
 	err = pci_read_config_dword(pdev, SSB_SPROMCTL, &spromctl);
Index: linux-2.6/drivers/ssb/pcmcia.c
===================================================================
--- linux-2.6.orig/drivers/ssb/pcmcia.c
+++ linux-2.6/drivers/ssb/pcmcia.c
@@ -353,7 +353,7 @@ static void ssb_pcmcia_write8(struct ssb
 	err = select_core_and_segment(dev, &offset);
 	if (likely(!err))
 		writeb(value, bus->mmio + offset);
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&bus->bar_lock, flags);
 }
 
@@ -367,7 +367,7 @@ static void ssb_pcmcia_write16(struct ss
 	err = select_core_and_segment(dev, &offset);
 	if (likely(!err))
 		writew(value, bus->mmio + offset);
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&bus->bar_lock, flags);
 }
 
@@ -383,7 +383,7 @@ static void ssb_pcmcia_write32(struct ss
 		writew((value & 0x0000FFFF), bus->mmio + offset);
 		writew(((value & 0xFFFF0000) >> 16), bus->mmio + offset + 2);
 	}
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&bus->bar_lock, flags);
 }
 
@@ -439,7 +439,7 @@ static void ssb_pcmcia_block_write(struc
 		SSB_WARN_ON(1);
 	}
 unlock:
-	mmiowb();
+	wmb();
 	spin_unlock_irqrestore(&bus->bar_lock, flags);
 }
 #endif /* CONFIG_SSB_BLOCKIO */
