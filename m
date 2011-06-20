From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [Linaro-mm-sig] [PATCH 3/8] ARM: dma-mapping: use asm-generic/dma-mapping-common.h
Date: Mon, 20 Jun 2011 23:33:00 +0900
Message-ID: <BANLkTimHE2jzQAav465WaG3iWVeHPyNRNQ@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46082 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab1FTOdB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 10:33:01 -0400
Received: by yxi11 with SMTP id 11so2097415yxi.19
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2011 07:33:00 -0700 (PDT)
In-Reply-To: <1308556213-24970-4-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>, Arnd Bergmann <arnd@arndb.de>

Hi.

Great job.

On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> +static inline void set_dma_ops(struct device *dev, struct dma_map_op=
s *ops)
> +{
> + =A0 =A0 =A0 dev->archdata.dma_ops =3D ops;
> +}
> +

Who calls set_dma_ops()?
In the mach. initialization part?
What if a device driver does not want to use arch's dma_map_ops
when machine init procedure set a dma_map_ops?
Even though, may arch defiens their dma_map_ops in archdata of device s=
tructure,
I think it is not a good idea that is device structure contains a
pointer to dma_map_ops
that may not be common to all devices in a board.

I also think that it is better to attach and to detach dma_map_ops dyna=
mically.
Moreover, a mapping is not permanent in our Exynos platform
because a System MMU may be turned off while runtime.

DMA API must come with IOMMU API to initialize IOMMU in runtime.

Regards,
Cho KyongHo.
