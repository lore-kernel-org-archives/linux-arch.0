Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:54168 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262649AbUCPDsy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2004 22:48:54 -0500
Subject: Re: More DMA API junk
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1079407959.2348.226.camel@gaston>
References: <1079398383.1968.205.camel@gaston>
	<1079399555.1804.232.camel@mulgrave>  <1079400742.1968.209.camel@gaston>
	<1079407473.2069.383.camel@mulgrave>  <1079407959.2348.226.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 15 Mar 2004 22:48:48 -0500
Message-Id: <1079408930.2158.408.camel@mulgrave>
Mime-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2004-03-15 at 22:32, Benjamin Herrenschmidt wrote:
> So dma_cache_sync() is specifically for use on space returned
> by dma_alloc_noncoherent (and not dma_map_*).

Yes.

> So on a platform
> like mine where we use non-cacheable memory for allocating coherent
> space, we can indeed nop this one out. But then, is this also the
> case for dma_sync_single_range() which seem to be documented as
> beeing part of the "non-coherent" extension to the DMA API ? In
> which case, where is the difference between
> dma_sync_single_range() and dma_cache_sync()

dma_sync_single_range is an extension of dma_sync_single that allows you
only to do a partial sync (because on platforms like PA, syncs grow in
expense linearly with size).  So, if you're snooping data in a ten page
mapping, and you're only interested in sixteen bytes, you only need sync
those sixteen bytes. 

On your platform, dma_sync_single_range() has a defined meaning for
streaming mappings.  dma_cache_sync will be a nop, so they're not
interchangeable.

> That is confusing then. We should remove this dma_addr_t argument,
> as there is no simple way for me to tell from a physical address if
> that was mapped in kernel space as cacheable or non-cacheable.

You're confused about what it's used for.  It's designed only to be
called on memory allocated by dma_alloc_noncoherent() and tells you if
that API actually returned coherent memory or not.  This was designed
for ARM which has a limited range of allocateable coherent memory and
then would need to fail dma_alloc_coherent() or, in the case of
dma_alloc_noncoherent() begin handing out ordinary kmalloc'd memory.

James
