Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:33943 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262868AbUCPDYj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2004 22:24:39 -0500
Subject: Re: More DMA API junk
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1079400742.1968.209.camel@gaston>
References: <1079398383.1968.205.camel@gaston>
	<1079399555.1804.232.camel@mulgrave>  <1079400742.1968.209.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 15 Mar 2004 22:24:31 -0500
Message-Id: <1079407473.2069.383.camel@mulgrave>
Mime-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2004-03-15 at 20:32, Benjamin Herrenschmidt wrote:
> On Tue, 2004-03-16 at 12:12, James Bottomley wrote:
> > They are both used.  Look at section II of DMA-API.txt.cd ..
> 
> I've looked and I couldn't find a proper meaning for them.

OK, the idea is that drivers that run on platforms which may not be able
to generate coherent memory use this (that's why no device in the API. 
I assumed it would be per-platform).

You call dma_alloc_noncoherent() to get the memory and you guarantee to
sync it correctly from the CPU's perspective using dma_cache_sync().

If you compile the driver on a coherent platform,
dma_alloc_noncoherent() becomes dma_alloc_coherent() and the
dma_cache_sync()s become nops.

If you compile it on a coherent incapable platform,
dma_alloc_noncoherent becomes an aligned kmalloc and the
dma_cache_sync() points map to the correct cpu caching instructions.

A driver has to be specially constructed to use this API ... and
obviously it needs to be used on the problem platforms.  The only
examples I know of are the scsi driver 53c700.c and the network driver
lasi_82596.


> How can dma_is_consistent() be implemented at all on an arch that
> implement consistency by allocating non-cacheable space using PTE
> bits ? we just cannot know if a given dma_addr_t is mapped by the
> kernel using a cacheable or non-cacheable (or both) mapping.

The idea was that either the platform can or cannot generate coherent
memory.  dma_is_consistent() returns true if dma_alloc_noncoherent()
returns coherent memory.

For a nop implementation see asm-i386/dma-mapping.h.  For a used
implementation see asm-parisc/dma-mapping.h.

> Regarding dma_cache_sync(), I still don't understand what it means
> and what it should be used for. We have dma_consistent_sync_*,
> care to explain in which cases those aren't useable and one would
> have to call dma_cache_sync() ?

It is used to do the CPU cache writeback and invalidates in the driver
on memory used for device mailboxes.  It's syntax is closely modelled on
dma_cache_wback() and friends (in asm/io.h).

I've never heard of dma_consistent_sync_* before.

James
