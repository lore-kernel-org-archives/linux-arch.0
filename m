Return-Path: <dsaxena@plexity.net>
Received: from fed1mtao05.cox.net ([68.6.19.126]:63688 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S263134AbUC2QgB
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Mar 2004 11:36:01 -0500
Date: Mon, 29 Mar 2004 09:35:59 -0700
From: Deepak Saxena <dsaxena@plexity.net>
Subject: [PATCH 2.6] Allow arch-specific pci_set_dma_mask and friends
Message-ID: <20040329163559.GA10421@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
To: linux-arch@vger.kernel.org
Cc: jgarzik@pobox.com
List-ID: <linux-arch.vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


All,

Apologies for posting this to linux-arch instead of lkml, but Jeff 
Garzik mentioned that this patch is really up to the arch maintainers 
to OK so I am sending it this way for approval.

The patch provides the ability for architectures to have custom
implementations of pci_set_dma_mask() and friends (dac_set_dma_mask
and set_consistent_dma_mask). The reason I need this is b/c I have 
a chipset (Intel ARM IXP425) that has a broken PCI interface that 
only allows PCI dma to/from the bottom 64MB of system memory.  To get 
around this limitation, I trap a custom dma-mapping implementation that 
bounces buffers outside the 64MB window. At device discover time, my 
custom platform_notify() function gets called and it sets the dma_mask 
to (64MB-1) and in ARM's dma-mapping code, I check for dma_mask != 0xffffffff
and if that is true, I call the special bounce helpers. This works great
except that certain drivers (e100, ide-pci) call pci_set_dma_mask()
with 0xffffffff and the generic implementation only allows for the
architecture-defined pci_dma_supported() to return true or false. There
is no method for the architecture to tell the PCI layer "I can't set
the mask to 0xffffffff, but I can set it to this other value" and there
is no way to pass that back to the driver. What this means is that if
I have pci_set_dma_supported() return failure on full 32-bit DMA, the
driver will not initialize the card; however, if I return true, 
pci_set_dma_mask() will set the dma mask to full 32-bits and I can no 
longer trap and will have buffers that are not dma-able and cause 
PCI master aborts.  Both of those are not acceptable.  IMHO, the 
driver shouldn't care if the architecture has to bounce DMA outside of 
64MB and since this is not something most architectures have to worry 
about, the easiest way to get around the issue is by allowing custom 
pci_set_dma_mask() for arches that need it but keeping the generic
implementation for those that do not.  In my case, it simply returns 
0 to the driver but keeps the device mask set to 64MB-1 so I can trap.

If this is acceptable, please apply.

Tnx,
~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and 
 will die here like rotten cabbages." - Number 6

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pci

===== drivers/pci/pci.c 1.63 vs edited =====
--- 1.63/drivers/pci/pci.c	Sun Mar 14 12:17:06 2004
+++ edited/drivers/pci/pci.c	Fri Mar 26 16:58:01 2004
@@ -658,6 +658,10 @@
 	}
 }
 
+#ifndef HAVE_ARCH_PCI_SET_DMA_MASK
+/*
+ * These can be overridden by arch-specific implementations
+ */
 int
 pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 {
@@ -690,6 +694,7 @@
 
 	return 0;
 }
+#endif
      
 static int __devinit pci_init(void)
 {

--xHFwDpU9dbj6ez1V--
