From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO
 mapping API
Date: Fri, 05 Feb 2010 10:43:54 -0600
Message-ID: <1265388234.14404.47.camel@mulgrave.site>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
	 <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53378 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753561Ab0BEQn6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2010 11:43:58 -0500
In-Reply-To: <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org

On Fri, 2010-02-05 at 16:31 +0000, Catalin Marinas wrote:
> This patch introduces support for the PIO mapping API on the ARM
> architecture. It is currently only meant as an example for discussions
> and it can be further optimised.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/Kconfig                   |    3 ++
>  arch/arm/include/asm/pio-mapping.h |   52 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/include/asm/pio-mapping.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4c33ca8..e48adcf 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -161,6 +161,9 @@ config ARCH_MTD_XIP
>  config GENERIC_HARDIRQS_NO__DO_IRQ
>  	def_bool y
>  
> +config HAVE_ARCH_PIO
> +	def_bool y
> +
>  if OPROFILE
>  
>  config OPROFILE_ARMV6
> diff --git a/arch/arm/include/asm/pio-mapping.h b/arch/arm/include/asm/pio-mapping.h
> new file mode 100644
> index 0000000..d7c866a
> --- /dev/null
> +++ b/arch/arm/include/asm/pio-mapping.h
> @@ -0,0 +1,52 @@
> +/*
> + * include/linux/pio-mapping.h
> + *
> + * Copyright (C) 2010 ARM Ltd.
> + * Written by Catalin Marinas <catalin.marinas@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#ifndef ASM_PIO_MAPPING_H
> +#define ASM_PIO_MAPPING_H
> +
> +#include <asm/cacheflush.h>
> +
> +static inline void *pio_map_single(void *addr, size_t size,
> +				   enum pio_data_direction dir)
> +{
> +	return addr;

This API is a bit semantically nasty to use, isn't it?  What we usually
get in the I/O path is a scatter gather list of pages and offsets (or
just a page in the network case).

In a highmem kernel, we'd have to kmap the page before it actually had a
kernel virtual address, so now the use case of the API becomes

vaddr = kmap_...(page)
pio_map_single(vaddr)

and the reverse on unmap.

Why not just combine the two since we always have to do them anyway and
do

kmap_pio ... with the various atomic versions?

enum pio_data_direction dir looks a bit wrong too ... why not just use
the exsiting enum dma_data_direction since that's what the dma API uses?

your pio_map_page is going to have to contain a kmap in the arch
implementation anyway ...

James
