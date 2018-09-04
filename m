From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Date: Tue, 4 Sep 2018 13:14:49 -0700
Message-ID: <ae6d35d6-ee1e-abde-5e5c-a4c489d1abb7@synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
List-Id: linux-arch.vger.kernel.org

On 07/30/2018 09:26 AM, Eugeniy Paltsev wrote:
> The ARC HS processor provides an IOC port (I/O coherency bus
> interface) that allows external devices such as DMA devices
> to access memory through the cache hierarchy, providing
> coherency between I/O transactions and the complete memory
> hierarchy.
> 
> Some recent SoC with ARC HS (like HSDK) allow to select bus
> port (IOC or non-IOC port) for connecting DMA devices in runtime.
> 
> With this patch we can use both HW-coherent and regular DMA
> peripherals simultaneously.
> 
> NOTE:
> This patch series was stress tested on HSDK with iperf3 (ethernet)
> and bonie++ (usb and sdio) in three configurations:
>  * IOC enabled globaly
>  * IOC disabled globaly
>  * IOC enabled partially (USB & SDIO are connected via IOC AXI port,
>    ethernet is connected to DDR AXI port (non-IOC port) 
> 
> NOTE:
> If you want to test some device without IOC it is not enough
> to remove "dma-coherent" property from dts. You had to remap this
> device to regular DDR AXI port intead of IOC AXI port.
> You also need to apply 3 following patches firstly:
> https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03865.html
> https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03889.html
> https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03887.html
> 
> NOTE:
> We don't touch any aperture configuration in this patch series. So we
> don't switch any devices between IOC and non-IOC AXI ports on any board.
> It can be done later if it is required.
> 
> Changes v1->v2 (Thanks to Christoph):
>  * Don't select DMA_DIRECT_OPS explicitly as it is already selected by
>    DMA_NONCOHERENT_OPS
>  * Remove check for HIGHMEM pages from arch_dma_{alloc, free}
> 
> Eugeniy Paltsev (4):
>   ARC: DTS: mark DMA devices connected through IOC port as dma-coherent
>   ARC: allow to use IOC and non-IOC DMA devices simultaneously
>   ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled
>   ARC: don't check for HIGHMEM pages in arch_dma_alloc
> 
>  arch/arc/boot/dts/axc003.dtsi      | 26 ++++++++++++++++
>  arch/arc/boot/dts/axc003_idu.dtsi  | 26 ++++++++++++++++
>  arch/arc/boot/dts/hsdk.dts         |  4 +++
>  arch/arc/include/asm/dma-mapping.h | 13 ++++++++
>  arch/arc/mm/cache.c                | 30 +++++++++---------
>  arch/arc/mm/dma.c                  | 62 +++++++++++++++++++-------------------
>  6 files changed, 115 insertions(+), 46 deletions(-)
>  create mode 100644 arch/arc/include/asm/dma-mapping.h

Apologies for the delay in getting to this - series applied and pushed to for-curr

Thx,
-Vineet
