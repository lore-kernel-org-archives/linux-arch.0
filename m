From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH 4/8] ARM: dma-mapping: implement dma sg methods on top of
 generic dma ops
Date: Mon, 20 Jun 2011 23:37:53 +0900
Message-ID: <BANLkTimwo9bMCevBRxfSZJBrkjDpdihtKw@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57801 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab1FTOhy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 10:37:54 -0400
Received: by yxi11 with SMTP id 11so2099724yxi.19
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2011 07:37:54 -0700 (PDT)
In-Reply-To: <1308556213-24970-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi.

On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> -extern int arm_dma_map_sg(struct device *, struct scatterlist *, int=
,
> +extern int generic_dma_map_sg(struct device *, struct scatterlist *,=
 int,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum dma_data_direction, struct dma_at=
trs *attrs);
> -extern void arm_dma_unmap_sg(struct device *, struct scatterlist *, =
int,
> +extern void generic_dma_unmap_sg(struct device *, struct scatterlist=
 *, int,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum dma_data_direction, struct dma_at=
trs *attrs);
> -extern void arm_dma_sync_sg_for_cpu(struct device *, struct scatterl=
ist *, int,
> +extern void generic_dma_sync_sg_for_cpu(struct device *, struct scat=
terlist *, int,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum dma_data_direction);
> -extern void arm_dma_sync_sg_for_device(struct device *, struct scatt=
erlist *, int,
> +extern void generic_dma_sync_sg_for_device(struct device *, struct s=
catterlist *, int,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum dma_data_direction);
>

I don't understand why you changed arm_dma_*() with generic_dma_*()
even though they're functionality is not changed
and they are still specific to ARM.
They look like that they are generic in the kernel code.

Regards,
Cho KyongHo.
