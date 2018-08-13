Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52234 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeHMTCS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Aug 2018 15:02:18 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Date: Mon, 13 Aug 2018 16:19:21 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08C82C@us01wembx1.internal.synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "hch@lst.de" <hch@lst.de>
Message-ID: <20180813161921.B5cnK__qyoaaWQIljTp9uvLbheSdXSXFLEY9vijgOGk@z>

On 07/30/2018 09:26 AM, Eugeniy Paltsev wrote:=0A=
> The ARC HS processor provides an IOC port (I/O coherency bus=0A=
> interface) that allows external devices such as DMA devices=0A=
> to access memory through the cache hierarchy, providing=0A=
> coherency between I/O transactions and the complete memory=0A=
> hierarchy.=0A=
=0A=
You didn't pay attention to my previous comment on this !=0A=
IOC port can be considered a micro-architecture optimization (an important =
one=0A=
though). The main thing is hardware snooping DMA transactions which enabled=
 IOC in=0A=
first place.=0A=
=0A=
> Some recent SoC with ARC HS (like HSDK) allow to select bus=0A=
> port (IOC or non-IOC port) for connecting DMA devices in runtime.=0A=
=0A=
Again you mention the port but none of your 4 patches actually touch the po=
rt=0A=
itself in programming it.=0A=
=0A=
=0A=
> With this patch we can use both HW-coherent and regular DMA=0A=
> peripherals simultaneously.=0A=
>=0A=
> NOTE:=0A=
> This patch series was stress tested on HSDK with iperf3 (ethernet)=0A=
> and bonie++ (usb and sdio) in three configurations:=0A=
>  * IOC enabled globaly=0A=
>  * IOC disabled globaly=0A=
>  * IOC enabled partially (USB & SDIO are connected via IOC AXI port,=0A=
>    ethernet is connected to DDR AXI port (non-IOC port) =0A=
>=0A=
> NOTE:=0A=
> If you want to test some device without IOC it is not enough=0A=
> to remove "dma-coherent" property from dts. You had to remap this=0A=
> device to regular DDR AXI port intead of IOC AXI port.=0A=
=0A=
Why are we not doing that for the GPU as part of this series.=0A=
=0A=
> You also need to apply 3 following patches firstly:=0A=
> https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03865.=
html=0A=
> https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03889.=
html=0A=
> https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03887.=
html=0A=
>=0A=
> NOTE:=0A=
> We don't touch any aperture configuration in this patch series. So we=0A=
> don't switch any devices between IOC and non-IOC AXI ports on any board.=
=0A=
> It can be done later if it is required.=0A=
>=0A=
> Changes v1->v2 (Thanks to Christoph):=0A=
>  * Don't select DMA_DIRECT_OPS explicitly as it is already selected by=0A=
>    DMA_NONCOHERENT_OPS=0A=
>  * Remove check for HIGHMEM pages from arch_dma_{alloc, free}=0A=
>=0A=
> Eugeniy Paltsev (4):=0A=
>   ARC: DTS: mark DMA devices connected through IOC port as dma-coherent=
=0A=
>   ARC: allow to use IOC and non-IOC DMA devices simultaneously=0A=
>   ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled=0A=
>   ARC: don't check for HIGHMEM pages in arch_dma_alloc=0A=
>=0A=
>  arch/arc/boot/dts/axc003.dtsi      | 26 ++++++++++++++++=0A=
>  arch/arc/boot/dts/axc003_idu.dtsi  | 26 ++++++++++++++++=0A=
>  arch/arc/boot/dts/hsdk.dts         |  4 +++=0A=
>  arch/arc/include/asm/dma-mapping.h | 13 ++++++++=0A=
>  arch/arc/mm/cache.c                | 30 +++++++++---------=0A=
>  arch/arc/mm/dma.c                  | 62 +++++++++++++++++++-------------=
------=0A=
>  6 files changed, 115 insertions(+), 46 deletions(-)=0A=
>  create mode 100644 arch/arc/include/asm/dma-mapping.h=0A=
>=0A=
=0A=
