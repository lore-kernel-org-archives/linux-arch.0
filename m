Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeKHFn5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Nov 2018 00:43:57 -0500
Date: Wed, 7 Nov 2018 12:11:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm: Introduce common STRUCT_PAGE_MAX_SHIFT define
Message-ID: <20181107121159.b8c9add7c61fb97f48ddd7de@linux-foundation.org>
In-Reply-To: <20181107173859.24096-2-logang@deltatee.com>
References: <20181107173859.24096-1-logang@deltatee.com>
        <20181107173859.24096-2-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Stephen Bates <sbates@raithlin.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20181107201159._UT0a8oe4UGQA1agvtqAbxL0HOadeGomHH0LnD1utbc@z>

On Wed,  7 Nov 2018 10:38:58 -0700 Logan Gunthorpe <logang@deltatee.com> wrote:

> This define is used by arm64 to calculate the size of the vmemmap
> region. It is defined as the log2 of the upper bound on the size
> of a struct page.
> 
> We move it into mm_types.h so it can be defined properly instead of
> set and checked with a build bug. This also allows us to use the same
> define for riscv.
> 
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -34,15 +34,6 @@
>   */
>  #define PCI_IO_SIZE		SZ_16M
>  
> -/*
> - * Log2 of the upper bound of the size of a struct page. Used for sizing
> - * the vmemmap region only, does not affect actual memory footprint.
> - * We don't use sizeof(struct page) directly since taking its size here
> - * requires its definition to be available at this point in the inclusion
> - * chain, and it may not be a power of 2 in the first place.
> - */
> -#define STRUCT_PAGE_MAX_SHIFT	6

Well that was lame.

> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -206,6 +206,11 @@ struct page {
>  #endif
>  } _struct_page_alignment;
>  
> +/*
> + * Used for sizing the vmemmap region on some architectures
> + */
> +#define STRUCT_PAGE_MAX_SHIFT	(order_base_2(sizeof(struct page)))

Much better.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
