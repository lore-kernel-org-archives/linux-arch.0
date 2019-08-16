From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] usb: don't create dma pools for HCDs with a localmem_pool
Date: Fri, 16 Aug 2019 08:24:30 +0200
Message-ID: <20190816062435.881-2-hch@lst.de>
References: <20190816062435.881-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190816062435.881-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: linux-arch@vger.kernel.org, Gavin Li <git@thegavinli.com>, linuxppc-dev@lists.ozlabs.org, Mathias Nyman <mathias.nyman@intel.com>, Geoff Levand <geoff@infradead.org>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Alan Stern <stern@rowland.harvard.edu>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Minas Harutyunyan <hminas@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-arch.vger.kernel.org

If the HCD provides a localmem pool we will never use the DMA pools, so
don't create them.

Fixes: b0310c2f09bb ("USB: use genalloc for USB HCs with local memory")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/core/buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 1359b78a624e..1a5b3dcae930 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -66,9 +66,9 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 	char		name[16];
 	int		i, size;
 
-	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
-	    (!is_device_dma_capable(hcd->self.sysdev) &&
-	     !hcd->localmem_pool))
+	if (hcd->localmem_pool ||
+	    !IS_ENABLED(CONFIG_HAS_DMA) ||
+	    !is_device_dma_capable(hcd->self.sysdev))
 		return 0;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
-- 
2.20.1
