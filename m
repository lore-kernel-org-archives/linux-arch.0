Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:55697 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750802AbXBSIwx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 19 Feb 2007 03:52:53 -0500
Date: Mon, 19 Feb 2007 09:30:04 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: + avr32-dma-mappingh.patch added to -mm tree
Message-ID: <20070219093004.6b93b836@dhcp-252-105.norway.atmel.com>
In-Reply-To: <200702162200.l1GM0r3F010985@shell0.pdx.osdl.net>
References: <200702162200.l1GM0r3F010985@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, zambrano@broadcom.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, 16 Feb 2007 14:00:53 -0800
akpm@linux-foundation.org wrote:

> Subject: avr32: dma-mapping.h
> From: "Gary Zambrano" <zambrano@broadcom.com>
> 
> Added dma_sync_single_range_for_cpu/device to dma-mapping.h in asm-avr32 to
> call dma_sync_single_for_cpu/device.  This patch enables b44 to compile on
> systems with these cpus.  This patch was created with the assumption that
> another method of dma_sync_single_range_for_cpu/device does not exist on these
> architectures.

Thanks. However, I have a couple of questions for the arch experts...

> +static inline void
> +dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
> +			      unsigned long offset, size_t size,
> +			      enum dma_data_direction direction)
> +{
> +	/* just sync everything, that's all the pci API can do */
> +	dma_sync_single_for_cpu(dev, dma_handle, offset+size, direction);

I'm a little curious about why we can't just do

dma_sync_single_for_cpu(dev, dma_handle + offset, size, direction);

instead?

Also, although not related to this patch in particular, I wonder if we
actually need to sync anything at all in the _for_cpu() functions.
These are analogous to dma_unmap_*(), right?

Haavard
