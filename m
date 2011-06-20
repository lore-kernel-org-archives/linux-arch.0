From: "Michal Nazarewicz" <mina86@mina86.com>
Subject: Re: [PATCH 1/8] ARM: dma-mapping: remove offset parameter to prepare
 for generic dma_ops
Date: Mon, 20 Jun 2011 10:35:36 +0200
Message-ID: <op.vxc8tmru3l0zgt@mnazarewicz-glaptop>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
 <1308556213-24970-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57081 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab1FTIfm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 04:35:42 -0400
Received: by gxk21 with SMTP id 21so215557gxk.19
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2011 01:35:41 -0700 (PDT)
In-Reply-To: <1308556213-24970-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Mon, 20 Jun 2011 09:50:06 +0200, Marek Szyprowski  
<m.szyprowski@samsung.com> wrote:
> +static inline void dma_sync_single_for_cpu(struct device *dev,

I wouldn't really put inline here or in the function below.

> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	BUG_ON(!valid_dma_direction(dir));
> +
> +	debug_dma_sync_single_for_cpu(dev, handle, size, dir);
> +
> +	if (!dmabounce_sync_for_cpu(dev, handle, size, dir))
> +		return;
> +
> +	__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);

I know it is just copy'n'paste but how about:

	if (dmabounce_sync_for_cpu(dev, handle, size, dir))
		__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);

> +}
> +
> +static inline void dma_sync_single_for_device(struct device *dev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	BUG_ON(!valid_dma_direction(dir));
> +
> +	debug_dma_sync_single_for_device(dev, handle, size, dir);
> +
> +	if (!dmabounce_sync_for_device(dev, handle, size, dir))
> +		return;
> +
> +	__dma_single_cpu_to_dev(dma_to_virt(dev, handle), size, dir);

Same as above.

> +}
> +
>  /**
>   * dma_sync_single_range_for_cpu
>   * @dev: valid struct device pointer, or NULL for ISA and EISA-like  
> devices

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
