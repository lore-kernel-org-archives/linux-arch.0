From: Christoph Hellwig <hch@lst.de>
Subject: next take at setting up a dma mask by default for platform devices v2
Date: Fri, 16 Aug 2019 08:24:29 +0200
Message-ID: <20190816062435.881-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

Hi all,

this is another attempt to make sure the dma_mask pointer is always
initialized for platform devices.  Not doing so lead to lots of
boilerplate code, and makes platform devices different from all our
major busses like PCI where we always set up a dma_mask.  In the long
run this should also help to eventually make dma_mask a scalar value
instead of a pointer and remove even more cruft.

The bigger blocker for this last time was the fact that the usb
subsystem uses the presence or lack of a dma_mask to check if the core
should do dma mapping for the driver, which is highly unusual.  So we
fix this first.  Note that this has some overlap with the pending
desire to use the proper dma_mmap_coherent helper for mapping usb
buffers.  The first two patches have already been queued up by Greg
and are only included for completeness.

Changes since v1:
 - fix a compile error in the ppc of ohci driver
 - revamp the last patch to get rid of the archdata callout entirely.
