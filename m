From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/4] ARC: allow to use IOC and non-IOC DMA devices simultaneously
Date: Tue, 24 Jul 2018 13:09:57 +0300
Message-ID: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-arch.vger.kernel.org

The ARC HS processor provides an IOC port (I/O coherency bus
interface) that allows external devices such as DMA devices
to access memory through the cache hierarchy, providing
coherency between I/O transactions and the complete memory
hierarchy.

Some recent SoC with ARC HS (like HSDK) allow to select bus
port (IOC or non-IOC port) for connecting DMA devices in runtime.

With this patch we can use both HW-coherent and regular DMA
peripherals simultaneously.

NOTE:
This patch series was stress tested on HSDK with iperf3 (ethernet)
and bonie++ (usb and sdio).

NOTE:
If you want to test some device without IOC it is not enough
to remove "dma-coherent" property from dts. You had to remap this
device to regular DDR AXI port intead of IOC AXI port.
You also need to take into account that all DMA devices on ARC will
not work without IOC after commit:
a8eb92d02dd7 - arc: fix arc_dma_{map,unmap}_page <Christoph Hellwig>
(I will create fix soon, see STAR 9001374807)

NOTE:
We don't touch any aperture configuration in this patch series. So we
don't switch any devices between IOC and non-IOC AXI ports on any board.
It can be done later if it is required.

Eugeniy Paltsev (4):
  ARC: DTS: mark DMA devices connected through IOC port as dma-coherent
  ARC: allow to use IOC and non-IOC DMA devices simultaneously
  ARC: refactor arch/arc/mm/dma.c
  ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled

 arch/arc/Kconfig                   |  1 +
 arch/arc/boot/dts/axc003.dtsi      | 26 +++++++++++++++++
 arch/arc/boot/dts/axc003_idu.dtsi  | 26 +++++++++++++++++
 arch/arc/boot/dts/hsdk.dts         |  4 +++
 arch/arc/include/asm/dma-mapping.h | 13 +++++++++
 arch/arc/mm/cache.c                | 30 ++++++++++----------
 arch/arc/mm/dma.c                  | 58 ++++++++++++++++++--------------------
 7 files changed, 112 insertions(+), 46 deletions(-)
 create mode 100644 arch/arc/include/asm/dma-mapping.h

-- 
2.14.4
