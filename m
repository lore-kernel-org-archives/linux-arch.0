Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:61917 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262784AbUCPDik (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2004 22:38:40 -0500
Subject: Re: More DMA API junk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1079407473.2069.383.camel@mulgrave>
References: <1079398383.1968.205.camel@gaston>
	 <1079399555.1804.232.camel@mulgrave>  <1079400742.1968.209.camel@gaston>
	 <1079407473.2069.383.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1079407959.2348.226.camel@gaston>
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 14:32:39 +1100
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


> OK, the idea is that drivers that run on platforms which may not be able
> to generate coherent memory use this (that's why no device in the API. 
> I assumed it would be per-platform).
> 
> You call dma_alloc_noncoherent() to get the memory and you guarantee to
> sync it correctly from the CPU's perspective using dma_cache_sync().

Ok, so a platform like ppc 4xx that will generate coherent memory
by allocating non-cacheable memory in dma_alloc_coherent isn't
concerned ? That dma_cache_sync() isn't doing anything different
than what dma_consistent_sync() or dma_sync_single_range() is
doing as far as I understand.

My problem is that we already have at least 6 different "sync"
functions, I don't like having one more, which is not clear and
DMA-api.txt really doesn't care explaining the difference with
dma_sync_single_range() (which was adapted by DaveM for the
to_device/to_cpu change, while dma_sync_cache was not).

> If you compile the driver on a coherent platform,
> dma_alloc_noncoherent() becomes dma_alloc_coherent() and the
> dma_cache_sync()s become nops.

So dma_cache_sync() is specifically for use on space returned
by dma_alloc_noncoherent (and not dma_map_*). So on a platform
like mine where we use non-cacheable memory for allocating coherent
space, we can indeed nop this one out. But then, is this also the
case for dma_sync_single_range() which seem to be documented as
beeing part of the "non-coherent" extension to the DMA API ? In
which case, where is the difference between
dma_sync_single_range() and dma_cache_sync() 

> If you compile it on a coherent incapable platform,
> dma_alloc_noncoherent becomes an aligned kmalloc and the
> dma_cache_sync() points map to the correct cpu caching instructions.
>
> A driver has to be specially constructed to use this API ... and
> obviously it needs to be used on the problem platforms.  The only
> examples I know of are the scsi driver 53c700.c and the network driver
> lasi_82596.

Ok, but see my point about
dma_sync_single_range() vs. dma_cache_sync() 

> > How can dma_is_consistent() be implemented at all on an arch that
> > implement consistency by allocating non-cacheable space using PTE
> > bits ? we just cannot know if a given dma_addr_t is mapped by the
> > kernel using a cacheable or non-cacheable (or both) mapping.
> 
> The idea was that either the platform can or cannot generate coherent
> memory.  dma_is_consistent() returns true if dma_alloc_noncoherent()
> returns coherent memory.

That is confusing then. We should remove this dma_addr_t argument,
as there is no simple way for me to tell from a physical address if
that was mapped in kernel space as cacheable or non-cacheable.

> For a nop implementation see asm-i386/dma-mapping.h.  For a used
> implementation see asm-parisc/dma-mapping.h.

I don't need a nop mapping. I can have non-coherent memory (kmalloc,
or anything not specifically allocated with dma_alloc_coherent)

> > Regarding dma_cache_sync(), I still don't understand what it means
> > and what it should be used for. We have dma_consistent_sync_*,
> > care to explain in which cases those aren't useable and one would
> > have to call dma_cache_sync() ?
> 
> It is used to do the CPU cache writeback and invalidates in the driver
> on memory used for device mailboxes.  It's syntax is closely modelled on
> dma_cache_wback() and friends (in asm/io.h).
> 
> I've never heard of dma_consistent_sync_* before.

I meant dma_sync_single/sg, sorry, and specifically dma_sync_single_range()
which is documented along with the non-coherent stuff.

Ben.
