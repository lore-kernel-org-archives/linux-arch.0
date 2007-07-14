Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:37104 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577AbXGNPVE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 14 Jul 2007 11:21:04 -0400
Date: Sat, 14 Jul 2007 16:20:58 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/7] Generic Virtual Memmap support for SPARSEMEM
Message-ID: <20070714152058.GA12478@infradead.org>
References: <exportbomb.1184333503@pinky> <E1I9LJY-00006o-GK@hellhawk.shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1I9LJY-00006o-GK@hellhawk.shadowen.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

> --- a/include/asm-generic/memory_model.h
> +++ b/include/asm-generic/memory_model.h
> @@ -46,6 +46,12 @@
>  	 __pgdat->node_start_pfn;					\
>  })
>  
> +#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
> +
> +/* memmap is virtually contigious.  */
> +#define __pfn_to_page(pfn)	(vmemmap + (pfn))
> +#define __page_to_pfn(page)	((page) - vmemmap)
> +
>  #elif defined(CONFIG_SPARSEMEM)

nice ifdef mess you have here.  and an sm-generic file should be something
truely generic instead of a complete ifdef forest.  I think we'd be
much better off duplicating the two lines above in architectures using
it anyway.

> diff --git a/mm/sparse.c b/mm/sparse.c
> index d6678ab..5cc6e74 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -9,6 +9,8 @@
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
>  #include <asm/dma.h>
> +#include <asm/pgalloc.h>
> +#include <asm/pgtable.h>
>  
>  /*
>   * Permanent SPARSEMEM data:
> @@ -218,6 +220,192 @@ void *alloc_bootmem_high_node(pg_data_t *pgdat, unsigned long size)
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +/*
> + * Virtual Memory Map support
> + *
> + * (C) 2007 sgi. Christoph Lameter <clameter@sgi.com>.

When did we start putting copyright lines and large block comment in the
middle of the file?

Please sort this and the ifdef mess out, I suspect a new file for this
code would be best.

> +void * __meminit vmemmap_alloc_block(unsigned long size, int node)

void * __meminit vmemmap_alloc_block(unsigned long size, int node)

> +#ifndef CONFIG_ARCH_POPULATES_SPARSEMEM_VMEMMAP
> +void __meminit vmemmap_verify(pte_t *pte, int node,
> +				unsigned long start, unsigned long end)
> +{
> +	unsigned long pfn = pte_pfn(*pte);
> +	int actual_node = early_pfn_to_nid(pfn);
> +
> +	if (actual_node != node)
> +		printk(KERN_WARNING "[%lx-%lx] potential offnode "
> +			"page_structs\n", start, end - 1);
> +}

Given tht this function is a tiny noop please just put them into the
arch dir for !CONFIG_ARCH_POPULATES_SPARSEMEM_VMEMMAP architectures
and save yourself both the ifdef mess and the config option.

